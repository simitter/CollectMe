CollectMe.Config = CollectMe:NewModule("Config")

function CollectMe.Config:OnInitialize()
    local ac = LibStub("AceConfig-3.0")
    local acd = LibStub("AceConfigDialog-3.0")
    local db = CollectMe.db
    local addon_name = CollectMe.ADDON_NAME
    local L = CollectMe.L
    local about_panel = LibStub:GetLibrary("LibAboutPanel", true)

    about_panel.new(nil, addon_name)

    --ac:RegisterOptionsTable(addon_name, options)
    --acd:AddToBlizOptions(addon_name)

    ac:RegisterOptionsTable(addon_name .. " Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(db))
    acd:AddToBlizOptions(addon_name .. " Profiles", L['Profiles'], addon_name)



end
