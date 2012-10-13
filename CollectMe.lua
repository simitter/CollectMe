CollectMe = LibStub("AceAddon-3.0"):NewAddon("CollectMe", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")

local addon_name = "CollectMe"
local MOUNT = 1
local TITLE = 2
local RANDOM_COMPANION = 3
local RANDOM_MOUNT = 4
local COMPANION = 5
local MOUNT_FILTERS = { "nlo", "tcg", "pvp", "are", "bsm", "rfm", "ptm" }
local TITLE_FILTERS = { "nlo", "pvp", "are" }

local GROUND = 1
local FLY = 2
local SWIM = 3
local AQUATIC = 4

local defaults = {
    profile = {
        ignored = {
            mounts = {},
            titles = {},
            companions = {}
        },
        filters = {
            mounts = {
                nlo = false,
                tcg = false,
                pvp = false,
                are = false,
                bsm = false,
                rfm = false,
                ptm = false
            },
            titles = {
                nlo = false,
                pvp = false,
                are = false
            }
        },
        missing_message = {
            mounts = false,
            titles = false
        },
        hide_ignore = {
            mounts = false,
            titles = false
        },
        random = {
            companions = {},
            mounts = {}
        },
        summon = {
            companions = {
                auto = false,
                disable_pvp = false
            },
            mounts = {
                flying_in_water = false,
                flying_on_ground = false,
                no_dismount = false,
                macro_left = 1,
                macro_right = 2,
                macro_shift_left = 3
            }
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

    self.cm_button_loaded = false

    self.display_creature = false

    self:BuildUI()

    self:RegisterChatCommand("collectme", "SlashProcessor")
    self:RegisterChatCommand("cm", "SlashProcessor")

    self:Hook("DressUpItemLink", true)
    self:HookScript(DressUpFrameResetButton, "OnClick", "DressUpFrameResetButton")

    self:SecureHook("MoveForwardStart", "AutoSummonCompanion")
    self:SecureHook("ToggleAutoRun", "AutoSummonCompanion")

    self:RegisterEvent("ADDON_LOADED", "AddonLoadedListener")
end

function CollectMe:AddonLoadedListener(event, name)
    if name == "Blizzard_PetJournal" and self.cm_button_loaded == false then
        local cmbutton = CreateFrame("Button", "CollectMeOpenButton", MountJournal, "UIPanelButtonTemplate")
        cmbutton:ClearAllPoints()
        cmbutton:SetPoint("BOTTOMRIGHT", -8, 3)
        cmbutton:SetHeight(22)
        cmbutton:SetWidth(100)
        cmbutton:SetText(addon_name)
        cmbutton:SetScript("OnClick", function() self.tabs:SelectTab(self.active_tab); self.frame:Show() end)

        local cmbutton2 = CreateFrame("Button", "CollectMeOpen2Button", PetJournal, "UIPanelButtonTemplate")
        cmbutton2:ClearAllPoints()
        cmbutton2:SetPoint("RIGHT", PetJournalFindBattle, "LEFT", -5, 0)
        cmbutton2:SetHeight(22)
        cmbutton2:SetWidth(100)
        cmbutton2:SetText(addon_name)
        cmbutton2:SetScript("OnClick", function() self.tabs:SelectTab(self.active_tab); self.frame:Show() end)

        self.cm_button_loaded = true
    end
end


function CollectMe:OnEnable()
    self:UpdateMacros()

    if self.professions == nil then
        self:UpdateProfessions()
    end
end

function CollectMe:UpdateMacros()
    self:InitMacro("CollectMeRC", "INV_PET_BABYBLIZZARDBEAR", '/script CollectMe:HandlePetMacro();')
    if self.CLASS == 'DRUID' then
        self:InitMacro("CollectMeRM", "ABILITY_MOUNT_BIGBLIZZARDBEAR", '/cancelform\n/script CollectMe:HandleMountMacro();')
    else
        self:InitMacro("CollectMeRM", "ABILITY_MOUNT_BIGBLIZZARDBEAR", '/script CollectMe:HandleMountMacro();')
    end
end

function CollectMe:UpdateProfessions()
    local first, second = GetProfessions()
    self.professions = {}
    if(first ~= nil) then
        self:SetProfession(first)
    end
    if(second ~= nil) then
        self:SetProfession(second)
    end
end

function CollectMe:SetProfession(index)
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
    elseif group == COMPANION then
        self.ignored_db = self.db.profile.ignored.companions
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
    tabs:SetTabs({ {text = self.L["Mounts"], value = MOUNT}, {text = self.L["Companions"], value = COMPANION}, {text = self.L["Titles"], value = TITLE}, {text = self.L["Random Companion"], value = RANDOM_COMPANION}, {text = self.L["Random Mount"], value = RANDOM_MOUNT}})
    tabs:SetCallback("OnGroupSelected", function (container, event, group) CollectMe:SelectGroup(container, group) end)
    f:AddChild(tabs)

    self.tabs = tabs
    self.frame = f

    local profilebutton = self:CreateButton(self.L["Profiles"], self.frame.frame)
    profilebutton:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory(addon_name) end)
    profilebutton:ClearAllPoints()
    profilebutton:SetPoint("RIGHT", self.frame.closebutton, "LEFT", 0, 0)

    local checkbutton = self:CreateButton(self.L["Check all"], self.frame.frame)
    checkbutton:SetScript("OnClick", function() CollectMe:BatchCheck(true) end)
    checkbutton:SetWidth(120)
    checkbutton:ClearAllPoints()
    checkbutton:SetPoint("TOPLEFT", self.tabs.frame, "BOTTOMLEFT", 35, -3)
    checkbutton:Hide()

    local uncheckbutton = self:CreateButton(self.L["Uncheck all"], self.frame.frame)
    uncheckbutton:SetScript("OnClick", function() CollectMe:BatchCheck(false) end)
    uncheckbutton:SetWidth(120)
    uncheckbutton:ClearAllPoints()
    uncheckbutton:SetPoint("LEFT", checkbutton, "RIGHT", 0, 0)
    uncheckbutton:Hide()

    self.checkbutton, self.uncheckbutton = checkbutton, uncheckbutton
end

function CollectMe:HideCheckButtons()
    self.checkbutton:Hide()
    self.uncheckbutton:Hide()
end

function CollectMe:ShowCheckButtons()
    self.checkbutton:Show()
    self.uncheckbutton:Show()
end

function CollectMe:CreateButton(text, parent)
    local f = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    f:SetHeight(20)
    f:SetWidth(100)
    f:SetText(text)
    return f
end


function CollectMe:BuildTab(container)
    self.frame.statusbar:Hide()
    self:HideCheckButtons()
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
    elseif self.active_tab == COMPANION then
        self:BuildMissingCompanionList(scroll)
        self:BuildMissingCompanionFilters(filter)
    elseif self.active_tab == RANDOM_COMPANION then
        self:BuildRandomPetList(scroll)
        self:ShowCheckButtons()
    elseif self.active_tab == RANDOM_MOUNT then
        self:BuildRandomList(scroll)
        self:ShowCheckButtons()
    end

    self:BuildOptions(filter)
end

function CollectMe:BuildRandomPetList(listcontainer)
    local collected_filter, favorite_filter = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_COLLECTED), not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_FAVORITES)
    C_PetJournal.SetSearchFilter("")
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true)
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false)

    local count, owned = C_PetJournal.GetNumPets(false)
    local random_db =  self.db.profile.random.companions

    listcontainer:AddChild(self:CreateHeading(self.L["Available companions"] ..  " - " .. owned))
    for i = 1,count do
        local id, _, owned, my_name, level, _, _, name = C_PetJournal.GetPetInfoByIndex(i, false)
        if name ~= nil and owned == true and C_PetJournal.PetIsSummonable(id) then
            local f = AceGUI:Create("CheckBox")
            if my_name ~= nil then
                f:SetLabel(name .. " - " .. my_name)
            else
                f:SetLabel(name)
            end
            f:SetFullWidth(true)
            local value = ((random_db[id] ~= nil and random_db[id] ~= false) and true or false)
            f:SetValue(value)
            f:SetCallback("OnValueChanged", function (container, event, val) random_db[id] = val end)
            listcontainer:AddChild(f)
        end
    end

    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, collected_filter)
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, favorite_filter)
end


function CollectMe:BuildRandomList(listcontainer)
    local type, random_db, title = "MOUNT", self.db.profile.random.mounts, self.L["Available mounts"]

    local count = GetNumCompanions(type)
    listcontainer:AddChild(self:CreateHeading(title ..  " - " .. count))

    for i = 1, count, 1 do
        local _, name, spell_id = GetCompanionInfo(type, i)
        local f = AceGUI:Create("CheckBox")
        f:SetLabel(name)
        f:SetFullWidth(true)
        local value = ((random_db[spell_id] ~= nil and random_db[spell_id] ~= false) and true or false)
        f:SetValue(value)
        f:SetCallback("OnValueChanged", function (container, event, val) random_db[spell_id] = val end)

        listcontainer:AddChild(f)
    end
end

function CollectMe:SummonRandomCompanion()
    local summonable = {};

    for i,v in pairs(self.db.profile.random.companions) do
        if v == true and C_PetJournal.PetIsSummonable(i) then
            table.insert(summonable, i)
        end
    end

    if (#summonable > 0) then
        local call = math.random(1, #summonable)
        C_PetJournal.SummonPetByID(summonable[call])
    else
        self:Print(self.L["You haven't configured your companion priorities yet. Please open the random companion tab"])
    end
end

function CollectMe:GetCurrentZone()
    SetMapToCurrentZone()
    return GetCurrentMapAreaID()
end

function CollectMe:SummonRandomMount(type)
    if not IsMounted() then
        local zone_mounts, type_mounts, fallback_mounts = {}, {}, {}
        local zone_id, is_swimming, is_flyable_area = self:GetCurrentZone(), IsSwimming(), IsFlyableArea()
        local profession_count = #self.professions
        for i = 1, GetNumCompanions("MOUNT") do
            local _, name, spell_id = GetCompanionInfo("MOUNT", i);

            -- check if current mount is in priority pool and if it is usable here
            if self.db.profile.random.mounts[spell_id] ~= nil and self.db.profile.random.mounts[spell_id] ~= false and IsUsableSpell(spell_id) ~= nil then

                -- get info table from mount db
                local info = self:GetMountInfo(spell_id)
                if info == nil then
                    info = {
                        type = GROUND, --mount not known, assuming it' is a ground mount
                        name    = name,
                        id      = spell_id
                    }
                end

                if info.professions == nil or self:ProfessionMount(info) == true then
                    -- setting up zone table (aquatic handled by that too currently)
                    if(info.zones ~= nil and self:IsInTable(info.zones, zone_id)) then
                        table.insert(zone_mounts, i)
                    end

                    if #zone_mounts == 0 then
                        -- swimming mounts
                        if is_swimming == 1 then
                            if info.type == SWIM or (self.db.profile.summon.mounts.flying_in_water == true and info.type == FLY and is_flyable_area == 1) then
                                table.insert(type_mounts, i)
                            end
                        -- flying mounts
                        elseif is_flyable_area == 1 then
                            if info.type == FLY then
                                table.insert(type_mounts, i)
                            end
                        end
                    end
                    if info.type == GROUND or (self.db.profile.summon.mounts.flying_on_ground  == true and info.type == FLY) then
                        table.insert(fallback_mounts, i)
                    end
                end
            end
        end


        if type == GROUND and #fallback_mounts > 0 then
            self:Mount(fallback_mounts)
        elseif #zone_mounts > 0 then
            self:Mount(zone_mounts)
        elseif #type_mounts > 0 then
            self:Mount(type_mounts)
        elseif #fallback_mounts > 0 then
            self:Mount(fallback_mounts)
        else
            if IsIndoors() == nil and UnitAffectingCombat("player") == nil then
                self:Print(self.L["You haven't configured your mount priorities yet. Please open the random mount tab"])
            end
        end

    elseif self.db.profile.summon.mounts.no_dismount == false then
        Dismount()
    end
end

function CollectMe:ProfessionMount(info)
    for i,v in pairs(info.professions) do
        for j, v1 in pairs(self.professions) do
            if i == v1.name and v1.skill >= v then
                return true
            end
        end
    end
    return false
end

function CollectMe:Mount(t)
    local call = math.random(1, #t);
    CallCompanion("MOUNT", t[call]);
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
                f:SetImageSize(20, 20)
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

    self:AddMissingRows(listcontainer, active, ignored, all_count, known_count, filter_count)
end

function CollectMe:AddMissingRows(container, active, ignored, all_count, known_count, filter_count)
    container:AddChild(self:CreateHeading(self.L["Missing"] .. " - " .. #active))
    for f = 1, #active, 1 do
        container:AddChild(active[f])
    end

    local hide_ignore = (self.active_tab == MOUNT and self.db.profile.hide_ignore.mounts or self.db.profile.hide_ignore.titles )
    if hide_ignore == false then
        container:AddChild(self:CreateHeading(self.L["Ignored"] .. " - " .. #ignored))
        for f = 1, #ignored, 1 do
            container:AddChild(ignored[f])
        end
    end

    all_count = all_count - #self.ignored_db - filter_count
    local percent = self:round(known_count / all_count * 100, 2)

    self.frame.statusbar:SetMinMaxValues(0, all_count)
    self.frame.statusbar:SetValue(known_count)
    self.frame.statusbar.value:SetText(known_count .. " / " .. all_count .. " (".. percent .. "%)")
    self.frame.statusbar:Show()
end

function CollectMe:BuildMissingCompanionList(listcontainer)
    listcontainer:ReleaseChildren()
    local collected_filter = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED)
    C_PetJournal.SetSearchFilter("")
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true)
    local total = C_PetJournal.GetNumPets(false)
    local active, ignored, owned_db = {}, {}, {}

    for i = 1,total do
        local pet_id, _, owned, _, _, _, _, name, icon, _, creature_id, source = C_PetJournal.GetPetInfoByIndex(i, false)
        if owned ~= true then
            local f = self:CreateItemRow()
            f:SetImage(icon)
            f:SetImageSize(20, 20)
            f:SetText(name)
            f:SetCallback("OnClick", function (container, event, group) CollectMe:ItemRowClick(group, creature_id) end)
            f:SetCallback("OnEnter", function (container, event, group) CollectMe:ItemRowEnter({ creature_id = creature_id, source = source, name = name }) end)
            f:SetCallback("OnLeave", function (container, event, group) CollectMe:ItemRowLeave() end)

            if self:IsInTable(self.ignored_db, creature_id) then
                table.insert(ignored, f)
            else
                table.insert(active, f)
            end
        else
            if not self:IsInTable(owned_db, creature_id) then
                table.insert(owned_db, creature_id)
            end
        end
    end

    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, collected_filter)
    self:AddMissingRows(listcontainer, active, ignored, #active + #ignored + #owned_db, #owned_db, 0)
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

function CollectMe:BuildMissingCompanionFilters(container)
    container:AddChild(self:CreateHeading(self.L["Source Filter"]))
    local numSources = C_PetJournal.GetNumPetSources();
    for i=1,numSources do
        local f = AceGUI:Create("CheckBox")
        f:SetLabel(_G["BATTLE_PET_SOURCE_"..i])
        f:SetValue(C_PetJournal.IsPetSourceFiltered(i))
        f:SetCallback("OnValueChanged", function (container, event, value)
            value = not value
            C_PetJournal.SetPetSourceFilter(i, value)
            CollectMe:BuildMissingCompanionList(self.scroll)
        end)
        container:AddChild(f)
    end

    container:AddChild(self:CreateHeading(self.L["Family Filter"]))
    local numTypes = C_PetJournal.GetNumPetTypes();
    for i=1,numTypes do
        local f = AceGUI:Create("CheckBox")
        f:SetLabel(_G["BATTLE_PET_NAME_"..i])
        f:SetValue(C_PetJournal.IsPetTypeFiltered(i))
        f:SetCallback("OnValueChanged", function (container, event, value)
            value = not value
            C_PetJournal.SetPetTypeFilter(i, value)
            CollectMe:BuildMissingCompanionList(self.scroll)
        end)
        container:AddChild(f)
    end
end

function CollectMe:BuildOptions(container)
    container:AddChild(self:CreateHeading(self.L["Options"]))

    if self.active_tab == MOUNT then
        local f = self:GetCheckboxOption(self.L["Disable missing mount message"], self.db.profile.missing_message.mounts)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.missing_message.mounts = value end)
        container:AddChild(f)
        local f = self:GetCheckboxOption(self.L["Hide ignored list"], self.db.profile.hide_ignore.mounts)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.hide_ignore.mounts = value; self:BuildList(self.scroll) end)
        container:AddChild(f)
    elseif self.active_tab == TITLE then
        local f = self:GetCheckboxOption(self.L["Disable missing title message"], self.db.profile.missing_message.titles)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.missing_message.titles = value end)
        container:AddChild(f)
        local f = self:GetCheckboxOption(self.L["Hide ignored list"], self.db.profile.hide_ignore.titles)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.hide_ignore.titles = value; self:BuildList(self.scroll) end)
        container:AddChild(f)
    elseif self.active_tab == RANDOM_COMPANION then
        local f = self:GetCheckboxOption(self.L["Auto summon on moving forward"], self.db.profile.summon.companions.auto)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.summon.companions.auto = value end)
        container:AddChild(f)
        local f = self:GetCheckboxOption(self.L["Disable auto summon in pvp"], self.db.profile.summon.companions.disable_pvp)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.summon.companions.disable_pvp = value end)
        container:AddChild(f)
    elseif self.active_tab == RANDOM_MOUNT then
        local f = self:GetCheckboxOption(self.L["Don't dismount when left-clicking on macro"], self.db.profile.summon.mounts.no_dismount)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.summon.mounts.no_dismount = value end)
        container:AddChild(f)
        local f = self:GetCheckboxOption(self.L["Use flying mounts in water"], self.db.profile.summon.mounts.flying_in_water)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.summon.mounts.flying_in_water = value end)
        container:AddChild(f)
        local f = self:GetCheckboxOption(self.L["Use flying mounts for ground"], self.db.profile.summon.mounts.flying_on_ground)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.summon.mounts.flying_on_ground = value end)
        container:AddChild(f)

        container:AddChild(self:CreateHeading(self.L["Macro"]))

        local f = self:CreateMacroDropdown(self.L["Left Click"], self.db.profile.summon.mounts.macro_left)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.summon.mounts.macro_left = value end)
        container:AddChild(f)
        local f = self:CreateMacroDropdown(self.L["Right Click"], self.db.profile.summon.mounts.macro_right)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.summon.mounts.macro_right = value end)
        container:AddChild(f)
        local f = self:CreateMacroDropdown(self.L["Shift + Left Click"], self.db.profile.summon.mounts.macro_shift_left)
        f:SetCallback("OnValueChanged", function (container, event, value) self.db.profile.summon.mounts.macro_shift_left = value end)
        container:AddChild(f)

    end
end

function CollectMe:BatchCheck(value)
    if self.active_tab == RANDOM_MOUNT then
        local random_db = self.db.profile.random.mounts
        local count = GetNumCompanions("MOUNT")
        for i = 1, count, 1 do
            local _, name, spell_id = GetCompanionInfo("MOUNT", i)
            random_db[spell_id] = value
        end
        self:SelectGroup(self.tabs, RANDOM_MOUNT)
    elseif self.active_tab == RANDOM_COMPANION then
        local count, owned = C_PetJournal.GetNumPets(false)
        local random_db =  self.db.profile.random.companions

        for i = 1,count do
            local id, _, owned, my_name, level, _, _, name = C_PetJournal.GetPetInfoByIndex(i, false)
            if name ~= nil and owned == true and C_PetJournal.PetIsSummonable(id) then
                random_db[id] = value
            end
        end
        self:SelectGroup(self.tabs, RANDOM_COMPANION)
    end
end

function CollectMe:HandleMountMacro()
    if GetMouseButtonClicked() == "RightButton" then
        value = self.db.profile.summon.mounts.macro_right
    elseif IsShiftKeyDown() then
        value = self.db.profile.summon.mounts.macro_shift_left
    else
        value = self.db.profile.summon.mounts.macro_left
    end

    if value == 1 then
        self:SummonRandomMount()
    elseif value == 2 then
        if IsMounted() then
            Dismount()
        end
    elseif value == 3 then
        self:SummonRandomMount(1)
    end
end

function CollectMe:HandlePetMacro()
    if GetMouseButtonClicked() == "RightButton" then
        self:DismissPet()
    else
        self:SummonRandomCompanion()
    end
end

function CollectMe:DismissPet()
    local active = C_PetJournal.GetSummonedPetID()
    if active ~= nil then
        C_PetJournal.SummonPetByID(active)
    end
end

function CollectMe:CreateMacroDropdown(label, value)
    local list = {}
    list[1] = self.L["Mount / Dismount"]
    list[2] = self.L["Dismount"]
    list[3] = self.L["Ground Mount / Dismount"]

    local f = AceGUI:Create("Dropdown")
    f:SetLabel(label)
    f:SetList(list)
    f.label:ClearAllPoints()
    f.label:SetPoint("LEFT", 10, 15)
    f.dropdown:ClearAllPoints()
    f.dropdown:SetPoint("TOPLEFT",f.frame,"TOPLEFT",-10,-15)
    f.dropdown:SetPoint("BOTTOMRIGHT",f.frame,"BOTTOMRIGHT",17,0)
    f:SetValue(value)
    return f
end

function CollectMe:GetCheckboxOption(label, init_value)
    local f = AceGUI:Create("CheckBox")
    f.text:SetMaxLines(2)
    f:SetLabel(label)
    f:SetHeight(35)
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
                self:PreviewCreature(mount.display_id)
            end
        end
    elseif self.active_tab == COMPANION and group == "LeftButton" then
        if spell_id ~= nil then
            self:PreviewCreature(spell_id)
        end
    elseif group == "RightButton" and IsControlKeyDown() then
        local offset = self.scroll.localstatus.offset
        local ignored_table = self.ignored_db

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

function CollectMe:PreviewCreature(display_id)
    if display_id ~= nil then
        self.display_creature = true
        DressUpBackgroundTopLeft:SetTexture(nil);
        DressUpBackgroundTopRight:SetTexture(nil);
        DressUpBackgroundBotLeft:SetTexture(nil);
        DressUpBackgroundBotRight:SetTexture(nil);
        if self.active_tab == COMPANION then
            DressUpModel:SetCreature(display_id)
        else
            DressUpModel:SetDisplayInfo(display_id)
        end
        if not DressUpFrame:IsShown() then
            ShowUIPanel(DressUpFrame);
        end
    end
end

function CollectMe:ItemRowEnter(v)
    local tooltip = self.frame.tooltip
    tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
    if self.active_tab == MOUNT then
        tooltip:SetHyperlink(v.link)
        tooltip:AddLine(" ")
        tooltip:AddLine(self.L["mount_" .. v.id], 0, 1, 0, 1)
    elseif self.active_tab == COMPANION then
        tooltip:AddLine(v.name, 1, 1 ,1)
        tooltip:AddLine(" ")
        tooltip:AddLine(v.source, 0, 1, 0, 1)
        local info = self.L["companion_" .. v.creature_id]
        if string.find(info, "companion_") == nil then
            tooltip:AddLine(" ")
            tooltip:AddLine(info, 0, 1, 0, 1)
        end
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
    elseif self.active_tab == COMPANION then
        tooltip:AddLine(self.L["tooltip_preview"], 0.65, 0.65, 0)
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

function CollectMe:GetActive(type)
    for i = 1, GetNumCompanions(type) do
        local _, _, spell_id, _, summoned = GetCompanionInfo("CRITTER", i);
        if (summoned ~= nil) then
            return spell_id
        end
    end
    return nil;
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

function CollectMe:PrintAllTitles()
    for i = 1, GetNumTitles(), 1 do
        local name = GetTitleName(i)
        if name ~= nil then
            self:Print(i.. " - " ..name)
        end
    end
end

-- no round in math library? seriously????
function CollectMe:round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function CollectMe:SortTable(tbl)
    table.sort(tbl, function(a, b) return (string.lower(a.name) < string.lower(b.name)) end)
end

function CollectMe:PrintProfessions()
    for i,v in ipairs(self.professions) do
        self:Print(v.name ..' - '.. v.skill)
    end
end

 -- CONSOLE COMMAND HANDLER
function CollectMe:SlashProcessor(input)
    if input == "rc" or input == "randomcompanion" then
        self:SummonRandomCompanion()
    elseif input == "rm" or input == "randommount" then
        self:SummonRandomMount()
    elseif input == "options" then
        InterfaceOptionsFrame_OpenToCategory(addon_name)
    elseif input == "debug zone" then
        self:Print(self:GetCurrentZone())
    elseif input == "debug title" then
        self:PrintAllTitles()
    elseif input == "debug profession" then
        self:PrintProfessions()
    elseif input == "macro" then
        self:UpdateMacros()
    else
        self.tabs:SelectTab(self.active_tab)
        self.frame:Show()
    end
end

 -- HOOKS
function CollectMe:DressUpItemLink(link)
    local spell = tonumber(link:match("spell:(%d+)"));
    if spell ~= nil then
        local info = self:GetMountInfo(spell)
        if info ~= nil then
            self:PreviewCreature(info.display_id)
            return true
        end
    end
    if self.display_creature == true then
        SetDressUpBackground(DressUpFrame, self.RACE);
        DressUpModel:SetUnit("player")
        self.display_creature = false
    end
end

function CollectMe:DressUpFrameResetButton()
     SetDressUpBackground(DressUpFrame, self.RACE);
     DressUpModel:SetUnit("player");
end

function CollectMe:AutoSummonCompanion()
    if UnitAffectingCombat("player") == nil and IsMounted() == nil and IsStealthed() == nil and self.db.profile.summon.companions.auto == true then
        if (not (UnitIsPVP("player") == 1 and self.db.profile.summon.companions.disable_pvp == true)) then
            local active = C_PetJournal.GetSummonedPetID()
            if (active == nil) then
                self:SummonRandomCompanion()
            end
        end
    end
    if (UnitIsPVP("player") == 1 and self.db.profile.summon.companions.disable_pvp == true) then
        self:DismissPet()
    end
end
