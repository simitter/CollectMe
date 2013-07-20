local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.Config = CollectMe:NewModule("Config")

function CollectMe.Config:OnInitialize()
    local ac = LibStub("AceConfig-3.0")
    local acd = LibStub("AceConfigDialog-3.0")
    local addon_name = CollectMe.ADDON_NAME
    local L = CollectMe.L
    local db = CollectMe.db

    local about_panel = LibStub:GetLibrary("LibAboutPanel", true)
    about_panel.new(nil, addon_name)

    ac:RegisterOptionsTable(addon_name .. " LDB", self:GetLdbOptionsTable())
    acd:AddToBlizOptions(addon_name .. " LDB", L["Data Broker Options"], addon_name)

    ac:RegisterOptionsTable(addon_name .. " Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(db))
    acd:AddToBlizOptions(addon_name .. " Profiles", L["Profiles"], addon_name)
end

function CollectMe.Config:GetLdbOptionsTable()
    local L = CollectMe.L
    local db = CollectMe.db

    return {
        name = L["Data Broker Options"],
        type = "group",
        order = 1,
        args = {
            tooltip = {
                type = "group",
                order = 1,
                name = L["Tooltip"],
                guiInline = true,
                args = self:GetLdbArgs(db.profile.ldb.tooltip)
            },
            text = {
                type = "group",
                order = 2,
                name = L["Text"],
                guiInline = true,
                args = self:GetLdbArgs(db.profile.ldb.text)
            }
        }
    }
end

function CollectMe.Config:GetLdbArgs(db)
    local L = CollectMe.L

    return {
        companions_collected = {
            name = L["Collected companions"],
            desc = L["Display already collected companions"],
            type = "toggle",
            order = 1,
            set = function(info,val) db.companions.collected = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function(info) return db.companions.collected end
        },
        companions_missing = {
            name = L["Missing companions"],
            desc = L["Display missing companions"],
            type = "toggle",
            order = 2,
            set = function(info,val) db.companions.missing = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function(info) return db.companions.missing end
        },
        companions_quality = {
            name = L["Companion Quality"],
            desc = L["Display companion quality"],
            type = "toggle",
            order = 3,
            set = function(info,val) db.companions.quality = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function(info) return db.companions.quality end
        },
        mounts_collected = {
            name = L["Collected mounts"],
            desc = L["Display already collected mounts"],
            type = "toggle",
            order = 4,
            set = function(info,val) db.mounts.collected = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function(info) return db.mounts.collected end
        },
        mounts_missing = {
            name = L["Missing mounts"],
            desc = L["Display missing mounts"],
            type = "toggle",
            order = 5,
            set = function(info,val) db.mounts.missing = val; CollectMe.LdbDisplay:ZoneChangeListener()  end,
            get = function(info) return db.mounts.missing end
        }
    }
end
