CollectMe.CompanionDB = CollectMe:NewModule("CompanionDB", "AceEvent-3.0", "AceConsole-3.0")
local LibPetJournal = LibStub("LibPetJournal-2.0")

function CollectMe.CompanionDB:Update()
    self.companions = {}

    for i,petid in LibPetJournal:IteratePetIDs() do
        local speciesID, customName, level, _, _, _, _, name, icon, _, creatureID = C_PetJournal.GetPetInfoByPetID(petid)
        local quality = select(5, C_PetJournal.GetPetStats(petid))

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
end

function CollectMe.CompanionDB:GetCompanions()
    return self.companions
end

function CollectMe.CompanionDB:OnInitialize()
    self.companions = {}
end

function CollectMe.CompanionDB:OnEnable()
    LibPetJournal.RegisterCallback(CollectMe.CompanionDB, "PetListUpdated", "Update")
end
