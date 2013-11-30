local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local PetBattle = CollectMe:NewModule("PetBattle", "AceEvent-3.0")
local db
local enemies = {}

local function ResetEnemyTable()
    enemies = {}
end

local function IsInEnemyTable(id, quality, level)
    for i = 1, #enemies do
        if enemies[i].enemy_species_id == id and enemies[i].enemy_quality == quality and enemies[i].enemy_level == level then
            return i
        end
    end

    return false
end

local function CheckEnemyQuality()
    if db.quality_check == true or db.missing_check == true or db.level_check == true then
        local trapable, trap_error = C_PetBattles.IsTrapAvailable()
        if trap_error == 6 or trap_error == 7 then
            return
        end
        for i=1, C_PetBattles.GetNumPets(2) do
            local enemy_species_id = C_PetBattles.GetPetSpeciesID(LE_BATTLE_PET_ENEMY, i)
            local enemy_quality = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY,i)
            local enemy_level = C_PetBattles.GetLevel(LE_BATTLE_PET_ENEMY,i)
            local quality = -1
            local level_warning = false

            local index = IsInEnemyTable(enemy_species_id, enemy_quality, enemy_level)
            if index == false then
                tinsert(enemies, {
                    enemy_species_id = enemy_species_id,
                    enemy_quality = enemy_quality,
                    enemy_level = enemy_level,
                    already_printed = false
                })

                index = IsInEnemyTable(enemy_species_id, enemy_quality, enemy_level)
            end

            for j,v in ipairs(CollectMe.CompanionDB:Get()) do
                if v.species_id == enemy_species_id then
                    local level_difference = enemy_level - v.level
                    if quality < v.quality then
                        quality = v.quality
                    end
                    if level_difference > 0 then
                        if (enemy_level >= 21 and level_difference >= 3) or (enemy_level >= 16 and enemy_level <= 20 and level_difference >= 2) or (enemy_level <= 15) then
                            level_warning = true
                        end
                    end
                end
            end

            if enemies[index].already_printed == false then
                if db.missing_check == true and quality == -1 then
                    CollectMe:Print(C_PetBattles.GetName(2,i).." - " .. CollectMe:ColorizeByQuality(_G["BATTLE_PET_BREED_QUALITY" .. enemy_quality], enemy_quality - 1) .. " (" .. enemy_level .. ") - " .. RED_FONT_COLOR_CODE .. CollectMe.L["Missing companion"] .. FONT_COLOR_CODE_CLOSE)
                elseif db.quality_check == true and quality < enemy_quality then
                    CollectMe:Print(C_PetBattles.GetName(2,i).." - " .. CollectMe:ColorizeByQuality(_G["BATTLE_PET_BREED_QUALITY" .. enemy_quality], enemy_quality - 1) .. " (" .. enemy_level .. ") - " .. RED_FONT_COLOR_CODE .. CollectMe.L["This companion has a higher quality than yours"] .. FONT_COLOR_CODE_CLOSE)
                elseif db.level_check == true and level_warning == true then
                    CollectMe:Print(C_PetBattles.GetName(2,i).." - " .. CollectMe:ColorizeByQuality(_G["BATTLE_PET_BREED_QUALITY" .. enemy_quality], enemy_quality - 1) .. " (" .. enemy_level .. ") - " .. RED_FONT_COLOR_CODE .. CollectMe.L["This companion would have a higher level than yours after capturing"] .. FONT_COLOR_CODE_CLOSE)
                end
                enemies[index].already_printed = true
            end
        end
    end
end

function PetBattle:OnInitialize()
    db = CollectMe.db.profile.battles

    self:RegisterEvent("PET_BATTLE_OPENING_START", ResetEnemyTable)
    self:RegisterEvent("PET_BATTLE_PET_CHANGED", CheckEnemyQuality)
end
