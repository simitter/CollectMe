local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Export = CollectMe:NewModule("Export")
local CompanionDB = CollectMe:GetModule("CompanionDB")
local MountDB = CollectMe:GetModule("MountDB")
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
    local source, _, zones, name
    for i,v in pairs(items) do
        if (v.species_id ~= nil) then
            name, _, _, _, source = C_PetJournal.GetPetInfoBySpeciesID(v.species_id)
            zones = extractZones(source)
            if next(zones) ~= nil then
                db.companions[v.species_id] = {
                    zones = zones,
                    name  = name
                }
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

function Export:Mounts()
    local _, _, mounts = MountDB:Get()
    local zones = {}

    for i,v in pairs(mounts) do
        if v.id ~= nil then
            zones = extractZones(v.source_text)
            db.mounts[v.id] = {
                zones =  zones,
                name = v.name
            }
        end
    end

    CollectMe:Print("mount export success")
end

function Export:Toys()
    local list = ZoneDB:GetList()
    for i,v in pairs(list) do
        local ids = {}
        C_ToyBox.SetFilterString("Zone: "..v);

        for j = 1, C_ToyBox.GetNumFilteredToys(), 1 do
            local id, name = C_ToyBox.GetToyInfo(C_ToyBox.GetToyFromIndex(j))
            ids[id] = name
        end

        if next(ids) ~= nil then
            db.toys[i] = {
                zonename = v,
                ids = ids
            }
        end
    end

    CollectMe:Print("toy export success")
end

function Export:OnInitialize()
    db = CollectMe.db.profile.export
    db.companions = {}
    db.mounts = {}
    db.toys = {}
end
