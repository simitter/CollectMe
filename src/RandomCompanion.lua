local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.RandomCompanion = CollectMe:NewModule("RandomCompanion", "AceHook-3.0")

function CollectMe.RandomCompanion:OnInitialize()
    self:SecureHook("MoveForwardStart", "AutoSummon")
    self:SecureHook("ToggleAutoRun", "AutoSummon")
end

function CollectMe.RandomCompanion:Summon()
    local summonable = {};

    for i,v in pairs(CollectMe.db.profile.random.companions) do
        if v == true and pcall(function() C_PetJournal.PetIsSummonable(i) end) and C_PetJournal.PetIsSummonable(i) then
            table.insert(summonable, i)
        end
    end

    if (#summonable > 0) then
        local call = math.random(1, #summonable)
        C_PetJournal.SummonPetByGUID(summonable[call])
    else
        CollectMe:Print(CollectMe.L["You haven't configured your companion priorities yet. Please open the random companion tab"])
    end
end

function CollectMe.RandomCompanion:Dismiss()
    local active = C_PetJournal.GetSummonedPetGUID()
    if active ~= nil then
        C_PetJournal.SummonPetByGUID(active)
    end
end

function CollectMe.RandomCompanion:AutoSummon()
    local summon = true
    if CollectMe.db.profile.summon.companions.disable_pvp == true then
        if UnitIsPVP("player") == true and CollectMe.db.profile.summon.companions.disable_pvp_world == true then
            summon = false
        else
            local inInstance, instanceType = IsInInstance()
            if inInstance then
                if instanceType == "arena" and CollectMe.db.profile.summon.companions.disable_pvp_arena == true then
                    summon = false
                elseif instanceType == "pvp" and CollectMe.db.profile.summon.companions.disable_pvp_bg == true then
                    summon = false
                end
            end
        end
    end

    if IsInRaid() == true and CollectMe.db.profile.summon.companions.disable_party_raid_grp == true then
        summon = false
    elseif IsInRaid() == false and IsInGroup() == true  and CollectMe.db.profile.summon.companions.disable_party_grp == true then
        summon = false
    else
        local inInstance, instanceType = IsInInstance()
        if inInstance then
            if instanceType == "raid" and CollectMe.db.profile.summon.companions.disable_raid_instance == true then
                summon = false
            elseif instanceType == "party" and CollectMe.db.profile.summon.companions.disable_dungeon == true then
                summon = false
            elseif instanceType == "scenario" and CollectMe.db.profile.summon.companions.disable_scenario == true then
                summon = false
            end
        end
    end

    if UnitAffectingCombat("player") == false and IsMounted() == false and IsStealthed() == false and CollectMe.db.profile.summon.companions.auto == true then
        if summon then
            local active = C_PetJournal.GetSummonedPetGUID()
            if (active == nil) then
                self:Summon()
            end
        end
    end
    if not summon then
        self:Dismiss()
    end
end
