local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local L = LibStub("AceLocale-3.0"):GetLocale("CollectMe", true)

local ToyDB = CollectMe:NewModule("ToyDB", "AceEvent-3.0")
local Data = CollectMe:GetModule("Data")
local collected, collectedIds = {}, {}
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
                    tooltip:SetToyByItemID(id)
                end ,
                OnLeave = function (container, event, group) CollectMe:ItemRowLeave() end ,
            }
        })
    end

    return info
end

function ToyDB:Update()
    local filterCollected, filterUncollected = C_ToyBox.GetCollectedShown(), C_ToyBox.GetUncollectedShown()

    --C_ToyBox.SetFilterString('')
    C_ToyBox.SetCollectedShown(true)
    C_ToyBox.SetUncollectedShown(false)
    C_ToyBox.ForceToyRefilter()
    collected = getToys(true)
    for k,v in ipairs(collected) do
        collectedIds[v.id] = v.id
    end

    C_ToyBox.SetCollectedShown(false)
    C_ToyBox.SetUncollectedShown(true)
    C_ToyBox.ForceToyRefilter()
    missing = getToys(false)

    -- restore filters
    C_ToyBox.SetCollectedShown(filterCollected)
    C_ToyBox.SetUncollectedShown(filterUncollected)
    C_ToyBox.ForceToyRefilter()
end

function ToyDB:IsInZone(id, zones)
    if type(zones) ~= "table" then
        zones = { zones }
    end

    if Data.ToysZone[id] ~= nil then
        for i = 1,#zones do
            if Data.ToysZone[id][zones[i]] ~= nil then
                return true
            end
        end
    end

    return false
end

function ToyDB:IsKnown(id)
    return collectedIds[id] ~= nil
end

function ToyDB:OnEnable()
    ToyDB:RegisterEvent("TOYS_UPDATED", "Update")
end

function ToyDB:Get()
    return collected, missing
end
