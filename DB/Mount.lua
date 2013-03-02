-- todo rework array key usage for more performant access

CollectMe.MountDB = CollectMe:NewModule("MountDB")

function CollectMe.MountDB:OnInitialize()
    self.GROUND = 1
    self.FLY = 2
    self.SWIM = 3
    self.AQUATIC = 4

    self.mounts = {}
    self.mount_spells = {}
    self.known_mounts = {}
    self.known_mount_count = 0

    self.filters = { "nlo", "umo", "tcg", "pvp", "are", "bsm", "rfm", "ptm" }

    self:Build()
end

function CollectMe.MountDB:Build()
    -- Common Mounts
    self:Add(75207, 34956, self.AQUATIC, {}, { 614, 615, 610 }) -- Abyssal Seahorse
    self:Add(60025, 25836, self.FLY) -- Albino Drake
    self:Add(96503, 37800, self.FLY, { tcg = 1 }) -- Amani Dragonhawk
    self:Add(98204, 38261):SetProperty(98204, "obtain_zones", {781})-- Amani Battle Bear
    self:Add(43688, 22464, self.GROUND, { nlo = 1 }) -- Amani War Bear
    self:Add(63844, 22471, self.FLY):SetProperty(63844, "obtain_zones", {492}) -- Argent Hippogryph
    self:Add(67466, 28918) -- Argent Warhorse
    self:Add(96491, 14341) -- Armored Razzashi Raptor
    self:Add(40192, 17890, self.FLY) -- Ashes of Al'ar
    self:Add(41514, 21521, self.FLY) -- Azure Netherwing Drake
    self:Add(59567, 27785, self.FLY) -- Azure Drake
    self:Add(51412, 25335, self.GROUND, { tcg = 1 }) -- Big Battle Bear
    self:Add(58983, 27567, self.GROUND, { nlo = 1 }) -- Big Blizzard Bear
    self:Add(71342, 30989, self.FLY) -- Big Love Rocket
    self:Add(59650, 25831, self.FLY) -- Black Drake
    self:Add(59976, 28040, self.FLY, { nlo = 1 }) -- Black Proto-Drake
    self:Add(26656, 15676, self.GROUND, { nlo = 1 }) -- Black Qiraji Battle Tank
    self:Add(107842, 39561, self.FLY) -- Blazing Drake
    self:Add(74856, 31803, self.FLY, { tcg = 1 }) -- Blazing Hippogryph
    self:Add(72808, 31156, self.FLY) -- Bloodbathed Frostbrood Vanquisher
    self:Add(59568, 25832, self.FLY) -- Blue Drake
    self:Add(59996, 28041, self.FLY) -- Blue Proto-Drake
    self:Add(25953, 15672, self.GROUND, {}, { 766 }) -- Blue Qiraji Battle Tank
    self:Add(39803, 21156, self.FLY) -- Blue Riding Nether Ray
    self:Add(43899, 22265, self.GROUND, { nlo = 1 }) -- Brewfest Ram
    self:Add(59569, 25833, self.FLY) -- Bronze Drake
    self:Add(88748, 35136) -- Brown Riding Camel
    self:Add(58615, 27507, self.FLY, { are = 1, nlo = 1 }) -- Brutal Nether Drake
    self:Add(75614, 31958, self.FLY, { bsm = 1 }) -- Celestial Steed
    self:Add(43927, 22473, self.FLY) -- Cenarion War Hippogryph
    self:Add(41515, 21525, self.FLY) -- Cobalt Netherwing Drake
    self:Add(39315, 21073) -- Cobalt Riding Talbuk
    self:Add(34896, 19375) -- Cobalt War Talbuk
    self:Add(97560, 38046, self.FLY) -- Corrupted Fire Hawk
    self:Add(102514, 38972, self.FLY, { tcg = 1 })  -- Corrupted Hippogryph
    self:Add(73313, 25279)  -- Crimson Deathcharger
    self:Add(88990, 37145, self.FLY)  -- Dark Phoenix
    self:Add(39316, 21074, self.GROUND, { pvp = 1 })  -- Dark Riding Talbuk
    self:Add(34790, 19303, self.GROUND, { pvp = 1 })  -- Dark War Talbuk
    self:Add(103081, 39060)  -- Darkmoon Dancing Bear
    self:Add(64927, 25511, self.FLY, { are = 1, nlo = 1 })         -- Deadly Gladiator's Frost Wyrm
    self:Add(88335, 35757, self.FLY)         -- Drake of the East Wind
    self:Add(88742, 35553, self.FLY)         -- Drake of the North Wind
    self:Add(88744, 35755, self.FLY)         -- Drake of the South Wind
    self:Add(88741, 35754, self.FLY):SetProperty(88741, "obtain_zones", {709})         -- Drake of the West Wind
    self:Add(110039, 39229, self.FLY)   -- Experiment 12-B
    self:Add(113120, 40568, self.FLY, { tcg = 1 })   -- Feldrake
    self:Add(36702, 19250)   -- Fiery Warhorse
    self:Add(101542, 38783, self.FLY)   -- Flametalon of Alysrazor
    self:Add(97359, 38018, self.FLY)   -- Flameward Hippogryph
    self:Add(61451, 28082, self.FLY, nil, nil, { tai = 300 })   -- self.FLYing Carpet
    self:Add(44153, 22719, self.FLY, nil, nil, { eng = 300 })   -- self.FLYing Machine
    self:Add(84751, 34410)   -- Fossilized Raptor
    self:Add(75596, 28063, self.FLY, nil, nil, { tai = 425 })   -- Frosty self.FLYing Carpet
    self:Add(65439, 25593, self.FLY, { are = 1, nlo = 1 })   -- Furious Gladiator's Frost Wyrm
    self:Add(49379, 24757)   -- Great Brewfest Kodo
    self:Add(61294, 28053, self.FLY)   -- Green Proto-Drake
    self:Add(26056, 15679, self.GROUND, {}, { 766 })   -- Green Qiraji Battle Tank
    self:Add(39798, 21152, self.FLY)   -- Green Riding Nether Ray
    self:Add(88750, 35135)   -- Grey Riding Camel
    self:Add(110051, 40029, self.FLY, { bsm = 1 })  -- Heart of the Aspects
    self:Add(48025, 25159, self.FLY)  -- Headless Horseman's Mount
    self:Add(72807, 31154, self.FLY)  -- Icebound Frostbrood Vanquisher
    self:Add(124659, 43254, self.FLY) -- Imperial Quilen
    self:Add(72286, 31007, self.FLY)  -- Invincible
    self:Add(63956, 28953, self.FLY)  -- Ironbound Proto-Drake
    self:Add(107845, 39563, self.FLY)  -- Life-Binder's Handmaiden
    self:Add(65917, 29344, self.GROUND, { tcg = 1 })  -- Magic Rooster
    self:Add(61309, 28060, self.FLY, nil, nil, { tai = 425 })  -- Magnificent self.FLYing Carpet
    self:Add(44744, 22620, self.FLY, { are = 1, nlo = 1})  -- Merciless Nether Drake
    self:Add(63796, 28890, self.FLY)  -- Mimiron's Head
    self:Add(93623, 37231, self.FLY, { tcg = 1 })  -- Mottled Drake
    self:Add(121820, 42498, self.FLY, { rfm = 1 })  -- Obsidian Nightwing
    self:Add(69395, 30346, self.FLY)  -- Onyxian Drake
    self:Add(41513, 21520, self.FLY)  -- Onyx Netherwing Drake
    self:Add(88718, 35740, self.FLY)  -- Phosphorescent Stone Drake
    self:Add(60021, 28042, self.FLY, { nlo = 1 })  -- Plagued Proto-Drake
    self:Add(97493, 38031, self.FLY)  -- Pureblood Fire Hawk
    self:Add(41516, 21523, self.FLY)  -- Purple Netherwing Drake
    self:Add(39801, 21155, self.FLY)  -- Purple Riding Nether Ray
    self:Add(41252, 21473)  -- Raven Lord
    self:Add(59570, 25835, self.FLY)  -- Red Drake
    self:Add(59961, 28044, self.FLY)  -- Red Proto-Drake
    self:Add(26054, 15681, self.GROUND, {}, { 766 })  -- Red Qiraji Battle Tank
    self:Add(39800, 21158, self.FLY)  -- Red Riding Nether Ray
    self:Add(67336, 29794, self.FLY, { are = 1, nlo = 1})  -- Relentless Gladiator's Frost Wyrm
    self:Add(30174, 17158, self.SWIM, { tcg = 1 })  -- Riding Turtle
    self:Add(17481, 10718)  -- Rivendare's Deathcharger
    self:Add(63963, 28954, self.FLY)  -- Rusted Proto-Drake
    self:Add(101821, 38755, self.FLY, { are = 1 })  -- Ruthless Gladiator's Twilight Drake
    self:Add(93326, 35750, self.FLY)  -- Sandstone Drake
    self:Add(97581, 38048, self.GROUND, { tcg = 1 })  -- Savage Raptor
    self:Add(64731, 29161, self.SWIM)  -- Sea Turtle
    self:Add(39802, 21157, self.FLY)  -- Silver Riding Nether Ray
    self:Add(39317, 21075)  -- Silver Riding Talbuk
    self:Add(34898, 19378)  -- Silver War Talbuk
    self:Add(42776, 21973, self.GROUND, { tcg = 1 })  -- Spectral Tiger
    self:Add(98718, 34955, self.AQUATIC, {}, { 614, 615, 610 })  -- Subdued Seahorse
    self:Add(43900, 22350)  -- Swift Brewfest Ram
    self:Add(102346, 1281)  -- Swift Forest Strider
    self:Add(102350, 1961)  -- Swift Lovebird
    self:Add(101573, 17011, self.GROUND, { tcg = 1 })  -- Swift Shorestrider
    self:Add(37015, 20344, self.FLY, { are = 1, nlo = 1})  -- Swift Nether Drake
    self:Add(24242, 15289, self.GROUND, { nlo = 1 })  -- Swift Razzashi Raptor
    self:Add(42777, 21974, self.GROUND, { tcg = 1 })  -- Swift Spectral Tiger
    self:Add(102349, 16992)  -- Swift Springstrider
    self:Add(46628, 19483)  -- Swift White Hawkstrider
    self:Add(49322, 24745, self.GROUND, { rfm = 1, nlo = 1 })  -- Swift Zhevra
    self:Add(96499, 37799)  -- Swift Zulian Panther
    self:Add(24252, 15290, self.GROUND, { nlo = 1 })  -- Swift Zulian Tiger
    self:Add(88749, 35134)  -- Tan Riding Camel
    self:Add(39318, 21077)  -- Tan Riding Talbuk
    self:Add(34899, 19376)  -- Tan War Talbuk
    self:Add(60002, 28045, self.FLY)  -- Time-Lost Proto-Drake
    self:Add(44151, 22720, self.FLY, nil, nil, { eng = 375 })  -- Turbo-Charged self.FLYing Machine
    self:Add(59571, 27796, self.FLY)  -- Twilight Drake
    self:Add(107844, 39562, self.FLY)  -- Twilight Harbinger
    self:Add(107203, 39530, self.FLY, { ptm = 1 })  -- Tyrael's Charger
    self:Add(92155, 15672)  -- Ultramarine Qiraji Battle Tank
    self:Add(49193, 24725, self.FLY, { are = 1, nlo = 1})  -- Vengeful Nether Drake
    self:Add(41517, 21522, self.FLY)  -- Veridian Netherwing Drake
    self:Add(41518, 21524, self.FLY)  -- Violet Netherwing Drake
    self:Add(60024, 28043, self.FLY)  -- Violet Proto-Drake
    self:Add(88746, 35751, self.FLY)  -- Vitreous Stone Drake
    self:Add(88331, 35551, self.FLY)  -- Volcanic Stone Drake
    self:Add(54753, 28428)  -- White Polar Bear Mount
    self:Add(102488, 37204, self.GROUND, { tcg = 1 })  -- White Riding Camel
    self:Add(39319, 21076)  -- White Riding Talbuk
    self:Add(34897, 19377)  -- White War Talbuk
    self:Add(98727, 38260, self.FLY, { bsm = 1 })  -- Winged Guardian
    self:Add(74918, 31721, self.GROUND, { tcg = 1 })  -- Wooly White Rhino
    self:Add(46197, 23656, self.FLY, { tcg = 1 })  -- X-51 Nether-Rocket
    self:Add(46199, 23647, self.FLY, { tcg = 1 })  -- X-51 Nether-Rocket X-TREME
    self:Add(75973, 31992, self.FLY, { rfm = 1, nlo = 1 })  -- X-53 Touring Rocket
    self:Add(26055, 15680, self.GROUND, {}, { 766 })  -- Yellow Qiraji Battle Tank
    self:Add(71810, 31047, self.FLY, { are = 1, nlo = 1}) -- Wrathful Gladiator's Frost Wyrm
    self:Add(127180, 43708, { umo = 1 }) -- Albino Riding Crane
    self:Add(123886, 43090) -- Amber Scorpion
    self:Add(132117, 45521, self.FLY) -- Ashen Pandaren Phoenix
    self:Add(127170, 46087, self.FLY) -- Astral Cloud Serpent
    self:Add(123992, 41989, self.FLY) -- Azure Cloud Serpent
    self:Add(127174, 43704) -- Azure Riding Crane
    self:Add(118089, 41711) -- Azure Water Strider
    self:Add(127286, 43717) -- Black Dragon Turtle
    self:Add(130138, 44836) -- Black Riding Goat
    self:Add(127209, 43709, { umo = 1 }) -- Black Riding Yak
    self:Add(127220, 43712) -- Blonde Riding Yak
    self:Add(127287, 43718) -- Blue Dragon Turtle
    self:Add(129934, 43900) -- Blue Shado-Pan Riding Tiger
    self:Add(127288, 43719) -- Brown Dragon Turtle
    self:Add(130086, 44807) -- Brown Riding Goat
    self:Add(127213, 43710, { umo = 1 }) -- Brown Riding Yak
    self:Add(124550, 38757, self.FLY, { are = 1}) -- Cataclysmic Gladiator's Twilight Drake
    self:Add(127156, 41592, self.FLY) -- Crimson Cloud Serpent
    self:Add(129552, 44633, self.FLY) -- Crimson Pandaren Phoenix
    self:Add(123160, 42837, { umo = 1 }) -- Crimson Riding Crane
    self:Add(127271, 43713, { umo = 1 }) -- Crimson Water Strider
    self:Add(126507, 43637, self.FLY) -- Depleted-Kyparium Rocket
    self:Add(132118, 45520, self.FLY) -- Emerald Pandaren Phoenix
    self:Add(126508, 43638, self.FLY) -- Geosynchronous World Spinner
    self:Add(123993, 41991, self.FLY) -- Golden Cloud Serpent
    self:Add(127176, 43705) -- Golden Riding Crane
    self:Add(127278, 43716, { umo = 1 }) -- Golden Water Strider
    self:Add(122708, 42703) -- Grand Expedition Yak
    self:Add(127295, 43723) -- Great Black Dragon Turtle
    self:Add(127302, 43724) -- Great Blue Dragon Turtle
    self:Add(127308, 43725) -- Great Brown Dragon Turtle
    self:Add(127293, 43722) -- Great Green Dragon Turtle
    self:Add(127310, 43726) -- Great Purple Dragon Turtle
    self:Add(120822, 42352) -- Great Red Dragon Turtle
    self:Add(120395, 42250) -- Green Dragon Turtle
    self:Add(129932, 44759) -- Green Shado-Pan Riding Tiger
    self:Add(127216, 43711) -- Grey Riding Yak
    self:Add(127169, 43697, self.FLY, { umo = 1 }) -- Heavenly Azure Cloud Serpent
    self:Add(127161, 43692, self.FLY) -- Heavenly Crimson Cloud Serpent
    self:Add(127164, 43693, self.FLY, { umo = 1 }) -- Heavenly Golden Cloud Serpent
    self:Add(127165, 43695, self.FLY, { umo = 1 }) -- Heavenly Jade Cloud Serpent
    self:Add(127158, 43689, self.FLY) -- Heavenly Onyx Cloud Serpent
    self:Add(113199, 40590, self.FLY) -- Jade Cloud Serpent
    self:Add(121837, 42502) -- Jade Panther
    self:Add(127274, 43714, { umo = 1 }) -- Jade Water Strider
    self:Add(120043, 42185, self.FLY) -- Jeweled Onyx Panther
    self:Add(127178, 43707, { umo = 1 }) -- Jungle Riding Crane
    self:Add(127154, 41990, self.FLY) -- Onyx Cloud Serpent
    self:Add(127272, 43715, { umo = 1 }) -- Orange Water Strider
    self:Add(127289, 43910) -- Purple Dragon Turtle
    self:Add(127290, 43721) -- Red Dragon Turtle
    self:Add(130092, 44808, self.FLY) -- Red self.FLYing Cloud
    self:Add(129935, 44757) -- Red Shado-Pan Riding Tiger
    self:Add(127177, 43706) -- Regal Riding Crane
    self:Add(121838, 42499) -- Ruby Panther
    self:Add(121836, 42500) -- Sapphire Panther
    self:Add(130965, 45264) -- Son of Galleon
    self:Add(121839, 42501, self.FLY) -- Sunstone Panther
    self:Add(129918, 43686, self.FLY) -- Thundering August Cloud Serpent
    self:Add(124408, 43562, self.FLY) -- Thundering Jade Cloud Serpent
    self:Add(132036, 45797, self.FLY) -- Thundering Ruby Cloud Serpent
    self:Add(132119, 45522, self.FLY) -- Violet Pandaren Phoenix
    self:Add(130137, 44837) -- White Riding Goat
    self:Add(123182, 41089, { umo = 1 }) -- White Riding Yak
    self:Add(133023, 42147, self.FLY) -- Jade Pandaren Kite
    self:Add(134573, 46729, self.FLY, { bsm = 1 }) -- Swift Windsteed

    -- Alliance Mounts
    if CollectMe.FACTION == "Alliance" then
        self:Add(60114, 27820):SetProperty(60114, "obtain_zones", {504}) -- Armored Brown Bear
        self:Add(61229, 27913, self.FLY):SetProperty(61229, "obtain_zones", {504}) -- Armored Snowy Gryphon
        self:Add(22719, 14372, self.GROUND, { pvp = 1 }):SetProperty(22719, "obtain_zones", {301}) -- Black Battlestrider
        self:Add(470, 2402):SetProperty(470, "obtain_zones", {301,40})   -- Black Stallion Bridle
        self:Add(60118, 27818):SetProperty(60118, "obtain_zones", {321,362,480,382}) -- Black War Bear
        self:Add(48027, 23928, self.GROUND, { pvp = 1 }):SetProperty(48027, "obtain_zones", {301}) -- Black War Elekk
        self:Add(59785, 27247):SetProperty(59785, "obtain_zones", {501}) -- Black War Mammoth
        self:Add(22720, 14577, self.GROUND, { pvp = 1 }):SetProperty(22720, "obtain_zones", {301}) -- Black War Ram
        self:Add(22717, 14337, self.GROUND, { pvp = 1 }):SetProperty(22717, "obtain_zones", {301}) -- Black War Steed
        self:Add(22723, 14330, self.GROUND, { pvp = 1 }):SetProperty(22723, "obtain_zones", {301}) -- Black War Tiger
        self:Add(61996, 27525, self.FLY) -- Blue Dragonhawk
        self:Add(10969, 6569):SetProperty(10969, "obtain_zones", {27}) -- Blue Mechanostrider
        self:Add(34406, 17063):SetProperty(34406, "obtain_zones", {471}) -- Brown Elekk
        self:Add(458, 2404):SetProperty(458, "obtain_zones", {301,40,141,30})     -- Brown Horse
        self:Add(6899, 2785):SetProperty(6899, "obtain_zones", {27})  -- Brown Ram
        self:Add(6648, 2405):SetProperty(458, "obtain_zones", {301,40,141,30})  -- Chestnut Mare
        self:Add(68187, 29937, self.GROUND, { nlo = 1 }):SetProperty(68187, "obtain_zones", {543}) -- Crusader's White Warhorse
        self:Add(63637, 29256):SetProperty(63637, "obtain_zones", {492}) -- Darnassian Nightsaber
        self:Add(32239, 17694, self.FLY):SetProperty(32239, "obtain_zones", {301,504,486,473,465}) -- Ebon Gryphon
        self:Add(63639, 29255):SetProperty(63639, "obtain_zones", {492}) -- Exodar Elekk
        self:Add(63638, 28571):SetProperty(63638, "obtain_zones", {492}) -- Gnomeregan Mechanostrider
        self:Add(32235, 17697, self.FLY):SetProperty(32235, "obtain_zones", {301,504,486,473,465}) -- Golden Gryphon
        self:Add(90621, 36213):SetProperty(90621, "obtain_zones", {301,504,481,471,341,381}) -- Golden King
        self:Add(61465, 27241):SetProperty(61465, "obtain_zones", {532}) -- Grand Black War Mammoth
        self:Add(135416, nil, self.FLY):SetProperty(135416, "obtain_zones", {857}) -- Grand Armored Gryphon
        self:Add(136163, nil, self.FLY):SetProperty(136163, "obtain_zones", {857}) -- Grand Gryphon
        self:Add(61470, 27242):SetProperty(61470, "obtain_zones", {495}) -- Grand Ice Mammoth
        self:Add(35710, 19869):SetProperty(35710, "obtain_zones", {471}) -- Gray Elekk
        self:Add(6777, 2736):SetProperty(6777, "obtain_zones", {27})  -- Gray Ram
        self:Add(35713, 19871):SetProperty(35713, "obtain_zones", {471}) -- Great Blue Elekk
        self:Add(35712, 19873):SetProperty(35712, "obtain_zones", {471}) -- Great Green Elekk
        self:Add(35714, 19872):SetProperty(35714, "obtain_zones", {471}) -- Great Purple Elekk
        self:Add(65637, 28606):SetProperty(65637, "obtain_zones", {492}) -- Great Red Elekk
        self:Add(17453, 10661):SetProperty(17453, "obtain_zones", {27}) -- Green Mechanostrider
        self:Add(59799, 27248):SetProperty(59799, "obtain_zones", {495}) -- Ice Mammoth
        self:Add(63636, 29258):SetProperty(63636, "obtain_zones", {492}) -- Ironforge Ram
        self:Add(60424, 25870) -- Mekgineer's Chopper
        self:Add(103195, 39096):SetProperty(103195, "obtain_zones", {381}) -- Mountain Horse
        self:Add(472, 2409):SetProperty(472, "obtain_zones", {301,40,141,30})   -- Pinto
        self:Add(35711, 19870):SetProperty(35711, "obtain_zones", {471}) -- Purple Elekk
        self:Add(66090, 28888):SetProperty(66090, "obtain_zones", {492}) -- Quel'dorei Steed
        self:Add(10873, 9473):SetProperty(10873, "obtain_zones", {27}) -- Red Mechanostrider
        self:Add(66087, 22474, self.FLY):SetProperty(66087, "obtain_zones", {492}) -- Silver Covenant Hippogryph
        self:Add(32240, 17696, self.FLY):SetProperty(32240, "obtain_zones", {301,504,486,473,465}) -- Snowy Gryphon
        self:Add(92231, 37160):SetProperty(92231, "obtain_zones", {709}) -- Spectral Steed
        self:Add(107516, 39546, self.FLY) -- Spectral Gryphon
        self:Add(10789, 6444):SetProperty(10789, "obtain_zones", {381}) -- Spotted Frostsaber
        self:Add(23510, 14777, self.GROUND, { pvp = 1 }):SetProperty(23510, "obtain_zones", {401}) -- Stormpike Battle Charger
        self:Add(63232, 28912):SetProperty(63232, "obtain_zones", {492}) -- Stormwind Steed
        self:Add(66847, 29755):SetProperty(66847, "obtain_zones", {381}) -- Striped Dawnsaber
        self:Add(8394, 6080):SetProperty(8394, "obtain_zones", {381})  -- Striped Frostsaber
        self:Add(10793, 6448):SetProperty(10793, "obtain_zones", {381})  -- Striped Nightsaber
        self:Add(68057, 29284, self.GROUND, { nlo = 1 }):SetProperty(68057, "obtain_zones", {543})  -- Swift Alliance Steed
        self:Add(32242, 17759, self.FLY):SetProperty(32242, "obtain_zones", {301,504,486,473,465})  -- Swift Blue Gryphon
        self:Add(23238, 14347):SetProperty(23238, "obtain_zones", {27})  -- Swift Brown Ram
        self:Add(23229, 14583):SetProperty(23229, "obtain_zones", {30,301,141})  -- Swift Brown Steed
        self:Add(23221, 14331):SetProperty(23221, "obtain_zones", {381})  -- Swift Frostsaber
        self:Add(23239, 14576):SetProperty(23239, "obtain_zones", {27})  -- Swift Gray Ram
        self:Add(65640, 29043):SetProperty(65640, "obtain_zones", {492})  -- Swift Gray Steed
        self:Add(32290, 17703, self.FLY):SetProperty(32290, "obtain_zones", {301,504,486,473,465})  -- Swift Green Gryphon
        self:Add(23225, 14374):SetProperty(23225, "obtain_zones", {27})  -- Swift Green Mechanostrider
        self:Add(23219, 14332):SetProperty(23219, "obtain_zones", {381})  -- Swift Mistsaber
        self:Add(103196, 39095):SetProperty(103196, "obtain_zones", {381})  -- Swift Mountain Horse
        self:Add(65638, 14333):SetProperty(65638, "obtain_zones", {492})  -- Swift Moonsaber
        self:Add(23227, 14582):SetProperty(23227, "obtain_zones", {30,301,141})  -- Swift Palomino
        self:Add(32292, 17717, self.FLY):SetProperty(32292, "obtain_zones", {301,504,486,473,465})  -- Swift Purple Gryphon
        self:Add(32289, 17718, self.FLY):SetProperty(32289, "obtain_zones", {301,504,486,473,465})  -- Swift Red Gryphon
        self:Add(23338, 14632):SetProperty(23338, "obtain_zones", {381})  -- Swift Stormsaber
        self:Add(65643, 28612):SetProperty(65643, "obtain_zones", {492})  -- Swift Violet Ram
        self:Add(23223, 14376):SetProperty(23223, "obtain_zones", {27})  -- Swift White Mechanostrider
        self:Add(23240, 14346):SetProperty(23240, "obtain_zones", {27})  -- Swift White Ram
        self:Add(23228, 14338):SetProperty(23228, "obtain_zones", {30,301,141})  -- Swift White Steed
        self:Add(23222, 14377):SetProperty(23222, "obtain_zones", {27})  -- Swift Yellow Mechanostrider
        self:Add(61425, 27237):SetProperty(61425, "obtain_zones", {504})  -- Traveler's Tundra Mammoth
        self:Add(65642, 14375):SetProperty(65642, "obtain_zones", {492})  -- Turbostrider
        self:Add(17454, 9476):SetProperty(17454, "obtain_zones", {27})  -- Unpainted Mechanostrider
        self:Add(100332, 38668, self.GROUND, { pvp = 1 }) -- Vicious War Steed
        self:Add(6898, 2786):SetProperty(6898, "obtain_zones", {27})   -- White Ram
        self:Add(16083, 2410, self.GROUND, { nlo = 1 })  -- White Stallion
        self:Add(17229, 10426):SetProperty(17229, "obtain_zones", {281})  -- Winterspring Frostsaber
        self:Add(59791, 27243):SetProperty(59791, "obtain_zones", {504})  -- Wooly Mammoth
        self:Add(130985, 45271, self.FLY) -- Pandaren Kite
    end

    -- Horde Mounts
    if CollectMe.FACTION == "Horde" then
        self:Add(61230, 27914, self.FLY) -- Armored Blue Wind Rider
        self:Add(60116, 27821) -- Armored Brown Bear
        self:Add(35022, 19478) -- Black Hawkstrider
        self:Add(64977, 29130) -- Black Skeletal Horse
        self:Add(60119, 27819) -- Black War Bear
        self:Add(22718, 14348, self.GROUND, { pvp = 1 }) -- Black War Kodo
        self:Add(59788, 27245) -- Black War Mammoth
        self:Add(22721, 14388, self.GROUND, { pvp = 1 }) -- Black War Raptor
        self:Add(22724, 14334, self.GROUND, { pvp = 1 }) -- Black War Wolf
        self:Add(64658, 207) -- Black Wolf
        self:Add(35020, 19480) -- Blue Hawkstrider
        self:Add(17463, 10671) -- Blue Skeletal Horse
        self:Add(32244, 17700, self.FLY) -- Blue Wind Rider
        self:Add(18990, 11641) -- Brown Kodo
        self:Add(17464, 10672) -- Brown Skeletal Horse
        self:Add(6654, 2328) -- Brown Wolf
        self:Add(68188, 29938, self.GROUND, { nlo = 1 }) -- Crusader's Black Warhorse
        self:Add(63635, 29261) -- Darkspear Raptor
        self:Add(6653, 2327) -- Dire Wolf
        self:Add(8395, 4806) -- Emerald Raptor
        self:Add(63643, 29257) -- Forsaken Warhorse
        self:Add(23509, 14776, self.GROUND, { pvp = 1 }) -- Frostwolf Howler
        self:Add(61467, 27240) -- Grand Black War Mammoth
        self:Add(61469, 27239) -- Grand Ice Mammoth
        self:Add(135418, nil, self.FLY) -- Grand Armored Wyvern
        self:Add(136164, nil, self.FLY) -- Grand Wyvern
        
        self:Add(18989, 12246) -- Gray Kodo
        self:Add(23249, 14578) -- Great Brown Kodo
        self:Add(65641, 28556) -- Great Golden Kodo
        self:Add(23248, 14579) -- Great Gray Kodo
        self:Add(23247, 14349) -- Great White Kodo
        self:Add(17465, 10720) -- Green Skeletal Warhorse
        self:Add(32245, 17701, self.FLY) -- Green Wind Rider
        self:Add(87090, 35249) -- Goblin Trike
        self:Add(87091, 35250) -- Goblin Turbo-Trike
        self:Add(59797, 27246) -- Ice Mammoth
        self:Add(93644, 37138) -- Kor'kron Annihilator
        self:Add(55531, 25871) -- Mechano-Hog
        self:Add(66846, 29754) -- Ochre Skeletal Warhorse
        self:Add(63640, 29260) -- Orgrimmar Wolf
        self:Add(35018, 19479) -- Purple Hawkstrider
        self:Add(23246, 10721) -- Purple Skeletal Warhorse
        self:Add(61997, 28402, self.FLY) -- Red Dragonhawk
        self:Add(34795, 18696) -- Red Hawkstrider
        self:Add(17462, 10670) -- Red Skeletal Horse
        self:Add(22722, 10719, self.GROUND, { pvp = 1 }) -- Red Skeletal Warhorse
        self:Add(63642, 29262) -- Silvermoon Hawkstrider
        self:Add(107517, 39547, self.FLY) -- Spectral Wind Rider
        self:Add(92232, 37159) -- Spectral Wolf
        self:Add(66088, 29696, self.FLY) -- Sunreaver Dragonhawk
        self:Add(66091, 28889) -- Sunreaver Hawkstrider
        self:Add(23241, 14339) -- Swift Blue Raptor
        self:Add(23250, 14573) -- Swift Brown Wolf
        self:Add(65646, 14335) -- Swift Burgundy Wolf
        self:Add(23252, 14574) -- Swift Gray Wolf
        self:Add(35025, 19484) -- Swift Green Hawkstrider
        self:Add(32295, 17720, self.FLY) -- Swift Green Wind Rider
        self:Add(68056, 29283, self.GROUND, { nlo = 1 }) -- Swift Horde Wolf
        self:Add(23242, 14344) -- Swift Olive Raptor
        self:Add(23243, 14342) -- Swift Orange Raptor
        self:Add(33660, 18697) -- Swift Pink Hawkstrider
        self:Add(35027, 19482) -- Swift Purple Hawkstrider
        self:Add(65644, 14343) -- Swift Purple Raptor
        self:Add(32297, 17721, self.FLY) -- Swift Purple Wind Rider
        self:Add(65639, 28607) -- Swift Red Hawkstrider
        self:Add(32246, 17719, self.FLY) -- Swift Red Wind Rider
        self:Add(23251, 14575) -- Swift Timber Wolf
        self:Add(35028, 20359, self.GROUND, { pvp = 1 }) -- Swift Warstrider
        self:Add(32296, 17722, self.FLY) -- Swift Yellow Wind Rider
        self:Add(32243, 17699, self.FLY) -- Tawny Wind Rider
        self:Add(63641, 29259) -- Thunder Bluff Kodo
        self:Add(580, 247) -- Timber Wolf
        self:Add(61447, 27238) -- Traveler's Tundra Mammoth
        self:Add(10796, 6472) -- Turquoise Raptor
        self:Add(64659, 29102) -- Venomhide Ravasaur
        self:Add(100333, 38607, self.GROUND, { pvp = 1 }) -- Vicious War Wolf
        self:Add(10799, 6473) -- Violet Raptor
        self:Add(64657, 12241) -- White Kodo
        self:Add(65645, 28605) -- White Skeletal Warhorse
        self:Add(59793, 27244) -- Wooly Mammoth
        self:Add(118737, 41903, self.FLY) -- Pandaren Kite
        self:Add(18992, 12242, self.GROUND, { nlo = 1 }) -- Teal Kodo
    end

    -- Paladin Mounts for Humans and Dwarfs
    if CollectMe.CLASS == "PALADIN" and (CollectMe.RACE == "Human" or CollectMe.RACE == "Dwarf") then
        self:Add(66906, 28919) -- Argent Charger
        self:Add(23214, 14584) -- Charger
        self:Add(13819, 8469) -- Warhorse
    end

    -- Paladin Mounts for Draenei
    if CollectMe.CLASS == "PALADIN" and CollectMe.RACE == "Draenei" then
        self:Add(66906, 28919) -- Argent Charger
        self:Add(73629, 31367) -- Exarch's Elekk
        self:Add(73630, 31368) -- Great Exarch's Elekk
    end

    -- Paladin Mounts for Blood Elves
    if CollectMe.CLASS == "PALADIN" and CollectMe.RACE == "BloodElf" then
        self:Add(66906, 28919) -- Argent Charger
        self:Add(34767, 19085) -- Horde Charger
        self:Add(34769, 19296) -- Horde Warhorse
    end

    -- Paladin Mounts for Tauren
    if CollectMe.CLASS == "PALADIN" and CollectMe.RACE == "Tauren" then
        self:Add(66906, 28919) -- Argent Charger
        self:Add(69826, 30501) -- Great Sunwalker Kodo
        self:Add(69820, 30366) -- Sunwalker Kodo
    end

    -- Warlock Mounts
    if CollectMe.CLASS == "WARLOCK" then
        self:Add(23161, 14554) -- Dreadsteed
        self:Add(5784, 2346) -- Felsteed
    end

    -- Death Knight Mounts
    if CollectMe.CLASS == "DEATHKNIGHT" then
        self:Add(48778, 25280) -- Acherus Deathcharger
        self:Add(54729, 28108, self.FLY) -- Winged Steed of the Ebon Blade
    end

    CollectMe:SortTable(self.mounts)
    self:RefreshKnown(true)
end

function CollectMe.MountDB:Add(spell_id, display_id, type, filters, zones, professions, obtain_zones)
    if spell_id ~= nil then
        local name, _, icon = GetSpellInfo(spell_id)
        local link = GetSpellLink(spell_id)

        table.insert(self.mounts, {
            name       = name,
            icon       = icon,
            link       = link,
            id         = spell_id,
            display_id = display_id,
            type       = (type == nil and self.GROUND or type),
            filters    = filters,
            zones      = zones,
            professions = professions,
            obtain_zones = (obtain_zones == nil and {} or obtain_zones)
        })

        table.insert(self.mount_spells, spell_id)
    end
    return self
end

function CollectMe.MountDB:SetProperty(spell_id, property, value)
    for i,v in ipairs(self.mounts) do
        if v.id == spell_id then
            v[property] = value
            return self
        end
    end
end

function CollectMe.MountDB:Get()
    return self.mounts, self.mount_spells
end

function CollectMe.MountDB:ObtainableInZone(id, zones)
    local info = self:GetInfo(id)
    if info ~= nil then
        for i,v in ipairs(info.obtain_zones) do
            for j,v1 in ipairs(zones) do
                if v == v1 then
                    return true
                end
            end
        end
    end
    return false
end

function CollectMe.MountDB:GetZoneMounts(zones)
    local obtainable = {}
    for index, info in ipairs(self:Get()) do
        for i,v in ipairs(info.obtain_zones) do
            for j,v1 in ipairs(zones) do
                if v == v1 then
                    tinsert(obtainable, info)
                    break
                end
            end
        end
    end
    return obtainable
end

function CollectMe.MountDB:GetInfo(spell_id)
    for i,v in ipairs(self.mounts) do
        if v.id == spell_id then
            return v
        end
    end
    return nil
end

function CollectMe.MountDB:RefreshKnown(no_message)
    self.known_mount_count = GetNumCompanions("Mount")
    self.known_mounts = {}

    for i = 1, self.known_mount_count, 1 do
        local _, name, spell_id = GetCompanionInfo("Mount", i)
        table.insert(self.known_mounts, spell_id);
        if CollectMe.db.profile.missing_message.mounts == false and no_message == nil then
            if not CollectMe:IsInTable(self.mount_spells, spell_id) then
                CollectMe:Print(CollectMe.L["Mount"] .. " " .. name .. "("..spell_id..") " .. CollectMe.L["is missing"] .. ". " .. CollectMe.L["Please inform the author"])
            end
        end
    end
end

function CollectMe.MountDB:IsKnown(id)
    return CollectMe:IsInTable(self.known_mounts, id)
end
