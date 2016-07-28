local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

local FollowerDB = CollectMe:NewModule("FollowerDB", "AceEvent-3.0")
local Data = CollectMe:GetModule("Data")
local ModelPreview = CollectMe:GetModule("ModelPreview")
local collected, collectedIds = {}, {}
local missing = {}

local function getFollowers(collected)
    local info = {}

    local followers = C_Garrison.GetFollowers(1) or {}

    for i = 1, #followers, 1 do
        local follower = followers[i];
        if (follower.isCollected == collected) then
            table.insert(info, {
                id = follower.followerID,
                name = follower.name,
                portrait = follower.portraitIconID,
                displayID = follower.displayID,
                callbacks = {
                    OnClick = function (container, event, group)
                        if group == "RightButton" and IsControlKeyDown() then
                            CollectMe:ToggleIgnore(follower.followerID)
                        else
                            ModelPreview:PreviewCreature(follower.displayID)
                        end

                    end,
                    OnEnter = function (container, event, group)
                        --TODO: Better tooltip 
                        local tooltip = CollectMe.UI.frame.tooltip
                        tooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
                        tooltip:AddLine(follower.name)
                        tooltip:AddLine(follower.level .. " " .. follower.className .. " " .. follower.followerID)
                        tooltip:AddLine(" ")
                        tooltip:AddLine(C_Garrison.GetFollowerSourceTextByID(follower.followerID))
                        tooltip:Show()
                    end ,
                    OnLeave = function (container, event, group) CollectMe:ItemRowLeave() end ,
                }
            })
        end
    end

    return info
end

function FollowerDB:Update()
    collected = getFollowers(true)

    for k,v in ipairs(collected) do
        collectedIds[v.name] = v.id
    end

    missing = getFollowers(nil)

    CollectMe:SortTable(missing)
end

function FollowerDB:IsInZone(id, zones)
    if type(zones) ~= "table" then
        zones = { zones }
    end

    if Data.FollowersZone[id] ~= nil then
        for i = 1,#zones do
            if Data.FollowersZone[id][zones[i]] ~= nil then
                return true
            end
        end
    end

    return false
end

function FollowerDB:IsKnown(name)
    return collectedIds[name] ~= nil
end

function FollowerDB:OnEnable()
    self:Update()
    FollowerDB:RegisterEvent("GARRISON_FOLLOWER_LIST_UPDATE", "Update")
end

function FollowerDB:Get()
    if(#collected == 0) then
        self:Update()
    end
    return collected, missing
end
