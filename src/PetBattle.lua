CollectMe.PetBattle = CollectMe:NewModule("PetBattle", "AceEvent-3.0")

function CollectMe.PetBattle:OnInitialize()
    self:RegisterEvent("PET_BATTLE_OPENING_START", "ResetEnemyTable")
    self:RegisterEvent("PET_BATTLE_PET_CHANGED", "CheckEnemyQuality")
    
    self.enemies = {}
end

function CollectMe.PetBattle:ResetEnemyTable()
    self.enemies = {}
end

function CollectMe.PetBattle:IsInEnemyTable(id, quality)
    for i = 1, #self.enemies do
        if self.enemies[i].enemy_species_id == id and self.enemies[i].enemy_quality == quality then
            return i
        end
    end

    return false
end

function CollectMe.PetBattle:CheckEnemyQuality()
    if CollectMe.db.profile.tooltip.companions.quality_check == true then
        local trapable, trap_error = C_PetBattles.IsTrapAvailable()
        if trap_error == 6 or trap_error == 7 then
            return
        end
        for i=1, C_PetBattles.GetNumPets(2) do
            local enemy_species_id = C_PetBattles.GetPetSpeciesID(LE_BATTLE_PET_ENEMY, i)
            local enemy_quality = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY,i)
            local quality = -1

            local index = self:IsInEnemyTable(enemy_species_id, enemy_quality)
            if index == false then
                tinsert(self.enemies, {
                    enemy_species_id = enemy_species_id,
                    enemy_quality = enemy_quality,
                    already_printed = false
                })

                index = self:IsInEnemyTable(enemy_species_id, enemy_quality)
            end

            for j,v in ipairs(CollectMe.CompanionDB:GetCompanions()) do
                if v.species_id == enemy_species_id then
                    if quality < v.quality then
                        quality = v.quality
                    end
                end
            end

            if self.enemies[index].already_printed == false then
                if quality == -1 then
                    CollectMe:Print(C_PetBattles.GetName(2,i).." - " .. CollectMe:ColorizeByQuality(_G["BATTLE_PET_BREED_QUALITY" .. enemy_quality], enemy_quality - 1) .. " - " .. RED_FONT_COLOR_CODE .. CollectMe.L["Missing companion"] .. FONT_COLOR_CODE_CLOSE)
                elseif quality < enemy_quality then
                    CollectMe:Print(C_PetBattles.GetName(2,i).." - " .. CollectMe:ColorizeByQuality(_G["BATTLE_PET_BREED_QUALITY" .. enemy_quality], enemy_quality - 1) .. " - " .. RED_FONT_COLOR_CODE .. CollectMe.L["This companion has a higher quality than yours"] .. FONT_COLOR_CODE_CLOSE)
                end

                self.enemies[index].already_printed = true
            end
        end
    end
end
