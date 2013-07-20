local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.RandomCompanion = CollectMe:NewModule("RandomCompanion", "AceHook-3.0")

function CollectMe.RandomCompanion:OnInitialize()
    self:SecureHook("MoveForwardStart", "AutoSummon")
    self:SecureHook("ToggleAutoRun", "AutoSummon")
end

function CollectMe.RandomCompanion:Summon()
    local summonable = {};

    for i,v in pairs(CollectMe.db.profile.random.companions) do
        if v == true and C_PetJournal.PetIsSummonable(i) then
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
    if UnitAffectingCombat("player") == nil and IsMounted() == nil and IsStealthed() == nil and CollectMe.db.profile.summon.companions.auto == true then
        if (not (UnitIsPVP("player") == 1 and CollectMe.db.profile.summon.companions.disable_pvp == true)) then
            local active = C_PetJournal.GetSummonedPetGUID()
            if (active == nil) then
                self:Summon()
            end
        end
    end
    if (UnitIsPVP("player") == 1 and CollectMe.db.profile.summon.companions.disable_pvp == true) then
        self:Dismiss()
    end
end
