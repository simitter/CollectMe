CollectMe.UI = CollectMe:NewModule("UI", "AceConsole-3.0")

function CollectMe.UI:initialize()
    local f = AceGUI:Create("CollectMe")
    f:SetTitle("Collect Me " .. self.COLLECTME_VERSION)
    f:SetWidth(570)
    f:SetLayout("Fill")
    tinsert(UISpecialFrames, f.frame:GetName())

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({ {text = self.L["Mounts"], value = CollectMe.MOUNT}, {text = self.L["Companions"], value = CollectMe.COMPANION}, {text = self.L["Titles"], value = CollectMe.TITLE}, {text = self.L["Random Companion"], value = CollectMe.RANDOM_COMPANION}, {text = self.L["Random Mount"], value = CollectMe.RANDOM_MOUNT}})
    tabs:SetCallback("OnGroupSelected", function (container, event, group) CollectMe:SelectGroup(container, group) end)
    f:AddChild(tabs)

    self.tabs = tabs
    self.frame = f

    local profilebutton = self:CreateButton(self.L["Profiles"], self.frame.frame)
    profilebutton:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory(addon_name) end)
    profilebutton:ClearAllPoints()
    profilebutton:SetPoint("RIGHT", self.frame.closebutton, "LEFT", 0, 0)

    local checkbutton = self:CreateButton(self.L["Check all"], self.frame.frame)
    checkbutton:SetScript("OnClick", function() CollectMe:BatchCheck(true) end)
    checkbutton:SetWidth(120)
    checkbutton:ClearAllPoints()
    checkbutton:SetPoint("TOPLEFT", self.tabs.frame, "BOTTOMLEFT", 35, -3)
    checkbutton:Hide()

    local uncheckbutton = self:CreateButton(self.L["Uncheck all"], self.frame.frame)
    uncheckbutton:SetScript("OnClick", function() CollectMe:BatchCheck(false) end)
    uncheckbutton:SetWidth(120)
    uncheckbutton:ClearAllPoints()
    uncheckbutton:SetPoint("LEFT", checkbutton, "RIGHT", 0, 0)
    uncheckbutton:Hide()

    self.checkbutton, self.uncheckbutton = checkbutton, uncheckbutton
end
