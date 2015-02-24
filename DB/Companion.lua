local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.CompanionDB = CollectMe:NewModule("CompanionDB", "AceEvent-3.0")
local LibPetJournal = LibStub("LibPetJournal-2.0")

local Data = CollectMe:GetModule("Data")


function CollectMe.CompanionDB:Update()
    self.companions = {}
    self.missing_companions = {}
    self.known_species = {}

    for i,petid in LibPetJournal:IteratePetIDs() do
        local speciesID, customName, level, _, _, _, _, name, icon, _, creatureID = C_PetJournal.GetPetInfoByPetID(petid)
        local quality = select(5, C_PetJournal.GetPetStats(petid))
        self.known_species[speciesID] = true
        tinsert(self.companions, {
            pet_id = petid,
            species_id = speciesID,
            quality = quality,
            color = (quality - 1),
            creature_id = creatureID,
            level = level,
            name = name,
            custom_name = customName,
            icon = icon,
            zones = Data.CompanionsZone[speciesID]
        })
    end

    for i,speciesID in LibPetJournal:IterateSpeciesIds() do
        if not self:IsSpeciesKnown(speciesID) then
            local name, icon, _, creatureID = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
            tinsert(self.missing_companions, {
                species_id = speciesID,
                creature_id = creatureID,
                name = name,
                icon = icon,
                zones = Data.CompanionsZone[speciesID]
            })
        end
    end
    CollectMe.LdbDisplay:ZoneChangeListener()
end

function CollectMe.CompanionDB:IsSpeciesKnown(species_id)
    if not self.known_species[species_id] then
        return false
    end
    return true
end

function CollectMe.CompanionDB:Get()
    return self.companions, self.missing_companions
end

function CollectMe.CompanionDB:ZoneSearch(companions, zone_id)
    local companions_in_zone = {}
    for i,v in ipairs(companions) do
        if v.zones ~= nil and v.zones[zone_id] ~= nil then
            tinsert(companions_in_zone, v)
        end
    end
    return companions_in_zone
end

function CollectMe.CompanionDB:GetCompanionsInZone(zone_id)
    return self:ZoneSearch(self.companions, zone_id), self:ZoneSearch(self.missing_companions, zone_id)
end

function CollectMe.CompanionDB:IsInZone(id, zones)
    if type(zones) ~= "table" then
        zones = { zones }
    end
    for i = 1,#zones do
        if Data.CompanionsZone[id] ~= nil and Data.CompanionsZone[id][zones[i]] ~= nil then
            return true
        end
    end
    return false
end

function CollectMe.CompanionDB:OnInitialize()
    self.companions = {}
    self.missing_companions = {}
    self.known_species = {}
end

function CollectMe.CompanionDB:OnEnable()
    LibPetJournal.RegisterCallback(CollectMe.CompanionDB, "PetListUpdated", "Update")
end
