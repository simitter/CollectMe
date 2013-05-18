CollectMe.TitleDB = CollectMe:NewModule("TitleDB")

function CollectMe.TitleDB:OnInitialize()
    self.titles = {}
    self.title_spells = {}

    self.filters = { "nlo", "pvp", "are" }

    self:Build()
end

function CollectMe.TitleDB:Build()
    -- Common Titles
    self:Add(29, {nlo = 1, are = 1})  -- Gladiator
    self:Add(30, {pvp = 1})  -- Duelist
    self:Add(31, {pvp = 1})  -- Rival
    self:Add(32, {pvp = 1})  -- Challenger
    self:Add(33, {nlo = 1})  -- Scarab Lord
    self:Add(36, {nlo = 1})  -- Champion of the Naaru
    self:Add(37, {nlo = 1, are = 1})  -- Merciless Gladiator
    self:Add(38)  -- of the Shattered Sun
    self:Add(39, {nlo = 1})  -- Hand of A'dal
    self:Add(40, {nlo = 1, are = 1})  -- Vengeful Gladiator
    self:Add(41)  -- Battlemaster
    self:Add(42)  -- the Seeker
    self:Add(43)  -- Elder
    self:Add(46)  -- the Exalted
    self:Add(47)  -- the Explorer
    self:Add(48)  -- the Diplomat
    self:Add(49, {nlo = 1, are = 1})  -- Brutal Gladiator
    self:Add(50, {are = 1})  -- Arena Master
    self:Add(51)  -- Salty
    self:Add(52)  -- Chef
    self:Add(53, {nlo = 1})  -- the Supreme
    self:Add(54, {nlo = 1})  -- of the Ten Storms
    self:Add(55, {nlo = 1})  -- of the Emerald Dream
    self:Add(56, {nlo = 1, are = 1})  -- Deadly Gladiator
    self:Add(57, {nlo = 1})  -- Prophet
    self:Add(58, {nlo = 1})  -- the Malefic
    self:Add(59, {nlo = 1})  -- Stalker
    self:Add(60, {nlo = 1})  -- of the Ebon Blade
    self:Add(61, {nlo = 1})  -- Archmage
    self:Add(62, {nlo = 1})  -- Warbringer
    self:Add(63, {nlo = 1})  -- Assassin
    self:Add(64, {nlo = 1})  -- Grand Master Alchemist
    self:Add(65, {nlo = 1})  -- Grand Master Blacksmith
    self:Add(66, {nlo = 1})  -- Iron Chef
    self:Add(67, {nlo = 1})  -- Grand Master Enchanter
    self:Add(68, {nlo = 1})  -- Grand Master Engineer
    self:Add(69, {nlo = 1})  -- Doctor
    self:Add(70, {nlo = 1})  -- Grand Master Angler
    self:Add(71, {nlo = 1})  -- Grand Master Herbalist
    self:Add(72, {nlo = 1})  -- Grand Master Scribe
    self:Add(73, {nlo = 1})  -- Grand Master Jewelcrafter
    self:Add(74, {nlo = 1})  -- Grand Master Leatherworker
    self:Add(75, {nlo = 1})  -- Grand Master Miner
    self:Add(76, {nlo = 1})  -- Grand Master Skinner
    self:Add(77, {nlo = 1})  -- Grand Master Tailor
    self:Add(78, {nlo = 1})  -- of Quel'Thalas
    self:Add(79, {nlo = 1})  -- of Argus
    self:Add(80, {nlo = 1})  -- of Khaz Modan
    self:Add(82, {nlo = 1})  -- the Lion Hearted
    self:Add(83, {nlo = 1})  -- Champion of Elune
    self:Add(84, {nlo = 1})  -- Hero of Orgrimmar
    self:Add(85, {nlo = 1})  -- Plainsrunner
    self:Add(86, {nlo = 1})  -- of the Darkspear
    self:Add(87, {nlo = 1})  -- the Forsaken
    self:Add(88, {nlo = 1})  -- the Magic Seeker
    self:Add(89)  -- Twilight Vanquisher
    self:Add(90, {nlo = 1})  -- Conqueror of Naxxramas
    self:Add(91, {nlo = 1})  -- Hero of Northrend
    self:Add(92)  -- the Hallowed
    self:Add(93)  -- Loremaster
    self:Add(96, {nlo = 1})  -- the Flawless Victor
    self:Add(97)  -- Champion of the Frozen Wastes
    self:Add(98)  -- Ambassador
    self:Add(99)  -- the Argent Champion
    self:Add(100) -- Guardian of Cenarius
    self:Add(101) -- Brewmaster
    self:Add(102) -- Merrymaker
    self:Add(103) -- the Love Fool
    self:Add(104) -- Matron
    self:Add(105) -- Patron
    self:Add(106, {nlo = 1}) -- Obsidian Slayer
    self:Add(107) -- of the Nightfall
    self:Add(108, {nlo = 1}) -- the Immortal
    self:Add(109, {nlo = 1}) -- the Undying
    self:Add(110) -- Jenkins
    self:Add(111) -- Bloodsail Admiral
    self:Add(112) -- the Insane
    self:Add(122) -- the Noble
    self:Add(123) -- Crusader
    self:Add(124, {nlo = 1}) -- Death's Demise
    self:Add(125, {nlo = 1}) -- the Celestial Defender
    self:Add(126, {nlo = 1}) -- Conqueror of Ulduar
    self:Add(127, {nlo = 1}) -- Champion of Ulduar
    self:Add(128, { nlo = 1, are = 1 }) -- Vanquisher
    self:Add(129) -- Starcaller
    self:Add(130) -- the Astral Walker
    self:Add(131) -- Herald of the Titans
    self:Add(132, {nlo = 1, are = 1}) -- Furious Gladiator
    self:Add(133) -- the Pilgrim
    self:Add(134, {nlo = 1, are = 1}) -- Relentless Gladiator
    self:Add(135, {nlo = 1}) -- Grand Crusader
    self:Add(136, {nlo = 1}) -- the Argent Defender
    self:Add(137) -- the Patient
    self:Add(138) -- the Light of Dawn
    self:Add(139) -- Bane of the Fallen King
    self:Add(140) -- the Kingslayer
    self:Add(141) -- of the Ashen Verdict
    self:Add(142, {nlo = 1, are = 1}) -- Wrathful Gladiator
    self:Add(143) -- the Camel-Hoarder
    self:Add(146, {nlo = 1}) -- Blessed Defender of Nordrassil", -- [1
    self:Add(147, {nlo = 1}) -- Slayer of Stupid, Incompetent and Disa
    self:Add(148) -- Assistant Professor
    self:Add(149) -- Associate Professor
    self:Add(150) -- Professor
    self:Add(151) -- of the Four Winds
    self:Add(184, {pvp = 1}) -- The Bloodthirsty
    self:Add(185) -- Defender of a Shattered World", -- [18
    self:Add(186) -- Dragonslayer
    self:Add(187) -- Blackwing's Bane
    self:Add(188) -- Avenger of Hyjal
    self:Add(189) -- the Flamebreaker
    self:Add(190) -- Firelord
    self:Add(191, {nlo = 1, are = 1}) -- Vicious Gladiator
    self:Add(192, {nlo = 1, are = 1}) -- Ruthless Gladiator
    self:Add(193, {are = 1, nlo = 1}) -- Cataclysmic Gladiator
    self:Add(194) -- Savior of Azeroth
    self:Add(196) -- Destroyer's End

    -- mists of pandaria
    self:Add(195) -- Farmer
    self:Add(197) -- the Beloved
    self:Add(198) -- the Fearless
    self:Add(199) -- Zookeeper
    self:Add(200) -- the Relic Hunter
    self:Add(201) -- the Undaunted
    self:Add(202) -- Master of the Ways
    self:Add(203) -- the Tranquil Master
    self:Add(204) -- Delver of the Vaults
    self:Add(205) -- Shadow-Master
    self:Add(206) -- the Scenaterdist
    self:Add(207) -- Tamer
    self:Add(208) -- Seeker of Knowledge
    self:Add(209) -- Brawler
    self:Add(218) -- the Wakener
    self:Add(220, { pvp = 1 }) -- Kahn
    self:Add(221) -- the Stormbreaker
    self:Add(222) -- Storm's End
    self:Add(223, { are = 1 }) -- Malevolent Gladiator
        
    --5.3
    self:Add(xxx, { are = 1 }) -- Vanquisher
    self:Add(xxx) -- Trainer
    self:Add(xxx) -- Gorgeous

        

    -- Alliance Titles
    if CollectMe.FACTION == "Alliance" then
        self:Add(1, {nlo = 1, pvp = 1})   -- Private
        self:Add(2, {nlo = 1, pvp = 1})   -- Porporal
        self:Add(3, {nlo = 1, pvp = 1})   -- Sergeant
        self:Add(4, {nlo = 1, pvp = 1})   -- Master Sergeant
        self:Add(5, {nlo = 1, pvp = 1})   -- Sergeant Major
        self:Add(6, {nlo = 1, pvp = 1})   -- Knight
        self:Add(7, {nlo = 1, pvp = 1})   -- Knight-Lieutenant
        self:Add(8, {nlo = 1, pvp = 1})   -- Knight-Captain
        self:Add(9, {nlo = 1, pvp = 1})   -- Knight-Champion
        self:Add(10, {nlo = 1, pvp = 1})   -- Lieutenant Commander
        self:Add(11, {nlo = 1, pvp = 1})   -- Commander
        self:Add(12, {nlo = 1, pvp = 1})   -- Marshal
        self:Add(13, {nlo = 1, pvp = 1})   -- Field Marshal
        self:Add(14, {nlo = 1, pvp = 1})   -- Grand Marshal
        self:Add(35, {pvp = 1})   -- Justicar
        self:Add(44)   -- Flame Warden
        self:Add(81)   -- of Gnomeregan
        self:Add(94, {pvp = 1})   -- of the Alliance
        self:Add(113)  -- of the Exodar
        self:Add(114)  -- of Darnassus
        self:Add(115)  -- of Ironforge
        self:Add(116)  -- of Stormwind
        self:Add(152, { pvp = 1 })  -- Veteran of the Alliance
        self:Add(154, { pvp = 1 })  -- Private
        self:Add(155, { pvp = 1 })  -- Corporal
        self:Add(156, { pvp = 1 })  -- Sergeant
        self:Add(157, { pvp = 1 })  -- Master Sergeant
        self:Add(158, { pvp = 1 })  -- Sergeant Major
        self:Add(159, { pvp = 1 })  -- Knight
        self:Add(160, { pvp = 1 })  -- Knight-Lieutenant
        self:Add(161, { pvp = 1 })  -- Knight-Captain
        self:Add(162, { pvp = 1 })  -- Knight-Champion
        self:Add(163, { pvp = 1 })  -- Lieutenant Commander
        self:Add(164, { pvp = 1 })  -- Commander
        self:Add(165, { pvp = 1 })  -- Marshal
        self:Add(166, { pvp = 1 })  -- Field Marshal
        self:Add(167, { pvp = 1 })  -- Grand Marshal
        self:Add(182, { pvp = 1 })  -- Hero of the Alliance
        self:Add(145, { pvp = 1 })  -- Warbound
            -- 5.3 Alliance
        self:Add(xxx)  -- the Hordebreaker
    end

    -- Horde Titles
    if CollectMe.FACTION == "Horde" then
        self:Add(15, {nlo = 1, pvp = 1})   -- Scout
        self:Add(16, {nlo = 1, pvp = 1})   -- Grunt
        self:Add(17, {nlo = 1, pvp = 1})   -- Sergeant
        self:Add(18, {nlo = 1, pvp = 1})   -- Senior Sergeant
        self:Add(19, {nlo = 1, pvp = 1})   -- First Sergeant
        self:Add(20, {nlo = 1, pvp = 1})   -- Stone Guard
        self:Add(21, {nlo = 1, pvp = 1})   -- Blood Guard
        self:Add(22, {nlo = 1, pvp = 1})   -- Legionnaire
        self:Add(23, {nlo = 1, pvp = 1})   -- Centurion
        self:Add(24, {nlo = 1, pvp = 1})   -- Champion
        self:Add(25, {nlo = 1, pvp = 1})   -- Lieutenant General
        self:Add(26, {nlo = 1, pvp = 1})   -- General
        self:Add(27, {nlo = 1, pvp = 1})   -- Warlord
        self:Add(28, {nlo = 1, pvp = 1})   -- High Warlord
        self:Add(34, {pvp = 1})   -- Conqueror
        self:Add(45)   -- Flame Keeper
        self:Add(95, {pvp = 1})   -- of the Horde
        self:Add(117)   -- of Orgrimmar
        self:Add(118)   -- of Sen'jin
        self:Add(119)   -- of Silvermoon
        self:Add(120)   -- of Thunder Bluff
        self:Add(121)   -- of the Undercity
        self:Add(153, { pvp = 1 })   -- Veteran of the Horde
        self:Add(168, { pvp = 1 })   -- Scout
        self:Add(169, { pvp = 1 })   -- Grunt
        self:Add(170, { pvp = 1 })   -- Sergeant
        self:Add(171, { pvp = 1 })   -- Senior Sergeant
        self:Add(172, { pvp = 1 })   -- First Sergeant
        self:Add(173, { pvp = 1 })   -- Stone Guard
        self:Add(174, { pvp = 1 })   -- Blood Guard
        self:Add(175, { pvp = 1 })   -- Legionnaire
        self:Add(176, { pvp = 1 })   -- Centurion
        self:Add(177, { pvp = 1 })   -- Champion
        self:Add(178, { pvp = 1 })   -- Lieutenant General
        self:Add(179, { pvp = 1 })   -- General
        self:Add(180, { pvp = 1 })   -- Warlord
        self:Add(181, { pvp = 1 })   -- High Warlord
        self:Add(183, { pvp = 1 })   -- Hero of the Horde
        self:Add(144, { pvp = 1 })   -- Warbringer
            --5.3 Horde
        self:Add(xxx)  -- Darkspear Revolutionary
    end

    CollectMe:SortTable(self.titles)
end

function CollectMe.TitleDB:Add(id, filters)
    if id ~= nil then
        local name = GetTitleName(id)
        if name ~= nil then
            table.insert(self.titles, {
                id         = id,
                name       = name:gsub("^%s*(.-)%s*$", "%1"),
                filters    = filters
            })
            table.insert(self.title_spells, id)
        end
    end
end

function CollectMe.TitleDB:Get()
    return self.titles, self.title_spells
end

function CollectMe.TitleDB:PrintAll()
    for i = 1, GetNumTitles(), 1 do
        local name = GetTitleName(i)
        if name ~= nil then
            CollectMe:Print(i.. " - " ..name)
        end
    end
end

function CollectMe.TitleDB:PrintUnkown()
    for i = 1, GetNumTitles(), 1 do
        if IsTitleKnown(i) == 1 and CollectMe:IsInTable(self.title_spells, i) == false then
            local name = GetTitleName(i)
            if name ~= nil then
                CollectMe:Print(CollectMe.L["Title"] .. " " .. name:gsub("^%s*(.-)%s*$", "%1") .. "("..i..") " .. CollectMe.L["is missing"] .. ". " .. CollectMe.L["Please inform the author"])
            end
        end
    end
end

