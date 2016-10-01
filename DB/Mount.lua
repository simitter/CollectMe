local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local MountDB = CollectMe:NewModule("MountDB", "AceEvent-3.0")
local Data = CollectMe:GetModule("Data")

local loaded = false
local collected, missing, info, filters  = {}, {}, {}, {}
local surfaceDetectionTime = 0

MountDB.GROUND, MountDB.FLY, MountDB.SWIM, MountDB.AQUATIC, MountDB.STRIDER = 1, 2, 3, 4, 5

local function getInfoFromApiType(api_type)
    if api_type == 231 then
        --Slow Turtles
        return MountDB.SWIM
    end
    if api_type == 254 then
        --Underwater Mounts
        return MountDB.AQUATIC
    end
    if api_type == 269 then
        --Water Striders
        return MountDB.STRIDER
    end
    if api_type == 232 then
        --Zone Underwater Mount
        return MountDB.AQUATIC, { [614] = 614, [615] = 615, [610] = 610 }
    end
    if api_type == 247 or api_type == 248 then
        --Normal Flying Mounts
        return MountDB.FLY
    end
    if api_type == 241 then
        --Zone Ground Mount
        return MountDB.GROUND, { [766] = 766 }
    end
    --Normal Ground Mounts
    return MountDB.GROUND
end

local function update()
    local collected_filter, not_collected_filter = C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED), C_MountJournal.GetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, true)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, true)

    C_MountJournal.SetSearch("");
    C_MountJournal.SetAllSourceFilters(true)

	collected, missing = {}, {}
	local mountIDs = C_MountJournal.GetNumDisplayedMounts();
	
    for i = 1, mountIDs do
        local name, id, icon, _, summonable, source, favorite, _, faction, hidden, owned, mount_id = C_MountJournal.GetDisplayedMountInfo(i)
		
        if hidden == false and (faction == nil or (faction == 0 and CollectMe.FACTION == 'Horde') or (faction == 1 and CollectMe.FACTION == 'Alliance')) then
            local creature_id, _, source_text, _, api_type = C_MountJournal.GetMountInfoExtraByID(mount_id)
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
                favorite    = favorite,
                mount_id    = mount_id,
            }
        end
    end

    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_COLLECTED, collected_filter)
    C_MountJournal.SetCollectedFilterSetting(LE_MOUNT_JOURNAL_FILTER_NOT_COLLECTED, not_collected_filter)
end

local function companionLearned(_, companionType)
    if (not companionType or companionType == "MOUNT") then
        update()
    end
end

local function SurfaceDetection()
    if not IsSwimming() then
        surfaceDetectionTime=GetTime()
    end
end

function MountDB:OnInitialize()
    MountDB:RegisterEvent("COMPANION_LEARNED", companionLearned)
    MountDB:RegisterEvent("MOUNT_JOURNAL_USABILITY_CHANGED", SurfaceDetection)
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

function MountDB:GetSurfaceDetectionTime()
    return surfaceDetectionTime
end

function MountDB:IsInZone(id, zones)
    if type(zones) ~= "table" then
        zones = { zones }
    end
    for i = 1,#zones do
        if Data.MountsZone[id] ~= nil and Data.MountsZone[id][zones[i]] ~= nil then
            return true
        end
    end
    return false
end

function MountDB:GetZoneMounts(zone)
    local mounts = {}
    if (Data.ZoneMounts[zone] ~= nil) then
        for i,v in pairs(Data.ZoneMounts[zone]) do
            if info[v] ~= nil then
                tinsert(mounts, info[v])
            end
        end
    end

    return mounts
end
