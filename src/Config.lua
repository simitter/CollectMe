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
            set = function(info,val) ldbdb.companions.collected = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
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
        },
        toys_collected = {
            name = L["Collected toys"],
            desc = L["Display already collected toys"],
            type = "toggle",
            order = 6,
            set = function(info,val) ldbdb.toys.collected = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function() return ldbdb.toys.collected end
        },
        toys_missing = {
            name = L["Missing toys"],
            desc = L["Display missing toys"],
            type = "toggle",
            order = 7,
            set = function(info,val) ldbdb.toys.missing = val; CollectMe.LdbDisplay:ZoneChangeListener()  end,
            get = function() return ldbdb.toys.missing end
        },
        followers_collected = {
            name = L["Collected followers"],
            desc = L["Display already collected followers"],
            type = "toggle",
            order = 8,
            set = function(info,val) ldbdb.followers.collected = val; CollectMe.LdbDisplay:ZoneChangeListener() end,
            get = function() return ldbdb.followers.collected end
        },
        followers_missing = {
            name = L["Missing followers"],
            desc = L["Display missing followers"],
            type = "toggle",
            order = 9,
            set = function(info,val) ldbdb.followers.missing = val; CollectMe.LdbDisplay:ZoneChangeListener()  end,
            get = function() return ldbdb.followers.missing end
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
            },
            title_settings = {
                type = "group",
                order = 3,
                name = L["Titles"],
                guiInline = true,
                args = {
                    title = {
                        name = L["Random Title Macro"],
                        desc = L["Adds a macro for selecting random titles and keeps it up to date"],
                        type = "toggle",
                        order = 1,
                        width = "full",
                        set = function(info,val) db.profile.macro.title = val; CollectMe.Macro:UpdateMacros() end,
                        get = function() return db.profile.macro.title end
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

local function GetPetBattleOptionsTable()
    return {
        name = L["Pet Battle Options"],
        type = "group",
        order = 1,
        args = {
            quality_check = {
                name = L["Quality Check"],
                desc = L["Perform quality check in pet battles"],
                type = "toggle",
                order = 1,
                width = "full",
                set = function(info,val) db.profile.battles.quality_check = val; end,
                get = function() return db.profile.battles.quality_check end
            },
            missing_check = {
                name = L["Missing Check"],
                desc = L["Perform check in pet battles if enemy pets are missing in your collection"],
                type = "toggle",
                order = 2,
                width = "full",
                set = function(info,val) db.profile.battles.missing_check = val; end,
                get = function() return db.profile.battles.missing_check end
            },
            level_check = {
                name = L["Level Check"],
                desc = L["Perform level check in pet battles if enemy pets have a higher level"],
                type = "toggle",
                order = 3,
                width = "full",
                set = function(info,val) db.profile.battles.level_check = val; end,
                get = function() return db.profile.battles.level_check end
            }
        }
    }
end 

function Config:OnInitialize()
    local ac = LibStub("AceConfig-3.0")
    local acd = LibStub("AceConfigDialog-3.0")
    local lap2 = LibStub("LibAboutPanel-2.0")

    local addon_name = CollectMe.ADDON_NAME
    db = CollectMe.db

    local options = {
        name = "CollectMe",
        type = "group",
        args = {},
        }

    options.args.aboutTab = lap2:AboutOptionsTable("CollectMe")

    acd:AddToBlizOptions(addon_name, "CollectMe")
    ac:RegisterOptionsTable(addon_name, options)

    ac:RegisterOptionsTable(addon_name .. " LDB", GetLdbOptionsTable())
    acd:AddToBlizOptions(addon_name .. " LDB", L["Data Broker Options"], addon_name)

    ac:RegisterOptionsTable(addon_name .. " Macros", GetMacroOptionsTable())
    acd:AddToBlizOptions(addon_name .. " Macros", L["Macros"], addon_name)

    ac:RegisterOptionsTable(addon_name .. " Pet Battles", GetPetBattleOptionsTable())
    acd:AddToBlizOptions(addon_name .. " Pet Battles", L["Pet Battles"], addon_name)

    ac:RegisterOptionsTable(addon_name .. " Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(db))
    acd:AddToBlizOptions(addon_name .. " Profiles", L["Profiles"], addon_name)
end

