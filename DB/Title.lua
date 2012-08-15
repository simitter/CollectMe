CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.TITLES = {}
CollectMe.TITLE_SPELLS = {}

function CollectMe:BuildTitleDB()
    -- Common Titles
    self:AddTitle(29, {nlo = 1, pvp = 1})  -- Gladiator
    self:AddTitle(30, {pvp = 1})  -- Duelist
    self:AddTitle(31, {pvp = 1})  -- Rival
    self:AddTitle(32, {pvp = 1})  -- Challenger
    self:AddTitle(33, {nlo = 1})  -- Scarab Lord
    self:AddTitle(36, {nlo = 1})  -- Champion of the Naaru
    self:AddTitle(37, {nlo = 1, pvp = 1})  -- Merciless Gladiator
    self:AddTitle(38)  -- of the Shattered Sun
    self:AddTitle(39, {nlo = 1})  -- Hand of A'dal
    self:AddTitle(40, {nlo = 1, pvp = 1})  -- Vengeful Gladiator
    self:AddTitle(41)  -- Battlemaster
    self:AddTitle(42)  -- the Seeker
    self:AddTitle(43)  -- Elder
    self:AddTitle(46)  -- the Exalted
    self:AddTitle(47)  -- the Explorer
    self:AddTitle(48)  -- the Diplomat
    self:AddTitle(49, {nlo = 1, pvp = 1})  -- Brutal Gladiator
    self:AddTitle(50)  -- Arena Master
    self:AddTitle(51)  -- Salty
    self:AddTitle(52)  -- Chef
    self:AddTitle(53, {nlo = 1})  -- the Supreme
    self:AddTitle(54, {nlo = 1})  -- of the Ten Storms
    self:AddTitle(55, {nlo = 1})  -- of the Emerald Dream
    self:AddTitle(56, {nlo = 1, pvp = 1})  -- Deadly Gladiator
    self:AddTitle(57, {nlo = 1})  -- Prophet
    self:AddTitle(58, {nlo = 1})  -- the Malefic
    self:AddTitle(59, {nlo = 1})  -- Stalker
    self:AddTitle(60, {nlo = 1})  -- of the Ebon Blade
    self:AddTitle(61, {nlo = 1})  -- Archmage
    self:AddTitle(62, {nlo = 1})  -- Warbringer
    self:AddTitle(63, {nlo = 1})  -- Assassin
    self:AddTitle(64, {nlo = 1})  -- Grand Master Alchemist
    self:AddTitle(65, {nlo = 1})  -- Grand Master Blacksmith
    self:AddTitle(66, {nlo = 1})  -- Iron Chef
    self:AddTitle(67, {nlo = 1})  -- Grand Master Enchanter
    self:AddTitle(68, {nlo = 1})  -- Grand Master Engineer
    self:AddTitle(69, {nlo = 1})  -- Doctor
    self:AddTitle(70, {nlo = 1})  -- Grand Master Angler
    self:AddTitle(71, {nlo = 1})  -- Grand Master Herbalist
    self:AddTitle(72, {nlo = 1})  -- Grand Master Scribe
    self:AddTitle(73, {nlo = 1})  -- Grand Master Jewelcrafter
    self:AddTitle(74, {nlo = 1})  -- Grand Master Leatherworker
    self:AddTitle(75, {nlo = 1})  -- Grand Master Miner
    self:AddTitle(76, {nlo = 1})  -- Grand Master Skinner
    self:AddTitle(77, {nlo = 1})  -- Grand Master Tailor
    self:AddTitle(78, {nlo = 1})  -- of Quel'Thalas
    self:AddTitle(79, {nlo = 1})  -- of Argus
    self:AddTitle(80, {nlo = 1})  -- of Khaz Modan
    self:AddTitle(82, {nlo = 1})  -- the Lion Hearted
    self:AddTitle(83, {nlo = 1})  -- Champion of Elune
    self:AddTitle(84, {nlo = 1})  -- Hero of Orgrimmar
    self:AddTitle(85, {nlo = 1})  -- Plainsrunner
    self:AddTitle(86, {nlo = 1})  -- of the Darkspear
    self:AddTitle(87, {nlo = 1})  -- the Forsaken
    self:AddTitle(88, {nlo = 1})  -- the Magic Seeker
    self:AddTitle(89)  -- Twilight Vanquisher
    self:AddTitle(90, {nlo = 1})  -- Conqueror of Naxxramas
    self:AddTitle(91, {nlo = 1})  -- Hero of Northrend
    self:AddTitle(92)  -- the Hallowed
    self:AddTitle(93)  -- Loremaster
    self:AddTitle(96, {nlo = 1})  -- the Flawless Victor
    self:AddTitle(97)  -- Champion of the Frozen Wastes
    self:AddTitle(98)  -- Ambassador
    self:AddTitle(99)  -- the Argent Champion
    self:AddTitle(100) -- Guardian of Cenarius
    self:AddTitle(101) -- Brewmaster
    self:AddTitle(102) -- Merrymaker
    self:AddTitle(103) -- the Love Fool
    self:AddTitle(104) -- Matron
    self:AddTitle(105) -- Patron
    self:AddTitle(106, {nlo = 1}) -- Obsidian Slayer
    self:AddTitle(107) -- of the Nightfall
    self:AddTitle(108) -- the Immortal
    self:AddTitle(109) -- the Undying
    self:AddTitle(110) -- Jenkins
    self:AddTitle(111) -- Bloodsail Admiral
    self:AddTitle(112) -- the Insane
    self:AddTitle(122) -- the Noble
    self:AddTitle(123) -- Crusader
    self:AddTitle(124, {nlo = 1}) -- Death's Demise
    self:AddTitle(125, {nlo = 1}) -- the Celestial Defender
    self:AddTitle(126) -- Conqueror of Ulduar
    self:AddTitle(127) -- Champion of Ulduar
    self:AddTitle(128, { nlo = 1, pvp = 1 }) -- Vanquisher
    self:AddTitle(129) -- Starcaller
    self:AddTitle(130) -- the Astral Walker
    self:AddTitle(131) -- Herald of the Titans
    self:AddTitle(132, {nlo = 1, pvp = 1}) -- Furious Gladiator
    self:AddTitle(133) -- the Pilgrim
    self:AddTitle(134, {nlo = 1, pvp = 1}) -- Relentless Gladiator
    self:AddTitle(135, {nlo = 1}) -- Grand Crusader
    self:AddTitle(136) -- the Argent Defender
    self:AddTitle(137) -- the Patient
    self:AddTitle(138) -- the Light of Dawn
    self:AddTitle(139) -- Bane of the Fallen King
    self:AddTitle(140) -- the Kingslayer
    self:AddTitle(141) -- of the Ashen Verdict
    self:AddTitle(142, {nlo = 1, pvp = 1}) -- Wrathful Gladiator
    self:AddTitle(143) -- the Camel-Hoarder
    self:AddTitle(146, {nlo = 1}) -- Blessed Defender of Nordrassil", -- [1
    self:AddTitle(147, {nlo = 1}) -- Slayer of Stupid, Incompetent and Disa
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
    self:AddTitle(191, {nlo = 1, pvp = 1}) -- Vicious Gladiator
    self:AddTitle(192, {nlo = 1, pvp = 1}) -- Ruthless Gladiator
    self:AddTitle(193, {pvp = 1}) -- Cataclysmic Gladiator
    self:AddTitle(194) -- Savior of Azeroth
    self:AddTitle(196) -- Destroyer's End

    -- Alliance Titles
    if self.FACTION == "Alliance" then
        self:AddTitle(1, {nlo = 1, pvp = 1})   -- Private
        self:AddTitle(2, {nlo = 1, pvp = 1})   -- Porporal
        self:AddTitle(3, {nlo = 1, pvp = 1})   -- Sergeant
        self:AddTitle(4, {nlo = 1, pvp = 1})   -- Master Sergeant
        self:AddTitle(5, {nlo = 1, pvp = 1})   -- Sergeant Major
        self:AddTitle(6, {nlo = 1, pvp = 1})   -- Knight
        self:AddTitle(7, {nlo = 1, pvp = 1})   -- Knight-Lieutenant
        self:AddTitle(8, {nlo = 1, pvp = 1})   -- Knight-Captain
        self:AddTitle(9, {nlo = 1, pvp = 1})   -- Knight-Champion
        self:AddTitle(10, {nlo = 1, pvp = 1})   -- Lieutenant Commander
        self:AddTitle(11, {nlo = 1, pvp = 1})   -- Commander
        self:AddTitle(12, {nlo = 1, pvp = 1})   -- Marshal
        self:AddTitle(13, {nlo = 1, pvp = 1})   -- Field Marshal
        self:AddTitle(14, {nlo = 1, pvp = 1})   -- Grand Marshal
        self:AddTitle(35)   -- Justicar
        self:AddTitle(44)   -- Flame Warden
        self:AddTitle(81)   -- of Gnomeregan
        self:AddTitle(94)   -- of the Alliance
        self:AddTitle(113)  -- of the Exodar
        self:AddTitle(114)  -- of Darnassus
        self:AddTitle(115)  -- of Ironforge
        self:AddTitle(116)  -- of Stormwind
        self:AddTitle(152, { pvp = 1 })  -- Veteran of the Alliance
        self:AddTitle(154, { pvp = 1 })  -- Private
        self:AddTitle(155, { pvp = 1 })  -- Corporal
        self:AddTitle(156, { pvp = 1 })  -- Sergeant
        self:AddTitle(157, { pvp = 1 })  -- Master Sergeant
        self:AddTitle(158, { pvp = 1 })  -- Sergeant Major
        self:AddTitle(159, { pvp = 1 })  -- Knight
        self:AddTitle(160, { pvp = 1 })  -- Knight-Lieutenant
        self:AddTitle(161, { pvp = 1 })  -- Knight-Captain
        self:AddTitle(162, { pvp = 1 })  -- Knight-Champion
        self:AddTitle(163, { pvp = 1 })  -- Lieutenant Commander
        self:AddTitle(164, { pvp = 1 })  -- Commander
        self:AddTitle(165, { pvp = 1 })  -- Marshal
        self:AddTitle(166, { pvp = 1 })  -- Field Marshal
        self:AddTitle(167, { pvp = 1 })  -- Grand Marshal
        self:AddTitle(182, { pvp = 1 })  -- Hero of the Alliance
        self:AddTitle(145, { pvp = 1 })  -- Warbound
    end

    -- Horde Titles
    if self.FACTION == "Horde" then
        self:AddTitle(15, {nlo = 1, pvp = 1})   -- Scout
        self:AddTitle(16, {nlo = 1, pvp = 1})   -- Grunt
        self:AddTitle(17, {nlo = 1, pvp = 1})   -- Sergeant
        self:AddTitle(18, {nlo = 1, pvp = 1})   -- Senior Sergeant
        self:AddTitle(19, {nlo = 1, pvp = 1})   -- First Sergeant
        self:AddTitle(20, {nlo = 1, pvp = 1})   -- Stone Guard
        self:AddTitle(21, {nlo = 1, pvp = 1})   -- Blood Guard
        self:AddTitle(22, {nlo = 1, pvp = 1})   -- Legionnaire
        self:AddTitle(23, {nlo = 1, pvp = 1})   -- Centurion
        self:AddTitle(24, {nlo = 1, pvp = 1})   -- Champion
        self:AddTitle(25, {nlo = 1, pvp = 1})   -- Lieutenant General
        self:AddTitle(26, {nlo = 1, pvp = 1})   -- General
        self:AddTitle(27, {nlo = 1, pvp = 1})   -- Warlord
        self:AddTitle(28, {nlo = 1, pvp = 1})   -- High Warlord
        self:AddTitle(34)   -- Conqueror
        self:AddTitle(45)   -- Flame Keeper
        self:AddTitle(95)   -- of the Horde
        self:AddTitle(117)   -- of Orgrimmar
        self:AddTitle(118)   -- of Sen'jin
        self:AddTitle(119)   -- of Silvermoon
        self:AddTitle(120)   -- of Thunder Bluff
        self:AddTitle(121)   -- of the Undercity
        self:AddTitle(153, { pvp = 1 })   -- Veteran of the Horde
        self:AddTitle(168, { pvp = 1 })   -- Scout
        self:AddTitle(169, { pvp = 1 })   -- Grunt
        self:AddTitle(170, { pvp = 1 })   -- Sergeant
        self:AddTitle(171, { pvp = 1 })   -- Senior Sergeant
        self:AddTitle(172, { pvp = 1 })   -- First Sergeant
        self:AddTitle(173, { pvp = 1 })   -- Stone Guard
        self:AddTitle(174, { pvp = 1 })   -- Blood Guard
        self:AddTitle(175, { pvp = 1 })   -- Legionnaire
        self:AddTitle(176, { pvp = 1 })   -- Centurion
        self:AddTitle(177, { pvp = 1 })   -- Champion
        self:AddTitle(178, { pvp = 1 })   -- Lieutenant General
        self:AddTitle(179, { pvp = 1 })   -- General
        self:AddTitle(180, { pvp = 1 })   -- Warlord
        self:AddTitle(181, { pvp = 1 })   -- High Warlord
        self:AddTitle(183, { pvp = 1 })   -- Hero of the Horde
        self:AddTitle(144, { pvp = 1 })   -- Warbringer
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
