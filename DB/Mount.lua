local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local MountDB = CollectMe:NewModule("MountDB")

local mounts = {}
local info = {}
local filters = {}

local function getInfoFromApiType(api_type)
    if api_type == 231 then
        return MountDB.SWIM, {}
    end
    if api_type == 232 or api_type == 254 then
        return MountDB.AQUATIC, { 614, 615, 610 }
    end
    if api_type == 247 or api_type == 248 then
        return MountDB.FLY, {}
    end
    if api_type == 241 then
        return MountDB.GROUND, { 766 }
    end

    return MountDB.GROUND, {}
end

function MountDB:OnInitialize()
    for i=1,C_PetJournal.GetNumPetSources() do
        filters[i] = true
    end

    MountDB.GROUND, MountDB.FLY, MountDB.SWIM, MountDB.AQUATIC = 1, 2, 3, 4
    MountDB:Update()
end

function MountDB:Update()
    local collected_filter, not_collected_filter = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED), C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, true)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, true)

    for i = 1, C_MountJournal.GetNumMounts() do
        local name, id, icon, _, _, source, _, _, faction, hidden, owned = C_MountJournal.GetMountInfo(i)

        if hidden == false and (faction == nil or (faction == 0 and CollectMe.FACTION == 'Horde') or (faction == 1 and CollectMe.FACTION == 'Alliance')) then
            local creature_id, _, source_text, _, api_type = C_MountJournal.GetMountInfoExtra(i)
            local type, zones = getInfoFromApiType(api_type)

            table.insert(mounts, id)
            info[id] = {
                name        = name,
                icon        = icon,
                link        = GetSpellLink(id),
                id          = id,
                display_id  = creature_id,
                source_id   = source,
                type        = type,
                zones       = zones,
                known       = owned,
                source_text = source_text,

            }
        end
    end

    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, collected_filter)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, not_collected_filter)
end

function MountDB:Get()
    return mounts, info
end

function MountDB:ObtainableInZone(id, zones)
    return false
end

function MountDB:GetZoneMounts(zones)
    return {}
end

function MountDB:GetInfo(spell_id)
    for i,v in ipairs(self.mounts) do
        if v.id == spell_id then
            return v
        end
    end
    return nil
end
