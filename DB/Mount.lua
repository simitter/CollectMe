CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.MOUNTS = {}
CollectMe.MOUNT_SPELLS = {}

local GROUND = 1
local FLY = 2
local SWIM = 3
local AQUATIC = 4

function CollectMe:BuildMountDB()
    -- Common Mounts
    self:AddMount(75207, 34956, AQUATIC) -- Abyssal Seahorse
    self:AddMount(60025, 25836, FLY) -- Albino Drake
    self:AddMount(96503, 37800, FLY) -- Amani Dragonhawk
    self:AddMount(98204, 38261) -- Amani Battle Bear
    self:AddMount(43688, 22464, GROUND, { nlo = 1 }) -- Amani War Bear
    self:AddMount(63844, 22471) -- Argent Hippogryph
    self:AddMount(67466, 28918) -- Argent Warhorse
    self:AddMount(96491, 14341) -- Armored Razzashi Raptor
    self:AddMount(40192, 17890, FLY) -- Ashes of Al'ar
    self:AddMount(41514, 21521, FLY) -- Azure Netherwing Drake
    self:AddMount(59567, 27785, FLY) -- Azure Drake
    self:AddMount(51412, 25335) -- Big Battle Bear
    self:AddMount(58983, 27567, GROUND, { nlo = 1 }) -- Big Blizzard Bear
    self:AddMount(71342, 30989, FLY) -- Big Love Rocket
    self:AddMount(59650, 25831, FLY) -- Black Drake
    self:AddMount(59976, 28040, FLY) -- Black Proto-Drake
    self:AddMount(26656, 15676) -- Black Qiraji Battle Tank
    self:AddMount(107842, 39561, FLY) -- Blazing Drake
    self:AddMount(74856, 31803, FLY) -- Blazing Hippogryph
    self:AddMount(72808, 31156, FLY) -- Bloodbathed Frostbrood Vanquisher
    self:AddMount(59568, 25832, FLY) -- Blue Drake
    self:AddMount(59996, 28041, FLY) -- Blue Proto-Drake
    self:AddMount(25953, 15672) -- Blue Qiraji Battle Tank
    self:AddMount(39803, 21156, FLY) -- Blue Riding Nether Ray
    self:AddMount(43899, 22265) -- Brewfest Ram
    self:AddMount(59569, 25833, FLY) -- Bronze Drake
    self:AddMount(88748, 35136) -- Brown Riding Camel
    self:AddMount(58615, 27507, FLY) -- Brutal Nether Drake
    self:AddMount(75614, 31958, FLY) -- Celestial Steed
    self:AddMount(43927, 22473, FLY) -- Cenarion War Hippogryph
    self:AddMount(41515, 21525, FLY) -- Cobalt Netherwing Drake
    self:AddMount(39315, 21073) -- Cobalt Riding Talbuk
    self:AddMount(34896, 19375) -- Cobalt War Talbuk
    self:AddMount(97560, 38046, FLY) -- Corrupted Fire Hawk
    self:AddMount(102514, 38972, FLY)  -- Corrupted Hippogryph
    self:AddMount(73313, 25279)  -- Crimson Deathcharger
    self:AddMount(88990, 37145, FLY)  -- Dark Phoenix
    self:AddMount(39316, 21074)  -- Dark Riding Talbuk
    self:AddMount(34790, 19303)  -- Dark War Talbuk
    self:AddMount(103081, 39060)  -- Darkmoon Dancing Bear
    self:AddMount(64927, 25511, FLY)         -- Deadly Gladiator's Frost Wyrm
    self:AddMount(88335, 35757, FLY)         -- Drake of the East Wind
    self:AddMount(88742, 35553, FLY)         -- Drake of the North Wind
    self:AddMount(88744, 35755, FLY)         -- Drake of the South Wind
    self:AddMount(88741, 35754, FLY)         -- Drake of the West Wind
    self:AddMount(110039, 39229, FLY)   -- Experiment 12-B
    self:AddMount(113120, nil, FLY)   -- Feldrake
    self:AddMount(36702, 19250)   -- Fiery Warhorse
    self:AddMount(101542, 38783, FLY)   -- Flametalon of Alysrazor
    self:AddMount(97359, 38018, FLY)   -- Flameward Hippogryph
    self:AddMount(61451, 28082, FLY)   -- Flying Carpet
    self:AddMount(44153, 22719, FLY)   -- Flying Machine
    self:AddMount(84751, 34410)   -- Fossilized Raptor
    self:AddMount(75596, 28063, FLY)   -- Frosty Flying Carpet
    self:AddMount(65439, 25593, FLY)   -- Furious Gladiator's Frost Wyrm
    self:AddMount(49379, 24757)   -- Great Brewfest Kodo
    self:AddMount(61294, 28053, FLY)   -- Green Proto-Drake
    self:AddMount(26056, 15679)   -- Green Qiraji Battle Tank
    self:AddMount(39798, 21152, FLY)   -- Green Riding Nether Ray
    self:AddMount(88750, 35135)   -- Grey Riding Camel
    self:AddMount(110051, 40029, FLY)  -- Heart of the Aspects
    self:AddMount(48025, 25159, FLY)  -- Headless Horseman's Mount
    self:AddMount(72807, 31154, FLY)  -- Icebound Frostbrood Vanquisher
    self:AddMount(72286, 31007, FLY)  -- Invincible
    self:AddMount(63956, 28953, FLY)  -- Ironbound Proto-Drake
    self:AddMount(107845, 39563, FLY)  -- Life-Binder's Handmaiden
    self:AddMount(65917, 29344)  -- Magic Rooster
    self:AddMount(61309, 28060, FLY)  -- Magnificent Flying Carpet
    self:AddMount(44744, 22620, FLY)  -- Merciless Nether Drake
    self:AddMount(63796, 28890, FLY)  -- Mimiron's Head
    self:AddMount(93623, 37231, FLY)  -- Mottled Drake
    self:AddMount(121820, nil, FLY)  -- Obsidian Nightwing
    self:AddMount(69395, 30346, FLY)  -- Onyxian Drake
    self:AddMount(41513, 21520, FLY)  -- Onyx Netherwing Drake
    self:AddMount(88718, 35740, FLY)  -- Phosphorescent Stone Drake
    self:AddMount(60021, 28042, FLY)  -- Plagued Proto-Drake
    self:AddMount(97493, 38031, FLY)  -- Pureblood Fire Hawk
    self:AddMount(41516, 21523, FLY)  -- Purple Netherwing Drake
    self:AddMount(39801, 21155, FLY)  -- Purple Riding Nether Ray
    self:AddMount(41252, 21473)  -- Raven Lord
    self:AddMount(59570, 25835, FLY)  -- Red Drake
    self:AddMount(59961, 28044, FLY)  -- Red Proto-Drake
    self:AddMount(26054, 15681)  -- Red Qiraji Battle Tank
    self:AddMount(39800, 21158, FLY)  -- Red Riding Nether Ray
    self:AddMount(67336, 29794, FLY)  -- Relentless Gladiator's Frost Wyrm
    self:AddMount(30174, 17158)  -- Riding Turtle
    self:AddMount(17481, 10718)  -- Rivendare's Deathcharger
    self:AddMount(63963, 28954, FLY)  -- Rusted Proto-Drake
    self:AddMount(101821, 38755, FLY)  -- Ruthless Gladiator's Twilight Drake
    self:AddMount(93326, 35750, FLY)  -- Sandstone Drake
    self:AddMount(97581, 38048)  -- Savage Raptor
    self:AddMount(64731, 29161)  -- Sea Turtle
    self:AddMount(39802, 21157, FLY)  -- Silver Riding Nether Ray
    self:AddMount(39317, 21075)  -- Silver Riding Talbuk
    self:AddMount(34898, 19378)  -- Silver War Talbuk
    self:AddMount(42776, 21973)  -- Spectral Tiger
    self:AddMount(98718, 34955, AQUATIC)  -- Subdued Seahorse
    self:AddMount(43900, 22350)  -- Swift Brewfest Ram
    self:AddMount(102346, 1281)  -- Swift Forest Strider
    self:AddMount(102350, 1961)  -- Swift Lovebird
    self:AddMount(101573, 17011)  -- Swift Shorestrider
    self:AddMount(37015, 20344, FLY)  -- Swift Nether Drake
    self:AddMount(24242, 15289)  -- Swift Razzashi Raptor
    self:AddMount(42777, 21974)  -- Swift Spectral Tiger
    self:AddMount(102349, 16992)  -- Swift Springstrider
    self:AddMount(46628, 19483)  -- Swift White Hawkstrider
    self:AddMount(49322, 24745)  -- Swift Zhevra
    self:AddMount(96499, 37799)  -- Swift Zulian Panther
    self:AddMount(24252, 15290)  -- Swift Zulian Tiger
    self:AddMount(88749, 35134)  -- Tan Riding Camel
    self:AddMount(39318, 21077)  -- Tan Riding Talbuk
    self:AddMount(34899, 19376)  -- Tan War Talbuk
    self:AddMount(60002, 28045, FLY)  -- Time-Lost Proto-Drake
    self:AddMount(44151, 22720, FLY)  -- Turbo-Charged Flying Machine
    self:AddMount(59571, 27796, FLY)  -- Twilight Drake
    self:AddMount(107844, 39562, FLY)  -- Twilight Harbinger
    self:AddMount(107203, 39530, FLY)  -- Tyrael's Charger
    self:AddMount(92155, 15672)  -- Ultramarine Qiraji Battle Tank
    self:AddMount(49193, 24725, FLY)  -- Vengeful Nether Drake
    self:AddMount(41517, 21522, FLY)  -- Veridian Netherwing Drake
    self:AddMount(41518, 21524, FLY)  -- Violet Netherwing Drake
    self:AddMount(60024, 28043, FLY)  -- Violet Proto-Drake
    self:AddMount(88746, 35751, FLY)  -- Vitreous Stone Drake
    self:AddMount(88331, 35551, FLY)  -- Volcanic Stone Drake
    self:AddMount(54753, 28428)  -- White Polar Bear Mount
    self:AddMount(39319, 21076 )  -- White Riding Camel
    self:AddMount(102488, nil)  -- White Riding Talbuk
    self:AddMount(34897, 19377)  -- White War Talbuk
    self:AddMount(98727, 38260, FLY)  -- Winged Guardian
    self:AddMount(74918, 31721)  -- Wooly White Rhino
    self:AddMount(46197, 23656, FLY)  -- X-51 Nether-Rocket
    self:AddMount(46199, 23647, FLY)  -- X-51 Nether-Rocket X-TREME
    self:AddMount(75973, 31992, FLY)  -- X-53 Touring Rocket
    self:AddMount(26055, 15680)  -- Yellow Qiraji Battle Tank

    -- Alliance Mounts
    if self.FACTION == "Alliance" then
        self:AddMount(60114, 27820) -- Armored Brown Bear
    end

    -- Horde Mounts
    if self.FACTION == "Horde" then
        self:AddMount(61230, 27914, FLY) -- Armored Blue Wind Rider
    end

    -- Paladin Mounts for Humans and Dwarfs
    if self.CLASS == "PALADIN" and (self.RACE == "Human" or self.RACE == "Dwarf") then
        self:AddMount(66906, 28919) -- Argent Charger
        self:AddMount(23214, 14584) -- Charger
        self:AddMount(13819, 8469) -- Warhorse
    end

    -- Paladin Mounts for Draenei
    if self.CLASS == "PALADIN" and self.RACE == "Draenei" then
        self:AddMount(73629, 31367) -- Exarch's Elekk
        self:AddMount(73630, 31368) -- Great Exarch's Elekk
    end

    -- Paladin Mounts for Blood Elves
    if self.CLASS == "PALADIN" and self.RACE == "BloodElf" then

    end

    -- Paladin Mounts for Tauren
    if self.CLASS == "PALADIN" and self.RACE == "Tauren" then

    end

    -- Warlock Mounts
    if self.CLASS == "WARLOCK" then
        self:AddMount(23161, 14554) -- Dreadsteed
        self:AddMount(5784, 2346) -- Felsteed
    end

    -- Death Knight Mounts
    if self.CLASS == "DEATHKNIGHT" then
        self:AddMount(48778, 25280) -- Acherus Deathcharger
        self:AddMount(54729, 28108) -- Winged Steed of the Ebon Blade
    end

    self:SortTable(self.MOUNTS)
end

function CollectMe:AddMount(spell_id, display_id, type, filters, zones)
    if spell_id ~= nil then
        local name, _, icon = GetSpellInfo(spell_id)
        local link = GetSpellLink(spell_id)

        table.insert(self.MOUNTS, {
            name       = name,
            icon       = icon,
            link       = link,
            id         = spell_id,
            display_id = display_id,
            ground     = true,     -- all mounts can walk on ground
            fly        = (type == FLY),
            swim       = (type == SWIM),
            aquatic    = (type == AQUATIC),
            primary    = (type == nil and GROUND or type),
            filters    = filters,
            zones      = zones
        })

        table.insert(self.MOUNT_SPELLS, spell_id)
    end
end

-- alliance mounts
CollectMeAllianceMountTable = {
    [61229] = 32335, -- Armored Snowy Gryphon
    [22719] = 14334, -- Black Battlestrider
    [470] = 308, -- Black Stallion Bridle
    [60118] = 32203, -- Black War Bear
    [48027] = 26439, -- Black War Elekk
    [59785] = 31849, -- Black War Mammoth
    [22720] = 14335, -- Black War Ram
    [22717] = 14332, -- Black War Steed
    [22723] = 14336, -- Black War Tiger
    [61996] = 31239, -- Blue Dragonhawk
    [10969] = 7749, -- Blue Mechanostrider
    [34406] = 19658, -- Brown Elekk
    [458] = 284, -- Brown Horse
    [6899] = 4779, -- Brown Ram
    [6648] = 4269, -- Chestnut Mare
    [68187] = 35876, -- Crusader's White Warhorse
    [63637] = 33298, -- Darnassian Nightsaber
    [32239] = 20503, -- Ebon Gryphon
    [63639] = 33416, -- Exodar Elekk
    [63638] = 33301, -- Gnomeregan Mechanostrider
    [32235] = 18360, -- Golden Gryphon
    [90621] = 48632, -- Golden King
    [61465] = 31862, -- Grand Black War Mammoth
    [61470] = 31858, -- Grand Ice Mammoth
    [35710] = 20846, -- Gray Elekk
    [6777] = 12373, -- Gray Ram
    [35713] = 20848, -- Great Blue Elekk
    [35712] = 20849, -- Great Green Elekk
    [35714] = 20850, -- Great Purple Elekk
    [65637] = 34551, -- Great Red Elekk
    [17453] = 11147, -- Green Mechanostrider
    [59799] = 31855, -- Ice Mammoth
    [63636] = 33408, -- Ironforge Ram
    [60424] = 32286, -- Mekgineer's Chopper
    [103195] = 55272, -- Mountain Horse
    [472] = 307, -- Pinto
    [35711] = 20847, -- Purple Elekk
    [66090] = 33840, -- Quel'dorei Steed
    [10873] = 7739, -- Red Mechanostrider
    [66087] = 35147, -- Silver Covenant Hippogryph
    [32240] = 20505, -- Snowy Gryphon
    [92231] = 49487, -- Spectral Steed
    [107516] = 57156, -- Spectral Gryphon
    [10789] = 7687, -- Spotted Frostsaber
    [23510] = 14745, -- Stormpike Battle Charger
    [63232] = 33297, -- Stormwind Steed
    [66847] = 35168, -- Striped Dawnsaber
    [8394] = 6074, -- Striped Frostsaber
    [10793] = 7690, -- Striped Nightsaber
    [68057] = 35808, -- Swift Alliance Steed
    [32242] = 18406, -- Swift Blue Gryphon
    [23238] = 14546, -- Swift Brown Ram
    [23229] = 14561, -- Swift Brown Steed
    [23221] = 14556, -- Swift Frostsaber
    [23239] = 14548, -- Swift Gray Ram
    [65640] = 34557, -- Swift Gray Steed
    [32290] = 20506, -- Swift Green Gryphon
    [23225] = 14553, -- Swift Green Mechanostrider
    [23219] = 14555, -- Swift Mistsaber
    [103196] = 55273, -- Swift Mountain Horse
    [65638] = 34550, -- Swift Moonsaber
    [23227] = 14559, -- Swift Palomino
    [32292] = 20507, -- Swift Purple Gryphon
    [32289] = 20508, -- Swift Red Gryphon
    [23338] = 14602, -- Swift Stormsaber
    [65643] = 34554, -- Swift Violet Ram
    [23223] = 14552, -- Swift White Mechanostrider
    [23240] = 14547, -- Swift White Ram
    [23228] = 14560, -- Swift White Steed
    [23222] = 14551, -- Swift Yellow Mechanostrider
    [61425] = 32633, -- Traveler's Tundra Mammoth
    [65642] = 34553, -- Turbostrider
    [17454] = 10180, -- Unpainted Mechanostrider
    [100332] = 53885, -- Vicious War Steed
    [6898] = 4777, -- White Ram
    [17229] = 11021, -- Winterspring Frostsaber
    [59791] = 31851, -- Wooly Mammoth
};

-- horde mounts
CollectMeHordeMountTable = {
    [60116] = 32207, -- Armored Brown Bear
    [35022] = 20222, -- Black Hawkstrider
    [64977] = 34238, -- Black Skeletal Horse
    [60119] = 32205, -- Black War Bear
    [22718] = 14333, -- Black War Kodo
    [59788] = 31850, -- Black War Mammoth
    [22721] = 14330, -- Black War Raptor
    [22724] = 14329, -- Black War Wolf
    [64658] = 356, -- Black Wolf
    [35020] = 20220, -- Blue Hawkstrider
    [17463] = 11154, -- Blue Skeletal Horse
    [32244] = 18364, -- Blue Wind Rider
    [18990] = 11689, -- Brown Kodo
    [17464] = 11155, -- Brown Skeletal Horse
    [6654] = 4272, -- Brown Wolf
    [68188] = 35878, -- Crusader's Black Warhorse
    [63635] = 33299, -- Darkspear Raptor
    [6653] = 4271, -- Dire Wolf
    [8395] = 6075, -- Emerald Raptor
    [63643] = 33414, -- Forsaken Warhorse
    [23509] = 14744, -- Frostwolf Howler
    [61467] = 31861, -- Grand Black War Mammoth
    [61469] = 31857, -- Grand Ice Mammoth
    [18989] = 12149, -- Gray Kodo
    [23249] = 14549, -- Great Brown Kodo
    [65641] = 34558, -- Great Golden Kodo
    [23248] = 14550, -- Great Gray Kodo
    [23247] = 14542, -- Great White Kodo
    [17465] = 11156, -- Green Skeletal Warhorse
    [32245] = 18365, -- Green Wind Rider
    [87090] = 46754, -- Goblin Trike
    [87091] = 46755, -- Goblin Turbo-Trike
    [59797] = 31854, -- Ice Mammoth
    [93644] = 51195, -- Kor'kron Annihilator
    [55531] = 29929, -- Mechano-Hog
    [66846] = 35169, -- Ochre Skeletal Warhorse
    [63640] = 33409, -- Orgrimmar Wolf
    [35018] = 20217, -- Purple Hawkstrider
    [23246] = 14558, -- Purple Skeletal Warhorse
    [61997] = 32944, -- Red Dragonhawk
    [34795] = 19280, -- Red Hawkstrider
    [17462] = 11153, -- Red Skeletal Horse
    [22722] = 14331, -- Red Skeletal Warhorse
    [63642] = 33418, -- Silvermoon Hawkstrider
    [107517] = 57157, -- Spectral Wind Rider
    [92232] = 49488, -- Spectral Wolf
    [66088] = 35148, -- Sunreaver Dragonhawk
    [66091] = 33841, -- Sunreaver Hawkstrider
    [23241] = 14545, -- Swift Blue Raptor
    [23250] = 14540, -- Swift Brown Wolf
    [65646] = 34555, -- Swift Burgundy Wolf
    [23252] = 14541, -- Swift Gray Wolf
    [35025] = 20224, -- Swift Green Hawkstrider
    [32295] = 18378, -- Swift Green Wind Rider
    [68056] = 35809, -- Swift Horde Wolf
    [23242] = 14543, -- Swift Olive Raptor
    [23243] = 14544, -- Swift Orange Raptor
    [33660] = 19281, -- Swift Pink Hawkstrider
    [35027] = 20223, -- Swift Purple Hawkstrider
    [65644] = 34549, -- Swift Purple Raptor
    [32297] = 18379, -- Swift Purple Wind Rider
    [65639] = 34556, -- Swift Red Hawkstrider
    [32246] = 18377, -- Swift Red Wind Rider
    [23251] = 14539, -- Swift Timber Wolf
    [35028] = 20225, -- Swift Warstrider
    [32296] = 18380, -- Swift Yellow Wind Rider
    [32243] = 18363, -- Tawny Wind Rider
    [63641] = 33300, -- Thunder Bluff Kodo
    [580] = 358, -- Timber Wolf
    [61447] = 32640, -- Traveler's Tundra Mammoth
    [10796] = 7707, -- Turquoise Raptor
    [64659] = 34156, -- Venomhide Ravasaur
    [100333] = 53985, -- Vicious War Wolf
    [10799] = 7708, -- Violet Raptor
    [64657] = 34155, -- White Kodo
    [65645] = 34552, -- White Skeletal Warhorse
    [59793] = 31852, -- Wooly Mammoth
    [71810] = 38361, -- Wrathful Gladiator's Frost Wyrm
};


-- horde paladin mounts
CollectMeHordePaladinMountTable = {
    [66906] = 35179, -- Argent Charger
    [34767] = 20030, -- Horde Charger
    [34769] = 20029, -- Horde Warhorse
    [69820] = 36883, -- Sunwalker Kodo
    [69826] = 37059, -- Great Sunwalker Kodo
};


-- filter for mounts
CollectMeMountFilter = {
    -- no longer obtainable
    ["nlo"] = {
        [59976] = 31912, -- Black Proto-Drake
        [26656] = 15711, -- Black Qiraji Battle Tank
        [43899] = 24368, -- Brewfest Ram
        [58615] = 31124, -- Brutal Nether Drake
        [68188] = 35878, -- Crusader's Black Warhorse
        [68187] = 35876, -- Crusader's White Warhorse
        [64927] = 34225, -- Deadly Gladiator's Frostwyrm
        [65439] = 34425, -- Furious Gladiator's Frost Wyrm
        [44744] = 24743, -- Merciless Nether Drake
        [60021] = 32156, -- Plagued Proto-Drake
        [67336] = 35362, -- Relentless Gladiator's Frost Wyrm
        [68057] = 35808, -- Swift Alliance Steed
        [68056] = 35809, -- Swift Horde Wolf
        [61444] = 32635, -- Swift Shadoweave (Ebonweave) Carpet
        [61446] = 32636, -- Swift Spellfire Carpet
        [61442] = 32634, -- Swift Mooncloth Carpet
        [37015] = 21510, -- Swift Nether Drake
        [24242] = 15090, -- Swift Razzashi Raptor
        [49322] = 27684, -- Swift Zhevra
        [24252] = 15104, -- Swift Zulian Tiger
        [49322] = 27684, -- Swift Zhevra
        [49193] = 27637, -- Vengeful Nether Drake
        [71810] = 38361, -- Wrathful Gladiator's Frost Wyrm
        [75973] = 40725, -- X-53 Touring Rocket
    },

    -- trading card game
    ["tcg"] = {
        [96503] = 52185, -- Amani Dragonhawk
        [51412] = 28363, -- Big Battle Bear
        [74856] = 40165, -- Blazing Hippogryph
        [102514] = 54903, -- Corrupted Hippogryph
        [113120] = 59072, -- Feldrake
        [65917] = 34655, -- Magic Rooster
        [93623] = 50467, -- Mottled Drake 
        [30174] = 17266, -- Riding Turtle
        [97581] = 52813, -- Savage Raptor
        [42776] = 24003, -- Spectral Tiger
        [101573] = 54423, -- Swift Shorestrider
        [42777] = 24004, -- Swift Spectral Tiger
        [39319] = 22514, -- White Riding Camel
        [74918] = 40191, -- Wooly White Rhino
        [46197] = 26192, -- X-51 Nether-Rocket
        [46199] = 26164, -- X-51 Nether-Rocket X-TREME
    },

    -- pvp mounts
    ["pvp"] = {
        [22719] = 14334, -- Black Battlestrider
        [48027] = 26439, -- Black War Elekk
        [22718] = 14333, -- Black War Kodo
        [22720] = 14335, -- Black War Ram
        [22721] = 14330, -- Black War Raptor
        [22717] = 14332, -- Black War Steed
        [22723] = 14336, -- Black War Tiger
        [22724] = 14329, -- Black War Wolf
        [58615] = 31124, -- Brutal Nether Drake
        [39316] = 22511, -- Dark Riding Talbuk
        [34790] = 20149, -- Dark War Talbuk
        [64927] = 34225, -- Deadly Gladiator's Frost Wyrm
        [23509] = 14744, -- Frostwolf Howler
        [65439] = 34425, -- Furious Gladiator's Frost Wyrm
        [44744] = 24743, -- Merciless Nether Drake
        [22722] = 14331, -- Red Skeletal Warhorse
        [67336] = 35362, -- Relentless Gladiator's Frost Wyrm
       [101821] = 54498, -- Ruthless Gladiator's Twilight Drake
        [23510] = 14745, -- Stormpike Battle Charger
        [37015] = 21510, -- Swift Nether Drake
        [35028] = 20225, -- Swift Warstrider
        [49193] = 27637, -- Vengeful Nether Drake
        [71810] = 38361, -- Wrathful Gladiator's Frost Wyrm
    },

    -- blizzard store mounts
    ["bsm"] = {
        [75614] = 40625, -- Celestial Steed
        [110051] = 58169, -- Heart of the Aspects
        [98727] = 53273, -- Winged Guardian
    },

    -- recruit a friend mounts
    ["rfm"] = {
        [49322] = 27684, -- Swift Zhevra
        [75973] = 40725, -- X-53 Touring Rocket
        [121820] = 62454, -- Obsidian Nightwing
    },

    -- promotional mounts
    ["ptm"] = {
        [107203] = 56921, -- Tyrael's Charger
    },
        
    -- Eng mounts
    ["eng"] = {
        [44153] = 24653, -- Flying Machine
        [44151] = 24654, -- Turbo-Charged Flying Machine
    },
        
    -- Tailoring mounts
    ["tal"] = {
        [61451] = 33029, -- Flying Carpet
        [61309] = 33030, -- Magnificent Flying Carpet
        [75596] = 40533, -- Frosty Flying Carpet


    },
};
