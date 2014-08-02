local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Data = CollectMe:GetModule("Data")
local L = LibStub("AceLocale-3.0"):NewLocale("CollectMe", "enUS", true, true)

Data.Titles = {}
Data.TitleIds ={}

Data.TitleIds[98] = 98
Data.Titles[98] = {
    id      = 98,
    name    = GetTitleName(98):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Ambassador
Data.TitleIds[61] = 61
Data.Titles[61] = {
    id      = 61,
    name    = GetTitleName(61):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Archmage
Data.TitleIds[50] = 50
Data.Titles[50] = {
    id      = 50,
    name    = GetTitleName(50):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = false,
        tmp = false,
    },
} -- Arena Master
Data.TitleIds[63] = 63
Data.Titles[63] = {
    id      = 63,
    name    = GetTitleName(63):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Assassin
Data.TitleIds[148] = 148
Data.Titles[148] = {
    id      = 148,
    name    = GetTitleName(148):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Assistant Professor
Data.TitleIds[149] = 149
Data.Titles[149] = {
    id      = 149,
    name    = GetTitleName(149):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Associate Professor
Data.TitleIds[188] = 188
Data.Titles[188] = {
    id      = 188,
    name    = GetTitleName(188):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Avenger of Hyjal
Data.TitleIds[139] = 139
Data.Titles[139] = {
    id      = 139,
    name    = GetTitleName(139):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Bane of the Fallen King
Data.TitleIds[41] = 41
Data.Titles[41] = {
    id      = 41,
    name    = GetTitleName(41):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Battlemaster
Data.TitleIds[187] = 187
Data.Titles[187] = {
    id      = 187,
    name    = GetTitleName(187):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Blackwing
Data.TitleIds[146] = 146
Data.Titles[146] = {
    id      = 146,
    name    = GetTitleName(146):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Blessed Defender of Nordrassil
Data.TitleIds[111] = 111
Data.Titles[111] = {
    id      = 111,
    name    = GetTitleName(111):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Bloodsail Admiral
Data.TitleIds[209] = 209
Data.Titles[209] = {
    id      = 209,
    name    = GetTitleName(209):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Brawler
Data.TitleIds[101] = 101
Data.Titles[101] = {
    id      = 101,
    name    = GetTitleName(101):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Brewmaster
Data.TitleIds[49] = 49
Data.Titles[49] = {
    id      = 49,
    name    = GetTitleName(49):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Brutal Gladiator
Data.TitleIds[193] = 193
Data.Titles[193] = {
    id      = 193,
    name    = GetTitleName(193):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Cataclysmic Gladiator
Data.TitleIds[32] = 32
Data.Titles[32] = {
    id      = 32,
    name    = GetTitleName(32):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = true,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Challenger
Data.TitleIds[83] = 83
Data.Titles[83] = {
    id      = 83,
    name    = GetTitleName(83):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Champion of Elune
Data.TitleIds[97] = 97
Data.Titles[97] = {
    id      = 97,
    name    = GetTitleName(97):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Champion of the Frozen Wastes
Data.TitleIds[36] = 36
Data.Titles[36] = {
    id      = 36,
    name    = GetTitleName(36):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Champion of the Naaru
Data.TitleIds[127] = 127
Data.Titles[127] = {
    id      = 127,
    name    = GetTitleName(127):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Champion of Ulduar
Data.TitleIds[52] = 52
Data.Titles[52] = {
    id      = 52,
    name    = GetTitleName(52):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Chef
Data.TitleIds[90] = 90
Data.Titles[90] = {
    id      = 90,
    name    = GetTitleName(90):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Conqueror of Naxxramas
Data.TitleIds[126] = 126
Data.Titles[126] = {
    id      = 126,
    name    = GetTitleName(126):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Conqueror of Ulduar
Data.TitleIds[123] = 123
Data.Titles[123] = {
    id      = 123,
    name    = GetTitleName(123):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Crusader
Data.TitleIds[245] = 245
Data.Titles[245] = {
    id      = 245,
    name    = GetTitleName(245):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Darkmaster
Data.TitleIds[56] = 56
Data.Titles[56] = {
    id      = 56,
    name    = GetTitleName(56):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Deadly Gladiator
Data.TitleIds[124] = 124
Data.Titles[124] = {
    id      = 124,
    name    = GetTitleName(124):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Death
Data.TitleIds[185] = 185
Data.Titles[185] = {
    id      = 185,
    name    = GetTitleName(185):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Defender of a Shattered World
Data.TitleIds[241] = 241
Data.Titles[241] = {
    id      = 241,
    name    = GetTitleName(241):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Defender of the Wall
Data.TitleIds[204] = 204
Data.Titles[204] = {
    id      = 204,
    name    = GetTitleName(204):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Delver of the Vaults
Data.TitleIds[196] = 196
Data.Titles[196] = {
    id      = 196,
    name    = GetTitleName(196):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Destroyer
Data.TitleIds[69] = 69
Data.Titles[69] = {
    id      = 69,
    name    = GetTitleName(69):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Doctor
Data.TitleIds[186] = 186
Data.Titles[186] = {
    id      = 186,
    name    = GetTitleName(186):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Dragonslayer
Data.TitleIds[30] = 30
Data.Titles[30] = {
    id      = 30,
    name    = GetTitleName(30):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = true,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Duelist
Data.TitleIds[43] = 43
Data.Titles[43] = {
    id      = 43,
    name    = GetTitleName(43):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Elder
Data.TitleIds[195] = 195
Data.Titles[195] = {
    id      = 195,
    name    = GetTitleName(195):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Farmer
Data.TitleIds[251] = 251
Data.Titles[251] = {
    id      = 251,
    name    = GetTitleName(251):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = true,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Fire
Data.TitleIds[190] = 190
Data.Titles[190] = {
    id      = 190,
    name    = GetTitleName(190):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Firelord
Data.TitleIds[243] = 243
Data.Titles[243] = {
    id      = 243,
    name    = GetTitleName(243):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Flameweaver
Data.TitleIds[132] = 132
Data.Titles[132] = {
    id      = 132,
    name    = GetTitleName(132):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Furious Gladiator
Data.TitleIds[29] = 29
Data.Titles[29] = {
    id      = 29,
    name    = GetTitleName(29):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Gladiator
Data.TitleIds[229] = 229
Data.Titles[229] = {
    id      = 229,
    name    = GetTitleName(229):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = true,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Gorgeous
Data.TitleIds[135] = 135
Data.Titles[135] = {
    id      = 135,
    name    = GetTitleName(135):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Crusader
Data.TitleIds[64] = 64
Data.Titles[64] = {
    id      = 64,
    name    = GetTitleName(64):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Alchemist
Data.TitleIds[70] = 70
Data.Titles[70] = {
    id      = 70,
    name    = GetTitleName(70):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Angler
Data.TitleIds[65] = 65
Data.Titles[65] = {
    id      = 65,
    name    = GetTitleName(65):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Blacksmith
Data.TitleIds[67] = 67
Data.Titles[67] = {
    id      = 67,
    name    = GetTitleName(67):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Enchanter
Data.TitleIds[68] = 68
Data.Titles[68] = {
    id      = 68,
    name    = GetTitleName(68):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Engineer
Data.TitleIds[71] = 71
Data.Titles[71] = {
    id      = 71,
    name    = GetTitleName(71):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Herbalist
Data.TitleIds[73] = 73
Data.Titles[73] = {
    id      = 73,
    name    = GetTitleName(73):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Jewelcrafter
Data.TitleIds[74] = 74
Data.Titles[74] = {
    id      = 74,
    name    = GetTitleName(74):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Leatherworker
Data.TitleIds[75] = 75
Data.Titles[75] = {
    id      = 75,
    name    = GetTitleName(75):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Miner
Data.TitleIds[72] = 72
Data.Titles[72] = {
    id      = 72,
    name    = GetTitleName(72):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Scribe
Data.TitleIds[76] = 76
Data.Titles[76] = {
    id      = 76,
    name    = GetTitleName(76):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Skinner
Data.TitleIds[77] = 77
Data.Titles[77] = {
    id      = 77,
    name    = GetTitleName(77):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Grand Master Tailor
Data.TitleIds[253] = 253
Data.Titles[253] = {
    id      = 253,
    name    = GetTitleName(253):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = false,
        tmp = false,
    },
} -- Grivious Gladiator
Data.TitleIds[100] = 100
Data.Titles[100] = {
    id      = 100,
    name    = GetTitleName(100):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Guardian of Cenarius
Data.TitleIds[39] = 39
Data.Titles[39] = {
    id      = 39,
    name    = GetTitleName(39):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Hand of A
Data.TitleIds[214] = 214
Data.Titles[214] = {
    id      = 214,
    name    = GetTitleName(214):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Hellscream's Downfall
Data.TitleIds[131] = 131
Data.Titles[131] = {
    id      = 131,
    name    = GetTitleName(131):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Herald of the Titans
Data.TitleIds[91] = 91
Data.Titles[91] = {
    id      = 91,
    name    = GetTitleName(91):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Hero of Northrend
Data.TitleIds[84] = 84
Data.Titles[84] = {
    id      = 84,
    name    = GetTitleName(84):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Hero of Orgrimmar
Data.TitleIds[66] = 66
Data.Titles[66] = {
    id      = 66,
    name    = GetTitleName(66):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Iron Chef
Data.TitleIds[249] = 249
Data.Titles[249] = {
    id      = 249,
    name    = GetTitleName(249):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Jade Protector
Data.TitleIds[110] = 110
Data.Titles[110] = {
    id      = 110,
    name    = GetTitleName(110):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Jenkins
Data.TitleIds[220] = 220
Data.Titles[220] = {
    id      = 220,
    name    = GetTitleName(220):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = true,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Kahn
Data.TitleIds[93] = 93
Data.Titles[93] = {
    id      = 93,
    name    = GetTitleName(93):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Loremaster
Data.TitleIds[223] = 223
Data.Titles[223] = {
    id      = 223,
    name    = GetTitleName(223):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = false,
        tmp = false,
    },
} -- Malevolent Gladiator
Data.TitleIds[202] = 202
Data.Titles[202] = {
    id      = 202,
    name    = GetTitleName(202):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Master of the Ways
Data.TitleIds[104] = 104
Data.Titles[104] = {
    id      = 104,
    name    = GetTitleName(104):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Matron
Data.TitleIds[37] = 37
Data.Titles[37] = {
    id      = 37,
    name    = GetTitleName(37):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Merciless Gladiator
Data.TitleIds[102] = 102
Data.Titles[102] = {
    id      = 102,
    name    = GetTitleName(102):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Merrymaker
Data.TitleIds[242] = 242
Data.Titles[242] = {
    id      = 242,
    name    = GetTitleName(242):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Mogu Slayer
Data.TitleIds[106] = 106
Data.Titles[106] = {
    id      = 106,
    name    = GetTitleName(106):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Obsidian Slayer
Data.TitleIds[79] = 79
Data.Titles[79] = {
    id      = 79,
    name    = GetTitleName(79):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- of Argus
Data.TitleIds[80] = 80
Data.Titles[80] = {
    id      = 80,
    name    = GetTitleName(80):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- of Khaz Modan
Data.TitleIds[78] = 78
Data.Titles[78] = {
    id      = 78,
    name    = GetTitleName(78):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- of Quel
Data.TitleIds[141] = 141
Data.Titles[141] = {
    id      = 141,
    name    = GetTitleName(141):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- of the Ashen Verdict
Data.TitleIds[86] = 86
Data.Titles[86] = {
    id      = 86,
    name    = GetTitleName(86):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- of the Darkspear
Data.TitleIds[60] = 60
Data.Titles[60] = {
    id      = 60,
    name    = GetTitleName(60):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- of the Ebon Blade
Data.TitleIds[55] = 55
Data.Titles[55] = {
    id      = 55,
    name    = GetTitleName(55):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- of the Emerald Dream
Data.TitleIds[151] = 151
Data.Titles[151] = {
    id      = 151,
    name    = GetTitleName(151):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- of the Four Winds
Data.TitleIds[107] = 107
Data.Titles[107] = {
    id      = 107,
    name    = GetTitleName(107):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- of the Nightfall
Data.TitleIds[38] = 38
Data.Titles[38] = {
    id      = 38,
    name    = GetTitleName(38):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- of the Shattered Sun
Data.TitleIds[54] = 54
Data.Titles[54] = {
    id      = 54,
    name    = GetTitleName(54):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- of the Ten Storms
Data.TitleIds[105] = 105
Data.Titles[105] = {
    id      = 105,
    name    = GetTitleName(105):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Patron
Data.TitleIds[85] = 85
Data.Titles[85] = {
    id      = 85,
    name    = GetTitleName(85):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Plainsrunner
Data.TitleIds[254] = 254
Data.Titles[254] = {
    id      = 254,
    name    = GetTitleName(254):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = false,
        tmp = false,
    },
} -- Prideful Gladiator
Data.TitleIds[150] = 150
Data.Titles[150] = {
    id      = 150,
    name    = GetTitleName(150):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Professor
Data.TitleIds[57] = 57
Data.Titles[57] = {
    id      = 57,
    name    = GetTitleName(57):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Prophet
Data.TitleIds[246] = 246
Data.Titles[246] = {
    id      = 246,
    name    = GetTitleName(246):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Purified Defender
Data.TitleIds[134] = 134
Data.Titles[134] = {
    id      = 134,
    name    = GetTitleName(134):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Relentless Gladiator
Data.TitleIds[31] = 31
Data.Titles[31] = {
    id      = 31,
    name    = GetTitleName(31):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = true,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Rival
Data.TitleIds[192] = 192
Data.Titles[192] = {
    id      = 192,
    name    = GetTitleName(192):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Ruthless Gladiator
Data.TitleIds[51] = 51
Data.Titles[51] = {
    id      = 51,
    name    = GetTitleName(51):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Salty
Data.TitleIds[194] = 194
Data.Titles[194] = {
    id      = 194,
    name    = GetTitleName(194):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Savior of Azeroth
Data.TitleIds[33] = 33
Data.Titles[33] = {
    id      = 33,
    name    = GetTitleName(33):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Scarab Lord
Data.TitleIds[244] = 244
Data.Titles[244] = {
    id      = 244,
    name    = GetTitleName(244):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Scarlet Commander
Data.TitleIds[208] = 208
Data.Titles[208] = {
    id      = 208,
    name    = GetTitleName(208):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Seeker of Knowledge
Data.TitleIds[205] = 205
Data.Titles[205] = {
    id      = 205,
    name    = GetTitleName(205):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Shadow
Data.TitleIds[247] = 247
Data.Titles[247] = {
    id      = 247,
    name    = GetTitleName(247):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Siegebreaker
Data.TitleIds[147] = 147
Data.Titles[147] = {
    id      = 147,
    name    = GetTitleName(147):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Slayer of Stupid
Data.TitleIds[59] = 59
Data.Titles[59] = {
    id      = 59,
    name    = GetTitleName(59):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Stalker
Data.TitleIds[129] = 129
Data.Titles[129] = {
    id      = 129,
    name    = GetTitleName(129):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Starcaller
Data.TitleIds[222] = 222
Data.Titles[222] = {
    id      = 222,
    name    = GetTitleName(222):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Storm
Data.TitleIds[248] = 248
Data.Titles[248] = {
    id      = 248,
    name    = GetTitleName(248):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = true,
    },
} -- Stormbrewer
Data.TitleIds[207] = 207
Data.Titles[207] = {
    id      = 207,
    name    = GetTitleName(207):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Tamer
Data.TitleIds[99] = 99
Data.Titles[99] = {
    id      = 99,
    name    = GetTitleName(99):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Argent Champion
Data.TitleIds[136] = 136
Data.Titles[136] = {
    id      = 136,
    name    = GetTitleName(136):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Argent Defender
Data.TitleIds[130] = 130
Data.Titles[130] = {
    id      = 130,
    name    = GetTitleName(130):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Astral Walker
Data.TitleIds[197] = 197
Data.Titles[197] = {
    id      = 197,
    name    = GetTitleName(197):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Beloved
Data.TitleIds[232] = 232
Data.Titles[232] = {
    id      = 232,
    name    = GetTitleName(232):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Bloodseeker
Data.TitleIds[184] = 184
Data.Titles[184] = {
    id      = 184,
    name    = GetTitleName(184):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = true,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- The Bloodthirsty
Data.TitleIds[143] = 143
Data.Titles[143] = {
    id      = 143,
    name    = GetTitleName(143):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Camel
Data.TitleIds[125] = 125
Data.Titles[125] = {
    id      = 125,
    name    = GetTitleName(125):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Celestial Defender
Data.TitleIds[240] = 240
Data.Titles[240] = {
    id      = 240,
    name    = GetTitleName(240):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Crazy Cat Lady
Data.TitleIds[252] = 252
Data.Titles[252] = {
    id      = 252,
    name    = GetTitleName(252):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Crazy Cat Man
Data.TitleIds[48] = 48
Data.Titles[48] = {
    id      = 48,
    name    = GetTitleName(48):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Diplomat
Data.TitleIds[237] = 237
Data.Titles[237] = {
    id      = 237,
    name    = GetTitleName(237):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Disector
Data.TitleIds[46] = 46
Data.Titles[46] = {
    id      = 46,
    name    = GetTitleName(46):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Exalted
Data.TitleIds[47] = 47
Data.Titles[47] = {
    id      = 47,
    name    = GetTitleName(47):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Explorer
Data.TitleIds[198] = 198
Data.Titles[198] = {
    id      = 198,
    name    = GetTitleName(198):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Fearless
Data.TitleIds[189] = 189
Data.Titles[189] = {
    id      = 189,
    name    = GetTitleName(189):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Flamebreaker
Data.TitleIds[96] = 96
Data.Titles[96] = {
    id      = 96,
    name    = GetTitleName(96):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Flawless Victor
Data.TitleIds[87] = 87
Data.Titles[87] = {
    id      = 87,
    name    = GetTitleName(87):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Forsaken
Data.TitleIds[92] = 92
Data.Titles[92] = {
    id      = 92,
    name    = GetTitleName(92):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Hallowed
Data.TitleIds[108] = 108
Data.Titles[108] = {
    id      = 108,
    name    = GetTitleName(108):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Immortal
Data.TitleIds[112] = 112
Data.Titles[112] = {
    id      = 112,
    name    = GetTitleName(112):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Insane
Data.TitleIds[140] = 140
Data.Titles[140] = {
    id      = 140,
    name    = GetTitleName(140):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Kingslayer
Data.TitleIds[138] = 138
Data.Titles[138] = {
    id      = 138,
    name    = GetTitleName(138):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Light of Dawn
Data.TitleIds[82] = 82
Data.Titles[82] = {
    id      = 82,
    name    = GetTitleName(82):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Lion Hearted
Data.TitleIds[233] = 233
Data.Titles[233] = {
    id      = 233,
    name    = GetTitleName(233):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Locust
Data.TitleIds[103] = 103
Data.Titles[103] = {
    id      = 103,
    name    = GetTitleName(103):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Love Fool
Data.TitleIds[238] = 238
Data.Titles[238] = {
    id      = 238,
    name    = GetTitleName(238):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Lucid
Data.TitleIds[88] = 88
Data.Titles[88] = {
    id      = 88,
    name    = GetTitleName(88):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Magic Seeker
Data.TitleIds[58] = 58
Data.Titles[58] = {
    id      = 58,
    name    = GetTitleName(58):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Malefic
Data.TitleIds[236] = 236
Data.Titles[236] = {
    id      = 236,
    name    = GetTitleName(236):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Manipulator
Data.TitleIds[122] = 122
Data.Titles[122] = {
    id      = 122,
    name    = GetTitleName(122):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Noble
Data.TitleIds[137] = 137
Data.Titles[137] = {
    id      = 137,
    name    = GetTitleName(137):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Patient
Data.TitleIds[133] = 133
Data.Titles[133] = {
    id      = 133,
    name    = GetTitleName(133):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Pilgrim
Data.TitleIds[231] = 231
Data.Titles[231] = {
    id      = 231,
    name    = GetTitleName(231):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Poisoned Mind
Data.TitleIds[235] = 235
Data.Titles[235] = {
    id      = 235,
    name    = GetTitleName(235):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Prime
Data.TitleIds[215] = 215
Data.Titles[215] = {
    id      = 215,
    name    = GetTitleName(215):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Proven Assailant
Data.TitleIds[216] = 216
Data.Titles[216] = {
    id      = 216,
    name    = GetTitleName(216):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Proven Defender
Data.TitleIds[219] = 219
Data.Titles[219] = {
    id      = 219,
    name    = GetTitleName(219):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Proven Healer
Data.TitleIds[200] = 200
Data.Titles[200] = {
    id      = 200,
    name    = GetTitleName(200):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Relic Hunter
Data.TitleIds[206] = 206
Data.Titles[206] = {
    id      = 206,
    name    = GetTitleName(206):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Scenaterdist
Data.TitleIds[42] = 42
Data.Titles[42] = {
    id      = 42,
    name    = GetTitleName(42):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Seeker
Data.TitleIds[221] = 221
Data.Titles[221] = {
    id      = 221,
    name    = GetTitleName(221):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Stormbreaker
Data.TitleIds[53] = 53
Data.Titles[53] = {
    id      = 53,
    name    = GetTitleName(53):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Supreme
Data.TitleIds[234] = 234
Data.Titles[234] = {
    id      = 234,
    name    = GetTitleName(234):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Swarmkeeper
Data.TitleIds[203] = 203
Data.Titles[203] = {
    id      = 203,
    name    = GetTitleName(203):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Tranquil Master
Data.TitleIds[201] = 201
Data.Titles[201] = {
    id      = 201,
    name    = GetTitleName(201):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Undaunted
Data.TitleIds[109] = 109
Data.Titles[109] = {
    id      = 109,
    name    = GetTitleName(109):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- the Undying
Data.TitleIds[218] = 218
Data.Titles[218] = {
    id      = 218,
    name    = GetTitleName(218):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Wakener
Data.TitleIds[239] = 239
Data.Titles[239] = {
    id      = 239,
    name    = GetTitleName(239):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = true,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- the Wind
Data.TitleIds[227] = 227
Data.Titles[227] = {
    id      = 227,
    name    = GetTitleName(227):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Trainer
Data.TitleIds[89] = 89
Data.Titles[89] = {
    id      = 89,
    name    = GetTitleName(89):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Twilight Vanquisher
Data.TitleIds[128] = 128
Data.Titles[128] = {
    id      = 128,
    name    = GetTitleName(128):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Vanquisher
Data.TitleIds[40] = 40
Data.Titles[40] = {
    id      = 40,
    name    = GetTitleName(40):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Vengeful Gladiator
Data.TitleIds[191] = 191
Data.Titles[191] = {
    id      = 191,
    name    = GetTitleName(191):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Vicious Gladiator
Data.TitleIds[62] = 62
Data.Titles[62] = {
    id      = 62,
    name    = GetTitleName(62):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = true,
        tmp = false,
    },
} -- Warbringer
Data.TitleIds[142] = 142
Data.Titles[142] = {
    id      = 142,
    name    = GetTitleName(142):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = true,
        nlo = true,
        tmp = false,
    },
} -- Wrathful Gladiator
Data.TitleIds[199] = 199
Data.Titles[199] = {
    id      = 199,
    name    = GetTitleName(199):gsub("^%s*(.-)%s*$", "%1"),
    filters = {
        umo = false,
        pvp = false,
        are = false,
        nlo = false,
        tmp = false,
    },
} -- Zookeeper

if UnitFactionGroup("player") == "Alliance" then
    Data.TitleIds[11] = 11
    Data.Titles[11] = {
        id      = 11,
        name    = GetTitleName(11):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Commander
    Data.TitleIds[164] = 164
    Data.Titles[164] = {
        id      = 164,
        name    = GetTitleName(164):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Commander
    Data.TitleIds[211] = 211
    Data.Titles[211] = {
        id      = 211,
        name    = GetTitleName(211):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Conqueror of Orgrimmar
    Data.TitleIds[155] = 155
    Data.Titles[155] = {
        id      = 155,
        name    = GetTitleName(155):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Corporal
    Data.TitleIds[13] = 13
    Data.Titles[13] = {
        id      = 13,
        name    = GetTitleName(13):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Field Marshal
    Data.TitleIds[166] = 166
    Data.Titles[166] = {
        id      = 166,
        name    = GetTitleName(166):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Field Marshal
    Data.TitleIds[44] = 44
    Data.Titles[44] = {
        id      = 44,
        name    = GetTitleName(44):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Flame Warden
    Data.TitleIds[14] = 14
    Data.Titles[14] = {
        id      = 14,
        name    = GetTitleName(14):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Grand Marshal
    Data.TitleIds[167] = 167
    Data.Titles[167] = {
        id      = 167,
        name    = GetTitleName(167):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Grand Marshal
    Data.TitleIds[182] = 182
    Data.Titles[182] = {
        id      = 182,
        name    = GetTitleName(182):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Hero of the Alliance
    Data.TitleIds[35] = 35
    Data.Titles[35] = {
        id      = 35,
        name    = GetTitleName(35):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Justicar
    Data.TitleIds[6] = 6
    Data.Titles[6] = {
        id      = 6,
        name    = GetTitleName(6):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Knight
    Data.TitleIds[7] = 7
    Data.Titles[7] = {
        id      = 7,
        name    = GetTitleName(7):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Knight
    Data.TitleIds[8] = 8
    Data.Titles[8] = {
        id      = 8,
        name    = GetTitleName(8):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Knight
    Data.TitleIds[9] = 9
    Data.Titles[9] = {
        id      = 9,
        name    = GetTitleName(9):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Knight
    Data.TitleIds[159] = 159
    Data.Titles[159] = {
        id      = 159,
        name    = GetTitleName(159):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Knight
    Data.TitleIds[160] = 160
    Data.Titles[160] = {
        id      = 160,
        name    = GetTitleName(160):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Knight
    Data.TitleIds[161] = 161
    Data.Titles[161] = {
        id      = 161,
        name    = GetTitleName(161):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Knight
    Data.TitleIds[162] = 162
    Data.Titles[162] = {
        id      = 162,
        name    = GetTitleName(162):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Knight
    Data.TitleIds[10] = 10
    Data.Titles[10] = {
        id      = 10,
        name    = GetTitleName(10):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Lieutenant Commander
    Data.TitleIds[163] = 163
    Data.Titles[163] = {
        id      = 163,
        name    = GetTitleName(163):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Lieutenant Commander
    Data.TitleIds[12] = 12
    Data.Titles[12] = {
        id      = 12,
        name    = GetTitleName(12):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Marshal
    Data.TitleIds[165] = 165
    Data.Titles[165] = {
        id      = 165,
        name    = GetTitleName(165):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Marshal
    Data.TitleIds[4] = 4
    Data.Titles[4] = {
        id      = 4,
        name    = GetTitleName(4):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Master Sergeant
    Data.TitleIds[157] = 157
    Data.Titles[157] = {
        id      = 157,
        name    = GetTitleName(157):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Master Sergeant
    Data.TitleIds[114] = 114
    Data.Titles[114] = {
        id      = 114,
        name    = GetTitleName(114):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of Darnassus
    Data.TitleIds[81] = 81
    Data.Titles[81] = {
        id      = 81,
        name    = GetTitleName(81):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of Gnomeregan
    Data.TitleIds[115] = 115
    Data.Titles[115] = {
        id      = 115,
        name    = GetTitleName(115):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of Ironforge
    Data.TitleIds[116] = 116
    Data.Titles[116] = {
        id      = 116,
        name    = GetTitleName(116):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of Stormwind
    Data.TitleIds[94] = 94
    Data.Titles[94] = {
        id      = 94,
        name    = GetTitleName(94):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of the Alliance
    Data.TitleIds[113] = 113
    Data.Titles[113] = {
        id      = 113,
        name    = GetTitleName(113):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of the Exodar
    Data.TitleIds[2] = 2
    Data.Titles[2] = {
        id      = 2,
        name    = GetTitleName(2):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Porporal
    Data.TitleIds[1] = 1
    Data.Titles[1] = {
        id      = 1,
        name    = GetTitleName(1):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Private
    Data.TitleIds[154] = 154
    Data.Titles[154] = {
        id      = 154,
        name    = GetTitleName(154):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Private
    Data.TitleIds[3] = 3
    Data.Titles[3] = {
        id      = 3,
        name    = GetTitleName(3):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Sergeant
    Data.TitleIds[156] = 156
    Data.Titles[156] = {
        id      = 156,
        name    = GetTitleName(156):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Sergeant
    Data.TitleIds[5] = 5
    Data.Titles[5] = {
        id      = 5,
        name    = GetTitleName(5):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Sergeant Major
    Data.TitleIds[158] = 158
    Data.Titles[158] = {
        id      = 158,
        name    = GetTitleName(158):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Sergeant Major
    Data.TitleIds[230] = 230
    Data.Titles[230] = {
        id      = 230,
        name    = GetTitleName(230):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- the Hordebreaker
    Data.TitleIds[152] = 152
    Data.Titles[152] = {
        id      = 152,
        name    = GetTitleName(152):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Veteran of the Alliance
    Data.TitleIds[145] = 145
    Data.Titles[145] = {
        id      = 145,
        name    = GetTitleName(145):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Warbound
end

if UnitFactionGroup("player") == "Horde" then
    Data.TitleIds[21] = 21
    Data.Titles[21] = {
        id      = 21,
        name    = GetTitleName(21):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Blood Guard
    Data.TitleIds[174] = 174
    Data.Titles[174] = {
        id      = 174,
        name    = GetTitleName(174):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Blood Guard
    Data.TitleIds[23] = 23
    Data.Titles[23] = {
        id      = 23,
        name    = GetTitleName(23):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Centurion
    Data.TitleIds[176] = 176
    Data.Titles[176] = {
        id      = 176,
        name    = GetTitleName(176):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Centurion
    Data.TitleIds[24] = 24
    Data.Titles[24] = {
        id      = 24,
        name    = GetTitleName(24):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Champion
    Data.TitleIds[177] = 177
    Data.Titles[177] = {
        id      = 177,
        name    = GetTitleName(177):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Champion
    Data.TitleIds[34] = 34
    Data.Titles[34] = {
        id      = 34,
        name    = GetTitleName(34):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Conqueror
    Data.TitleIds[228] = 228
    Data.Titles[228] = {
        id      = 228,
        name    = GetTitleName(228):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Darkspear Revolutionary
    Data.TitleIds[19] = 19
    Data.Titles[19] = {
        id      = 19,
        name    = GetTitleName(19):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- First Sergeant
    Data.TitleIds[172] = 172
    Data.Titles[172] = {
        id      = 172,
        name    = GetTitleName(172):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- First Sergeant
    Data.TitleIds[45] = 45
    Data.Titles[45] = {
        id      = 45,
        name    = GetTitleName(45):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Flame Keeper
    Data.TitleIds[26] = 26
    Data.Titles[26] = {
        id      = 26,
        name    = GetTitleName(26):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- General
    Data.TitleIds[179] = 179
    Data.Titles[179] = {
        id      = 179,
        name    = GetTitleName(179):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- General
    Data.TitleIds[16] = 16
    Data.Titles[16] = {
        id      = 16,
        name    = GetTitleName(16):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Grunt
    Data.TitleIds[169] = 169
    Data.Titles[169] = {
        id      = 169,
        name    = GetTitleName(169):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Grunt
    Data.TitleIds[183] = 183
    Data.Titles[183] = {
        id      = 183,
        name    = GetTitleName(183):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Hero of the Horde
    Data.TitleIds[28] = 28
    Data.Titles[28] = {
        id      = 28,
        name    = GetTitleName(28):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- High Warlord
    Data.TitleIds[181] = 181
    Data.Titles[181] = {
        id      = 181,
        name    = GetTitleName(181):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- High Warlord
    Data.TitleIds[22] = 22
    Data.Titles[22] = {
        id      = 22,
        name    = GetTitleName(22):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Legionnaire
    Data.TitleIds[175] = 175
    Data.Titles[175] = {
        id      = 175,
        name    = GetTitleName(175):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Legionnaire
    Data.TitleIds[212] = 212
    Data.Titles[212] = {
        id      = 212,
        name    = GetTitleName(212):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Liberator of Orgrimmar
    Data.TitleIds[25] = 25
    Data.Titles[25] = {
        id      = 25,
        name    = GetTitleName(25):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Lieutenant General
    Data.TitleIds[178] = 178
    Data.Titles[178] = {
        id      = 178,
        name    = GetTitleName(178):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Lieutenant General
    Data.TitleIds[117] = 117
    Data.Titles[117] = {
        id      = 117,
        name    = GetTitleName(117):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of Orgrimmar
    Data.TitleIds[118] = 118
    Data.Titles[118] = {
        id      = 118,
        name    = GetTitleName(118):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of Sen
    Data.TitleIds[119] = 119
    Data.Titles[119] = {
        id      = 119,
        name    = GetTitleName(119):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of Silvermoon
    Data.TitleIds[95] = 95
    Data.Titles[95] = {
        id      = 95,
        name    = GetTitleName(95):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of the Horde
    Data.TitleIds[121] = 121
    Data.Titles[121] = {
        id      = 121,
        name    = GetTitleName(121):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of the Undercity
    Data.TitleIds[120] = 120
    Data.Titles[120] = {
        id      = 120,
        name    = GetTitleName(120):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = false,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- of Thunder Bluff
    Data.TitleIds[15] = 15
    Data.Titles[15] = {
        id      = 15,
        name    = GetTitleName(15):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Scout
    Data.TitleIds[168] = 168
    Data.Titles[168] = {
        id      = 168,
        name    = GetTitleName(168):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Scout
    Data.TitleIds[18] = 18
    Data.Titles[18] = {
        id      = 18,
        name    = GetTitleName(18):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Senior Sergeant
    Data.TitleIds[171] = 171
    Data.Titles[171] = {
        id      = 171,
        name    = GetTitleName(171):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Senior Sergeant
    Data.TitleIds[17] = 17
    Data.Titles[17] = {
        id      = 17,
        name    = GetTitleName(17):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Sergeant
    Data.TitleIds[170] = 170
    Data.Titles[170] = {
        id      = 170,
        name    = GetTitleName(170):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Sergeant
    Data.TitleIds[20] = 20
    Data.Titles[20] = {
        id      = 20,
        name    = GetTitleName(20):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Stone Guard
    Data.TitleIds[173] = 173
    Data.Titles[173] = {
        id      = 173,
        name    = GetTitleName(173):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Stone Guard
    Data.TitleIds[153] = 153
    Data.Titles[153] = {
        id      = 153,
        name    = GetTitleName(153):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Veteran of the Horde
    Data.TitleIds[144] = 144
    Data.Titles[144] = {
        id      = 144,
        name    = GetTitleName(144):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Warbringer
    Data.TitleIds[27] = 27
    Data.Titles[27] = {
        id      = 27,
        name    = GetTitleName(27):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = true,
            tmp = false,
        },
    } -- Warlord
    Data.TitleIds[180] = 180
    Data.Titles[180] = {
        id      = 180,
        name    = GetTitleName(180):gsub("^%s*(.-)%s*$", "%1"),
        filters = {
            umo = false,
            pvp = true,
            are = false,
            nlo = false,
            tmp = false,
        },
    } -- Warlord
end

L["title_98"] = "Reward for getting exalted with each city of your faction."
L["title_61"] = "Realm first level 80 Mage. Removed in early WotLK Beta."
L["title_50"] = "Reward from the arena achievement 'The Arena Master'."
L["title_63"] = "Realm first level 80 Rogue. Removed in early WotLK Beta."
L["title_148"] = "Reward for finding one rare artifact in Archeology"
L["title_149"] = "Reward for finding 10 rare artifacts in Archeology"
L["title_188"] = "Reward for earning exalted reputation with the Avenger's of Hyjal"
L["title_139"] = "Reward for defeating the Lich King in 10-player mode on heroic difficulty"
L["title_41"] = "Reward from the PvP achievement 'Battlemaster'."
L["title_187"] = "Reward for defeating Nefarian in Blackwing Descent on heroic difficulty"
L["title_146"] = "Temporary title while on the quest for Dragonwrath, Tarecgosa's Rest"
L["title_21"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_174"] = "Reward for reaching a rated battleground rating of 1700"
L["title_111"] = "Reward for gaining exalted reputation with the Bloodsail Buccaneers."
L["title_209"] = "Reward for 'Now your just showing off' wich requires you to reach rank 8 in the Brawler's Guild."
L["title_101"] = "Reward for completing the Brewfest holiday achievements."
L["title_49"] = "This title was awarded to players who were ranked #1 in their battlegroup when season 4 ended."
L["title_193"] = "Awarded per battlegroup at the end of arena season 11 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_23"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_176"] = "Reward for reaching a rated battleground rating of 1900"
L["title_32"] = "Awarded per battlegroup at the end of a season based on top ranked percentage. Top 10% - 35%."
L["title_24"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_177"] = "Reward for reaching a rated battleground rating of 2000"
L["title_83"] = "Realm first level 80 Night Elf. Removed in early WotLK Beta."
L["title_97"] = "Reward for completing every WotLK 3.0 Dungeon on heroic difficulty and every WotLK 3.0 Raid on any difficulty"
L["title_36"] = "This title was awarded to players that completed the attunement quest for Serpentshrine Cavern back in Burning Crusade."
L["title_127"] = "Reward for defeatubg each boss in Ulduar in 10-player mode without allowing any raid member to die to that boss at any point during that raid lockout period."
L["title_52"] = "Reward from the cooking achievement 'Hail to the Chef'."
L["title_11"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_164"] = "Reward for reaching a rated battleground rating of 2100"
L["title_34"] = "Obtained by gaining exalted reputation with  Frostwolf Clan, The Defilers, Warsong Outriders."
L["title_90"] = "Awarded to participant in the realm first defeat of Kel'Thuzad in Naxxramas in 25-player mode. "
L["title_211"] = "Defeat Garrosh Hellscream in Siege of Orgrimmar on Normal or Heroic difficulty"
L["title_126"] = "Reward for defeating each boss in Ulduar in 25-player mode without allowing any raid member to die to that boss at any point during that raid lockout period."
L["title_155"] = "Reward for reaching a rated battleground rating of 1200"
L["title_123"] = "Reward for earning the right to represent every city of you faction in the Argent Tournament as well as beeing exalted with them and the Argent Crusade."
L["title_245"] = "Reward for holding realm best time in challange mode 'Scholomance'. Removed if someone is faster than you."
L["title_228"] = "Complete the Vol'jin's troll uprising questline."
L["title_56"] = "This title was awarded to players that were ranked #1 in their battlegroup when season 5 ended."
L["title_124"] = "Reward for realm first Yogg-Saron kill in 25-player mode"
L["title_185"] = "Reward for completing all Cataclysm 4.0 dungeons on heroic difficulty and the Cataclysm 4.0 raids on any difficulty"
L["title_241"] = "Reward for holding realm best time in challange mode 'Gate of the Setting Sun'. Removed if someone is faster than you."
L["title_204"] = "Defeat the Will of the Emperor in Mogu'shan Vaults on Heroic difficulty."
L["title_196"] = "Reward for defeating Deathwing on normal difficulty."
L["title_69"] = "Realm first First Aid skill 450. Removed in early WotLK Beta."
L["title_186"] = "Reward for defeating Sinestra in the Bastion of Twilight on heroic difficulty"
L["title_30"] = "Awarded per battlegroup at the end of a season based on top ranked percentage. Top 0.5% - 3%."
L["title_43"] = "Reward from the world event achievement 'To Honor One's Elders'."
L["title_195"] = "Exalted repuation with the Tillers."
L["title_13"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_166"] = "Reward for reaching a rated battleground rating of 2300"
L["title_251"] = "Reward for 'Fire-Catcher' achievement wich required you to obtain 10000 Bloody Coins as an Emissary of Ordos or Ordon Fire-Watcher."
L["title_190"] = "Reward for defeating Ragnaros in the Firelands on heroic difficulty."
L["title_19"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_172"] = "Reward for reaching a rated battleground rating of 1500"
L["title_45"] = "Reward from the world event achievement 'The Flame Keeper'."
L["title_44"] = "Reward from the world event achievement 'The Flame Warden'."
L["title_243"] = "Reward for holding realm best time in challange mode 'Scarlet Halls'. Removed if someone is faster than you."
L["title_132"] = "Awarded per battlegroup at the end of arena season 6 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_26"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_179"] = "Reward for reaching a rated battleground rating of 2200"
L["title_29"] = "Awarded per battlegroup at the end of a season based on top ranked percentage. Top 0.0% - 0.5%."
L["title_229"] = "Reward for 'Master of Deepwind Gorge' achievement."
L["title_135"] = "Reward for realm first conquest of the Trial of the Grand Crusader with 50 attempts remaining in 25-player mode"
L["title_14"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_167"] = "Reward for reaching a rated battleground rating of 2400"
L["title_64"] = "Realm first Alchemy skill 450. Removed in early WotLK Beta."
L["title_70"] = "Realm first Fishing skill 450. Removed in early WotLK Beta."
L["title_65"] = "Realm first Blacksmithing skill 450. Removed in early WotLK Beta."
L["title_67"] = "Realm first Enchanting skill 450. Removed in early WotLK Beta."
L["title_68"] = "Realm first Engineering skill 450. Removed in early WotLK Beta."
L["title_71"] = "Realm first Herbalism skill 450. Removed in early WotLK Beta."
L["title_73"] = "Realm first Jewelcrafting skill 450. Removed in early WotLK Beta."
L["title_74"] = "Realm first Leatherworking skill 450. Removed in early WotLK Beta."
L["title_75"] = "Realm first Mining skill 450. Removed in early WotLK Beta."
L["title_72"] = "Realm first Inscription skill 450. Removed in early WotLK Beta."
L["title_76"] = "Realm first Skinning skill 450. Removed in early WotLK Beta."
L["title_77"] = "Realm first Tailoring skill 450. Removed in early WotLK Beta."
L["title_253"] = "Awarded per battlegroup at the end of arena season 14 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_16"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_169"] = "Reward for reaching a rated battleground rating of 1200"
L["title_100"] = "Reward for getting exalted with the Cenarion Circle and the Cenarion Expedition."
L["title_39"] = "Awarded after completing the quest 'The Vials of Eternity', this quest in no longer obtainable."
L["title_214"] = "Defeat Garrosh Hellscream in Siege of Orgrimmar on Heroic difficulty"
L["title_131"] = "Reward for defeating Algalon the Observer in 10-player mode at level 80 without anyone in the raid wearing any equipment with an item level higher than is available in 10-player Ulduar"
L["title_91"] = "Reward for realm first exalted with the Argent Crusade, the Wyrmrest Accord, the Kirin Tor and the Knights of the Ebon Blade. Removed in early WotLK Beta."
L["title_84"] = "Realm first level 80 Orc. Removed in early WotLK Beta."
L["title_182"] = "Reward for ending PvP season 9 in the top 0.5% bracket."
L["title_183"] = "Reward for ending PvP season 9 in the top 0.5% bracket."
L["title_28"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_181"] = "Reward for reaching a rated battleground rating of 2400"
L["title_66"] = "Reward for obtaining 200 cooking recipes."
L["title_249"] = "Reward for holding realm best time in challange mode 'Temple of the Jade Serpent'. Removed if someone is faster than you."
L["title_110"] = "Reward for killing 50 rookery whelps within 15 seconds in Upper Blackrock Spire."
L["title_35"] = "Obtained by gaining exalted reputation with Silverwing Sentinels, the League of Arathor, Stormpike Guard."
L["title_220"] = "Reward for pvp achievement 'Kahn' which required you to complete the master achievements for following battlegrounds: Battle for Gilneas, Isle of Conquest, Twin Peaks, Silvershard Mines, Temple of Kotmogu."
L["title_6"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_7"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_8"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_9"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_159"] = "Reward for reaching a rated battleground rating of 1600"
L["title_160"] = "Reward for reaching a rated battleground rating of 1700"
L["title_161"] = "Reward for reaching a rated battleground rating of 1800"
L["title_162"] = "Reward for reaching a rated battleground rating of 1900"
L["title_22"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_175"] = "Reward for reaching a rated battleground rating of 1800"
L["title_212"] = "Defeat Garrosh Hellscream in Siege of Orgrimmar on Normal or Heroic difficulty"
L["title_10"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_163"] = "Reward for reaching a rated battleground rating of 2000"
L["title_25"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_178"] = "Reward for reaching a rated battleground rating of 2100"
L["title_93"] = "Reward for from the 'Loremaster' achievement for completing almost all quests in all zones."
L["title_223"] = "Awarded per battlegroup at the end of arena season 12 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_12"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_165"] = "Reward for reaching a rated battleground rating of 2200"
L["title_202"] = "Raise your cooking to 600 and complete Master of Pandaren Cooking."
L["title_4"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_157"] = "Reward for reaching a rated battleground rating of 1400"
L["title_104"] = "Reward for completing the Children's Week holiday achievements. Only applies to female characters."
L["title_37"] = "Awarded per battlegroup at the end of arena season 2 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_102"] = "Reward for completing the Winter's Veil holiday achievements."
L["title_242"] = "Reward for holding realm best time in challange mode 'Mogushan Palace'. Removed if someone is faster than you."
L["title_106"] = "Reward for realm first defeat of Sartharion the Onyx Guardian in 25-player mode."
L["title_79"] = "Realm first level 80 Draenei. Removed in early WotLK Beta."
L["title_114"] = "Reward for earning the right to represent Darnassus in the Argent Tournament."
L["title_81"] = "Realm first level 80 Dwarf. Removed in early WotLK Beta."
L["title_115"] = "Reward for earning the right to represent Ironforge in the Argent Tournament."
L["title_117"] = "Reward for earning the right to represent Orgrimmar in the Argent Tournament."
L["title_78"] = "Realm first level 80 Blood Elf. Removed in early WotLK Beta."
L["title_118"] = "Reward for earning the right to represent Sen'jin in the Argent Tournament."
L["title_119"] = "Reward for earning the right to represent Silvermoon in the Argent Tournament."
L["title_116"] = "Reward for earning the right to represent Stormwind in the Argent Tournament."
L["title_94"] = "Reward for reaching 100.000 honorable kills."
L["title_141"] = "Reward for getting exalted with the Ashen Verdict"
L["title_86"] = "Realm first level 80 Troll. Removed in early WotLK Beta."
L["title_60"] = "Realm first level 80 Death Knight. Removed in early WotLK Beta."
L["title_55"] = "Realm first level 80 Druid. Removed in early WotLK Beta."
L["title_113"] = "Reward for earning the right to represent the Exodar in the Argent Tournament."
L["title_151"] = "Reward for defeating Al'Akir in Throne of the Four Winds on heroic difficulty"
L["title_95"] = "Reward for reaching 100.000 honorable kills."
L["title_107"] = "Reward for defeating Sartharion the Onyx Guardian with all three drakes alive in 10-player mode."
L["title_38"] = "Awarded after completing the quest 'A Magnanimous Benefactor' after gaining exalted reputation with the Shattered Sun Offensive."
L["title_54"] = "Realm first level 80 Shaman. Removed in early WotLK Beta."
L["title_121"] = "Reward for earning the right to represent the Undercity in the Argent Tournament."
L["title_120"] = "Reward for earning the right to represent Thunder Bluff in the Argent Tournament."
L["title_105"] = "Reward for completing the Children's Week holiday achievements. Only applies to male characters."
L["title_85"] = "Realm first level 80 Tauren. Removed in early WotLK Beta."
L["title_2"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_254"] = "Awarded per battlegroup at the end of arena season 15 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_1"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_154"] = "Reward for reaching a rated battleground rating of 1100"
L["title_150"] = "Reward for finding 20 rare artifacts in Archeology"
L["title_57"] = "Realm first level 80 Priest. Removed in early WotLK Beta."
L["title_246"] = "Reward for holding realm best time in challange mode 'Shado-pan Monastery'. Removed if someone is faster than you."
L["title_134"] = "Awarded per battlegroup at the end of arena season 7 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_31"] = "Awarded per battlegroup at the end of a season based on top ranked percentage. Top 3% - 10%."
L["title_192"] = "Awarded per battlegroup at the end of arena season 10 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_51"] = "Reward from the fishing achievement 'Accomplished Angler'."
L["title_194"] = "Reward for defeating Deathwing on heroic difficulty."
L["title_33"] = "The title was originally awarded when opening the gates to Ahn'Qiraj and is no longer obtainable."
L["title_244"] = "Reward for holding realm best time in challange mode 'Scarlet Monastery'. Removed if someone is faster than you."
L["title_15"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_168"] = "Reward for reaching a rated battleground rating of 1100"
L["title_208"] = "Reward for 'The Seat of Knowledge' restoring and displaying pristine versions of all Pandaren and Mogu artifacts."
L["title_18"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_171"] = "Reward for reaching a rated battleground rating of 1400"
L["title_3"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_156"] = "Reward for reaching a rated battleground rating of 1300"
L["title_17"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_170"] = "Reward for reaching a rated battleground rating of 1300"
L["title_5"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_158"] = "Reward for reaching a rated battleground rating of 1500"
L["title_205"] = "Complete The Shado-Master, doing a bunch of achievements tied to dailies with Shado-Pan, similar to The Flamebreaker from the Molten Front."
L["title_247"] = "Reward for holding realm best time in challange mode 'Siege of Niuzao Temple'. Removed if someone is faster than you."
L["title_147"] = "Temporary title earned in Blackwing Descent"
L["title_59"] = "Realm first level 80 Hunter. Removed in early WotLK Beta."
L["title_129"] = "Reward for defeating Algalon the Observer in 10-player mode."
L["title_20"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_173"] = "Reward for reaching a rated battleground rating of 1600"
L["title_222"] = "Reward for defeating Lei Shen in the Throne of Thunder raid on heroic difficulty"
L["title_248"] = "Reward for holding realm best time in challange mode 'Stormstour Brewery'. Removed if someone is faster than you."
L["title_207"] = "Reward for defeating all 40 of the Pet Tamers across Azeroth."
L["title_99"] = "Reward for getting exalted with the Argent Dawn and the Argent Crusade."
L["title_136"] = "Reward for meet the criteria for A Tribute to Insanity without any raid member having used an item only obtainable from 25-player Coliseum, or any more powerful item"
L["title_130"] = "Reward for defeating Algalon the Observer in 25-player mode."
L["title_197"] = "Raise 70 reputations to Exalted."
L["title_232"] = "Unknown method of obtaining."
L["title_184"] = "Reward for reaching 250.000 honorable kills."
L["title_143"] = "Reward for obtaining the reins of the Grey Riding Camel from Dormus the Camel-Hoarder."
L["title_125"] = "Reward for realm first Algalon the Observer kill in 25-player mode"
L["title_240"] = "Reward for 'Crazy for Cats' achievement wich required you to capture a variety of battle pets."
L["title_252"] = "Reward for 'Crazy for Cats' achievement wich required you to capture a variety of battle pets."
L["title_48"] = "Obtained by gaining exalted reputation with Timbermaw Hold, Sporeggar and the Kurenai(Alliance)/Mag'har(Horde).  "
L["title_237"] = "Unknown method of obtaining."
L["title_46"] = "Obtained by gaining 55 exalted reputations"
L["title_47"] = "Reward from the exploration achievement 'World Explorer'."
L["title_198"] = "Complete Heroic: Sha of Fear in Terrace of Endless Spring."
L["title_189"] = "Reward for completing all special achievements of the Molten Front 'Veteran of the Molten Front' achievement."
L["title_96"] = "Reward for winning 10 ranked matches in a row with a rating above 2.000 at level 80. Removed in patch 3.1.0"
L["title_87"] = "Realm first level 80 Undead. Removed in early WotLK Betav"
L["title_92"] = "Reward for completing all Hallow's End holiday achievements."
L["title_230"] = "Complete the Vol'jin's troll uprising questline."
L["title_108"] = "Reward for defeating all the bosses in Naxxramas on heroic, during one lockout period, without any raid members dying during any of the boss encounters in 25-player mode."
L["title_112"] = "Reward for gaining exalted reputation with the Bloodsail Buccaneers, Darkmoon Faire, Gadgetzan, Booty Bay, Everlook, Ratchet, Ravenholdt"
L["title_140"] = "Reward for defeating every Boss in Icecrown Citadel"
L["title_138"] = "Reward for defeating the Lich King in 25-player mode on heroic difficulty"
L["title_82"] = "Realm first level 80 Human. Removed in early WotLK Beta."
L["title_233"] = "Unknown method of obtaining."
L["title_103"] = "Reward for completing the Love is in the Air holiday achievements."
L["title_238"] = "Unknown method of obtaining."
L["title_88"] = "Reward for realm first defeat of Malygos in 25-player mode."
L["title_58"] = "Realm first level 80 Warlock. Removed in early WotLK Beta."
L["title_236"] = "Unknown method of obtaining."
L["title_122"] = "Reward for completing the Noblegarden holiday achievements."
L["title_137"] = "Reward for using the Dungeon Finder tool to finish random heroic dungeons until you have grouped with 50 random players total"
L["title_133"] = "Reward for completing the Pilgrim's Bounty holiday achievements"
L["title_231"] = "Unknown method of obtaining."
L["title_235"] = "Unknown method of obtaining."
L["title_215"] = "Successfully complete Wave 30 of the Basic Damage (Endless) trial at the Proving Grounds"
L["title_216"] = "Successfully complete Wave 30 of the Basic Tank(Endless) trial at the Proving Grounds"
L["title_219"] = "Successfully complete Wave 30 of the Basic Healer(Endless) trial at the Proving Grounds"
L["title_200"] = "Reward from  'Is Another Man's Treasure'. In addition to rare spawns bringing quirky flavor to MoP, there are rare objects hidden around Pandaria too like Blade of the Prime. Finding 20 of these will net you this title."
L["title_206"] = "Reward for completing 'Scenaterday/ Scenaterday' doing all the MoP Scenarios on a Saturday."
L["title_42"] = "Awarded after gaining '3000 Quests Completed' achievement."
L["title_221"] = "Reward for completing all Isle of Giants achievements."
L["title_53"] = "Realm first level 80 Warrior. Removed in early WotLK Beta."
L["title_234"] = "Unknown method of obtaining."
L["title_203"] = "From Tranquil Master, requiring players to kill all the Sha-themed NPCs."
L["title_201"] = "From Challenge Conqueror: Bronze, completing every Challenge Mode with a rating of Bronze or better."
L["title_109"] = "Reward for defeating all the bosses in Naxxramas on heroic, during one lockout period, without any raid members dying during any of the boss encounters in 10-player mode."
L["title_218"] = "Reward for reaching exalted reputation with the Klaxxi and completing 'Amber is the Color of My Energy' achievement for recovering all paragons."
L["title_239"] = "Unknown method of obtaining."
L["title_227"] = "Reward for 'Deadly Pet Brawler' win 1000 PvP pet battles through Find Battle with a full team of level 25 pets."
L["title_89"] = "Reward from the achievement 'The Twilight Zone (25 player)'."
L["title_128"] = "Reward for beeing in the top 1.000 players in the 2009 Arena Season."
L["title_40"] = "Awarded per battlegroup at the end of arena season 3 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_152"] = "Reward for winning 75 rated battlegrounds"
L["title_153"] = "Reward for winning 75 rated battlegrounds"
L["title_191"] = "Awarded per battlegroup at the end of arena season 9 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_145"] = "Reward for winning 300 rated battleground"
L["title_62"] = "Reward for winning 300 rated battlegrounds."
L["title_144"] = "Reward for winning 300 rated battleground"
L["title_27"] = "The title was originally awarded as part of the PvP ranking system and is no longer obtainable."
L["title_180"] = "Reward for reaching a rated battleground rating of 2300"
L["title_142"] = "Awarded per battlegroup at the end of arena season 8 based on top ranked percentage. Top 0.0% - 0.5%."
L["title_199"] = "Reward from 'World Safari'- - Catch every battle pet"
