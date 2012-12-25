CollectMe.LdbDisplay = CollectMe:NewModule("LdbDisplay", "AceEvent-3.0")

function CollectMe.LdbDisplay:OnInitialize()
    self.L = CollectMe.L
    self.loaded = false

    self.dataObject = LibStub("LibDataBroker-1.1"):NewDataObject(CollectMe.ADDON_NAME, {
        type = "data source",
        icon = "Interface\\Icons\\INV_PET_BABYBLIZZARDBEAR",
        text = CollectMe.L["Collectables in this zone"],

        OnClick = function()
            GameTooltip:FadeOut()
            CollectMe.UI:Show(CollectMe.COMPANION)
        end,

        OnEnter = function(this)
            if self.loaded == false then
                self:ZoneChangeListener()
            end
            GameTooltip:SetOwner( this, "ANCHOR_NONE" )
            GameTooltip:ClearAllPoints()
            local cx, cy = this:GetCenter()
            if cy < GetScreenHeight() / 2 then
                GameTooltip:SetPoint( "BOTTOM", this, "TOP", dx, dy )
            else
                GameTooltip:SetPoint( "TOP", this, "BOTTOM", dx, dy )
            end

            self:UpdateTooltip()
            GameTooltip:Show()
        end,

        OnLeave = function()
            GameTooltip:FadeOut()
        end
    })

    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneChangeListener")
end

function CollectMe.LdbDisplay:ZoneChangeListener()
    self:UpdateData()
    self:UpdateText()
end

function CollectMe.LdbDisplay:UpdateData()
    self.collected, self.missing = CollectMe.CompanionDB:GetCompanionsInZone(CollectMe.ZoneDB:Current())
    self.unique_collected_count = 0
    self.missing_count = #self.missing
    self.quality_counts = { [1]=0, [2]=0, [3]=0, [4]=0 }
    self.zone_name = GetMapNameByID(CollectMe.ZoneDB:Current())

    local collected = {}

    for i,v in ipairs(self.collected) do
        self.quality_counts[v.quality] = self.quality_counts[v.quality] + 1
        if not collected[v.species_id] then
            collected[v.species_id] = v.species_id;
            self.unique_collected_count = self.unique_collected_count + 1
        end
    end
    self.loaded = true
end

function CollectMe.LdbDisplay:UpdateText()
    local text = ""
    if self.missing_count > 0 then
        text = text .. RED_FONT_COLOR_CODE .. self.missing_count .. " " .. self.L["missing"] .. FONT_COLOR_CODE_CLOSE .. " / "
    end
    if self.unique_collected_count > 0 then
        text = text .. GREEN_FONT_COLOR_CODE .. self.unique_collected_count .. " " .. self.L["collected"] .. FONT_COLOR_CODE_CLOSE
        text = text .. " ("
        for i = 1,#self.quality_counts do
            if i ~= 1 then
                text = text .."/"
            end
            text = text .. CollectMe:ColorizeByQuality(self.quality_counts[i], i - 1)
        end
        text = text .. ")"
    end

    if text == "" then
        text = "No data"
    end

    self.dataObject.text = text

    GameTooltip:Hide()
end

function CollectMe.LdbDisplay:UpdateTooltip()
    GameTooltip:SetText(self.L["Companions in"] .. " " .. self.zone_name)
    GameTooltip:AddLine(" ")
    if self.unique_collected_count > 0 then
        GameTooltip:AddLine(GREEN_FONT_COLOR_CODE .. self.unique_collected_count .. " " .. self.L["collected"] .. ":" .. FONT_COLOR_CODE_CLOSE)
        for i,v in ipairs(self.collected) do
            local name = v.name
            if(v.custom_name ~= nil) then
                name = name .. " (".. v.custom_name..")"
            end
            GameTooltip:AddDoubleLine(name, CollectMe:ColorizeByQuality("Level " .. v.level, v.color))
        end
        GameTooltip:AddLine(" ")
    end
    if self.missing_count > 0 then
        GameTooltip:AddLine(RED_FONT_COLOR_CODE .. self.missing_count .. " " .. self.L["missing"] .. ":" .. FONT_COLOR_CODE_CLOSE)
        for i,v in ipairs(self.missing) do
            GameTooltip:AddLine(v.name)
        end
    end
end

