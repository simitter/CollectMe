local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.Tooltip = CollectMe:NewModule("Tooltip", "AceHook-3.0")

function CollectMe.Tooltip:OnInitialize()
    self.gametooltip_visible = false
    self:SecureHookScript(GameTooltip, "OnShow", "TooltipHook")
end

function CollectMe.Tooltip:TooltipHook(tooltip)
    if self.gametooltip_visible == true or CollectMe.db.profile.tooltip.companions.hide == true then
        return
    end
    -- UnitIsWildBattlePet/UnitGUID reject secret values during combat; return early to avoid errors
    if InCombatLockdown() then
        return
    end

    self.gametooltip_visible = true
    if (tooltip and tooltip.GetUnit) then
        local _, unit = tooltip:GetUnit()
        local ok, is_wild = pcall(UnitIsWildBattlePet, unit)
        if not ok or not is_wild then
            self.gametooltip_visible = false
            return
        end
        local guid_ok, guid = pcall(UnitGUID, unit)
        if not guid_ok or not guid then
            self.gametooltip_visible = false
            return
        end
        local creature_id = tonumber(select(6, strsplit("-", guid)), 10)
        if creature_id then
            local line
            for i,v in ipairs(CollectMe.CompanionDB:Get()) do
                if(creature_id == v.creature_id) then
                    if line == nil then
                        line = CollectMe.L["My companions"] .. ": "
                    else
                        line = line .. ", "
                    end
                    line = line .. CollectMe:ColorizeByQuality(_G["BATTLE_PET_BREED_QUALITY" .. v.quality] .. " (" .. v.level .. ")" , v.color)
                end
            end
            if line ~= nil then
                tooltip:AddLine(line)
            else
                tooltip:AddLine(RED_FONT_COLOR_CODE .. CollectMe.L["Missing companion"] .. FONT_COLOR_CODE_CLOSE)
            end
            tooltip:Show()
        end
    end
    self.gametooltip_visible = false
end
