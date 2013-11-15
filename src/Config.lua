local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Config = CollectMe:NewModule("Config")

local L = CollectMe.L
local db

local function GetLdbArgs(ldbdb)
    return {
        companions_collected = {
            name = L["Collected companions"],
            desc = L["Display already collected companions"],
            type = "toggle",
            order = 1,
            set = function(info,val) ldbbd.companions.collected = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function() return ldbdb.companions.collected end
        },
        companions_missing = {
            name = L["Missing companions"],
            desc = L["Display missing companions"],
            type = "toggle",
            order = 2,
            set = function(info,val) ldbdb.companions.missing = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function() return ldbdb.companions.missing end
        },
        companions_quality = {
            name = L["Companion Quality"],
            desc = L["Display companion quality"],
            type = "toggle",
            order = 3,
            set = function(info,val) ldbdb.companions.quality = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function() return ldbdb.companions.quality end
        },
        mounts_collected = {
            name = L["Collected mounts"],
            desc = L["Display already collected mounts"],
            type = "toggle",
            order = 4,
            set = function(info,val) ldbdb.mounts.collected = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function() return ldbdb.mounts.collected end
        },
        mounts_missing = {
            name = L["Missing mounts"],
            desc = L["Display missing mounts"],
            type = "toggle",
            order = 5,
            set = function(info,val) ldbdb.mounts.missing = val; CollectMe.LdbDisplay:ZoneChangeListener()  end,
            get = function() return ldbdb.mounts.missing end
        }
    }
end

local function GetMacroOptionsTable()
    local list = {}
    list[1] = L["Mount / Dismount"]
    list[2] = L["Dismount"]
    list[3] = L["Ground Mount / Dismount"]

    return {
        name = L["Macro Options"],
        type = "group",
        order = 1,
        args = {
            mount_settings = {
                type = "group",
                order = 1,
                name = L["Mounts"],
                guiInline = true,
                args = {
                    mount = {
                        name = L["Random Mount Macro"],
                        desc = L["Adds a macro for summoning random mounts and keeps it up to date"],
                        type = "toggle",
                        order = 1,
                        width = "full",
                        set = function(info,val) db.profile.macro.mount = val; CollectMe.Macro:UpdateMacros() end,
                        get = function() return db.profile.macro.mount end
                    },
                    nostance = {
                        name = L["Use nostance"],
                        desc = L["The mount macro automatically changes stance before mounting up"],
                        type = "toggle",
                        order = 2,
                        width = "full",
                        set = function(info,val) db.profile.macro.nostance = val; CollectMe.Macro:UpdateMacros() end,
                        get = function() return db.profile.macro.nostance end
                    },
                    left = {
                        name = L["Left Click"],
                        desc = L["Left Click on Mount Macro"],
                        type = "select",
                        order = 3,
                        values = list,
                        set = function(info,val) db.profile.summon.mounts.macro_left = val end,
                        get = function() return db.profile.summon.mounts.macro_left end
                    },
                    right = {
                        name = L["Right Click"],
                        desc = L["Right Click on Mount Macro"],
                        type = "select",
                        order = 4,
                        values = list,
                        set = function(info,val) db.profile.summon.mounts.macro_right = val end,
                        get = function() return db.profile.summon.mounts.macro_right end
                    },
                    shift_left = {
                        name = L["Shift + Left Click"],
                        desc = L["Shift + Left Click on Mount Macro"],
                        type = "select",
                        order = 5,
                        values = list,
                        set = function(info,val) db.profile.summon.mounts.macro_shift_left = val end,
                        get = function() return db.profile.summon.mounts.macro_shift_left end
                    }
                }
            },
            companion_settings = {
                type = "group",
                order = 2,
                name = L["Companions"],
                guiInline = true,
                args = {
                    companion = {
                        name = L["Random Companion Macro"],
                        desc = L["Adds a macro for summoning random companions and keeps it up to date"],
                        type = "toggle",
                        order = 1,
                        width = "full",
                        set = function(info,val) db.profile.macro.companion = val; CollectMe.Macro:UpdateMacros() end,
                        get = function() return db.profile.macro.companion end
                    }
                }
            }
        }
    }
end

local function GetLdbOptionsTable()
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
                args = GetLdbArgs(db.profile.ldb.tooltip)
            },
            text = {
                type = "group",
                order = 2,
                name = L["Text"],
                guiInline = true,
                args = GetLdbArgs(db.profile.ldb.text)
            }
        }
    }
end

function Config:OnInitialize()
    local ac = LibStub("AceConfig-3.0")
    local acd = LibStub("AceConfigDialog-3.0")
    local addon_name = CollectMe.ADDON_NAME

    db = CollectMe.db

    local about_panel = LibStub:GetLibrary("LibAboutPanel", true)
    about_panel.new(nil, addon_name)

    ac:RegisterOptionsTable(addon_name .. " LDB", GetLdbOptionsTable())
    acd:AddToBlizOptions(addon_name .. " LDB", L["Data Broker Options"], addon_name)

    ac:RegisterOptionsTable(addon_name .. " Macros", GetMacroOptionsTable())
    acd:AddToBlizOptions(addon_name .. " Macros", L["Macros"], addon_name)

    ac:RegisterOptionsTable(addon_name .. " Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(db))
    acd:AddToBlizOptions(addon_name .. " Profiles", L["Profiles"], addon_name)
end

