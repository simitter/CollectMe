CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.TITLES = {}
CollectMe.TITLE_SPELLS = {}

function CollectMe:BuildTitleDB()
    -- Common Titles
    self:AddTitle(29)  -- Gladiator
    self:AddTitle(30)  -- Duelist
    self:AddTitle(31)  -- Rival
    self:AddTitle(32)  -- Challenger
    self:AddTitle(36)  -- Champion of the Naaru
    self:AddTitle(37, { nlo = 1 })  -- Merciless Gladiator
    self:AddTitle(38)  -- of the Shattered Sun
    self:AddTitle(39)  -- Hand of A'dal
    self:AddTitle(40)  -- Vengeful Gladiator
    self:AddTitle(41)  -- Battlemaster
    self:AddTitle(42)  -- the Seeker
    self:AddTitle(43)  -- Elder
    self:AddTitle(46)  -- the Exalted
    self:AddTitle(47)  -- the Explorer
    self:AddTitle(48)  -- the Diplomat
    self:AddTitle(49)  -- Brutal Gladiator
    self:AddTitle(50)  -- Arena Master
    self:AddTitle(51)  -- Salty
    self:AddTitle(52)  -- Chef
    self:AddTitle(53)  -- the Supreme
    self:AddTitle(54)  -- of the Ten Storms
    self:AddTitle(55)  -- of the Emerald Dream
    self:AddTitle(56)  -- Deadly Gladiator
    self:AddTitle(57)  -- Prophet
    self:AddTitle(58)  -- the Malefic
    self:AddTitle(59)  -- Stalker
    self:AddTitle(60)  -- of the Ebon Blade
    self:AddTitle(61)  -- Archmage
    self:AddTitle(62)  -- Warbringer
    self:AddTitle(63)  -- Assassin
    self:AddTitle(64)  -- Grand Master Alchemist
    self:AddTitle(65)  -- Grand Master Blacksmith
    self:AddTitle(66)  -- Iron Chef
    self:AddTitle(67)  -- Grand Master Enchanter
    self:AddTitle(68)  -- Grand Master Engineer
    self:AddTitle(69)  -- Doctor
    self:AddTitle(70)  -- Grand Master Angler
    self:AddTitle(71)  -- Grand Master Herbalist
    self:AddTitle(72)  -- Grand Master Scribe
    self:AddTitle(73)  -- Grand Master Jewelcrafter
    self:AddTitle(74)  -- Grand Master Leatherworker
    self:AddTitle(75)  -- Grand Master Miner
    self:AddTitle(76)  -- Grand Master Skinner
    self:AddTitle(77)  -- Grand Master Tailor
    self:AddTitle(78)  -- of Quel'Thalas
    self:AddTitle(79)  -- of Argus
    self:AddTitle(80)  -- of Khaz Modan
    self:AddTitle(82)  -- the Lion Hearted
    self:AddTitle(83)  -- Champion of Elune
    self:AddTitle(84)  -- Hero of Orgrimmar
    self:AddTitle(85)  -- Plainsrunner
    self:AddTitle(86)  -- of the Darkspear
    self:AddTitle(87)  -- the Forsaken
    self:AddTitle(88)  -- the Magic Seeker
    self:AddTitle(89)  -- Twilight Vanquisher
    self:AddTitle(90)  -- Conqueror of Naxxramas
    self:AddTitle(91)  -- Hero of Northrend
    self:AddTitle(92)  -- the Hallowed
    self:AddTitle(93)  -- Loremaster
    self:AddTitle(96)  -- the Flawless Victor
    self:AddTitle(97)  -- Champion of the Frozen Wastes
    self:AddTitle(98)  -- Ambassador
    self:AddTitle(99)  -- the Argent Champion
    self:AddTitle(100) -- Guardian of Cenarius
    self:AddTitle(101) -- Brewmaster
    self:AddTitle(102) -- Merrymaker
    self:AddTitle(103) -- the Love Fool
    self:AddTitle(104) -- Matron
    self:AddTitle(105) -- Patron
    self:AddTitle(106) -- Obsidian Slayer
    self:AddTitle(107) -- of the Nightfall
    self:AddTitle(108) -- the Immortal
    self:AddTitle(109) -- the Undying
    self:AddTitle(110) -- Jenkins
    self:AddTitle(111) -- Bloodsail Admiral
    self:AddTitle(112) -- the Insane
    self:AddTitle(122) -- the Noble
    self:AddTitle(123) -- Crusader
    self:AddTitle(124) -- Death's Demise
    self:AddTitle(125) -- the Celestial Defender
    self:AddTitle(126) -- Conqueror of Ulduar
    self:AddTitle(127) -- Champion of Ulduar
    self:AddTitle(128) -- Vanquisher
    self:AddTitle(129) -- Starcaller
    self:AddTitle(130) -- the Astral Walker
    self:AddTitle(131) -- Herald of the Titans
    self:AddTitle(132) -- Furious Gladiator
    self:AddTitle(133) -- the Pilgrim
    self:AddTitle(134) -- Relentless Gladiator
    self:AddTitle(135) -- Grand Crusader
    self:AddTitle(136) -- the Argent Defender
    self:AddTitle(137) -- the Patient
    self:AddTitle(138) -- the Light of Dawn
    self:AddTitle(139) -- Bane of the Fallen King
    self:AddTitle(140) -- the Kingslayer
    self:AddTitle(141) -- of the Ashen Verdict
    self:AddTitle(142) -- Wrathful Gladiator
    self:AddTitle(143) -- the Camel-Hoarder
    self:AddTitle(146) -- Blessed Defender of Nordrassil", -- [1
    self:AddTitle(147) -- Slayer of Stupid, Incompetent and Disa
    self:AddTitle(148) -- Assistant Professor
    self:AddTitle(149) -- Associate Professor
    self:AddTitle(150) -- Professor
    self:AddTitle(151) -- of the Four Winds
    self:AddTitle(184) -- The Bloodthirsty
    self:AddTitle(185) -- Defender of a Shattered World", -- [18
    self:AddTitle(186) -- Dragonslayer
    self:AddTitle(187) -- Blackwing's Bane
    self:AddTitle(188) -- Avenger of Hyjal
    self:AddTitle(189) -- the Flamebreaker
    self:AddTitle(190) -- Firelord
    self:AddTitle(191) -- Vicious Gladiator
    self:AddTitle(192) -- Ruthless Gladiator
    self:AddTitle(193) -- Cataclysmic Gladiator
    self:AddTitle(194) -- Savior of Azeroth
    self:AddTitle(196) -- Destroyer's End

    -- Alliance Titles
    if self.FACTION == "Alliance" then
        self:AddTitle(1)   -- Private
        self:AddTitle(2)   -- Porporal
        self:AddTitle(3)   -- Sergeant
        self:AddTitle(4)   -- Master Sergeant
        self:AddTitle(5)   -- Sergeant Major
        self:AddTitle(6)   -- Knight
        self:AddTitle(7)   -- Knight-Lieutenant
        self:AddTitle(8)   -- Knight-Captain
        self:AddTitle(9)   -- Knight-Champion
        self:AddTitle(10)   -- Lieutenant Commander
        self:AddTitle(11)   -- Commander
        self:AddTitle(12)   -- Marshal
        self:AddTitle(13)   -- Field Marshal
        self:AddTitle(14)   -- Grand Marshal
        self:AddTitle(35)   -- Justicar
        self:AddTitle(44)   -- Flame Warden
        self:AddTitle(81)   -- of Gnomeregan
        self:AddTitle(94)   -- of the Alliance
        self:AddTitle(113)  -- of the Exodar
        self:AddTitle(114)  -- of Darnassus
        self:AddTitle(115)  -- of Ironforge
        self:AddTitle(116)  -- of Stormwind
        self:AddTitle(152)  -- Veteran of the Alliance
        self:AddTitle(154)  -- Private
        self:AddTitle(155)  -- Corporal
        self:AddTitle(156)  -- Sergeant
        self:AddTitle(157)  -- Master Sergeant
        self:AddTitle(158)  -- Sergeant Major
        self:AddTitle(159)  -- Knight
        self:AddTitle(160)  -- Knight-Lieutenant
        self:AddTitle(161)  -- Knight-Captain
        self:AddTitle(162)  -- Knight-Champion
        self:AddTitle(163)  -- Lieutenant Commander
        self:AddTitle(164)  -- Commander
        self:AddTitle(165)  -- Marshal
        self:AddTitle(166)  -- Field Marshal
        self:AddTitle(167)  -- Grand Marshal
        self:AddTitle(182)  -- Hero of the Alliance
        self:AddTitle(145)  -- Warbound
    end

    -- Horde Titles
    if self.FACTION == "Horde" then
        self:AddTitle(15)   -- Scout
        self:AddTitle(16)   -- Grunt
        self:AddTitle(17)   -- Sergeant
        self:AddTitle(18)   -- Senior Sergeant
        self:AddTitle(19)   -- First Sergeant
        self:AddTitle(20)   -- Stone Guard
        self:AddTitle(21)   -- Blood Guard
        self:AddTitle(22)   -- Legionnaire
        self:AddTitle(23)   -- Centurion
        self:AddTitle(24)   -- Champion
        self:AddTitle(25)   -- Lieutenant General
        self:AddTitle(26)   -- General
        self:AddTitle(27)   -- Warlord
        self:AddTitle(28)   -- High Warlord
        self:AddTitle(34)   -- Conqueror
        self:AddTitle(45)   -- Flame Keeper
        self:AddTitle(95)   -- of the Horde
        self:AddTitle(117)   -- of Orgrimmar
        self:AddTitle(118)   -- of Sen'jin
        self:AddTitle(119)   -- of Silvermoon
        self:AddTitle(120)   -- of Thunder Bluff
        self:AddTitle(121)   -- of the Undercity
        self:AddTitle(153)   -- Veteran of the Horde
        self:AddTitle(168)   -- Scout
        self:AddTitle(169)   -- Grunt
        self:AddTitle(170)   -- Sergeant
        self:AddTitle(171)   -- Senior Sergeant
        self:AddTitle(172)   -- First Sergeant
        self:AddTitle(173)   -- Stone Guard
        self:AddTitle(174)   -- Blood Guard
        self:AddTitle(175)   -- Legionnaire
        self:AddTitle(176)   -- Centurion
        self:AddTitle(177)   -- Champion
        self:AddTitle(178)   -- Lieutenant General
        self:AddTitle(179)   -- General
        self:AddTitle(180)   -- Warlord
        self:AddTitle(181)   -- High Warlord
        self:AddTitle(183)   -- Hero of the Horde
        self:AddTitle(144)   -- Warbringer
    end

    self:SortTable(self.TITLES)
end

function CollectMe:AddTitle(id, filters)
    if id ~= nil then
        local name = GetTitleName(id)

        table.insert(self.TITLES, {
            id         = id,
            name       = name:gsub("^%s*(.-)%s*$", "%1"),
            filters    = filters
        })

        table.insert(self.TITLE_SPELLS, id)
    end
end

-- filter for titles
CollectMeTitleFilter = {
    -- no longer obtainable
    ["nlo"] = {
        1, -- Private
        2, -- Corporal
        3, -- Sergeant
        4, -- Master Sergeant
        5, -- Sergeant Major
        6, -- Knight
        7, -- Knight-Lieutenant
        8, -- Knight-Captain
        9, -- Knight-Champion
        10, -- Lieutenant Commander
        11, -- Commander
        12, -- Marshal
        13, -- Field Marshal
        14, -- Grand Marshal
        15, -- Scout
        16, -- Grunt
        17, -- Sergeant
        18, -- Senior Sergeant
        19, -- First Sergeant
        20, -- Stone Guard
        21, -- Blood Guard
        22, -- Legionnaire
        23, -- Centurion
        24, -- Champion
        25, -- Lieutenant General
        26, -- General
        27, -- Warlord
        28, -- High Warlord
        29, -- Gladiator
        33, -- Scarab Lord
        128, -- Vanquisher
        37, -- Merciless Gladiator
        40, -- Vengeful Gladiator
        49, -- Brutal Gladiator
        56, -- Deadly Gladiator
        132, -- Furious Gladiator
        134, -- Relentless Gladiator
        142, -- Wrathful Gladiator
        191, -- Vicious Gladiator
        192, -- Ruthless Gladiator
        36, -- Champion of the Naaru
        39, -- Hand of A'dal
        53, -- the Supreme
        54, -- of the Ten Storms
        55, -- of the Emerald Dream
        57, -- Prophet
        58, -- the Malefic
        59, -- Stalker
        60, -- of the Ebon Blade
        61, -- Archmage
        62, -- Warbringer
        63, -- Assassin
        64, -- Grand Master Alchemist
        65, -- Grand Master Blacksmith
        66, -- Iron Chef
        67, -- Grand Master Enchanter
        68, -- Grand Master Engineer
        69, -- Doctor
        70, -- Grand Master Angler
        71, -- Grand Master Herbalist
        72, -- Grand Master Scribe
        73, -- Grand Master Jewelcrafter
        74, -- Grand Master Leatherworker
        75, -- Grand Master Miner
        76, -- Grand Master Skinner
        77, -- Grand Master Tailor
        78, -- of Quel'Thalas
        79, -- of Argus
        80, -- of Khaz Modan
        82, -- the Lion Hearted
        83, -- Champion of Elune
        84, -- Hero of Orgrimmar
        85, -- Plainsrunner
        86, -- of the Darkspear
        87, -- the Forsaken
        88, -- the Magic Seeker
        90, -- Conqueror of Naxxramas
        124, -- Death's Demise
        125, -- the Celestial Defender
        106, -- Obsidian Slayer
        135, -- Grand Crusader
        91, -- Hero of Northrend
        96, -- the Flawless Victor
        146, -- Blessed Defender of Nordrassil
        147, -- Slayer of Stupid, Incompetent and Disappointing Minions
    },

    -- trading card game
    ["pvp"] = {
        1, -- Private
        2, -- Corporal
        3, -- Sergeant
        4, -- Master Sergeant
        5, -- Sergeant Major
        6, -- Knight
        7, -- Knight-Lieutenant
        8, -- Knight-Captain
        9, -- Knight-Champion
        10, -- Lieutenant Commander
        11, -- Commander
        12, -- Marshal
        13, -- Field Marshal
        14, -- Grand Marshal
        15, -- Scout
        16, -- Grunt
        17, -- Sergeant
        18, -- Senior Sergeant
        19, -- First Sergeant
        20, -- Stone Guard
        21, -- Blood Guard
        22, -- Legionnaire
        23, -- Centurion
        24, -- Champion
        25, -- Lieutenant General
        26, -- General
        27, -- Warlord
        28, -- High Warlord
        29, -- Gladiator
        30, -- Duelist
        31, -- Rival
        32, -- Challenger
        128, -- Vanquisher
        37, -- Merciless Gladiator
        40, -- Vengeful Gladiator
        49, -- Brutal Gladiator
        56, -- Deadly Gladiator
        132, -- Furious Gladiator
        134, -- Relentless Gladiator
        142, -- Wrathful Gladiator
        191, -- Vicious Gladiator
        192, -- Ruthless Gladiator
        193, -- Cataclysmic Gladiator
        144, -- Warbringer
        145, -- Warbound
        152, -- Veteran of the Alliance
        154, -- Private
        155, -- Corporal
        156, -- Sergeant
        157, -- Master Sergeant
        158, -- Sergeant Major
        159, -- Knight
        160, -- Knight-Lieutenant
        161, -- Knight-Captain
        162, -- Knight-Champion
        163, -- Lieutenant Commander
        164, -- Commander
        165, -- Marshal
        166, -- Field Marshal
        167, -- Grand Marshal
        182, -- Hero of the Alliance
        153, -- Veteran of the Horde
        168, -- Scout
        169, -- Grunt
        170, -- Sergeant
        171, -- Senior Sergeant
        172, -- First Sergeant
        173, -- Stone Guard
        174, -- Blood Guard
        175, -- Legionnaire
        176, -- Centurion
        177, -- Champion
        178, -- Lieutenant General
        179, -- General
        180, -- Warlord
        181, -- High Warlord
        183, -- Hero of the Horde
    },
};

