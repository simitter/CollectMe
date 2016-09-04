local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.Macro = CollectMe:NewModule("Macro")
local RandomMount = CollectMe:GetModule("RandomMount")
local MountDB = CollectMe:GetModule("MountDB")

function CollectMe.Macro:OnEnable()
    self:UpdateMacros()
end

function CollectMe.Macro:UpdateMacros()
    local options = CollectMe.db.profile.macro;
    if options.companion == true then
        self:InitMacro("CollectMeRC", "INV_PET_BABYBLIZZARDBEAR", '/cm rc')
    end
    
    if options.title == true then
        self:InitMacro("CollectMeRT", "INV_PET_SCORCHEDSTONE", '/cm rt')
    end
    
    if options.mount == true then
        if CollectMe.CLASS == "DRUID" and options.nostance then
            self:InitMacro("CollectMeRM", "ABILITY_MOUNT_BIGBLIZZARDBEAR", '/cancelform [nostance:5]\n/cm rm')
        else
            self:InitMacro("CollectMeRM", "ABILITY_MOUNT_BIGBLIZZARDBEAR", '/cm rm')
        end
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
        RandomMount:Summon()
    elseif value == 2 then
        if IsMounted() then
            Dismount()
        end
    elseif value == 3 then
        RandomMount:Summon(MountDB.GROUND)
    end
end

function CollectMe.Macro:Companion()
    if GetMouseButtonClicked() == "RightButton" then
        CollectMe.RandomCompanion:Dismiss()
    else
        CollectMe.RandomCompanion:Summon()
    end
end

function CollectMe.Macro:Title()
    CollectMe.RandomTitle:Select()
end
