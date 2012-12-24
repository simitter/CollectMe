CollectMe = LibStub("AceAddon-3.0"):NewAddon("CollectMe", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0")
local addon_name = "CollectMe"

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
        },
        tooltip = {
            companions = {
                hide = false,
                quality_check = true
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
    self.ADDON_NAME = addon_name
    self.VERSION = GetAddOnMetadata("CollectMe", "Version")
    self.L = LibStub("AceLocale-3.0"):GetLocale("CollectMe", true)

    self.MOUNT = 1
    self.TITLE = 2
    self.RANDOM_COMPANION = 3
    self.RANDOM_MOUNT = 4
    self.COMPANION = 5

    self.FACTION = UnitFactionGroup("player")
    LocalizedPlayerRace, self.RACE = UnitRace("player")
    LocalizedPlayerClass, self.CLASS = UnitClass("player")

    LibStub("AceConfig-3.0"):RegisterOptionsTable(addon_name, options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addon_name)

    self.db = LibStub("AceDB-3.0"):New("CollectMeDB", defaults)
    options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

    self.filter_db = self.db.profile.filters.mounts
    self.ignored_db = self.db.profile.ignored.mounts
    self.item_list = self.MountDB:Get()
    self.filter_list = self.MountDB.filters

    self:RegisterChatCommand("collectme", "SlashProcessor")
    self:RegisterChatCommand("cm", "SlashProcessor")
end

function CollectMe:BuildData(no_filters)
    if self.UI.active_group == self.MOUNT then
        self.filter_db = self.db.profile.filters.mounts
        self.ignored_db = self.db.profile.ignored.mounts
        self.item_list = self.MountDB:Get()
        self.filter_list = self.MountDB.filters
        self:BuildList()
        if not no_filters then
            self:BuildFilters()
        end
    elseif self.UI.active_group == self.TITLE then
        self.filter_db = self.db.profile.filters.titles
        self.ignored_db = self.db.profile.ignored.titles
        self.item_list = self.TitleDB:Get()
        self.filter_list = self.TitleDB.filters
        self:BuildList()
        if not no_filters then
            self:BuildFilters()
        end

    elseif self.UI.active_group == self.COMPANION then
        self.ignored_db = self.db.profile.ignored.companions
        self:BuildMissingCompanionList()
        if not no_filters then
            self:BuildMissingCompanionFilters()
        end
    elseif self.UI.active_group == self.RANDOM_COMPANION then
        self:BuildRandomPetList()
        self.UI:ShowCheckButtons()
    elseif self.UI.active_group == self.RANDOM_MOUNT then
        self:BuildRandomList()
        self.UI:ShowCheckButtons()
    end

    if not no_filters then
        self:BuildOptions()
    end
end


function CollectMe:BuildRandomPetList()
    local companions = self.CompanionDB:Get()
    local random_db =  self.db.profile.random.companions
    local search = self.UI:GetSearchText():lower()

    self.UI:AddToScroll(self.UI:CreateHeading(self.L["Available companions"] ..  " - " .. #companions))
    for i,v in ipairs(companions) do
        if C_PetJournal.PetIsSummonable(v.pet_id) then
            local name = v.name
            if v.custom_name ~= nil then
                name = name .. " - " .. v.custom_name
            end
            if name:lower():find(search) ~= nil then
                local value = ((random_db[v.pet_id] ~= nil and random_db[v.pet_id] ~= false) and true or false)
                self.UI:CreateScrollCheckbox(self:ColorizeByQuality(name .." - " .. v.level, v.color), value, { OnValueChanged = function (container, event, val) random_db[v.pet_id] = val end})
            end
        end
    end
end


function CollectMe:BuildRandomList()
    local type, random_db, title = "MOUNT", self.db.profile.random.mounts, self.L["Available mounts"]
    local count = GetNumCompanions(type)
    local search = self.UI:GetSearchText():lower()

    self.UI:AddToScroll(self.UI:CreateHeading(title ..  " - " .. count))
    for i = 1, count, 1 do
        local _, name, spell_id = GetCompanionInfo(type, i)
        if name:lower():find(search) ~= nil then
            local value = ((random_db[spell_id] ~= nil and random_db[spell_id] ~= false) and true or false)
            self.UI:CreateScrollCheckbox(name, value, { OnValueChanged = function (container, event, val) random_db[spell_id] = val end})
        end
    end
end

function CollectMe:BuildList()
    if self.UI.active_group == self.MOUNT then
        self.MountDB:RefreshKnown()
    elseif self.UI.active_group == self.TITLE and self.db.profile.missing_message.titles == false then
        self.TitleDB:PrintUnkown()
    end

    local active, ignored = {}, {}
    local all_count, known_count, filter_count = #self.item_list, 0, 0

    for i,v in ipairs(self.item_list) do
        if (self.UI.active_group == self.MOUNT and not self.MountDB:IsKnown(v.id)) or (self.UI.active_group == self.TITLE and IsTitleKnown(v.id) ~= 1) then
            if self:IsInTable(self.ignored_db, v.id) then
                table.insert(ignored, v)
            else
                if not self:IsFiltered(v.filters) then
                    table.insert(active, v)
                else
                    filter_count = filter_count + 1
                end
            end
        else
            known_count = known_count +1
        end
    end

    self:AddMissingRows(active, ignored, all_count, known_count, filter_count)
end

function CollectMe:AddMissingRows(active, ignored, all_count, known_count, filter_count)
    self.UI:AddToScroll(self.UI:CreateHeading(self.L["Missing"] .. " - " .. #active))
    self:BuildItemRow(active)

    local hide_ignore = (self.UI.active_group == self.MOUNT and self.db.profile.hide_ignore.mounts or self.db.profile.hide_ignore.titles )
    if hide_ignore == false then
        self.UI:AddToScroll(self.UI:CreateHeading(self.L["Ignored"] .. " - " .. #ignored))
        self:BuildItemRow(ignored)
    end

    all_count = all_count - #self.ignored_db - filter_count
    self.UI:UpdateStatusBar(all_count, known_count)
end

function CollectMe:BuildItemRow(items)
    local search = self.UI:GetSearchText():lower()
    for i,v in ipairs(items) do
        if v.name:lower():find(search) ~= nil then
            local callbacks
            if not v.callbacks then
                callbacks = {
                    OnClick = function (container, event, group) CollectMe:ItemRowClick(group, v.id) end,
                    OnEnter = function (container, event, group) CollectMe:ItemRowEnter(v) end ,
                    OnLeave = function (container, event, group) CollectMe:ItemRowLeave(v) end ,
                }
            else
                callbacks = v.callbacks
            end
            self.UI:CreateScrollLabel(v.name, v.icon, callbacks)
        end
    end
end

function CollectMe:BuildMissingCompanionList()
    local collected_filter = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED)
    C_PetJournal.SetSearchFilter("")
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true)
    local total = C_PetJournal.GetNumPets(false)
    local active, ignored, owned_db = {}, {}, {}

    for i = 1,total do
        local pet_id, _, owned, _, _, _, _, name, icon, _, creature_id, source = C_PetJournal.GetPetInfoByIndex(i, false)
        if owned ~= true then
            local v = {
                name = name,
                icon = icon,
                callbacks = {
                    OnClick = function (container, event, group) CollectMe:ItemRowClick(group, creature_id) end,
                    OnEnter = function (container, event, group) CollectMe:ItemRowEnter({ creature_id = creature_id, source = source, name = name }) end,
                    OnLeave = function (container, event, group) CollectMe:ItemRowLeave() end
                }
            }
            if self:IsInTable(self.ignored_db, creature_id) then
                table.insert(ignored, v)
            else
                table.insert(active, v)
            end
        else
            if not self:IsInTable(owned_db, creature_id) then
                table.insert(owned_db, creature_id)
            end
        end
    end

    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, collected_filter)
    self:AddMissingRows(active, ignored, #active + #ignored + #owned_db, #owned_db, 0)
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

function CollectMe:BuildFilters()
    self.UI:AddToFilter(self.UI:CreateHeading(self.L["Filters"]))

    for i = 1, #self.filter_list, 1 do
        self.UI:CreateFilterCheckbox(self.L["filters_" .. self.filter_list[i]], self.filter_db[self.filter_list[i]], { OnValueChanged = function (container, event, value) CollectMe:ToggleFilter(self.filter_list[i], value) end })
    end
end

function CollectMe:BuildMissingCompanionFilters()
    self.UI:AddToFilter(self.UI:CreateHeading(self.L["Source Filter"]))
    local numSources = C_PetJournal.GetNumPetSources();
    for i=1,numSources do
        self.UI:CreateFilterCheckbox(_G["BATTLE_PET_SOURCE_"..i], C_PetJournal.IsPetSourceFiltered(i), { OnValueChanged = function (container, event, value) value = not value; C_PetJournal.SetPetSourceFilter(i, value); self.UI:ReloadScroll() end })
    end

    self.UI:AddToFilter(self.UI:CreateHeading(self.L["Family Filter"]))
    local numTypes = C_PetJournal.GetNumPetTypes();
    for i=1,numTypes do
        self.UI:CreateFilterCheckbox(_G["BATTLE_PET_NAME_"..i], C_PetJournal.IsPetTypeFiltered(i), { OnValueChanged = function (container, event, value) value = not value; C_PetJournal.SetPetTypeFilter(i, value); self.UI:ReloadScroll() end })
    end
end

function CollectMe:BuildOptions()
    self.UI:AddToFilter(self.UI:CreateHeading(self.L["Options"]))

    if self.UI.active_group == self.MOUNT then
        self.UI:CreateFilterCheckbox(self.L["Disable missing mount message"], self.db.profile.missing_message.mounts, { OnValueChanged = function (container, event, value) self.db.profile.missing_message.mounts = value end }, 2)
        self.UI:CreateFilterCheckbox(self.L["Hide ignored list"], self.db.profile.hide_ignore.mounts, { OnValueChanged = function (container, event, value) self.db.profile.hide_ignore.mounts = value; self.UI:ReloadScroll() end })
    elseif self.UI.active_group == self.TITLE then
        self.UI:CreateFilterCheckbox(self.L["Disable missing title message"], self.db.profile.missing_message.titles, { OnValueChanged = function (container, event, value) self.db.profile.missing_message.titles = value end })
        self.UI:CreateFilterCheckbox(self.L["Hide ignored list"], self.db.profile.hide_ignore.titles, { OnValueChanged = function (container, event, value) self.db.profile.hide_ignore.titles = value; self.UI:ReloadScroll() end })
    elseif self.UI.active_group == self.COMPANION then
        self.UI:CreateFilterCheckbox(self.L["Disable tooltip notice for missing companions"], self.db.profile.tooltip.companions.hide, { OnValueChanged = function (container, event, value) self.db.profile.tooltip.companions.hide = value end }, 2)
        self.UI:CreateFilterCheckbox(self.L["Perform quality check in pet battles"], self.db.profile.tooltip.companions.quality_check, { OnValueChanged = function (container, event, value) self.db.profile.tooltip.companions.quality_check = value end }, 2)
    elseif self.UI.active_group == self.RANDOM_COMPANION then
        self.UI:CreateFilterCheckbox(self.L["Auto summon on moving forward"], self.db.profile.summon.companions.auto, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.auto = value end }, 2)
        self.UI:CreateFilterCheckbox(self.L["Disable auto summon in pvp"], self.db.profile.summon.companions.disable_pvp, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_pvp = value end }, 2)
    elseif self.UI.active_group == self.RANDOM_MOUNT then
        self.UI:CreateFilterCheckbox(self.L["Don't dismount when left-clicking on macro"], self.db.profile.summon.mounts.no_dismount, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.no_dismount = value end }, 2)
        self.UI:CreateFilterCheckbox(self.L["Use flying mounts in water"], self.db.profile.summon.mounts.flying_in_water, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.flying_in_water = value end }, 2)
        self.UI:CreateFilterCheckbox(self.L["Use flying mounts for ground"], self.db.profile.summon.mounts.flying_on_ground, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.flying_on_ground = value end }, 2)

        self.UI:AddToFilter(self.UI:CreateHeading(self.L["Macro"]))
        local list = {}
        list[1] = self.L["Mount / Dismount"]
        list[2] = self.L["Dismount"]
        list[3] = self.L["Ground Mount / Dismount"]
        self.UI:CreateFilterDropdown(self.L["Left Click"], list, self.db.profile.summon.mounts.macro_left, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.macro_left = value end })
        self.UI:CreateFilterDropdown(self.L["Right Click"], list, self.db.profile.summon.mounts.macro_right, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.macro_right = value end })
        self.UI:CreateFilterDropdown(self.L["Shift + Left Click"], list, self.db.profile.summon.mounts.macro_shift_left, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.macro_shift_left = value end })
    end
end

function CollectMe:BatchCheck(value)
    if self.UI.active_group == self.RANDOM_MOUNT then
        local random_db = self.db.profile.random.mounts
        local count = GetNumCompanions("MOUNT")
        for i = 1, count, 1 do
            local _, name, spell_id = GetCompanionInfo("MOUNT", i)
            random_db[spell_id] = value
        end
        self.UI:ReloadScroll()
    elseif self.UI.active_group == self.RANDOM_COMPANION then
        local random_db =  self.db.profile.random.companions

        for i,v in pairs(self.CompanionDB:Get()) do
            if v.pet_id ~= nil and C_PetJournal.PetIsSummonable(v.pet_id) then
                random_db[v.pet_id] = value
            end
        end
        self.UI:ReloadScroll()
    end
end

function CollectMe:ToggleFilter(filter, value)
    self.filter_db[filter] = value
    self.UI:ReloadScroll()
end

function CollectMe:ItemRowClick(group, spell_id)
    if self.UI.active_group == self.MOUNT and group == "LeftButton" then
        local mount = self.MountDB:GetInfo(spell_id)
        if mount ~= nil then
            if IsShiftKeyDown() == 1 and mount.link ~= nil then
                ChatEdit_InsertLink(mount.link)
            elseif mount.display_id ~= nil then
                self.ModelPreview:PreviewCreature(mount.display_id)
            end
        end
    elseif self.UI.active_group == self.COMPANION and group == "LeftButton" then
        if spell_id ~= nil then
            self.ModelPreview:PreviewCreature(spell_id)
        end
    elseif group == "RightButton" and IsControlKeyDown() then
        local ignored_table = self.ignored_db

        local position = self:IsInTable(ignored_table, spell_id)
        if position ~= false then
            table.remove(ignored_table, position)
        else
            table.insert(ignored_table, spell_id)
        end

        self.UI:ReloadScroll()
    end
end

function CollectMe:ItemRowEnter(v)
    local tooltip = self.UI.frame.tooltip
    tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
    if self.UI.active_group == self.MOUNT then
        tooltip:SetHyperlink(v.link)
        tooltip:AddLine(" ")
        tooltip:AddLine(self.L["mount_" .. v.id], 0, 1, 0, 1)
    elseif self.UI.active_group == self.COMPANION then
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
    if self.UI.active_group == self.MOUNT then
        tooltip:AddLine(self.L["tooltip_preview"], 0.65, 0.65, 0)
        tooltip:AddLine(self.L["tooltip_link"], 0.65, 0.65, 0)
    elseif self.UI.active_group == self.COMPANION then
        tooltip:AddLine(self.L["tooltip_preview"], 0.65, 0.65, 0)
    end
    tooltip:AddLine(self.L["tooltip_toggle"], 0.65, 0.65, 0)
    tooltip:Show()
end

function CollectMe:ItemRowLeave()
    self.UI.frame.tooltip:Hide()
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
        self.RandomCompanion:Summon()
    elseif input == "rm" or input == "randommount" then
        self.RandomMount:Summon()
    elseif input == "options" then
        InterfaceOptionsFrame_OpenToCategory(addon_name)
    elseif input == "companion zone" then
        self:CompanionsInZone()
    elseif input == "debug title" then
        self.TitleDB:PrintAll()
    elseif input == "macro" then
        self:UpdateMacros()
    else
        self.UI:Show()
    end
end

function CollectMe:ColorizeByQuality(text, quality)
    local color = "|C" .. select(4, GetItemQualityColor(quality))
    return color .. text .. FONT_COLOR_CODE_CLOSE;
end

function CollectMe:CompanionsInZone()
    local zone = self.ZoneDB:Current()
    local known, unknown = self.CompanionDB:GetCompanionsInZone(zone)
    for i,v in ipairs(known) do
        self:Print("known "..v.name)
    end
    for i,v in ipairs(unknown) do
        self:Print("unknown "..v.name)
    end
end
