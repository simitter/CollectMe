local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local RandomMount = CollectMe:NewModule("RandomMount")
local MountDB = CollectMe:GetModule("MountDB")

function RandomMount:Summon(type)
    local db = CollectMe.db.profile
    
    if not IsMounted() then
        local zone_mounts, type_mounts, fallback_mounts = {}, {}, {}
        local zone_id, is_swimming, is_flyable_area = CollectMe.ZoneDB:Current(), IsSwimming(), IsFlyableArea()
        local collected, _, infos = MountDB:Get()

        --IsFlyableArea() falsely returns true for Dreanor
        --if(GetCurrentMapContinent() == 7) then
        --    is_flyable_area = false
       --end

        for _,id in pairs(collected) do
            -- check if current mount is in priority pool and if it is usable here
            if db.random.mounts[id] ~= nil and db.random.mounts[id] ~= false and IsUsableSpell(id) ~= nil and infos[id].summonable then
                -- setting up zone table (aquatic handled by that too currently)
                if infos[id].zones ~= nil and infos[id].zones[zone_id] ~= nil then
                    table.insert(zone_mounts, infos[id].mount_id)
                end

                if #zone_mounts == 0 then
                    -- swimming mounts
                    if is_swimming == true then
                        if infos[id].type == MountDB.SWIM or (db.summon.mounts.flying_in_water == true and infos[id].type == MountDB.FLY and is_flyable_area == true) then
                            table.insert(type_mounts, infos[id].mount_id)
                        end
                        -- flying mounts
                    elseif is_flyable_area == true then
                        if infos[id].type == MountDB.FLY then
                            table.insert(type_mounts, infos[id].mount_id)
                        end
                    end
                end
                if infos[id].type == MountDB.GROUND or (db.summon.mounts.flying_on_ground  == true and infos[id].type == MountDB.FLY) then
                    table.insert(fallback_mounts, infos[id].mount_id)
                end
            end
        end

        if type == MountDB.GROUND and #fallback_mounts > 0 then
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

    elseif db.summon.mounts.no_dismount == false then
        Dismount()
    end
end

function RandomMount:Mount(t)
    local call = math.random(1, #t);
    C_MountJournal.SummonByID(t[call]);
end