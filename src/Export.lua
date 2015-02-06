local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Export = CollectMe:NewModule("Export")
local CompanionDB = CollectMe:GetModule("CompanionDB")
local ZoneDB = CollectMe:GetModule("ZoneDB")

local db

local function extractZones(source)
    local list = ZoneDB:GetList()
    local zones = {}
    for i,v in pairs(list) do
        if source:lower():find(v:lower()) ~= nil then
            zones[i] = i
        end
    end
    return zones
end

local function exportCompanions(items)
    local source, _, zones
    for i,v in pairs(items) do
        if (v.species_id ~= nil) then
            _, _, _, _, source = C_PetJournal.GetPetInfoBySpeciesID(v.species_id)
            zones = extractZones(source)
            if next(zones) ~= nil then
                db.companions[v.species_id] = zones
            end
        end
    end
end

function Export:Companions()
    local collected, missing = CompanionDB:Get()
    exportCompanions(collected)
    exportCompanions(missing)

    CollectMe:Print("companion export success")
end

function Export:OnInitialize()
    db = CollectMe.db.profile.export
    db.companions = {}
end
