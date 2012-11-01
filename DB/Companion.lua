CollectMe.CompanionDB = CollectMe:NewModule("CompanionDB", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")

local function _UpdateDB(frame)
    local self = frame.obj

    if self.updating == true or self.next_update == false or time() < self.next_update then
        return
    end

    self.next_update = false
    self.updating = true

    self:ClearFilters()

    -- currentyl we only want the owned pets
    local num, owned = C_PetJournal.GetNumPets(false)
    if (owned ~= #self.companions) then
        self.companions = {}
        for i = 1,num do
            local pet_id, species_id, owned, custom_name, level, _, _, name, icon, _, creature_id = C_PetJournal.GetPetInfoByIndex(i, false)
            if owned then
                local quality = select(5, C_PetJournal.GetPetStats(pet_id))
                tinsert(self.companions, {
                    pet_id = pet_id,
                    species_id = species_id,
                    quality = quality,
                    color = (quality - 1),
                    creature_id = creature_id,
                    level = level,
                    name = name,
                    custom_name = custom_name,
                    icon = icon
                })
            end
        end
    end

    self:RestoreFilters()

    self.updating = false
end

function CollectMe.CompanionDB:ClearFilters()
    self.filter_searchtext = self.searchtext

    self.LE_PET_JOURNAL_FLAG_COLLECTED = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_COLLECTED)
    self.LE_PET_JOURNAL_FLAG_FAVORITES = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_FAVORITES)
    self.LE_PET_JOURNAL_FLAG_NOT_COLLECTED = not C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED)

    self.types = {}
    for i=1,C_PetJournal.GetNumPetTypes() do
        self.types[i] = not C_PetJournal.IsPetTypeFiltered(i)
    end

    self.sources = {}
    for i=1,C_PetJournal.GetNumPetSources() do
        self.sources[i] = not C_PetJournal.IsPetSourceFiltered(i)
    end

    C_PetJournal.SetSearchFilter("")
    C_PetJournal.AddAllPetTypesFilter()
    C_PetJournal.AddAllPetSourcesFilter()
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true)
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false)
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, false) -- currently not needed
end

function CollectMe.CompanionDB:RestoreFilters()
    C_PetJournal.SetSearchFilter(self.filter_searchtext or "")

    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, self.LE_PET_JOURNAL_FLAG_COLLECTED)
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, self.LE_PET_JOURNAL_FLAG_FAVORITES)
    C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, self.LE_PET_JOURNAL_FLAG_NOT_COLLECTED)

    for i=1,C_PetJournal.GetNumPetTypes() do
        C_PetJournal.SetPetTypeFilter(i, self.types[i])
    end

    for i=1,C_PetJournal.GetNumPetSources() do
        C_PetJournal.SetPetSourceFilter(i, self.sources[i])
    end
end

function CollectMe.CompanionDB:SetSearchFilter(text)
    self.searchtext = text
end

function CollectMe.CompanionDB:GetCompanions()
    return self.companions
end

function CollectMe.CompanionDB:OnInitialize()
    self.companions = {}
    self.updating = false
    self.next_update = false
    self.searchtext = ''

    self.LE_PET_JOURNAL_FLAG_COLLECTED = false
    self.LE_PET_JOURNAL_FLAG_FAVORITES = false
    self.LE_PET_JOURNAL_FLAG_NOT_COLLECTED = false
    self.types = {}
    self.sources = {}
    self.filter_searchtext = ''

    self.timer = CreateFrame("Frame", UIParent) -- Thanx Udorn from PetBattleMaster
    self.timer.obj = self
    self.timer:SetScript("OnUpdate", _UpdateDB)
end

function CollectMe.CompanionDB:OnEnable()
    self:RegisterEvent("PET_JOURNAL_LIST_UPDATE", "Update")
    self:RegisterEvent("PET_JOURNAL_PET_DELETED", "Update")
    self:SecureHook(C_PetJournal, "SetSearchFilter")
end

function CollectMe.CompanionDB:Update()
    if self.updating == false then
        self.next_update = time() + 1
    end
end