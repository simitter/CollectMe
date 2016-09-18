local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

local HeirloomDB = CollectMe:NewModule("HeirloomDB", "AceEvent-3.0")
local collected, missing = {}, {}

function HeirloomDB:Update()
    collected, missing = {}, {}
    local heirloomIDs = C_Heirloom.GetHeirloomItemIDs()

    for i = 1, #heirloomIDs, 1 do
        local name, itemEquipLoc, isPvP, itemTexture, upgradeLevel, source = C_Heirloom.GetHeirloomInfo(heirloomIDs[i])
        if(source ~= nil and C_Heirloom.GetHeirloomSourceFilter(source) == true) then
            if C_Heirloom.PlayerHasHeirloom(heirloomIDs[i]) == true then
                table.insert(collected, heirloomIDs[i])
            else
                table.insert(missing, {
                    id = heirloomIDs[i],
                    name = name,
                    icon = itemTexture,
                    callbacks = {
                        OnClick = function (container, event, group)
                            if group == "RightButton" and IsControlKeyDown() then
                                CollectMe:ToggleIgnore(heirloomIDs[i])
                            end
                        end,
                        OnEnter = function (container, event, group)
                            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
                            GameTooltip:SetHeirloomByItemID(heirloomIDs[i])
                        end,
                        OnLeave = function (container, event, group) GameTooltip:Hide() end ,
                }
            })
            end
        end
    end
end

function HeirloomDB:OnEnable()
    HeirloomDB:RegisterEvent("HEIRLOOMS_UPDATED", "Update")
end

function HeirloomDB:Get()
    self:Update()
    return collected, missing
end
