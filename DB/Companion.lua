CollectMe.CompanionDB = CollectMe:NewModule("CompanionDB", "AceEvent-3.0", "AceConsole-3.0")
local LibPetJournal = LibStub("LibPetJournal-2.0")

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
            icon = icon
        })
    end

    for i,species_id in LibPetJournal:IterateSpeciesIds() do
        if not self:IsSpeciesKnown(species_id) then
            local name, icon, _, creatureID = C_PetJournal.GetPetInfoBySpeciesID(species_id);
            tinsert(self.missing_companions, {
                species_id = species_id,
                creature_id = creatureID,
                name = name,
                icon = icon
            })
        end
    end
end

function CollectMe.CompanionDB:IsSpeciesKnown(species_id)
    if not self.known_species[species_id] then
        return false
    end
    return true
end

function CollectMe.CompanionDB:GetCompanions()
    return self.companions
end

function CollectMe.CompanionDB:GetMissingCompanions()
    return self.missing_companions
end

function CollectMe.CompanionDB:OnInitialize()
    self.companions = {}
    self.missing_companions = {}
    self.known_species = {}
end

function CollectMe.CompanionDB:OnEnable()
    LibPetJournal.RegisterCallback(CollectMe.CompanionDB, "PetListUpdated", "Update")
end