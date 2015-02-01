local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local MountDB = CollectMe:NewModule("MountDB", "AceEvent-3.0")

local loaded = false
local collected, missing, info, filters  = {}, {}, {}, {}

MountDB.GROUND, MountDB.FLY, MountDB.SWIM, MountDB.AQUATIC = 1, 2, 3, 4

local function getInfoFromApiType(api_type)
    if api_type == 231 then
        return MountDB.SWIM
    end
    if api_type == 232 or api_type == 254 then
        return MountDB.AQUATIC, { [614] = 614, [615] = 615, [610] = 610 }
    end
    if api_type == 247 or api_type == 248 then
        return MountDB.FLY
    end
    if api_type == 241 then
        return MountDB.GROUND, { [766] = 766 }
    end

    return MountDB.GROUND
end

local function update()
    local collected_filter, not_collected_filter = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED), C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, true)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, true)

    for i = 1, C_MountJournal.GetNumMounts() do
        local name, id, icon, _, summonable, source, _, _, faction, hidden, owned = C_MountJournal.GetMountInfo(i)

        if hidden == false and (faction == nil or (faction == 0 and CollectMe.FACTION == 'Horde') or (faction == 1 and CollectMe.FACTION == 'Alliance')) then
            local creature_id, _, source_text, _, api_type = C_MountJournal.GetMountInfoExtra(i)
            local type, zones = getInfoFromApiType(api_type)

            if owned then
                table.insert(collected, id)
            else
                table.insert(missing, id)
            end
            info[id] = {
                index       = i,
                name        = name,
                icon        = icon,
                link        = GetSpellLink(id),
                id          = id,
                display_id  = creature_id,
                source_id   = source,
                type        = type,
                zones       = zones,
                collected   = owned,
                source_text = source_text,
                summonable  = summonable,
            }
        end
    end

    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, collected_filter)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, not_collected_filter)
end

local function companionLearned(_, type)
    if type == "MOUNT" then
        update()
    end
end

function MountDB:OnInitialize()
    MountDB:RegisterEvent("COMPANION_LEARNED", companionLearned)
end

function MountDB:OnEnable()
    if loaded == false then
        loaded = true
        update()
    end
end

function MountDB:Get()
    return collected, missing, info
end

function MountDB:ObtainableInZone(id, zones)
    return false
end

function MountDB:GetZoneMounts(zones)
    return {}
end
