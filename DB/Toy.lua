local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local L = LibStub("AceLocale-3.0"):GetLocale("CollectMe", true)

local ToyDB = CollectMe:NewModule("ToyDB", "AceEvent-3.0")
local collected = {}
local missing = {}

local function getToys()
    local info = {}

    for i = 1, C_ToyBox.GetNumFilteredToys(), 1 do
        local id, name, icon = C_ToyBox.GetToyInfo(C_ToyBox.GetToyFromIndex(i))
        table.insert(info, {
            id = id,
            name = name,
            icon = icon,
            callbacks = {
                OnClick = function (container, event, group)
                    if group == "RightButton" and IsControlKeyDown() then
                        CollectMe:ToggleIgnore(id)
                    end
                end,
                OnEnter = function (container, event, group)
                    local tooltip = CollectMe.UI.frame.tooltip
                    tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
                    tooltip:AddLine(name)

                    if L["toy_" .. id] ~= nil then
                        tooltip:AddLine(" ")
                        tooltip:AddLine(L["toy_" .. id], 0, 1, 0, 1)
                    end

                    tooltip:AddLine(" ")
                    tooltip:AddLine(L["tooltip_toggle"], 0.65, 0.65, 0)
                    tooltip:Show()
                end ,
                OnLeave = function (container, event, group) CollectMe:ItemRowLeave() end ,
            }
        })
    end

    return info
end

function ToyDB:Update()
    local filterCollected, filterUncollected = C_ToyBox.GetFilterCollected(), C_ToyBox.GetFilterUncollected()

    C_ToyBox.SetFilterString('')
    C_ToyBox.SetFilterCollected(true)
    C_ToyBox.SetFilterUncollected(false)
    C_ToyBox.FilterToys()
    collected = getToys()

    C_ToyBox.SetFilterCollected(false)
    C_ToyBox.SetFilterUncollected(true)
    C_ToyBox.FilterToys()
    missing = getToys()

    -- restore filters
    C_ToyBox.SetFilterCollected(filterCollected)
    C_ToyBox.SetFilterUncollected(filterUncollected)
    C_ToyBox.FilterToys()
end

function ToyDB:OnEnable()
    self:Update()
    ToyDB:RegisterEvent("TOYS_UPDATED", "Update")
end

function ToyDB:Get()
    return collected, missing
end
