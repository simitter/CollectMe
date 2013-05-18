CollectMe.LdbDisplay = CollectMe:NewModule("LdbDisplay", "AceEvent-3.0")

function CollectMe.LdbDisplay:OnInitialize()
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
            if self.loaded == false then
                self:ZoneChangeListener()
            end
            GameTooltip:SetOwner( this, "ANCHOR_NONE" )
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
        end
    })

    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneChangeListener")
end

function CollectMe.LdbDisplay:ZoneChangeListener()
    self:UpdateData()
    self:UpdateText()
end

function CollectMe.LdbDisplay:UpdateData()
    self.zone_name = GetMapNameByID(CollectMe.ZoneDB:Current())

    if self.db.tooltip.companions.missing == true or self.db.tooltip.companions.collected == true or self.db.text.companions.missing == true or self.db.text.companions.collected == true or self.db.tooltip.companions.quality == true or self.db.text.companions.quality == true then
        self.collected, self.missing = CollectMe.CompanionDB:GetCompanionsInZone(CollectMe.ZoneDB:Current())
        self.unique_collected_count = 0
        self.missing_count = #self.missing
        self.quality_counts = { [1]=0, [2]=0, [3]=0, [4]=0 }

        local collected = {}

        for i,v in ipairs(self.collected) do
            self.quality_counts[v.quality] = self.quality_counts[v.quality] + 1
            if not collected[v.species_id] then
                collected[v.species_id] = v.species_id;
                self.unique_collected_count = self.unique_collected_count + 1
            end
        end
    end

    if self.db.tooltip.mounts.missing == true or self.db.tooltip.mounts.collected == true or self.db.text.mounts.missing == true or self.db.text.mounts.collected == true then
        CollectMe.MountDB:RefreshKnown(true)
        self.collected_mounts, self.missing_mounts = {}, {}
        local current_filter_list, current_filter_db = CollectMe.filter_list, CollectMe.filter_db

        CollectMe.filter_list, CollectMe.filter_db = CollectMe.MountDB.filters, CollectMe.db.profile.filters.mounts

        for i,v in ipairs(CollectMe.MountDB:GetZoneMounts({CollectMe.ZoneDB:Current()})) do
            if not CollectMe:IsFiltered(v.filters) and not CollectMe:IsInTable(CollectMe.db.profile.ignored.mounts , v.id) then
                if CollectMe.MountDB:IsKnown(v.id) ~= false then
                    tinsert(self.collected_mounts, v)
                else
                    tinsert(self.missing_mounts, v)
                end
            end
        end
    end

    self.loaded = true
end

function CollectMe.LdbDisplay:UpdateText()
    local text = ""
    if self.missing_count > 0 then
        text = text .. RED_FONT_COLOR_CODE .. self.missing_count .. FONT_COLOR_CODE_CLOSE
        if self.unique_collected_count > 0 then
            text = text .. "/"
        end
    end
    if self.unique_collected_count > 0 then
        text = text .. GREEN_FONT_COLOR_CODE .. self.unique_collected_count .. FONT_COLOR_CODE_CLOSE
        text = text .. " ("
        for i = 1,#self.quality_counts do
            if i ~= 1 then
                text = text .."/"
            end
            text = text .. CollectMe:ColorizeByQuality(self.quality_counts[i], i - 1)
        end
        text = text .. ")"
    end

    if (#self.missing_mounts + #self.collected_mounts) > 0 then
        text = text .. " - "
    end


    if #self.missing_mounts > 0 then
        text = text .. RED_FONT_COLOR_CODE .. #self.missing_mounts .. FONT_COLOR_CODE_CLOSE
    end
    if #self.collected_mounts > 0 then
        if #self.missing_mounts > 0 then
            text = text .. "/"
        end
        text = text .. GREEN_FONT_COLOR_CODE .. #self.collected_mounts .. FONT_COLOR_CODE_CLOSE
    end

    if text == "" then
        text = "No data"
    end

    self.dataObject.text = text

    GameTooltip:Hide()
end

function CollectMe.LdbDisplay:UpdateTooltip()
    GameTooltip:SetText(self.L["CollectMe in"] .. " " .. self.zone_name)
    GameTooltip:AddLine(" ")

    if self.db.tooltip.companions.collected == true then
        if self.unique_collected_count > 0 then
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
    end
    if self.db.tooltip.companions.missing == true then
        if self.missing_count > 0 then
            GameTooltip:AddLine(RED_FONT_COLOR_CODE .. self.missing_count .. " " .. self.L["Companions"] .. " " .. self.L["missing"] .. ":" .. FONT_COLOR_CODE_CLOSE)
            for i,v in ipairs(self.missing) do
                GameTooltip:AddLine(v.name)
            end
            GameTooltip:AddLine(" ")
        end
    end

    if self.db.tooltip.mounts.collected == true then
        if #self.collected_mounts > 0 then
            GameTooltip:AddLine(GREEN_FONT_COLOR_CODE .. #self.collected_mounts .. " " .. self.L["Mounts"] .. " " .. self.L["collected"] .. ":" .. FONT_COLOR_CODE_CLOSE)
            for i,v in ipairs(self.collected_mounts) do
                GameTooltip:AddLine(v.name)
            end
            GameTooltip:AddLine(" ")
        end
    end

    if self.db.tooltip.mounts.missing == true then
        if #self.missing_mounts > 0 then
            GameTooltip:AddLine(RED_FONT_COLOR_CODE .. #self.missing_mounts .. " " .. self.L["Mounts"] .. " " .. self.L["missing"] .. ":" .. FONT_COLOR_CODE_CLOSE)
            for i,v in ipairs(self.missing_mounts) do
                GameTooltip:AddLine(v.name)
            end
        end
    end
end
