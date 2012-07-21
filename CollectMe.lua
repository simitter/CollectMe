CollectMe = LibStub("AceAddon-3.0"):NewAddon("CollectMe", "AceConsole-3.0");
local AceGUI = LibStub("AceGUI-3.0");

function CollectMe:OnInitialize()
    self.COLLECTME_VERSION = GetAddOnMetadata("CollectMe", "Version");

    self:BuildUI();

    self:RegisterChatCommand("collectme", "SlashProcessor");
    self:RegisterChatCommand("cm", "SlashProcessor");

end

function CollectMe:BuildUI()
    local f = AceGUI:Create("Frame");
    f:SetTitle("Collect Me " .. self.COLLECTME_VERSION);
    f:Hide();

    self.frame = f;
end

function CollectMe:SlashProcessor(input)
    self.frame:Show();
end
