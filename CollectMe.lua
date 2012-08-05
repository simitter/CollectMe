CollectMe = LibStub("AceAddon-3.0"):NewAddon("CollectMe", "AceConsole-3.0", "AceHook-3.0");
local AceGUI = LibStub("AceGUI-3.0");
local addon_name = "CollectMe"


local defaults = {
    profile = {
        ignored = {
            mounts = {},
            titles = {}
        }
    }
}

local options = {
    name = addon_name,
    type = "group",
    childGroups = "tab",
    args = { }
}

function CollectMe:OnInitialize()
    self.COLLECTME_VERSION = GetAddOnMetadata("CollectMe", "Version")
    self.L = LibStub("AceLocale-3.0"):GetLocale("CollectMe", true)

    self.FACTION = UnitFactionGroup("player")
    LocalizedPlayerRace, self.RACE = UnitRace("player")
    LocalizedPlayerClass, self.CLASS = UnitClass("player")

    LibStub("AceConfig-3.0"):RegisterOptionsTable(addon_name, options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addon_name)

    self.db = LibStub("AceDB-3.0"):New("CollectMeDB", defaults)
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

    self:BuildMountDB()
    self:BuildUI()

    self:RegisterChatCommand("collectme", "SlashProcessor")
    self:RegisterChatCommand("cm", "SlashProcessor")

    self:SecureHook("DressUpItemLink")
    self:HookScript(DressUpFrameResetButton, "OnClick", "DressUpFrameResetButton")
end

function CollectMe:SelectGroup(container, group)
    container:ReleaseChildren()
    CollectMe:BuildTab(container, group)
end

function CollectMe:BuildUI()
    local f = AceGUI:Create("CollectMe")
    f:SetTitle("Collect Me " .. self.COLLECTME_VERSION)
    f:SetWidth(570)
    f:SetLayout("Fill")
    tinsert(UISpecialFrames, f.frame:GetName())

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({ {text = self.L["Mounts"], value = 1}, {text = self.L["Titles"], value = 2}, {text = self.L["Random Mount"], value = 3}, {text = self.L["Random Companion"], value = 4}})
    tabs:SetCallback("OnGroupSelected", function (container, event, group) CollectMe:SelectGroup(container, group) end)
    f:AddChild(tabs)

    self.tabs = tabs
    self.frame = f
end

function CollectMe:BuildTab(container, group)
    container:SetLayout("Flow")

    local scrollcontainer = AceGUI:Create("SimpleGroup")
    scrollcontainer:SetRelativeWidth(0.6)
    scrollcontainer:SetFullHeight(true)
    scrollcontainer:SetLayout("Fill")
    container:AddChild(scrollcontainer)

    local filtercontainer = AceGUI:Create("SimpleGroup")
    filtercontainer:SetRelativeWidth(0.4)
    filtercontainer:SetFullHeight(true)
    filtercontainer:SetLayout("Fill")
    container:AddChild(filtercontainer)

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    scrollcontainer:AddChild(scroll)

    local active = AceGUI:Create("Heading")
    active:SetText(self.L["Active"])
    active:SetFullWidth(true)
    scroll:AddChild(active)

    local filter = AceGUI:Create("ScrollFrame")
    filter:SetFullHeight(true)
    filter:SetLayout("Flow")
    filtercontainer:AddChild(filter)

    local desc = AceGUI:Create("Heading")
    desc:SetText(self.L["Filters"])
    desc:SetFullWidth(true)
    filter:AddChild(desc)

    if(group == 1) then
        self:BuildMounts(scroll, filter)
    elseif(group == 2) then
        --        self:BuildTitles()
    end
end

function CollectMe:BuildMounts(listcontainer, filtercontainer)
    local mount_count = GetNumCompanions("Mount")
    for i,v in ipairs(self.MOUNTS) do
        local f = self:CreateItemRow()
        f:SetText(v.name)
        f:SetImage(v.icon)
        f:SetImageSize(36, 36)
        f:SetCallback("OnClick", function (container, event, group) CollectMe:ItemRowClick(group, v.spell_id) end)

        listcontainer:AddChild(f)
    end
end

function CollectMe:ItemRowClick(group, spell_id)
    if group == "LeftButton" then
        local mount = self:GetMountInfo(spell_id)
        if mount ~= nil then
            if IsShiftKeyDown() == 1 and mount.link ~= nil then
                ChatEdit_InsertLink(mount.link)
            elseif mount.display_id ~= nil then
                DressUpBackgroundTopLeft:SetTexture(nil);
                DressUpBackgroundTopRight:SetTexture(nil);
                DressUpBackgroundBotLeft:SetTexture(nil);
                DressUpBackgroundBotRight:SetTexture(nil);
                DressUpModel:SetDisplayInfo(mount.display_id);
                if not DressUpFrame:IsShown() then
                    ShowUIPanel(DressUpFrame);
                end
            end
        end
    elseif group == "RightButton" then
        -- move to inactive
    end
end

function CollectMe:CreateItemRow()
    local f = AceGUI:Create("CollectMeLabel")
    f:SetHighlight("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    return f
end

function CollectMe:GetMountInfo(spell_id)
    for i,v in ipairs(self.MOUNTS) do
        if v.spell_id == spell_id then
            return v
        end
    end
    return nil
end

function CollectMe:SortTable(tbl)
    table.sort(tbl, function(a, b) return (string.lower(a.name) < string.lower(b.name)) end)
end


 -- CONSOLE COMMAND HANDLER
function CollectMe:SlashProcessor(input)
    self.tabs:SelectTab(1)
    self.frame:Show()
end

 -- HOOKS
function CollectMe:DressUpItemLink(link)
    if IsDressableItem(link) then
        SetDressUpBackground(DressUpFrame, self.RACE);
        DressUpModel:SetUnit("player")
        DressUpModel:TryOn(link)
    end
end

function CollectMe:DressUpFrameResetButton()
     SetDressUpBackground(DressUpFrame, self.RACE);
     DressUpModel:SetUnit("player");
end

