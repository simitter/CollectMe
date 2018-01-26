local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.LdbDisplay = CollectMe:NewModule("LdbDisplay", "AceEvent-3.0")

local Data = CollectMe:GetModule("Data")
local ToyDB = CollectMe:GetModule("ToyDB")
local FollowerDB = CollectMe:GetModule("FollowerDB")
local MountDB = CollectMe:GetModule("MountDB")
local ownerFrame = nil

function CollectMe.LdbDisplay:OnEnable()
    self.L = CollectMe.L
    self.loaded = false

    self.db = CollectMe.db.profile.ldb

    self.dataObject = LibStub("LibDataBroker-1.1"):NewDataObject(CollectMe.ADDON_NAME, {
        type = "data source",
        icon = "Interface\\Icons\\INV_PET_BABYBLIZZARDBEAR",
        text = CollectMe.L["Collectables in this zone"],

        OnClick = function()
            GameTooltip:Hide()
            CollectMe.UI:Show(CollectMe.COMPANION)
        end,

        OnEnter = function(this)
            ownerFrame = this
            if self.loaded == false then
                self:ZoneChangeListener()
            end
            GameTooltip:SetOwner( ownerFrame, "ANCHOR_NONE" )
            GameTooltip:ClearAllPoints()
            local _, cy = this:GetCenter()
            if cy < GetScreenHeight() / 2 then
                GameTooltip:SetPoint( "BOTTOM", this, "TOP" )
            else
                GameTooltip:SetPoint( "TOP", this, "BOTTOM" )
            end

            self:UpdateTooltip()
            GameTooltip:Show()
        end,

        OnLeave = function()
            GameTooltip:Hide()
            ownerFrame = nil
        end
    })

    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneChangeListener")
    self:RegisterEvent("COMPANION_LEARNED", "ZoneChangeListener")
    self:RegisterEvent("TOYS_UPDATED", "ZoneChangeListener")
    self:RegisterEvent("GARRISON_FOLLOWER_LIST_UPDATE", "ZoneChangeListener")
end

function CollectMe.LdbDisplay:ZoneChangeListener(event)
	if (event == "ZONE_CHANGED_NEW_AREA") then
		self.zone_id = CollectMe.ZoneDB:Current()
	else
		self.zone_id = CollectMe.ZoneDB:GetZone()
	end
	self.zone_name = GetMapNameByID(self.zone_id)

    self:UpdateData()
    self:UpdateText()
end

function CollectMe.LdbDisplay:UpdateData()
    self.collected, self.missing = {}, {}
    self.unique_collected_count = 0
    self.missing_count = #self.missing
    self.quality_counts = { [1]=0, [2]=0, [3]=0, [4]=0 }
    self.collected_mounts, self.missing_mounts = {}, {}
    self.collected_toys, self.missing_toys = {}, {}
    self.collected_followers, self.missing_followers = {}, {}

    if self.db.text.companions.missing == true or self.db.text.companions.collected == true or self.db.text.companions.quality == true or self.db.tooltip.companions.missing == true or self.db.tooltip.companions.collected == true or self.db.tooltip.companions.quality == true then
        local zcollected, missing = CollectMe.CompanionDB:GetCompanionsInZone(self.zone_id)
        for i,v in ipairs(missing) do
            if not CollectMe:IsInTable(CollectMe.db.profile.ignored.companions, v.creature_id) then
                table.insert(self.missing, v)
            end
        end

        self.missing_count = #self.missing
        local collected = {}
        for i,v in ipairs(zcollected) do
            if not CollectMe:IsInTable(CollectMe.db.profile.ignored.companions, v.creature_id) then
                table.insert(self.collected, v)
                self.quality_counts[v.quality] = self.quality_counts[v.quality] + 1
                if not collected[v.species_id] then
                    collected[v.species_id] = v.species_id;
                    self.unique_collected_count = self.unique_collected_count + 1
                end
            end
        end
    end

    if self.db.text.mounts.missing == true or self.db.text.mounts.collected == true or self.db.tooltip.mounts.missing == true or self.db.tooltip.mounts.collected == true then
        CollectMe.filter_list, CollectMe.filter_db = MountDB.filters, CollectMe.db.profile.filters.mounts

        for i,v in ipairs(MountDB:GetZoneMounts(self.zone_id)) do
            if not CollectMe:IsFiltered(v.filters) and not CollectMe:IsInTable(CollectMe.db.profile.ignored.mounts , v.id) then
                if v.collected ~= false then
                    tinsert(self.collected_mounts, v)
                else
                    tinsert(self.missing_mounts, v)
                end

                CollectMe:SortTable(self.collected_mounts)
                CollectMe:SortTable(self.missing_mounts)
            end
        end
    end

    if self.db.text.toys.missing == true or self.db.text.toys.collected == true or self.db.tooltip.toys.missing == true or self.db.tooltip.toys.collected == true then
        if Data.ZoneToys[self.zone_id] ~= nil then
            for i,v in pairs(Data.ZoneToys[self.zone_id]) do
                if not CollectMe:IsInTable(CollectMe.db.profile.ignored.toys , v) then
                    local _, name = C_ToyBox.GetToyInfo(v)
                    if ToyDB:IsKnown(v) then
                        tinsert(self.collected_toys, { name = name })
                    else
                        tinsert(self.missing_toys, { name = name })
                    end
                end
            end
        end
    end

    if self.db.text.followers.missing == true or self.db.text.followers.collected == true or self.db.tooltip.followers.missing == true or self.db.tooltip.followers.collected == true then
        if Data.ZoneFollowers[zone_id] ~= nil then
            for i,v in pairs(Data.ZoneFollowers[zone_id]) do
                if not CollectMe:IsInTable(CollectMe.db.profile.ignored.followers , v) then
                    local follower = C_Garrison.GetFollowerInfo(v)
                    if FollowerDB:IsKnown(follower.name) then
                        tinsert(self.collected_followers, { name = follower.name })
                    else
                        tinsert(self.missing_followers, { name = follower.name })
                    end
                end
            end
        end
    end

    self.loaded = true
end

function CollectMe.LdbDisplay:UpdateText()
    local text = ""

    if self.db.text.companions.missing == true and self.missing_count > 0 then
        text = text .. RED_FONT_COLOR_CODE .. self.missing_count .. FONT_COLOR_CODE_CLOSE
        if self.unique_collected_count > 0 and self.db.text.companions.collected == true then
            text = self:AppendText(text, "/")
        end
    end

    if self.unique_collected_count > 0 then
        if self.db.text.companions.collected == true then
            text = text .. GREEN_FONT_COLOR_CODE .. self.unique_collected_count .. FONT_COLOR_CODE_CLOSE
        end
        if self.db.text.companions.quality == true then
            text = text .. " ("
            for i = 1,#self.quality_counts do
                if i ~= 1 then
                    text = text .."/"
                end
                text = text .. CollectMe:ColorizeByQuality(self.quality_counts[i], i - 1)
            end
            text = text .. ")"
        end
    end

    if (self.db.text.mounts.missing == true and #self.missing_mounts > 0) or (self.db.text.mounts.collected == true and #self.collected_mounts > 0) then
        text = self:AppendText(text, " - ")
    end

    if self.db.text.mounts.missing == true and #self.missing_mounts > 0 then
        text = text .. RED_FONT_COLOR_CODE .. #self.missing_mounts .. FONT_COLOR_CODE_CLOSE
    end

    if self.db.text.mounts.collected == true and #self.collected_mounts > 0 then
        if #self.missing_mounts > 0 and self.db.text.mounts.missing == true then
            text = self:AppendText(text, "/")
        end
        text = text .. GREEN_FONT_COLOR_CODE .. #self.collected_mounts .. FONT_COLOR_CODE_CLOSE
    end

    if (self.db.text.toys.missing == true and #self.missing_toys > 0) or (self.db.text.toys.collected == true and #self.collected_toys > 0) then
        text = self:AppendText(text, " - ")
    end

    if self.db.text.toys.missing == true and #self.missing_toys > 0 then
        text = text .. RED_FONT_COLOR_CODE .. #self.missing_toys .. FONT_COLOR_CODE_CLOSE
    end

    if self.db.text.toys.collected == true and #self.collected_toys > 0 then
        if #self.missing_toys > 0 and self.db.text.toys.missing == true then
            text = self:AppendText(text, "/")
        end
        text = text .. GREEN_FONT_COLOR_CODE .. #self.collected_toys .. FONT_COLOR_CODE_CLOSE
    end

    if (self.db.text.followers.missing == true and #self.missing_followers > 0) or (self.db.text.followers.collected == true and #self.collected_followers > 0) then
        text = self:AppendText(text, " - ")
    end

    if self.db.text.followers.missing == true and #self.missing_followers > 0 then
        text = text .. RED_FONT_COLOR_CODE .. #self.missing_followers .. FONT_COLOR_CODE_CLOSE
    end

    if self.db.text.followers.collected == true and #self.collected_followers > 0 then
        if #self.missing_followers > 0 and self.db.text.followers.missing == true then
            text = self:AppendText(text, "/")
        end
        text = text .. GREEN_FONT_COLOR_CODE .. #self.collected_followers .. FONT_COLOR_CODE_CLOSE
    end

    if text == "" then
        text = "0/0"
    end

    self.dataObject.text = text:trim()
    if ownerFrame ~= nil and GameTooltip:IsOwned(ownerFrame) then
        GameTooltip:Hide()
        ownerFrame = nil
    end
end

function CollectMe.LdbDisplay:AppendText(text, text_to_append)
    if text:trim():len() > 0 then
        text = text .. text_to_append
    end
    return text
end

local function AddTooltipSection(items, label, color)
    GameTooltip:AddLine(color .. #items .. " " .. label .. ":" .. FONT_COLOR_CODE_CLOSE)
    for i,v in ipairs(items) do
        GameTooltip:AddLine(v.name)
    end
end

function CollectMe.LdbDisplay:UpdateTooltip()
    if self.zone_name == nil then
        return nil
    end

    GameTooltip:SetText(self.L["CollectMe in"] .. " " .. self.zone_name)
    GameTooltip:AddLine(" ")

    if self.db.tooltip.companions.collected == true and self.unique_collected_count > 0 then
        GameTooltip:AddLine(GREEN_FONT_COLOR_CODE .. self.unique_collected_count .. " " .. self.L["Companions"] .. " " .. self.L["collected"] .. ":" .. FONT_COLOR_CODE_CLOSE)
        for i,v in ipairs(self.collected) do
            local name = v.name
            if(v.custom_name ~= nil) then
                name = name .. " (".. v.custom_name..")"
            end
            if self.db.tooltip.companions.quality == true then
                GameTooltip:AddDoubleLine(name, CollectMe:ColorizeByQuality("Level " .. v.level, v.color))
            else
                GameTooltip:AddLine(name)
            end
        end
        GameTooltip:AddLine(" ")
    end
    if self.db.tooltip.companions.missing == true and self.missing_count > 0 then
        GameTooltip:AddLine(RED_FONT_COLOR_CODE .. self.missing_count .. " " .. self.L["Companions"] .. " " .. self.L["missing"] .. ":" .. FONT_COLOR_CODE_CLOSE)
        for i,v in ipairs(self.missing) do
            GameTooltip:AddLine(v.name)
        end
        GameTooltip:AddLine(" ")
    end

    if self.db.tooltip.mounts.collected == true and #self.collected_mounts > 0 then
        AddTooltipSection(self.collected_mounts, self.L["Mounts"] .. " " .. self.L["collected"], GREEN_FONT_COLOR_CODE)
        GameTooltip:AddLine(" ")
    end

    if self.db.tooltip.mounts.missing == true and #self.missing_mounts > 0  then
        AddTooltipSection(self.missing_mounts, self.L["Mounts"] .. " " .. self.L["missing"], RED_FONT_COLOR_CODE)
        GameTooltip:AddLine(" ")
    end

    if self.db.tooltip.toys.collected == true and #self.collected_toys > 0 then
        AddTooltipSection(self.collected_toys, self.L["Toys"] .. " " .. self.L["collected"], GREEN_FONT_COLOR_CODE)
        GameTooltip:AddLine(" ")
    end

    if self.db.tooltip.toys.missing == true and #self.missing_toys > 0  then
        AddTooltipSection(self.missing_toys, self.L["Toys"] .. " " .. self.L["missing"], RED_FONT_COLOR_CODE)
        GameTooltip:AddLine(" ")
    end

    if self.db.tooltip.followers.collected == true and #self.collected_followers > 0 then
        AddTooltipSection(self.collected_followers, self.L["Followers"] .. " " .. self.L["collected"], GREEN_FONT_COLOR_CODE)
        GameTooltip:AddLine(" ")
    end

    if self.db.tooltip.followers.missing == true and #self.missing_followers > 0  then
        AddTooltipSection(self.missing_followers, self.L["Followers"] .. " " .. self.L["missing"], RED_FONT_COLOR_CODE)
    end
end
