local CollectMe = LibStub("AceAddon-3.0"):NewAddon("CollectMe", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0")
local addon_name = "CollectMe"

CollectMe.ADDON_NAME = addon_name
CollectMe.VERSION = GetAddOnMetadata("CollectMe", "Version")
CollectMe.L = LibStub("AceLocale-3.0"):GetLocale("CollectMe", true)

local defaults = {
    profile = {
        ignored = {
            mounts = {},
            titles = {},
            companions = {},
            toys = {}
        },
        export = {
            companions = {},
            mounts = {}
        },
        filters = {
            mounts = {
                nlo = false,
                umo = false,
                tcg = false,
                pvp = false,
                are = false,
                bsm = false,
                rfm = false,
                ptm = false,
                czo = false,
                zones = {},
                sources = {}
            },
            titles = {
                nlo = false,
                pvp = false,
                are = false
            },
            companions = {
                czo = false,
                zones = {}
            },
            toys = {
                czo = false,
                zones = {}
            }
        },
        missing_message = {
            titles = false
        },
        hide_ignore = {
            mounts = false,
            companions = false,
            titles = false,
            toys = false
        },
        random = {
            companions = {},
            mounts = {}
        },
        summon = {
            companions = {
                auto = false,
                disable_pvp = false,
                disable_pvp_arena = true,
                disable_pvp_bg = true,
                disable_pvp_world = true,
                disable_party_grp = false,
                disable_party_raid_grp = false,
                disable_raid_instance = false,
                disable_dungeon = false,
                disable_scenario = false
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
                hide = false
            }
        },
        battles ={
            quality_check = true,
            missing_check = true,
            level_check = true
        },
        ldb = {
            tooltip = {
                companions = {
                    collected = true,
                    missing = true,
                    quality = true
                },
                mounts = {
                    collected = true,
                    missing = true
                },
                toys = {
                    collected = true,
                    missing = true
                }
            },
            text = {
                companions = {
                    collected = true,
                    missing = true,
                    quality = true
                },
                mounts = {
                    collected = true,
                    missing = true
                },
                toys = {
                    collected = true,
                    missing = true
                }
            }
        },
        macro = {
            mount = true,
            nostance = true,
            companion = true
        }
    }
}

function CollectMe:OnInitialize()
    --bindings
    BINDING_HEADER_COLLECTME = addon_name
    BINDING_NAME_MISSING_MOUNTS = self.L["Mounts"]
    BINDING_NAME_MISSING_COMPANIONS = self.L["Companions"]
    BINDING_NAME_MISSING_TITLES = self.L["Titles"]
    BINDING_NAME_RANDOM_MOUNTS = self.L["Random Mount"]
    BINDING_NAME_RANDOM_COMPANIONS = self.L["Random Companion"]
    BINDING_NAME_SUMMON_COMPANION = self.L["Summon Random Companion"]
    BINDING_NAME_DISMISS_COMPANION = self.L["Dismiss Companion"]
    BINDING_NAME_CM_MOUNT = self.L["Mount / Dismount"]
    BINDING_NAME_CM_DISMOUNT = self.L["Dismount"]
    BINDING_NAME_CM_GROUND_MOUNT = self.L["Ground Mount / Dismount"]

    self.db = LibStub("AceDB-3.0"):New("CollectMeDB", defaults)

    self.MOUNT = 1
    self.TITLE = 2
    self.RANDOM_COMPANION = 3
    self.RANDOM_MOUNT = 4
    self.COMPANION = 5
    self.TOYS = 6

    self.FACTION = UnitFactionGroup("player")
    LocalizedPlayerRace, self.RACE = UnitRace("player")
    LocalizedPlayerClass, self.CLASS = UnitClass("player")

    self.filter_db = self.db.profile.filters.mounts
    self.ignored_db = self.db.profile.ignored.mounts
    self.item_list = {}
    self.filter_list = {}

    self:RegisterChatCommand("collectme", "SlashProcessor")
    self:RegisterChatCommand("cm", "SlashProcessor")

    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneChangeListener")
end

function CollectMe:BuildData(no_filters)
    local MountDB = CollectMe:GetModule('MountDB')

    if self.UI.active_group == self.MOUNT then
        self.filter_db = self.db.profile.filters.mounts
        self.ignored_db = self.db.profile.ignored.mounts
        self.filter_list = {}
        self:BuildMissingMountList()
        if not no_filters then
            self:BuildFilters()
        end
    elseif self.UI.active_group == self.TITLE then
        self.filter_db = self.db.profile.filters.titles
        self.ignored_db = self.db.profile.ignored.titles
        self.filter_list = self.TitleDB.filters
        self:BuildMissingTitleList()
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
    elseif self.UI.active_group == self.TOYS then
        self.ignored_db = self.db.profile.ignored.toys
        self:BuildMissingToyList()
        if not no_filters then
            self:BuildMissingToyFilters()
        end
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
    local random_db = self.db.profile.random.mounts
    local count = 0
    local search = self.UI:GetSearchText():lower()
	local mounts_to_add = {}
	local MountDB = CollectMe:GetModule("MountDB")
    local collected, _, infos = MountDB:Get()

    for _, id in pairs(collected) do
        if infos[id].name:lower():find(search) ~= nil then
            table.insert(mounts_to_add, id);
            count = count + 1;
        end
    end
	self.UI:AddToScroll(self.UI:CreateHeading(self.L["Available mounts"] ..  " - " .. count))
	
	for i,spell_id in pairs(mounts_to_add) do
		local value = ((random_db[spell_id] ~= nil and random_db[spell_id] ~= false) and true or false)
		self.UI:CreateScrollCheckbox(GetSpellInfo(spell_id), value, { OnValueChanged = function (container, event, val) random_db[spell_id] = val end})
	end
end

function CollectMe:BuildMissingMountList()
    local MountDB = CollectMe:GetModule("MountDB")
    local collected, missing, infos = MountDB:Get()

    local active, ignored = {}, {}
    local all_count, known_count, filter_count = #missing + #collected, #collected, 0
    local zones = self:CloneTable(self.db.profile.filters.mounts.zones)
    if self.db.profile.filters.mounts.czo == true then
        table.insert(zones, self.ZoneDB:Current())
    end

    for _,id in pairs(missing) do
        if (self.UI.active_group == self.MOUNT and not infos[id].collected and (#zones == 0 or MountDB:IsInZone(id, zones))) then
            if self:IsInTable(self.ignored_db, id) then
                table.insert(ignored, infos[id])
            else
                if not self.filter_db.sources[infos[id].source_id] then
                    table.insert(active, infos[id])
                else
                    filter_count = filter_count + 1
                end
            end
        end
    end

    self:AddMissingRows(active, ignored, all_count, known_count, filter_count)
end

function CollectMe:BuildMissingTitleList()
    self.TitleDB:PrintUnkown()

    local titles, sort = self.TitleDB:Get()
    local active, ignored = {}, {}
    local all_count, known_count, filter_count = #sort, 0, 0

    for i,v in pairs(sort) do
        if (self.UI.active_group == self.TITLE and IsTitleKnown(v) == false and titles[v] ~= nil) then
            if self:IsInTable(self.ignored_db, v) then
                table.insert(ignored, titles[v])
            else
                if not self:IsFiltered(titles[v].filters) then
                    table.insert(active, titles[v])
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

    local hide_ignore = (self.UI.active_group == self.MOUNT and self.db.profile.hide_ignore.mounts) or
                        (self.UI.active_group == self.COMPANION and self.db.profile.hide_ignore.companions) or
                        (self.UI.active_group == self.TITLE and self.db.profile.hide_ignore.titles) or
                        (self.UI.active_group == self.TOYS and self.db.profile.hide_ignore.toys)
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

--@todo switch to compaion db
function CollectMe:BuildMissingCompanionList()
    local collected_filter = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED)
    C_PetJournal.SetSearchFilter("")
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true)
    local total = C_PetJournal.GetNumPets(false)
    local active, ignored, owned_db = {}, {}, {}
    local zones = self:CloneTable(self.db.profile.filters.companions.zones)
    if self.db.profile.filters.companions.czo == true then
        table.insert(zones, self.ZoneDB:Current())
    end

    for i = 1,total do
        local pet_id, species_id, owned, _, _, _, _, name, icon, _, creature_id, source = C_PetJournal.GetPetInfoByIndex(i, false)
        if next(zones) == nil or self.CompanionDB:IsInZone(species_id, zones) then
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
    end

    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, collected_filter)
    self:AddMissingRows(active, ignored, #active + #ignored + #owned_db, #owned_db, 0)
end


function CollectMe:BuildMissingToyList()
    local ToyDB = self:GetModule('ToyDB')
    local collected, missing = ToyDB:Get()
    local active, ignored = {}, {}
    local zones = self:CloneTable(self.db.profile.filters.toys.zones)
    if self.db.profile.filters.toys.czo == true then
        table.insert(zones, self.ZoneDB:Current())
    end

    for i,v in ipairs(missing) do
        if next(zones) == nil or ToyDB:IsInZone(v.id, zones) then
            if self:IsInTable(self.ignored_db, v.id) then
                table.insert(ignored, v)
            else
                table.insert(active, v)
            end
        end
    end

    self:AddMissingRows(active, ignored, #active + #ignored + #collected, #collected, 0)
end

function CollectMe:IsFiltered(filters)
    if filters ~= nil then
        for k,v in pairs(filters) do
            if v == 1 or v == true then
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

    if self.UI.active_group == self.MOUNT then
        self.UI:CreateFilterCheckbox(self.L["Current Zone"], self.db.profile.filters.mounts.czo, { OnValueChanged = function (container, event, value) self.db.profile.filters.mounts.czo = value; self.UI:ReloadScroll() end })
        local list, order = CollectMe.ZoneDB:GetList()
        self.UI:CreateFilterDropdown(self.L["Select Zones"], list, self.db.profile.filters.mounts.zones, { OnValueChanged = function (container, event, value) local pos = self:IsInTable(self.db.profile.filters.mounts.zones, value); if not pos then table.insert(self.db.profile.filters.mounts.zones, value) else table.remove(self.db.profile.filters.mounts.zones, pos) end; self.UI:ReloadScroll() end }, true, order)

        local numSources = C_PetJournal.GetNumPetSources();
        for i=1,numSources do
            self.UI:CreateFilterCheckbox(_G["BATTLE_PET_SOURCE_"..i], self.filter_db.sources[i] ~= nil and self.filter_db.sources[i] ~= false, { OnValueChanged = function (container, event, value) self.filter_db.sources[i] = value; self.UI:ReloadScroll() end })
        end
    end

    for i = 1, #self.filter_list, 1 do
        self.UI:CreateFilterCheckbox(self.L["filters_" .. self.filter_list[i]], self.filter_db[self.filter_list[i]], { OnValueChanged = function (container, event, value) CollectMe:ToggleFilter(self.filter_list[i], value) end })
    end
end


function CollectMe:BuildMissingCompanionFilters()
    self.UI:AddToFilter(self.UI:CreateHeading(self.L["Zone Filter"]))
    self.UI:CreateFilterCheckbox(self.L["Current Zone"], self.db.profile.filters.companions.czo, { OnValueChanged = function (container, event, value) self.db.profile.filters.companions.czo = value; self.UI:ReloadScroll() end })
    local list, order = CollectMe.ZoneDB:GetList()
    self.UI:CreateFilterDropdown(self.L["Select Zones"], list, self.db.profile.filters.companions.zones, { OnValueChanged = function (container, event, value) local pos = self:IsInTable(self.db.profile.filters.companions.zones, value); if not pos then table.insert(self.db.profile.filters.companions.zones, value) else table.remove(self.db.profile.filters.companions.zones, pos) end; self.UI:ReloadScroll() end }, true, order)

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

function CollectMe:BuildMissingToyFilters()
    self.UI:AddToFilter(self.UI:CreateHeading(self.L["Zone Filter"]))
    self.UI:CreateFilterCheckbox(self.L["Current Zone"], self.db.profile.filters.toys.czo, { OnValueChanged = function (container, event, value) self.db.profile.filters.toys.czo = value; self.UI:ReloadScroll() end })
    local list, order = CollectMe.ZoneDB:GetList()
    self.UI:CreateFilterDropdown(self.L["Select Zones"], list, self.db.profile.filters.toys.zones, { OnValueChanged = function (container, event, value) local pos = self:IsInTable(self.db.profile.filters.toys.zones, value); if not pos then table.insert(self.db.profile.filters.toys.zones, value) else table.remove(self.db.profile.filters.toys.zones, pos) end; self.UI:ReloadScroll() end }, true, order)

    self.UI:AddToFilter(self.UI:CreateHeading(self.L["Source Filter"]))
    local ToyDB = self:GetModule("ToyDB")
    for _,i in pairs {1,2,3,4,7,8} do
        self.UI:CreateFilterCheckbox(_G["BATTLE_PET_SOURCE_"..i], C_ToyBox.IsSourceTypeFiltered(i), { OnValueChanged = function (container, event, value)
            value = not value;
            C_ToyBox.SetFilterSourceType(i, value)
            ToyDB:Update()
            self.UI:ReloadScroll()
        end })
    end
end

function CollectMe:BuildOptions()
    self.UI:AddToFilter(self.UI:CreateHeading(self.L["Options"]))

    if self.UI.active_group == self.MOUNT then
        self.UI:CreateFilterCheckbox(self.L["Hide ignored list"], self.db.profile.hide_ignore.mounts, { OnValueChanged = function (container, event, value) self.db.profile.hide_ignore.mounts = value; self.UI:ReloadScroll() end })
    elseif self.UI.active_group == self.TITLE then
        self.UI:CreateFilterCheckbox(self.L["Disable missing title message"], self.db.profile.missing_message.titles, { OnValueChanged = function (container, event, value) self.db.profile.missing_message.titles = value end })
        self.UI:CreateFilterCheckbox(self.L["Hide ignored list"], self.db.profile.hide_ignore.titles, { OnValueChanged = function (container, event, value) self.db.profile.hide_ignore.titles = value; self.UI:ReloadScroll() end })
    elseif self.UI.active_group == self.COMPANION then
        self.UI:CreateFilterCheckbox(self.L["Disable tooltip notice for missing companions"], self.db.profile.tooltip.companions.hide, { OnValueChanged = function (container, event, value) self.db.profile.tooltip.companions.hide = value end }, 2)
        self.UI:CreateFilterCheckbox(self.L["Hide ignored list"], self.db.profile.hide_ignore.companions, { OnValueChanged = function (container, event, value) self.db.profile.hide_ignore.companions = value; self.UI:ReloadScroll() end })
    elseif self.UI.active_group == self.RANDOM_COMPANION then
        self.UI.filter:ReleaseChildren()
        self.UI:AddToFilter(self.UI:CreateHeading(self.L["Options"]))
        self.UI:CreateFilterCheckbox(self.L["Auto summon companion on moving forward"], self.db.profile.summon.companions.auto, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.auto = value self:BuildOptions() end }, 2)
        self.UI:AddToFilter(self.UI:CreateHeading(self.L["PvP Options"]))
        self.UI:CreateFilterCheckbox(self.L["Disable auto summon in pvp"], self.db.profile.summon.companions.disable_pvp, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_pvp = value self:BuildOptions() end }, 2, nil, self.db.profile.summon.companions.auto)
        self.UI:CreateFilterCheckbox(self.L["- Disable in pvp arena"], self.db.profile.summon.companions.disable_pvp_arena, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_pvp_arena = value end }, nil, nil, self.db.profile.summon.companions.disable_pvp and self.db.profile.summon.companions.auto)
        self.UI:CreateFilterCheckbox(self.L["- Disable in battleground"], self.db.profile.summon.companions.disable_pvp_bg, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_pvp_bg = value end }, nil, nil, self.db.profile.summon.companions.disable_pvp and self.db.profile.summon.companions.auto)
        self.UI:CreateFilterCheckbox(self.L["- Disable for world pvp"], self.db.profile.summon.companions.disable_pvp_world, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_pvp_world = value end }, nil, nil, self.db.profile.summon.companions.disable_pvp and self.db.profile.summon.companions.auto)
        self.UI:AddToFilter(self.UI:CreateHeading(self.L["Group Options"]))
        self.UI:CreateFilterCheckbox(self.L["Disable in raid group"], self.db.profile.summon.companions.disable_party_raid_grp, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_party_raid_grp = value end }, 2, nil, self.db.profile.summon.companions.auto)
        self.UI:CreateFilterCheckbox(self.L["Disable in normal group"], self.db.profile.summon.companions.disable_party_grp, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_party_grp = value end }, 2, nil, self.db.profile.summon.companions.auto)
		self.UI:AddToFilter(self.UI:CreateHeading(self.L["Type Options"]))
        self.UI:CreateFilterCheckbox(self.L["Disable in raid instance"], self.db.profile.summon.companions.disable_raid_instance, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_raid_instance = value end }, nil, nil, self.db.profile.summon.companions.auto)
        self.UI:CreateFilterCheckbox(self.L["Disable in dungeon"], self.db.profile.summon.companions.disable_dungeon, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_dungeon = value end }, nil, nil, self.db.profile.summon.companions.auto)
        self.UI:CreateFilterCheckbox(self.L["Disable in scenario"], self.db.profile.summon.companions.disable_scenario, { OnValueChanged = function (container, event, value) self.db.profile.summon.companions.disable_scenario = value end }, nil, nil, self.db.profile.summon.companions.auto)
    elseif self.UI.active_group == self.RANDOM_MOUNT then
        self.UI:CreateFilterCheckbox(self.L["Don't dismount when left-clicking on macro"], self.db.profile.summon.mounts.no_dismount, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.no_dismount = value end }, 2)
        self.UI:CreateFilterCheckbox(self.L["Use flying mounts in water"], self.db.profile.summon.mounts.flying_in_water, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.flying_in_water = value end }, 2)
        self.UI:CreateFilterCheckbox(self.L["Use flying mounts for ground"], self.db.profile.summon.mounts.flying_on_ground, { OnValueChanged = function (container, event, value) self.db.profile.summon.mounts.flying_on_ground = value end }, 2)
    elseif self.UI.active_group == self.TOYS then
        self.UI:CreateFilterCheckbox(self.L["Hide ignored list"], self.db.profile.hide_ignore.toys, { OnValueChanged = function (container, event, value) self.db.profile.hide_ignore.toys = value; self.UI:ReloadScroll() end })
    end
end

function CollectMe:BatchCheck(value)
	local search = self.UI:GetSearchText():lower()
    if self.UI.active_group == self.RANDOM_MOUNT then
        local random_db = self.db.profile.random.mounts
        local count = C_MountJournal.GetNumMounts()
		
		for i = 1, count, 1 do
			local name, spell_id, _, _, _, _, _, isFactionSpecific, faction, _, isCollected = C_MountJournal.GetMountInfo(i)
			if isCollected then
				if not faction then
					faction = -1
				end
				if not isFactionSpecific or CollectMe.FACTION == "Horde" and faction == 0 or CollectMe.FACTION == "Alliance" and faction == 1 then
					if name:lower():find(search) ~= nil then
						random_db[spell_id] = value
					end
				end
			end
		end
        self.UI:ReloadScroll()
    elseif self.UI.active_group == self.RANDOM_COMPANION then
        local random_db =  self.db.profile.random.companions

        for i,v in pairs(self.CompanionDB:Get()) do
			
            if v.pet_id ~= nil and C_PetJournal.PetIsSummonable(v.pet_id) then
				if v.name:lower():find(search) ~= nil then
					random_db[v.pet_id] = value
				end
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
        local MountDB = CollectMe:GetModule("MountDB")
        local _, _, infos = MountDB:Get()
        local mount = infos[spell_id]
        if mount ~= nil then
            if IsShiftKeyDown() == true and mount.link ~= nil then
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
        self:ToggleIgnore(spell_id)
    end
end

function CollectMe:ToggleIgnore(id)
    local ignored_table = self.ignored_db
    local position = self:IsInTable(ignored_table, id)
    if position ~= false then
        table.remove(ignored_table, position)
    else
        table.insert(ignored_table, id)
    end

    self.LdbDisplay:ZoneChangeListener()
    self.UI:ReloadScroll()
end

function CollectMe:ItemRowEnter(v)
    local tooltip = self.UI.frame.tooltip
    tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
    if self.UI.active_group == self.MOUNT then
        tooltip:SetHyperlink(v.link)
        tooltip:AddLine(" ")
        tooltip:AddLine(v.source_text, 0, 1, 0, 1)
        if self.L["mount_" .. v.id] ~= "mount_" .. v.id then
            tooltip:AddLine(" ")
            tooltip:AddLine(self.L["mount_" .. v.id], 0, 1, 0, 1)
        end
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
            if value == true or value == 1 then
                tooltip:AddLine(self.L["filters_" .. k], 0, 0.5, 1, 1)
            end
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
    if not t then
        return false
    end
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
    table.sort(tbl, function(a, b) return a ~= nil and b ~= nil and (string.lower(a.name) < string.lower(b.name)) end)
end

 -- CONSOLE COMMAND HANDLER
function CollectMe:SlashProcessor(input)
    if input == "rc" or input == "randomcompanion" then
        self.Macro:Companion()
    elseif input == "rm" or input == "randommount" then
        self.Macro:Mount()
    elseif input == "options" then
        InterfaceOptionsFrame_OpenToCategory(addon_name)
    elseif input == "debug title" then
        self.TitleDB:PrintAll()
    elseif input == "macro" then
        self:UpdateMacros()
    elseif input == "export companion" then
        CollectMe:GetModule("Export"):Companions()
    elseif input == "export mount" then
        CollectMe:GetModule("Export"):Mounts()
    else
        self.UI:Show()
    end
end

function CollectMe:ColorizeByQuality(text, quality)
    local color = "|C" .. select(4, GetItemQualityColor(quality))
    return color .. text .. FONT_COLOR_CODE_CLOSE;
end

function CollectMe:ZoneChangeListener()
    if (self.db.profile.filters.companions.czo == true and self.UI.active_group == self.COMPANION) or
       (self.db.profile.filters.mounts.czo == true and self.UI.active_group == self.MOUNT) or
       (self.db.profile.filters.toys.czo == true and self.UI.active_group == self.TOYS) then
        self.UI:ReloadScroll()
    end
end

function CollectMe:CloneTable(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[self:CloneTable(orig_key)] = self:CloneTable(orig_value)
        end
        setmetatable(copy, self:CloneTable(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
