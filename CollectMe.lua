CollectMe = LibStub("AceAddon-3.0"):NewAddon("CollectMe", "AceConsole-3.0", "AceHook-3.0");
local AceGUI = LibStub("AceGUI-3.0");
local addon_name = "CollectMe"
local MOUNT = 1
local TITLE = 2
local RANDOM_COMPANION = 3
local RANDOM_MOUNT = 4


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
    options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

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
    tabs:SetTabs({ {text = self.L["Mounts"], value = MOUNT}, {text = self.L["Titles"], value = TITLE}, {text = self.L["Random Companion"], value = RANDOM_MOUNT}, {text = self.L["Random Mount"], value = RANDOM_COMPANION}})
    tabs:SetCallback("OnGroupSelected", function (container, event, group) CollectMe:SelectGroup(container, group) end)
    f:AddChild(tabs)

    self.tabs = tabs
    self.frame = f
end

function CollectMe:BuildTab(container, group)
    self.frame.statusbar:Hide()
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
    self.scroll = scroll

    local filter = AceGUI:Create("ScrollFrame")
    filter:SetFullHeight(true)
    filter:SetLayout("Flow")
    filtercontainer:AddChild(filter)

    local desc = AceGUI:Create("Heading")
    desc:SetText(self.L["Filters"])
    desc:SetFullWidth(true)
    filter:AddChild(desc)

    if(group == MOUNT) then
        self:BuildMounts(scroll, filter)
    elseif(group == TITLE) then
        --        self:BuildTitles()
    end
end

function CollectMe:BuildMounts(listcontainer, filtercontainer)
    self:RefreshKnownMounts()

    local active_mounts, ignored_mounts = {}, {}
    local all_count, known_count = #self.MOUNTS, 0

    for i,v in ipairs(self.MOUNTS) do
        if not self:IsInTable(self.known_mounts, v.spell_id) then
            local f = self:CreateItemRow()
            f:SetText(v.name)
            f:SetImage(v.icon)
            f:SetImageSize(36, 36)
            f:SetCallback("OnClick", function (container, event, group) CollectMe:ItemRowClick(group, v.spell_id) end)

            if self:IsInTable(self.db.profile.ignored.mounts, v.spell_id) then
                table.insert(ignored_mounts, f)
            else
                table.insert(active_mounts, f)
            end
        else
            known_count = known_count +1
        end
    end

    local active = AceGUI:Create("Heading")
    active:SetText(self.L["Active"] .. " - " .. #active_mounts)
    active:SetFullWidth(true)
    listcontainer:AddChild(active)
    for f = 1, #active_mounts, 1 do
        listcontainer:AddChild(active_mounts[f])
    end

    local ignored = AceGUI:Create("Heading")
    ignored:SetText(self.L["Ignored"] .. " - " .. #ignored_mounts)
    ignored:SetFullWidth(true)
    listcontainer:AddChild(ignored)
    for f = 1, #ignored_mounts, 1 do
        listcontainer:AddChild(ignored_mounts[f])
    end

    all_count = all_count - #self.db.profile.ignored.mounts
    local percent = self:round(known_count / all_count * 100, 2)

    self.frame.statusbar:SetMinMaxValues(0, all_count)
    self.frame.statusbar:SetValue(known_count)
    self.frame.statusbar.value:SetText(known_count .. " / " .. all_count .. " (".. percent .. "%)")
    self.frame.statusbar:Show()
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
    elseif group == "RightButton" and IsControlKeyDown() then
        local offset = self.scroll.localstatus.offset
        local position = self:IsInTable(self.db.profile.ignored.mounts, spell_id)
        if position ~= false then
            table.remove(self.db.profile.ignored.mounts, position)
        else
            table.insert(self.db.profile.ignored.mounts, spell_id)
        end

        self.tabs:SelectTab(MOUNT)

        -- SetScroll doe not calculate position accurately
        local status_table = self.scroll.localstatus
        status_table.offset = offset
        self.scroll:SetStatusTable(status_table)
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

function CollectMe:RefreshKnownMounts()
    self.known_mount_count = GetNumCompanions("Mount")
    self.known_mounts = {}

    for i = 1, self.known_mount_count, 1 do
        local _, _, spell_id = GetCompanionInfo("Mount", i)
        table.insert(self.known_mounts, spell_id);
    end
end

-- checks is element is in table returns position if true, false otherwise
function CollectMe:IsInTable(t, spell_id)
    for i = 1, #t do
        if t[i] == spell_id then
            return i
        end
    end

    return false
end

-- no round in math library? seriously????
function CollectMe:round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function CollectMe:SortTable(tbl)
    table.sort(tbl, function(a, b) return (string.lower(a.name) < string.lower(b.name)) end)
end


 -- CONSOLE COMMAND HANDLER
function CollectMe:SlashProcessor(input)
    self.tabs:SelectTab(MOUNT)
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

