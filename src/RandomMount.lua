local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.RandomMount = CollectMe:NewModule("RandomMount")

function CollectMe.RandomMount:OnInitialize()
    self.db = CollectMe.db
end


function CollectMe.RandomMount:OnEnable()
    if self.professions == nil then
        self:UpdateProfessions()
    end
end

function CollectMe.RandomMount:UpdateProfessions()
    local first, second = GetProfessions()
    self.professions = {}
    if(first ~= nil) then
        self:SetProfession(first)
    end
    if(second ~= nil) then
        self:SetProfession(second)
    end
end

function CollectMe.RandomMount:SetProfession(index)
    local _, icon, skill = GetProfessionInfo(index)
    local name
    if string.find(icon, "Trade_Tailoring") ~= nil then
        name = 'tai'
    elseif string.find(icon, "Trade_Engineering") ~= nil then
        name = 'eng'
    end
    if name ~= nil then
        table.insert(self.professions, { name = name, skill = skill} )
    end
end

function CollectMe.RandomMount:Summon(type)
    if not IsMounted() then
        local zone_mounts, type_mounts, fallback_mounts = {}, {}, {}
        local zone_id, is_swimming, is_flyable_area = CollectMe.ZoneDB:Current(), IsSwimming(), IsFlyableArea()
        local profession_count = #self.professions

        --IsFlyableArea() falsely returns true for Dreanor
        if(GetCurrentMapContinent() == 7) then
            is_flyable_area = false
        end

        for i = 1, C_MountJournal.GetNumMounts() do
            local name, spell_id = C_MountJournal.GetMountInfo(i)

            -- check if current mount is in priority pool and if it is usable here
            if self.db.profile.random.mounts[spell_id] ~= nil and self.db.profile.random.mounts[spell_id] ~= false and IsUsableSpell(spell_id) ~= nil then

                -- get info table from mount db
                local info = CollectMe.MountDB:GetInfo(spell_id)
                if info == nil then
                    info = {
                        type    = CollectMe.MountDB.GROUND, --mount not known, assuming it' is a ground mount
                        name    = name,
                        id      = spell_id
                    }
                end

                if info.professions == nil or self:ProfessionMount(info) == true then
                    -- setting up zone table (aquatic handled by that too currently)
                    if(info.zones ~= nil and CollectMe:IsInTable(info.zones, zone_id)) then
                        table.insert(zone_mounts, i)
                    end

                    if #zone_mounts == 0 then
                        -- swimming mounts
                        if is_swimming == true then
                            if info.type == CollectMe.MountDB.SWIM or (self.db.profile.summon.mounts.flying_in_water == true and info.type == CollectMe.MountDB.FLY and is_flyable_area == true) then
                                table.insert(type_mounts, i)
                            end
                            -- flying mounts
                        elseif is_flyable_area == true then
                            if info.type == CollectMe.MountDB.FLY then
                                table.insert(type_mounts, i)
                            end
                        end
                    end
                    if info.type == CollectMe.MountDB.GROUND or (self.db.profile.summon.mounts.flying_on_ground  == true and info.type == CollectMe.MountDB.FLY) then
                        table.insert(fallback_mounts, i)
                    end
                end
            end
        end

        if type == CollectMe.MountDB.GROUND and #fallback_mounts > 0 then
            self:Mount(fallback_mounts)
        elseif #zone_mounts > 0 then
            self:Mount(zone_mounts)
        elseif #type_mounts > 0 then
            self:Mount(type_mounts)
        elseif #fallback_mounts > 0 then
            self:Mount(fallback_mounts)
        else
            if IsIndoors() == nil and UnitAffectingCombat("player") == nil then
                CollectMe:Print(CollectMe.L["You haven't configured your mount priorities yet. Please open the random mount tab"])
            end
        end

    elseif self.db.profile.summon.mounts.no_dismount == false then
        Dismount()
    end
end

function CollectMe.RandomMount:ProfessionMount(info)
    for i,v in pairs(info.professions) do
        for j, v1 in pairs(self.professions) do
            if i == v1.name and v1.skill >= v then
                return true
            end
        end
    end
    return false
end

function CollectMe.RandomMount:Mount(t)
    local call = math.random(1, #t);
    C_MountJournal.Summon(t[call]);
end
