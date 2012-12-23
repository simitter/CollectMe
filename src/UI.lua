CollectMe.UI = CollectMe:NewModule("UI", "AceConsole-3.0")
local AceGUI = LibStub("AceGUI-3.0")

function CollectMe.UI:OnInitialize()
    self.active_group = CollectMe.TITLE

    self:Build()
    self:Show()
end

function CollectMe.UI:Build()
    self.L = CollectMe.L

    local f = AceGUI:Create("CollectMe")
    f:SetTitle("Collect Me " .. CollectMe.VERSION)
    f:SetWidth(570)
    f:SetLayout("Fill")
    --tinsert(UISpecialFrames, f.frame:GetName())

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({ {text = self.L["Mounts"], value = CollectMe.MOUNT}, {text = self.L["Companions"], value = CollectMe.COMPANION}, {text = self.L["Titles"], value = CollectMe.TITLE}, {text = self.L["Random Companion"], value = CollectMe.RANDOM_COMPANION}, {text = self.L["Random Mount"], value = CollectMe.RANDOM_MOUNT}})
    tabs:SetCallback("OnGroupSelected", function (container, event, group) self:SelectGroup(container, group) end)
    f:AddChild(tabs)

    local profilebutton = self:CreateButton(self.L["Profiles"], f.frame)
    profilebutton:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory(addon_name) end)
    profilebutton:ClearAllPoints()
    profilebutton:SetPoint("RIGHT", f.closebutton, "LEFT", 0, 0)

    local checkbutton = self:CreateButton(self.L["Check all"], f.frame)
    checkbutton:SetScript("OnClick", function() CollectMe:BatchCheck(true) end)
    checkbutton:SetWidth(120)
    checkbutton:ClearAllPoints()
    checkbutton:SetPoint("TOPLEFT", tabs.frame, "BOTTOMLEFT", 35, -3)
    checkbutton:Hide()

    local uncheckbutton = self:CreateButton(self.L["Uncheck all"], f.frame)
    uncheckbutton:SetScript("OnClick", function() CollectMe:BatchCheck(false) end)
    uncheckbutton:SetWidth(120)
    uncheckbutton:ClearAllPoints()
    uncheckbutton:SetPoint("LEFT", checkbutton, "RIGHT", 0, 0)
    uncheckbutton:Hide()

    self.frame = f
    self.tabs = tabs
    self.checkbutton, self.uncheckbutton = checkbutton, uncheckbutton
end

function CollectMe.UI:Show()
    self:SelectTab(CollectMe.TITLE)
    self.frame:Show()
end

function CollectMe.UI:SelectTab(group)
    self.tabs:SelectTab(group)
end


function CollectMe.UI:SelectGroup(container, group)
    container:ReleaseChildren()
    self.active_group = group

    self.frame.statusbar:Hide()
    self:HideCheckButtons()
    container:SetLayout("Flow")

    local scrollcontainer = AceGUI:Create("SimpleGroup")
    scrollcontainer:SetRelativeWidth(0.6)
    scrollcontainer:SetFullHeight(true)
    scrollcontainer:SetLayout("Fill")
    container:AddChild(scrollcontainer)

    local filtercontainer = AceGUI:Create("SimpleGroup")
    filtercontainer:SetRelativeWidth(0.4)
    filtercontainer:SetFullHeight(true)
    filtercontainer:SetLayout("Fill")
    container:AddChild(filtercontainer)

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    scrollcontainer:AddChild(scroll)
    self.scroll = scroll

    local filter = AceGUI:Create("ScrollFrame")
    filter:SetFullHeight(true)
    filter:SetLayout("Flow")
    filtercontainer:AddChild(filter)
    self.filter = filter

    CollectMe:BuildData()
end

function CollectMe.UI:UpdateStatusBar(all, active)
    local percent = CollectMe:round(active / all * 100, 2)

    self.frame.statusbar:SetMinMaxValues(0, all)
    self.frame.statusbar:SetValue(active)
    self.frame.statusbar.value:SetText(active .. " / " .. all .. " (".. percent .. "%)")
    self.frame.statusbar:Show()
end


function CollectMe.UI:AddToScroll(f)
    self.scroll:AddChild(f)
end

function CollectMe.UI:CreateHeading(text)
    local heading = AceGUI:Create("Heading")
    heading:SetText(text)
    heading:SetFullWidth(true)

    return heading
end

function CollectMe.UI:CreateScrollLabel(...)
    self:AddToScroll(self:CreateLabel(...))
end

function CollectMe.UI:CreateLabel(text, icon, callbacks)
    local f = AceGUI:Create("CollectMeLabel")
    f:SetHighlight("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(20, 20)
    end

    if callbacks ~= nil then
        for i,v in pairs(callbacks) do
            f:SetCallback(i, v)
        end
    end

    return f
end

function CollectMe.UI:CreateButton(text, parent)
    local f = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    f:SetHeight(20)
    f:SetWidth(100)
    f:SetText(text)
    return f
end

function CollectMe.UI:HideCheckButtons()
    self.checkbutton:Hide()
    self.uncheckbutton:Hide()
end

function CollectMe.UI:ShowCheckButtons()
    self.checkbutton:Show()
    self.uncheckbutton:Show()
end
