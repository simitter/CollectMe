local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.UI = CollectMe:NewModule("UI", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")

local IsAddOnLoaded = C_AddOns.IsAddOnLoaded

function CollectMe.UI:OnInitialize()
    self.active_group = false

    self.cm_button_loaded = false
    self:RegisterEvent("ADDON_LOADED", "AddonLoadedListener")

    self:Build()
    self:AddCollectMeButtons()
end

function CollectMe.UI:AddonLoadedListener(event, name)
    if name == "Blizzard_Collections" and self.cm_button_loaded == false then
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
    search_box:SetWidth(387)
    search_box:SetCallback("OnEnterPressed", function() self:ReloadScroll() end)
    f:AddChild(search_box)

    local xbutton = self:CreateButton(self.L["X"], f.frame)
    xbutton:SetScript("OnClick", function() self.search_box:SetText("") self:ReloadScroll() end)
    xbutton:SetWidth(25)
    xbutton:ClearAllPoints()
    xbutton:SetPoint("LEFT", search_box.frame, "RIGHT", 0, 0)

    local okaybutton = self:CreateButton(self.L["Search"], f.frame)
    okaybutton:SetScript("OnClick", function() self:ReloadScroll() end)
    okaybutton:SetWidth(120)
    okaybutton:ClearAllPoints()
    okaybutton:SetPoint("LEFT", search_box.frame, "RIGHT", 25, 0)

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("Fill")
    container:SetFullWidth(true)
    container:SetHeight(427)
    f:AddChild(container)

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({
        {text = self.L["Mounts"], value = CollectMe.MOUNT},
        {text = self.L["Companions"], value = CollectMe.COMPANION},
        {text = self.L["Titles"], value = CollectMe.TITLE},
        {text = self.L["Toys"], value = CollectMe.TOYS },
        {text = self.L["Followers"], value = CollectMe.FOLLOWERS },
        {text = self.L["Heirlooms"], value = CollectMe.HEIRLOOMS },
        {text = self.L["Random Mount"], value = CollectMe.RANDOM_MOUNT},
        {text = self.L["Random Companion"], value = CollectMe.RANDOM_COMPANION},
        {text = self.L["Random Title"], value = CollectMe.RANDOM_TITLE}
    })
    tabs:SetCallback("OnGroupSelected", function (container, event, group) self:SelectGroup(container, group) end)
    container:AddChild(tabs)

    local profilebutton = self:CreateButton(self.L["Options"], f.frame)
    profilebutton:SetScript("OnClick", function()
        if Settings and Settings.OpenToCategory then
            Settings.OpenToCategory(CollectMe.ADDON_NAME)
        else
            InterfaceOptionsFrame_OpenToCategory(CollectMe.ADDON_NAME) 
            InterfaceOptionsFrame_OpenToCategory(CollectMe.ADDON_NAME) 
        end 
    end)
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
    if self.frame:IsVisible() then
        self.scroll:ReleaseChildren()
        CollectMe:BuildData(true)
    end
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
    local percent = 0
    if all ~= 0 then
        percent = CollectMe:round(active / all * 100, 2)
    end
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

function CollectMe.UI:CreateCheckbox(label, value, callbacks, max_lines, height, enabled)
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
    if enabled ~= nil then
        f:SetDisabled(not enabled)
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
    if self.cm_button_loaded == false and IsAddOnLoaded("Blizzard_Collections") then
        local cmbutton = CreateFrame("Button", "CollectMeOpenButton", MountJournal, "UIPanelButtonTemplate")
        cmbutton:ClearAllPoints()
        cmbutton:SetPoint("BOTTOMRIGHT", -8, 3)
        cmbutton:SetHeight(22)
        cmbutton:SetWidth(100)
        cmbutton:SetText(CollectMe.ADDON_NAME)
        cmbutton:SetScript("OnClick", function() self:Show(CollectMe.MOUNT); end)

        local cmbutton2 = CreateFrame("Button", "CollectMeOpen2Button", PetJournal, "UIPanelButtonTemplate")
        cmbutton2:ClearAllPoints()
        if IsAddOnLoaded("PetTracker_Journal") then
            cmbutton2:SetPoint("RIGHT", PetTracker_JournalTrackToggle, "LEFT", -5, 0)
        else
            cmbutton2:SetPoint("RIGHT", PetJournalFindBattle, "LEFT", -5, 0)
        end
        cmbutton2:SetHeight(22)
        cmbutton2:SetWidth(100)
        cmbutton2:SetText(CollectMe.ADDON_NAME)
        cmbutton2:SetScript("OnClick", function() self:Show(CollectMe.COMPANION); self.frame:Show() end)

        local cmbutton3 = CreateFrame("Button", "CollectMeOpen3Button", ToyBox.iconsFrame, "UIPanelButtonTemplate")
        cmbutton3:ClearAllPoints()
        cmbutton3:SetPoint("BOTTOMRIGHT", ToyBox.iconsFrame, "BOTTOMRIGHT", -50, 30)
        cmbutton3:SetHeight(22)
        cmbutton3:SetWidth(100)
        cmbutton3:SetText(CollectMe.ADDON_NAME)
        cmbutton3:SetScript("OnClick", function() self:Show(CollectMe.TOYS); self.frame:Show() end)
        
        local cmbutton4 = CreateFrame("Button", "CollectMeOpen4Button", HeirloomsJournal, "UIPanelButtonTemplate")
        cmbutton4:ClearAllPoints()
        cmbutton4:SetPoint("BOTTOMRIGHT", HeirloomsJournal, "BOTTOMRIGHT", -50, 30)
        cmbutton4:SetHeight(22)
        cmbutton4:SetWidth(100)
        cmbutton4:SetText(CollectMe.ADDON_NAME)
        cmbutton4:SetScript("OnClick", function() self:Show(CollectMe.HEIRLOOMS); self.frame:Show() end)
        cmbutton4:SetFrameStrata("TOOLTIP")

        self.cm_button_loaded = true
    end
end

function CollectMe.UI:GetSearchText()
    return self.search_box:GetText()
end

