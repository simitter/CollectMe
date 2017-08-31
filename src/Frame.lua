--[[-----------------------------------------------------------------------------
Frame Container
-------------------------------------------------------------------------------]]
local Type, Version = "CollectMe", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local pairs, assert, type = pairs, assert, type
local wipe = table.wipe

-- WoW APIs
local PlaySound = PlaySound
local CreateFrame, UIParent = CreateFrame, UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: CLOSE

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function CorrectTooltipFont(...)
    for i = 1, select("#", ...) do
        local region = select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            region:SetFontObject(SystemFont_Tiny)
        end
    end
end

local function Button_OnClick(frame)
    PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT)
    frame.obj:Hide()
end

local function Frame_OnClose(frame)
    frame.obj:Fire("OnClose")
end

local function Frame_OnMouseDown(frame)
    AceGUI:ClearFocus()
end

local function Title_OnMouseDown(frame)
    frame:GetParent():StartMoving()
    AceGUI:ClearFocus()
end

local function Title_OnMouseUp(mover)
    local frame = mover:GetParent()
    frame:StopMovingOrSizing()
    local self = frame.obj
    local status = self.status or self.localstatus
    status.width = frame:GetWidth()
    status.height = frame:GetHeight()
    status.top = frame:GetTop()
    status.left = frame:GetLeft()
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
    ["OnAcquire"] = function(self)
        self.frame:SetParent(UIParent)
        self.frame:SetFrameStrata("FULLSCREEN_DIALOG")
        self:SetTitle()
        self:ApplyStatus()
    end,

    ["OnRelease"] = function(self)
        self.status = nil
        wipe(self.localstatus)
    end,

    ["OnWidthSet"] = function(self, width)
        local content = self.content
        local contentwidth = width - 34
        if contentwidth < 0 then
            contentwidth = 0
        end
        content:SetWidth(contentwidth)
        content.width = contentwidth
    end,

    ["OnHeightSet"] = function(self, height)
        local content = self.content
        local contentheight = height - 57
        if contentheight < 0 then
            contentheight = 0
        end
        content:SetHeight(contentheight)
        content.height = contentheight
    end,

    ["SetTitle"] = function(self, title)
        self.titletext:SetText(title)
        self.titlebg:SetWidth((self.titletext:GetWidth() or 0) + 10)
    end,

    ["Hide"] = function(self)
        self.frame:Hide()
    end,

    ["Show"] = function(self)
        self.frame:Show()
    end,

    ["Toggle"] = function(self)
        if self.frame:IsVisible() then
            self.frame:Hide()
        else
            self.frame:Show()
        end
    end,

    -- called to set an external table to store status in
    ["SetStatusTable"] = function(self, status)
        assert(type(status) == "table")
        self.status = status
        self:ApplyStatus()
    end,

    ["ApplyStatus"] = function(self)
        local status = self.status or self.localstatus
        local frame = self.frame
        self:SetWidth(status.width or 700)
        self:SetHeight(status.height or 520)
        frame:ClearAllPoints()
        if status.top and status.left then
            frame:SetPoint("TOP", UIParent, "BOTTOM", 0, status.top)
            frame:SetPoint("LEFT", UIParent, "LEFT", status.left, 0)
        else
            frame:SetPoint("CENTER")
        end
    end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local FrameBackdrop = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
}

local PaneBackdrop  = {
    bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 3, right = 3, top = 5, bottom = 3 }
}

local function Constructor()
    local frame = CreateFrame("Frame", "CollectMeFrame", UIParent)
    frame:Hide()

    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetFrameStrata("FULLSCREEN_DIALOG")
    frame:SetBackdrop(FrameBackdrop)
    frame:SetBackdropColor(0, 0, 0, 1)
    frame:SetMinResize(400, 200)
    frame:SetToplevel(true)
    frame:SetScript("OnHide", Frame_OnClose)
    frame:SetScript("OnMouseDown", Frame_OnMouseDown)

    local closebutton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    closebutton:SetScript("OnClick", Button_OnClick)
    closebutton:SetPoint("BOTTOMRIGHT", -20, 17)
    closebutton:SetHeight(20)
    closebutton:SetWidth(100)
    closebutton:SetText(CLOSE)

    local statusbar = CreateFrame("StatusBar", nil, frame)
    statusbar:SetPoint("BOTTOMLEFT", 22, 17)
    statusbar:SetHeight(20)
    statusbar:SetWidth(300)
    statusbar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    statusbar:SetStatusBarColor(0, 0.65, 0)
    statusbar.bg = statusbar:CreateTexture(nil, "BACKGROUND")
    statusbar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    statusbar.bg:SetAllPoints(true)
    statusbar.bg:SetVertexColor(0.45, 0.25, 0, 0.5)
    statusbar.value = statusbar:CreateFontString(nil, "OVERLAY")
    statusbar.value:SetPoint("CENTER", statusbar, "CENTER", 4, 0)
    statusbar.value:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
    statusbar.value:SetTextColor(1, 1, 0)
    statusbar:Hide()

    local tooltip = CreateFrame( "GameTooltip", "CollectMeTooltip", nil, "GameTooltipTemplate" )
    CorrectTooltipFont(tooltip:GetRegions())

    local titlebg = frame:CreateTexture(nil, "OVERLAY")
    titlebg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    titlebg:SetTexCoord(0.31, 0.67, 0, 0.63)
    titlebg:SetPoint("TOP", 0, 12)
    titlebg:SetWidth(100)
    titlebg:SetHeight(40)

    local title = CreateFrame("Frame", nil, frame)
    title:EnableMouse(true)
    title:SetScript("OnMouseDown", Title_OnMouseDown)
    title:SetScript("OnMouseUp", Title_OnMouseUp)
    title:SetAllPoints(titlebg)

    local titletext = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titletext:SetPoint("TOP", titlebg, "TOP", 0, -14)

    local titlebg_l = frame:CreateTexture(nil, "OVERLAY")
    titlebg_l:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    titlebg_l:SetTexCoord(0.21, 0.31, 0, 0.63)
    titlebg_l:SetPoint("RIGHT", titlebg, "LEFT")
    titlebg_l:SetWidth(30)
    titlebg_l:SetHeight(40)

    local titlebg_r = frame:CreateTexture(nil, "OVERLAY")
    titlebg_r:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    titlebg_r:SetTexCoord(0.67, 0.77, 0, 0.63)
    titlebg_r:SetPoint("LEFT", titlebg, "RIGHT")
    titlebg_r:SetWidth(30)
    titlebg_r:SetHeight(40)

    --Container Support
    local content = CreateFrame("Frame", nil, frame)
    content:SetPoint("TOPLEFT", 17, -27)
    content:SetPoint("BOTTOMRIGHT", -17, 40)

    local widget = {
        localstatus = {},
        titletext   = titletext,
        titlebg     = titlebg,
        content     = content,
        frame       = frame,
        type        = Type,
        statusbar   = statusbar,
        tooltip     = tooltip,
        closebutton = closebutton
    }
    for method, func in pairs(methods) do
        widget[method] = func
    end
    closebutton.obj = widget

    return AceGUI:RegisterAsContainer(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
