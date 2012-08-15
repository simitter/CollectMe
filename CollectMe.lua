CollectMe = LibStub("AceAddon-3.0"):NewAddon("CollectMe", "AceConsole-3.0", "AceHook-3.0");
local AceGUI = LibStub("AceGUI-3.0");
local addon_name = "CollectMe"
local MOUNT = 1
local TITLE = 2
local RANDOM_COMPANION = 3
local RANDOM_MOUNT = 4
local MOUNT_FILTERS = { "nlo", "tcg", "pvp", "bsm", "rfm", "ptm" }
local TITLE_FILTERS = { "nlo", "pvp" }

local defaults = {
    profile = {
        ignored = {
            mounts = {},
            titles = {}
        },
        filters = {
            mounts = {
                nlo = false,
                tcg = false,
                pvp = false,
                bsm = false,
                rfm = false,
                ptm = false
            },
            titles = {
                nlo = false,
                pvp = false
            }
        },
        missing_message = {
            mounts = false,
            titles = false
        },
        random = {
            companions = {},
            mounts = {}
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
    self:BuildTitleDB()

    self.active_tab = MOUNT
    self.filter_db = self.db.profile.filters.mounts
    self.ignored_db = self.db.profile.ignored.mounts
    self.item_list = self.MOUNTS
    self.filter_list = MOUNT_FILTERS

    self:BuildUI()

    self:RegisterChatCommand("collectme", "SlashProcessor")
    self:RegisterChatCommand("cm", "SlashProcessor")

    self:SecureHook("DressUpItemLink")
    self:HookScript(DressUpFrameResetButton, "OnClick", "DressUpFrameResetButton")
end

function CollectMe:OnEnable()
    self:InitMacro("CollectMeRC", "INV_PET_BABYBLIZZARDBEAR", "/cm rc")
end

function CollectMe:InitMacro(name, icon, body)
    local index = GetMacroIndexByName(name)
    if index == 0 then
        local id = CreateMacro(name, icon, body, nil);
    else
        EditMacro(index, nil, nil, body)
    end
end

function CollectMe:SelectGroup(container, group)
    container:ReleaseChildren()
    self.active_tab = group
    if group == MOUNT then
        self.filter_db = self.db.profile.filters.mounts
        self.ignored_db = self.db.profile.ignored.mounts
        self.item_list = self.MOUNTS
        self.filter_list = MOUNT_FILTERS
    elseif group == TITLE then
        self.filter_db = self.db.profile.filters.titles
        self.ignored_db = self.db.profile.ignored.titles
        self.item_list = self.TITLES
        self.filter_list = TITLE_FILTERS
    end

    CollectMe:BuildTab(container)
end

function CollectMe:BuildUI()
    local f = AceGUI:Create("CollectMe")
    f:SetTitle("Collect Me " .. self.COLLECTME_VERSION)
    f:SetWidth(570)
    f:SetLayout("Fill")
    tinsert(UISpecialFrames, f.frame:GetName())

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({ {text = self.L["Mounts"], value = MOUNT}, {text = self.L["Titles"], value = TITLE}, {text = self.L["Random Companion"], value = RANDOM_COMPANION}, {text = self.L["Random Mount"], value = RANDOM_MOUNT}})
    tabs:SetCallback("OnGroupSelected", function (container, event, group) CollectMe:SelectGroup(container, group) end)
    f:AddChild(tabs)

    self.tabs = tabs
    self.frame = f
end

function CollectMe:BuildTab(container)
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

    if self.active_tab == MOUNT or self.active_tab == TITLE then
        self:BuildList(scroll)
        self:BuildFilters(filter)
    elseif self.active_tab == RANDOM_COMPANION then
        self:BuildRandomList(scroll)
    end

    self:BuildOptions(filter)
end

function CollectMe:BuildRandomList(listcontainer)
    local count = GetNumCompanions("CRITTER")

    listcontainer:AddChild(self:CreateHeading(self.L["Available companions"] ..  " - " .. count))
    for i = 1, count, 1 do
        local _, name, spell_id = GetCompanionInfo("CRITTER", i)
        local f = AceGUI:Create("Slider")
        f:SetLabel(name)
        f:SetFullWidth(true)
        f:SetSliderValues(0, 10, 1)
        local value = (self.db.profile.random.companions[spell_id] ~= nil and self.db.profile.random.companions[spell_id] or 0)
        f:SetValue(value)
        f:SetCallback("OnValueChanged", function (container, event, val) self.db.profile.random.companions[spell_id] = val end)

        listcontainer:AddChild(f)
    end
end

function CollectMe:SummonRandomCompanion()
    local summonable = {};
    for i = 1, GetNumCompanions("CRITTER") do
        local _, _, spell_id = GetCompanionInfo("CRITTER", i);
        if (self.db.profile.random.companions[spell_id] ~= nil and self.db.profile.random.companions[spell_id] ~= 0) then
            for j = 1, self.db.profile.random.companions[spell_id] do
                table.insert(summonable, i);
            end
        end
    end

    if (#summonable > 0) then
        local call = math.random(1, #summonable - 1);
        CallCompanion("CRITTER", summonable[call]);
    else
        self:Print(self.L["You don't have configured your companion priorities yet. Please open the random companion tab"])
    end
end

function CollectMe:BuildList(listcontainer)
    listcontainer:ReleaseChildren()

    if self.active_tab == MOUNT then
        self:RefreshKnownMounts()
    elseif self.active_tab == TITLE and self.db.profile.missing_message.titles == false then
        for i = 1, GetNumTitles(), 1 do
            if IsTitleKnown(i) == 1 and self:IsInTable(self.TITLE_SPELLS, i) == false then
                local name = GetTitleName(i)
                if name ~= nil then
                    self:Print(self.L["Title"] .. " " .. name:gsub("^%s*(.-)%s*$", "%1") .. "("..i..") " .. self.L["is missing"] .. ". " .. self.L["Please inform the author"])
                end
            end
        end
    end

    local active, ignored = {}, {}
    local all_count, known_count, filter_count = #self.item_list, 0, 0

    for i,v in ipairs(self.item_list) do
        if (self.active_tab == MOUNT and not self:IsInTable(self.known_mounts, v.id)) or (self.active_tab == TITLE and IsTitleKnown(v.id) ~= 1) then
            local f = self:CreateItemRow()
            if self.active_tab == MOUNT then
                f:SetImage(v.icon)
                f:SetImageSize(36, 36)
            end
            f:SetText(v.name)
            f:SetCallback("OnClick", function (container, event, group) CollectMe:ItemRowClick(group, v.id) end)
            f:SetCallback("OnEnter", function (container, event, group) CollectMe:ItemRowEnter(v) end)
            f:SetCallback("OnLeave", function (container, event, group) CollectMe:ItemRowLeave(v) end)

            if self:IsInTable(self.ignored_db, v.id) then
                table.insert(ignored, f)
            else
                if not self:IsFiltered(v.filters) then
                    table.insert(active, f)
                else
                    filter_count = filter_count + 1
                end
            end
        else
            known_count = known_count +1
        end
    end

    listcontainer:AddChild(self:CreateHeading(self.L["Active"] .. " - " .. #active))
    for f = 1, #active, 1 do
        listcontainer:AddChild(active[f])
    end

    listcontainer:AddChild(self:CreateHeading(self.L["Ignored"] .. " - " .. #ignored))
    for f = 1, #ignored, 1 do
        listcontainer:AddChild(ignored[f])
    end

    all_count = all_count - #self.ignored_db - filter_count
    local percent = self:round(known_count / all_count * 100, 2)

    self.frame.statusbar:SetMinMaxValues(0, all_count)
    self.frame.statusbar:SetValue(known_count)
    self.frame.statusbar.value:SetText(known_count .. " / " .. all_count .. " (".. percent .. "%)")
    self.frame.statusbar:Show()
end

function CollectMe:IsFiltered(filters)
    if filters ~= nil then
        for k,v in pairs(filters) do
            if v == 1 then
                for i = 1, #self.filter_list, 1 do
                    if self.filter_list[i] == k and self.filter_db[self.filter_list[i]] == true then
                        return true
                    end
                end
            end
        end
    end

    return false
end

function CollectMe:BuildFilters(filtercontainer)
    filtercontainer:AddChild(self:CreateHeading(self.L["Filters"]))

    for i = 1, #self.filter_list, 1 do
        local f = AceGUI:Create("CheckBox")
        f:SetLabel(self.L["filters_" .. self.filter_list[i]])
        f:SetPoint("Top", 15, 15)
        f:SetValue(self.filter_db[self.filter_list[i]])
        f:SetCallback("OnValueChanged", function (container, event, value) CollectMe:ToggleFilter(self.filter_list[i], value) end)
        filtercontainer:AddChild(f)
    end
end

function CollectMe:BuildOptions(container)
    container:AddChild(self:CreateHeading(self.L["Options"]))

    if self.active_tab == MOUNT then
        local f = self:GetCheckboxOption(self.L["Disable missing mount message"], self.db.profile.missing_message.mounts)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.missing_message.mounts = value end)
        container:AddChild(f)
    elseif self.active_tab == TITLE then
        local f = self:GetCheckboxOption(self.L["Disable missing title message"], self.db.profile.missing_message.titles)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.missing_message.titles = value end)
        container:AddChild(f)
    end
end

function CollectMe:GetCheckboxOption(label, init_value)
    local f = AceGUI:Create("CheckBox")
    f.text:SetMaxLines(2)
    f:SetLabel(label)
    f:SetPoint("Top", 15, 15)
    f:SetValue(init_value)
    return f
end

function CollectMe:ToggleFilter(filter, value)
    self.filter_db[filter] = value
    self:BuildList(self.scroll)
end

function CollectMe:ItemRowClick(group, spell_id)
    if self.active_tab == MOUNT and group == "LeftButton" then
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
        local ignored_table = (self.active_tab ==  MOUNT and self.db.profile.ignored.mounts or self.db.profile.ignored.titles)

        local position = self:IsInTable(ignored_table, spell_id)
        if position ~= false then
            table.remove(ignored_table, position)
        else
            table.insert(ignored_table, spell_id)
        end

        self.tabs:SelectTab(self.active_tab)

        -- SetScroll doe not calculate position accurately
        local status_table = self.scroll.localstatus
        status_table.offset = offset
        self.scroll:SetStatusTable(status_table)
    end
end

function CollectMe:ItemRowEnter(v)
    local tooltip = self.frame.tooltip
    tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
    if self.active_tab == MOUNT then
        tooltip:SetHyperlink(v.link)
        tooltip:AddLine(" ")
        tooltip:AddLine(self.L["mount_" .. v.id], 0, 1, 0, 1)
    else
        tooltip:AddLine(v.name)
        tooltip:AddLine(" ")
        tooltip:AddLine(self.L["title_" .. v.id], 0, 1, 0, 1)
    end

    if v.filters ~= nil then
        tooltip:AddLine(" ")
        for k,value in pairs(v.filters) do
            tooltip:AddLine(self.L["filters_" .. k], 0, 0.5, 1, 1)
        end
    end

    tooltip:AddLine(" ")
    if self.active_tab == MOUNT then
        tooltip:AddLine(self.L["tooltip_preview"], 0.65, 0.65, 0)
        tooltip:AddLine(self.L["tooltip_link"], 0.65, 0.65, 0)
    end
    tooltip:AddLine(self.L["tooltip_toggle"], 0.65, 0.65, 0)
    tooltip:Show()
end

function CollectMe:ItemRowLeave(v)
    self.frame.tooltip:Hide()
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
        if v.id == spell_id then
            return v
        end
    end
    return nil
end

function CollectMe:RefreshKnownMounts()
    self.known_mount_count = GetNumCompanions("Mount")
    self.known_mounts = {}

    for i = 1, self.known_mount_count, 1 do
        local _, name, spell_id = GetCompanionInfo("Mount", i)
        table.insert(self.known_mounts, spell_id);
        if self.db.profile.missing_message.mounts == false then
            if not self:IsInTable(self.MOUNT_SPELLS, spell_id) then
                self:Print(self.L["Mount"] .. " " .. name .. "("..spell_id..") " .. self.L["is missing"] .. ". " .. self.L["Please inform the author"])
            end
        end
    end
end

function CollectMe:CreateHeading(text)
    local heading = AceGUI:Create("Heading")
    heading:SetText(text)
    heading:SetFullWidth(true)

    return heading
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
    if input == "rc" or input == "randomcompanion" then
        self:SummonRandomCompanion()
    else
        self.tabs:SelectTab(MOUNT)
        self.frame:Show()
    end
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

