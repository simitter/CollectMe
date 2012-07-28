CollectMe = LibStub("AceAddon-3.0"):NewAddon("CollectMe", "AceConsole-3.0");
local AceGUI = LibStub("AceGUI-3.0");

function CollectMe:OnInitialize()
    self.COLLECTME_VERSION = GetAddOnMetadata("CollectMe", "Version");

    self:BuildUI();

    self:RegisterChatCommand("collectme", "SlashProcessor");
    self:RegisterChatCommand("cm", "SlashProcessor");
end

function CollectMe:SelectGroup(container, group)
    container:ReleaseChildren()
    CollectMe:BuildTab(container, group)
end

function CollectMe:BuildUI()
    local f = AceGUI:Create("CollectMe");
    f:SetTitle("Collect Me " .. self.COLLECTME_VERSION);
    f:SetWidth(570)
    f:SetLayout("Fill")

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({ {text = "Mounts", value = 1}, {text = "Titles", value = 62}})
    tabs:SetCallback("OnGroupSelected", function (container, event, group) CollectMe:SelectGroup(container, group) end)
    f:AddChild(tabs)

    self.tabs = tabs
    self.frame = f
end

function CollectMe:BuildTab(container, group)
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
    scrollcontainer:AddChild(scroll)

    local active = AceGUI:Create("Heading")
    active:SetText("Active")
    active:SetFullWidth(true)
    scroll:AddChild(active)

    local filter = AceGUI:Create("ScrollFrame")
    filter:SetFullHeight(true)
    filtercontainer:AddChild(filter)

    local desc = AceGUI:Create("Heading")
    desc:SetText("Filters")
    desc:SetFullWidth(true)
    filter:AddChild(desc)
end

function CollectMe:SlashProcessor(input)
    self.tabs:SelectTab(1)
    self.frame:Show()
end
