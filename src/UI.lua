CollectMe.UI = CollectMe:NewModule("UI", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")

function CollectMe.UI:OnInitialize()
    self.active_group = false

    self.cm_button_loaded = false
    self:RegisterEvent("ADDON_LOADED", "AddonLoadedListener")

    self:Build()
    self:AddCollectMeButtons()
end

function CollectMe.UI:AddonLoadedListener(event, name)
    if name == "Blizzard_PetJournal" and self.cm_button_loaded == false then
        self:AddCollectMeButtons()
    end
end

function CollectMe.UI:Build()
    self.L = CollectMe.L

    local f = AceGUI:Create("CollectMe")
    f:SetTitle("Collect Me " .. CollectMe.VERSION)
    f:SetWidth(570)
    f:SetLayout("List")
    tinsert(UISpecialFrames, f.frame:GetName())

    local search_box = AceGUI:Create("EditBox")
    search_box:DisableButton(true)
    search_box:SetWidth(412)
    search_box:SetCallback("OnEnterPressed", function() self:ReloadScroll() end)
    f:AddChild(search_box)

    local okaybutton = self:CreateButton(self.L["Search"], f.frame)
    okaybutton:SetScript("OnClick", function() self:ReloadScroll() end)
    okaybutton:SetWidth(120)
    okaybutton:ClearAllPoints()
    okaybutton:SetPoint("LEFT", search_box.frame, "RIGHT", 0, -1)

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("Fill")
    container:SetFullWidth(true)
    container:SetHeight(407)
    f:AddChild(container)

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({ {text = self.L["Mounts"], value = CollectMe.MOUNT}, {text = self.L["Companions"], value = CollectMe.COMPANION}, {text = self.L["Titles"], value = CollectMe.TITLE}, {text = self.L["Random Companion"], value = CollectMe.RANDOM_COMPANION}, {text = self.L["Random Mount"], value = CollectMe.RANDOM_MOUNT}})
    tabs:SetCallback("OnGroupSelected", function (container, event, group) self:SelectGroup(container, group) end)
    container:AddChild(tabs)

    local profilebutton = self:CreateButton(self.L["Options"], f.frame)
    profilebutton:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory(CollectMe.ADDON_NAME) end)
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
    self.search_box = search_box
    self.checkbutton, self.uncheckbutton = checkbutton, uncheckbutton
end

function CollectMe.UI:ReloadScroll()
    self.scroll:ReleaseChildren()
    CollectMe:BuildData(true)
end

function CollectMe.UI:Show(group)
    if group ~= nil then
        self:SelectTab(group)
    elseif self.active_group == false then
        self:SelectTab(CollectMe.MOUNT)
    end
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

function CollectMe.UI:AddToFilter(f)
    self.filter:AddChild(f)
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

function CollectMe.UI:CreateFilterCheckbox(...)
    self:AddToFilter(self:CreateCheckbox(...))
end

function CollectMe.UI:CreateScrollCheckbox(...)
    self:AddToScroll(self:CreateCheckbox(...))
end

function CollectMe.UI:CreateFilterDropdown(...)
    self:AddToFilter(self:CreateDropdown(...))
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

    self:AddCallbacks(f, callbacks)
    return f
end

function CollectMe.UI:AddCallbacks(f, callbacks)
    if callbacks ~= nil then
        for i,v in pairs(callbacks) do
            f:SetCallback(i, v)
        end
    end
end

function CollectMe.UI:CreateButton(text, parent)
    local f = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    f:SetHeight(20)
    f:SetWidth(100)
    f:SetText(text)
    return f
end

function CollectMe.UI:CreateCheckbox(label, value, callbacks, max_lines, height)
    local f = AceGUI:Create("CheckBox")

    if label ~= nil then
        f:SetLabel(label)
    end
    if value ~= nil then
        f:SetValue(value)
    end
    if max_lines ~= nil then
        f.text:SetMaxLines(max_lines)
    end
    if height ~= nil then
        f:SetHeight(height)
    end

    f:SetFullWidth(true)
    f:SetPoint("Top", 15, 15)
    self:AddCallbacks(f, callbacks)
    return f
end

function CollectMe.UI:CreateDropdown(label, list, value, callbacks, multiselect, order)
    local f = AceGUI:Create("Dropdown")
    f:SetLabel(label)
    f:SetList(list, order)
    if multiselect ~= nil then
        f:SetMultiselect(multiselect)
    end
    f.label:ClearAllPoints()
    f.label:SetPoint("LEFT", 10, 15)
    f.dropdown:ClearAllPoints()
    f.dropdown:SetPoint("TOPLEFT",f.frame,"TOPLEFT",-10,-15)
    f.dropdown:SetPoint("BOTTOMRIGHT",f.frame,"BOTTOMRIGHT",17,0)
    if type(value) == "table" then
        for i = 1,#value do
            f:SetValue(value[i])
            f:SetItemValue(value[i], true)
        end
    else
        f:SetValue(value)
    end

    self:AddCallbacks(f, callbacks)
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

function CollectMe.UI:AddCollectMeButtons()
    if self.cm_button_loaded == false and IsAddOnLoaded("Blizzard_PetJournal") then
        local cmbutton = CreateFrame("Button", "CollectMeOpenButton", MountJournal, "UIPanelButtonTemplate")
        cmbutton:ClearAllPoints()
        cmbutton:SetPoint("BOTTOMRIGHT", -8, 3)
        cmbutton:SetHeight(22)
        cmbutton:SetWidth(100)
        cmbutton:SetText(CollectMe.ADDON_NAME)
        cmbutton:SetScript("OnClick", function() self:Show(CollectMe.MOUNT); end)

        local cmbutton2 = CreateFrame("Button", "CollectMeOpen2Button", PetJournal, "UIPanelButtonTemplate")
        cmbutton2:ClearAllPoints()
        cmbutton2:SetPoint("RIGHT", PetJournalFindBattle, "LEFT", -5, 0)
        cmbutton2:SetHeight(22)
        cmbutton2:SetWidth(100)
        cmbutton2:SetText(CollectMe.ADDON_NAME)
        cmbutton2:SetScript("OnClick", function() self:Show(CollectMe.COMPANION); self.frame:Show() end)

        self.cm_button_loaded = true
    end
end

function CollectMe.UI:GetSearchText()
    return self.search_box:GetText()
end

