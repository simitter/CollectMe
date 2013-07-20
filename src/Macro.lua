local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.Macro = CollectMe:NewModule("Macro")

function CollectMe.Macro:OnEnable()
    self:UpdateMacros()
end

function CollectMe.Macro:UpdateMacros()
    self:InitMacro("CollectMeRC", "INV_PET_BABYBLIZZARDBEAR", '/script CollectMe.Macro:Companion();')
    if CollectMe.CLASS == "DRUID" then
        self:InitMacro("CollectMeRM", "ABILITY_MOUNT_BIGBLIZZARDBEAR", '/cancelform\n/script CollectMe.Macro:Mount();')
    else
        self:InitMacro("CollectMeRM", "ABILITY_MOUNT_BIGBLIZZARDBEAR", '/script CollectMe.Macro:Mount();')
    end
end

function CollectMe.Macro:InitMacro(name, icon, body)
    local index = GetMacroIndexByName(name)
    if index == 0 then
        local id = CreateMacro(name, icon, body, nil);
    else
        EditMacro(index, nil, nil, body)
    end
end

function CollectMe.Macro:Mount()
    if GetMouseButtonClicked() == "RightButton" then
        value = CollectMe.db.profile.summon.mounts.macro_right
    elseif IsShiftKeyDown() then
        value = CollectMe.db.profile.summon.mounts.macro_shift_left
    else
        value = CollectMe.db.profile.summon.mounts.macro_left
    end

    if value == 1 then
        CollectMe.RandomMount:Summon()
    elseif value == 2 then
        if IsMounted() then
            Dismount()
        end
    elseif value == 3 then
        CollectMe.RandomMount:Summon(CollectMe.MountDB.GROUND)
    end
end

function CollectMe.Macro:Companion()
    if GetMouseButtonClicked() == "RightButton" then
        CollectMe.RandomCompanion:Dismiss()
    else
        CollectMe.RandomCompanion:Summon()
    end
end
