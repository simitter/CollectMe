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
        --1.0-4.3
    self:Add(75207, 34956, self.AQUATIC, {}, { 614, 615, 610 }):SetObtainZones(75207, {610}) -- Abyssal Seahorse
    self:Add(60025, 25836, self.FLY) -- Albino Drake
    self:Add(96503, 37800, self.FLY, { tcg = 1 }) -- Amani Dragonhawk
    self:Add(98204, 38261):SetObtainZones(98204, {781})-- Amani Battle Bear
    self:Add(43688, 22464, self.GROUND, { nlo = 1 }):SetObtainZones(43688, {781}) -- Amani War Bear
    self:Add(63844, 22471, self.FLY):SetObtainZones(63844, {492}) -- Argent Hippogryph
    self:Add(67466, 28918):SetObtainZones(67466, {492}) -- Argent Warhorse
    self:Add(96491, 14341):SetObtainZones(96491, {793}) -- Armored Razzashi Raptor
    self:Add(40192, 17890, self.FLY):SetObtainZones(40192, {789}) -- Ashes of Al'ar
    self:Add(41514, 21521, self.FLY):SetObtainZones(41514, {473}) -- Azure Netherwing Drake
    self:Add(59567, 27785, self.FLY):SetObtainZones(59567, {527}) -- Azure Drake
    self:Add(51412, 25335, self.GROUND, { tcg = 1 }) -- Big Battle Bear
    self:Add(58983, 27567, self.GROUND, { nlo = 1 }) -- Big Blizzard Bear
    self:Add(71342, 30989, self.FLY):SetObtainZones(71342, {764}) -- Big Love Rocket
    self:Add(59650, 25831, self.FLY):SetObtainZones(59650, {531}) -- Black Drake
    self:Add(59976, 28040, self.FLY, { nlo = 1 }):SetObtainZones(59976, {535}) -- Black Proto-Drake
    self:Add(26656, 15676, self.GROUND, { nlo = 1 }):SetObtainZones(26656, {261}) -- Black Qiraji Battle Tank
    self:Add(107842, 39561, self.FLY):SetObtainZones(107842, {824}) -- Blazing Drake
    self:Add(74856, 31803, self.FLY, { tcg = 1 }) -- Blazing Hippogryph
    self:Add(72808, 31156, self.FLY):SetObtainZones(72808, {529}) -- Bloodbathed Frostbrood Vanquisher
    self:Add(59568, 25832, self.FLY):SetObtainZones(59568, {527}) -- Blue Drake
    self:Add(59996, 28041, self.FLY):SetObtainZones(59996, {524}) -- Blue Proto-Drake
    self:Add(25953, 15672, self.GROUND, {}, { 766 }):SetObtainZones(25953, {766}) -- Blue Qiraji Battle Tank
    self:Add(39803, 21156, self.FLY):SetObtainZones(39803, {478}) -- Blue Riding Nether Ray
    self:Add(43899, 22265, self.GROUND, { nlo = 1 }):SetObtainZones(43899, {4}) -- Brewfest Ram
    self:Add(59569, 25833, self.FLY):SetObtainZones(59569, {521}) -- Bronze Drake
    self:Add(88748, 35136):SetObtainZones(88748, {720}) -- Brown Riding Camel
    self:Add(58615, 27507, self.FLY, { are = 1, nlo = 1 }) -- Brutal Nether Drake
    self:Add(75614, 31958, self.FLY, { bsm = 1 }) -- Celestial Steed
    self:Add(43927, 22473, self.FLY):SetObtainZones(43927, {467}) -- Cenarion War Hippogryph
    self:Add(41515, 21525, self.FLY):SetObtainZones(41515, {473}) -- Cobalt Netherwing Drake
    self:Add(39315, 21073):SetObtainZones(39315, {477}) -- Cobalt Riding Talbuk
    self:Add(34896, 19375):SetObtainZones(34896, {477}) -- Cobalt War Talbuk
    self:Add(97560, 38046, self.FLY):SetObtainZones(97560, {800}) -- Corrupted Fire Hawk
    self:Add(102514, 38972, self.FLY, { tcg = 1 })  -- Corrupted Hippogryph
    self:Add(73313, 25279):SetObtainZones(73313, {604})  -- Crimson Deathcharger
    self:Add(88990, 37145, self.FLY):SetObtainZones(88990, {301,381,321,362,471,341,480,382,481,504})  -- Dark Phoenix
    self:Add(39316, 21074, self.GROUND, { pvp = 1 }):SetObtainZones(39316, {477})  -- Dark Riding Talbuk
    self:Add(34790, 19303, self.GROUND, { pvp = 1 }):SetObtainZones(34790, {477})  -- Dark War Talbuk
    self:Add(103081, 39060):SetObtainZones(103081, {823})  -- Darkmoon Dancing Bear
    self:Add(64927, 25511, self.FLY, { are = 1, nlo = 1 })         -- Deadly Gladiator's Frost Wyrm
    self:Add(88335, 35757, self.FLY)         -- Drake of the East Wind
    self:Add(88742, 35553, self.FLY):SetObtainZones(88742, {769})         -- Drake of the North Wind
    self:Add(88744, 35755, self.FLY):SetObtainZones(88744, {773})         -- Drake of the South Wind
    self:Add(88741, 35754, self.FLY):SetObtainZones(88741, {709})         -- Drake of the West Wind
    self:Add(110039, 39229, self.FLY):SetObtainZones(110039, {824})   -- Experiment 12-B
    self:Add(113120, 40568, self.FLY, { tcg = 1 })   -- Feldrake
    self:Add(36702, 19250):SetObtainZones(36702, {799})   -- Fiery Warhorse
    self:Add(101542, 38783, self.FLY):SetObtainZones(101542, {800})   -- Flametalon of Alysrazor
    self:Add(97359, 38018, self.FLY):SetObtainZones(97359, {606})   -- Flameward Hippogryph
    self:Add(61451, 28082, self.FLY, nil, nil, { tai = 300 })   -- self.FLYing Carpet
    self:Add(44153, 22719, self.FLY, nil, nil, { eng = 300 })   -- self.FLYing Machine
    self:Add(84751, 34410)   -- Fossilized Raptor
    self:Add(75596, 28063, self.FLY, nil, nil, { tai = 425 })   -- Frosty self.FLYing Carpet
    self:Add(65439, 25593, self.FLY, { are = 1, nlo = 1 })   -- Furious Gladiator's Frost Wyrm
    
    self:Add(49379, 24757):SetObtainZones(49379, {704})   -- Great Brewfest Kodo
    self:Add(61294, 28053, self.FLY):SetObtainZones(61294, {493})   -- Green Proto-Drake
    self:Add(26056, 15679, self.GROUND, {}, { 766 }):SetObtainZones(26056, {766})   -- Green Qiraji Battle Tank
    self:Add(39798, 21152, self.FLY):SetObtainZones(39798, {478})   -- Green Riding Nether Ray
    self:Add(88750, 35135):SetObtainZones(88750, {720})   -- Grey Riding Camel
    self:Add(110051, 40029, self.FLY, { bsm = 1 })  -- Heart of the Aspects
    self:Add(48025, 25159, self.FLY):SetObtainZones(48025, {762})  -- Headless Horseman's Mount
        
    self:Add(72807, 31154, self.FLY):SetObtainZones(72807, {604})  -- Icebound Frostbrood Vanquisher
    self:Add(124659, 43254, self.FLY) -- Imperial Quilen
    self:Add(72286, 31007, self.FLY):SetObtainZones(72286, {604})  -- Invincible
    self:Add(63956, 28953, self.FLY):SetObtainZones(63956, {529})  -- Ironbound Proto-Drake
    self:Add(107845, 39563, self.FLY):SetObtainZones(107845, {824})  -- Life-Binder's Handmaiden
    self:Add(65917, 29344, self.GROUND, { tcg = 1 })  -- Magic Rooster
    self:Add(61309, 28060, self.FLY, nil, nil, { tai = 425 })  -- Magnificent self.FLYing Carpet
    self:Add(44744, 22620, self.FLY, { are = 1, nlo = 1})  -- Merciless Nether Drake
    self:Add(63796, 28890, self.FLY):SetObtainZones(63796, {529})  -- Mimiron's Head
    self:Add(93623, 37231, self.FLY, { tcg = 1 })  -- Mottled Drake
    self:Add(121820, 42498, self.FLY, { rfm = 1 })  -- Obsidian Nightwing
    self:Add(69395, 30346, self.FLY):SetObtainZones(69395, {718})  -- Onyxian Drake
    self:Add(41513, 21520, self.FLY):SetObtainZones(41513, {473})  -- Onyx Netherwing Drake
    self:Add(88718, 35740, self.FLY):SetObtainZones(88718, {640})  -- Phosphorescent Stone Drake
    self:Add(60021, 28042, self.FLY, { nlo = 1 }):SetObtainZones(60021, {535})  -- Plagued Proto-Drake
    self:Add(97493, 38031, self.FLY):SetObtainZones(97493, {800})  -- Pureblood Fire Hawk
    self:Add(41516, 21523, self.FLY):SetObtainZones(41516, {473})  -- Purple Netherwing Drake
    self:Add(39801, 21155, self.FLY):SetObtainZones(39801, {478})  -- Purple Riding Nether Ray
    self:Add(41252, 21473):SetObtainZones(41252, {723})  -- Raven Lord
    self:Add(59570, 25835, self.FLY):SetObtainZones(59570, {488})  -- Red Drake
    self:Add(59961, 28044, self.FLY)  -- Red Proto-Drake
    self:Add(26054, 15681, self.GROUND, {}, { 766 }):SetObtainZones(26054, {766})  -- Red Qiraji Battle Tank
    self:Add(39800, 21158, self.FLY):SetObtainZones(39800, {478})  -- Red Riding Nether Ray
    self:Add(67336, 29794, self.FLY, { are = 1, nlo = 1})  -- Relentless Gladiator's Frost Wyrm
    self:Add(30174, 17158, self.SWIM, { tcg = 1 })  -- Riding Turtle
    self:Add(17481, 10718):SetObtainZones(17481, {765})  -- Rivendare's Deathcharger
    self:Add(63963, 28954, self.FLY):SetObtainZones(63963, {529})  -- Rusted Proto-Drake
    self:Add(101821, 38755, self.FLY, { are = 1 })  -- Ruthless Gladiator's Twilight Drake
    self:Add(93326, 35750, self.FLY)  -- Sandstone Drake
    self:Add(97581, 38048, self.GROUND, { tcg = 1 })  -- Savage Raptor
    self:Add(64731, 29161, self.SWIM)  -- Sea Turtle
    self:Add(39802, 21157, self.FLY):SetObtainZones(39802, {478})  -- Silver Riding Nether Ray
    self:Add(39317, 21075):SetObtainZones(39317, {477})  -- Silver Riding Talbuk
    self:Add(34898, 19378):SetObtainZones(34898, {477})  -- Silver War Talbuk
    self:Add(42776, 21973, self.GROUND, { tcg = 1 })  -- Spectral Tiger
    self:Add(98718, 34955, self.AQUATIC, {}, { 614, 615, 610 })  -- Subdued Seahorse
    self:Add(43900, 22350):SetObtainZones(43900, {27,4})  -- Swift Brewfest Ram
    self:Add(102346, 1281):SetObtainZones(102346, {823})  -- Swift Forest Strider
    self:Add(102350, 1961)  -- Swift Lovebird
    self:Add(101573, 17011, self.GROUND, { tcg = 1 })  -- Swift Shorestrider
    self:Add(37015, 20344, self.FLY, { are = 1, nlo = 1})  -- Swift Nether Drake
    self:Add(24242, 15289, self.GROUND, { nlo = 1 }):SetObtainZones(24242, {793})  -- Swift Razzashi Raptor
    self:Add(42777, 21974, self.GROUND, { tcg = 1 })  -- Swift Spectral Tiger
    self:Add(102349, 16992)  -- Swift Springstrider
    self:Add(46628, 19483):SetObtainZones(46628, {798})  -- Swift White Hawkstrider
    self:Add(49322, 24745, self.GROUND, { rfm = 1, nlo = 1 })  -- Swift Zhevra
    self:Add(96499, 37799):SetObtainZones(96499, {793})  -- Swift Zulian Panther
    self:Add(24252, 15290, self.GROUND, { nlo = 1 }):SetObtainZones(24252, {793})  -- Swift Zulian Tiger
    self:Add(88749, 35134):SetObtainZones(88749, {720})  -- Tan Riding Camel
    self:Add(39318, 21077):SetObtainZones(39318, {477})  -- Tan Riding Talbuk
    self:Add(34899, 19376):SetObtainZones(34899, {477})  -- Tan War Talbuk
    self:Add(60002, 28045, self.FLY):SetObtainZones(60002, {495})  -- Time-Lost Proto-Drake
    self:Add(44151, 22720, self.FLY, nil, nil, { eng = 375 })  -- Turbo-Charged self.FLYing Machine
    self:Add(59571, 27796, self.FLY):SetObtainZones(59571, {531})  -- Twilight Drake
    self:Add(107844, 39562, self.FLY):SetObtainZones(107844, {824})  -- Twilight Harbinger
    self:Add(107203, 39530, self.FLY, { ptm = 1 })  -- Tyrael's Charger
    self:Add(92155, 15672)  -- Ultramarine Qiraji Battle Tank
    self:Add(49193, 24725, self.FLY, { are = 1, nlo = 1})  -- Vengeful Nether Drake
    self:Add(41517, 21522, self.FLY):SetObtainZones(41517, {473})  -- Veridian Netherwing Drake
    self:Add(41518, 21524, self.FLY):SetObtainZones(41518, {473})  -- Violet Netherwing Drake
    self:Add(60024, 28043, self.FLY)  -- Violet Proto-Drake
    self:Add(88746, 35751, self.FLY):SetObtainZones(88746, {768})  -- Vitreous Stone Drake
    self:Add(88331, 35551, self.FLY)  -- Volcanic Stone Drake
    self:Add(54753, 28428):SetObtainZones(54753, {495})  -- White Polar Bear Mount
    self:Add(102488, 37204, self.GROUND, { tcg = 1 })  -- White Riding Camel
    self:Add(39319, 21076):SetObtainZones(39319, {477})  -- White Riding Talbuk
    self:Add(34897, 19377):SetObtainZones(34897, {477})  -- White War Talbuk
    self:Add(98727, 38260, self.FLY, { bsm = 1 })  -- Winged Guardian
    self:Add(74918, 31721, self.GROUND, { tcg = 1 })  -- Wooly White Rhino
    self:Add(46197, 23656, self.FLY, { tcg = 1 })  -- X-51 Nether-Rocket
    self:Add(46199, 23647, self.FLY, { tcg = 1 })  -- X-51 Nether-Rocket X-TREME
    self:Add(75973, 31992, self.FLY, { rfm = 1, nlo = 1 })  -- X-53 Touring Rocket
    self:Add(26055, 15680, self.GROUND, {}, { 766 }):SetObtainZones(26055, {766})  -- Yellow Qiraji Battle Tank
    self:Add(71810, 31047, self.FLY, { are = 1, nlo = 1}) -- Wrathful Gladiator's Frost Wyrm
    --5.1
    self:Add(127180, 43708, self.GROUND, { umo = 1 }) -- Albino Riding Crane
    self:Add(123886, 43090):SetObtainZones(123886, {858}) -- Amber Scorpion
    self:Add(132117, 45521, self.FLY):SetObtainZones(132117, {811,905,903}) -- Ashen Pandaren Phoenix
    self:Add(127170, 46087, self.FLY):SetObtainZones(127170, {896}) -- Astral Cloud Serpent
    self:Add(123992, 41989, self.FLY):SetObtainZones(123992, {806}) -- Azure Cloud Serpent
    self:Add(127174, 43704):SetObtainZones(127174, {811}) -- Azure Riding Crane
    self:Add(118089, 41711):SetObtainZones(118089, {857}) -- Azure Water Strider
    self:Add(127286, 43717):SetObtainZones(127286, {301,321}) -- Black Dragon Turtle
    self:Add(130138, 44836):SetObtainZones(130138, {807}) -- Black Riding Goat
    self:Add(127209, 43709, self.GROUND, { umo = 1 }) -- Black Riding Yak
    self:Add(127220, 43712):SetObtainZones(127220, {809}) -- Blonde Riding Yak
    self:Add(127287, 43718):SetObtainZones(127287, {301,321}) -- Blue Dragon Turtle
    self:Add(129934, 43900):SetObtainZones(129934, {810}) -- Blue Shado-Pan Riding Tiger
    self:Add(127288, 43719):SetObtainZones(127288, {301,321}) -- Brown Dragon Turtle
    self:Add(130086, 44807):SetObtainZones(130086, {807}) -- Brown Riding Goat
    self:Add(127213, 43710, self.GROUND, { umo = 1 }) -- Brown Riding Yak
    self:Add(124550, 38757, self.FLY, { are = 1}) -- Cataclysmic Gladiator's Twilight Drake
    self:Add(127156, 41592, self.FLY) -- Crimson Cloud Serpent
    self:Add(129552, 44633, self.FLY):SetObtainZones(129552, {811,905,903}) -- Crimson Pandaren Phoenix
    self:Add(123160, 42837, self.GROUND, { umo = 1 }) -- Crimson Riding Crane
    self:Add(127271, 43713, self.GROUND, { umo = 1 }) -- Crimson Water Strider
    self:Add(126507, 43637, self.FLY) -- Depleted-Kyparium Rocket
    self:Add(132118, 45520, self.FLY):SetObtainZones(132118, {811,905,903}) -- Emerald Pandaren Phoenix
    self:Add(126508, 43638, self.FLY) -- Geosynchronous World Spinner
    self:Add(123993, 41991, self.FLY):SetObtainZones(123993, {806}) -- Golden Cloud Serpent
    self:Add(127176, 43705):SetObtainZones(127176, {811}) -- Golden Riding Crane
    self:Add(127278, 43716, self.GROUND, { umo = 1 }) -- Golden Water Strider
    self:Add(122708, 42703):SetObtainZones(122708, {809}) -- Grand Expedition Yak
    self:Add(127295, 43723):SetObtainZones(127295, {301,321}) -- Great Black Dragon Turtle
    self:Add(127302, 43724):SetObtainZones(127302, {301,321}) -- Great Blue Dragon Turtle
    self:Add(127308, 43725):SetObtainZones(127308, {301,321}) -- Great Brown Dragon Turtle
    self:Add(127293, 43722):SetObtainZones(127293, {301,321}) -- Great Green Dragon Turtle
    self:Add(127310, 43726):SetObtainZones(127310, {301,321}) -- Great Purple Dragon Turtle
    self:Add(120822, 42352):SetObtainZones(120822, {301,321}) -- Great Red Dragon Turtle
    self:Add(120395, 42250):SetObtainZones(120395, {301,321}) -- Green Dragon Turtle
    self:Add(129932, 44759):SetObtainZones(129932, {810}) -- Green Shado-Pan Riding Tiger
    self:Add(127216, 43711):SetObtainZones(127216, {809}) -- Grey Riding Yak
    self:Add(127169, 43697, self.FLY, { umo = 1 }) -- Heavenly Azure Cloud Serpent
    self:Add(127161, 43692, self.FLY) -- Heavenly Crimson Cloud Serpent
    self:Add(127164, 43693, self.FLY, { umo = 1 }) -- Heavenly Golden Cloud Serpent
    self:Add(127165, 43695, self.FLY, { umo = 1 }) -- Heavenly Jade Cloud Serpent
    self:Add(127158, 43689, self.FLY):SetObtainZones(127158, {809}) -- Heavenly Onyx Cloud Serpent
    self:Add(113199, 40590, self.FLY):SetObtainZones(113199, {806}) -- Jade Cloud Serpent
    self:Add(121837, 42502, self.FLY) -- Jade Panther
    self:Add(127274, 43714, self.GROUND, { umo = 1 }) -- Jade Water Strider
    self:Add(120043, 42185, self.FLY) -- Jeweled Onyx Panther
    self:Add(127178, 43707, self.GROUND, { umo = 1 }) -- Jungle Riding Crane
    self:Add(127154, 41990, self.FLY):SetObtainZones(127154, {810}) -- Onyx Cloud Serpent
    self:Add(127272, 43715, self.GROUND, { umo = 1 }) -- Orange Water Strider
    self:Add(127289, 43910):SetObtainZones(127289, {301,321}) -- Purple Dragon Turtle
    self:Add(127290, 43721):SetObtainZones(127290, {301,321}) -- Red Dragon Turtle
    self:Add(130092, 44808, self.FLY):SetObtainZones(130092, {811}) -- Red self.FLYing Cloud
    self:Add(129935, 44757):SetObtainZones(129935, {810}) -- Red Shado-Pan Riding Tiger
    self:Add(127177, 43706):SetObtainZones(127177, {811}) -- Regal Riding Crane
    self:Add(121838, 42499, self.FLY) -- Ruby Panther
    self:Add(121836, 42500, self.FLY) -- Sapphire Panther
    self:Add(130965, 45264):SetObtainZones(130965, {807}) -- Son of Galleon
    self:Add(121839, 42501, self.FLY) -- Sunstone Panther
    self:Add(129918, 43686, self.FLY):SetObtainZones(129918, {905,903}) -- Thundering August Cloud Serpent
    self:Add(124408, 43562, self.FLY):SetObtainZones(124408, {301,321}) -- Thundering Jade Cloud Serpent
    self:Add(132036, 45797, self.FLY):SetObtainZones(132036, {811}) -- Thundering Ruby Cloud Serpent
    self:Add(132119, 45522, self.FLY):SetObtainZones(132119, {811,905,903}) -- Violet Pandaren Phoenix
    self:Add(130137, 44837):SetObtainZones(130137, {807}) -- White Riding Goat
    self:Add(123182, 41089, self.GROUND, { umo = 1 }) -- White Riding Yak
    self:Add(133023, 42147, self.FLY) -- Jade Pandaren Kite
    self:Add(134573, 46729, self.FLY, { bsm = 1 }) -- Swift Windsteed
    --5.2
    self:Add(138643, 47827):SetObtainZones(138643, {929}) -- Reins of the Green Primal Raptor
    self:Add(138642, 47828):SetObtainZones(138642, {929}) -- Reins of the Black Primal Raptor
    self:Add(138641, 47826):SetObtainZones(138641, {929}) -- Reins of the Red Primal Raptor
    self:Add(138640, 47825):SetObtainZones(138640, {858}) -- Reins of the Bone-White Primal Raptor
    self:Add(138426, 47717) -- Reins of the Jade Primordial Direhorn
    self:Add(138424, 47718) -- Reins of the Amber Primordial Direhorn
    self:Add(138425, 47715) -- Reins of the Slate Primordial Direhorn
    self:Add(138423, 47716):SetObtainZones(138423, {929}) -- Reins of the Cobalt Primordial Direhorn
    self:Add(140250, 48101):SetObtainZones(140250, {928}) -- Crimson Primal Direhorn
    self:Add(140249, 48100):SetObtainZones(140249, {928}) -- Golden Primal Direhorn
    self:Add(136471, 47238):SetObtainZones(136471, {930}) -- Spawn of Horridon
    self:Add(136400, 47256, self.FLY):SetObtainZones(136400, {930}) -- Armored Riding Pteradactyl
    self:Add(136505, 48014, self.FLY, { tcg = 1 }) -- Ghastly Charger's Skull
    self:Add(139442, 47981, self.FLY):SetObtainZones(139442, {928}) -- Thundering Cobalt Cloud Serpent
    --5.3
    self:Add(142641, 48858) -- Brawler's Burly Mushan Beast
    self:Add(142073, nil, self.FLY, { ptm = 1 }) -- Hearthsteed
    self:Add(142878, 48714, self.FLY, { umo = 1 }) -- Enchanted Fey Dragon

    -- Alliance Mounts
    if CollectMe.FACTION == "Alliance" then
        self:Add(60114, 27820):SetObtainZones(60114, {504}) -- Armored Brown Bear
        self:Add(61229, 27913, self.FLY):SetObtainZones(61229, {504}) -- Armored Snowy Gryphon
        self:Add(22719, 14372, self.GROUND, { pvp = 1 }):SetObtainZones(22719, {301}) -- Black Battlestrider
        self:Add(470, 2402):SetObtainZones(470, {301,40})   -- Black Stallion Bridle
        self:Add(60118, 27818):SetObtainZones(60118, {321,362,480,382}) -- Black War Bear
        self:Add(48027, 23928, self.GROUND, { pvp = 1 }):SetObtainZones(48027, {301}) -- Black War Elekk
        self:Add(59785, 27247):SetObtainZones(59785, {501}) -- Black War Mammoth
        self:Add(22720, 14577, self.GROUND, { pvp = 1 }):SetObtainZones(22720, {301}) -- Black War Ram
        self:Add(22717, 14337, self.GROUND, { pvp = 1 }):SetObtainZones(22717, {301}) -- Black War Steed
        self:Add(22723, 14330, self.GROUND, { pvp = 1 }):SetObtainZones(22723, {301}) -- Black War Tiger
        self:Add(61996, 27525, self.FLY) -- Blue Dragonhawk
        self:Add(10969, 6569):SetObtainZones(10969, {27}) -- Blue Mechanostrider
        self:Add(34406, 17063):SetObtainZones(34406, {471}) -- Brown Elekk
        self:Add(458, 2404):SetObtainZones(458, {301,40,141,30})     -- Brown Horse
        self:Add(6899, 2785):SetObtainZones(6899, {27})  -- Brown Ram
        self:Add(6648, 2405):SetObtainZones(6648, {301,40,141,30})  -- Chestnut Mare
        self:Add(68187, 29937, self.GROUND, { nlo = 1 }):SetObtainZones(68187, {543}) -- Crusader's White Warhorse
        self:Add(63637, 29256):SetObtainZones(63637, {492}) -- Darnassian Nightsaber
        self:Add(32239, 17694, self.FLY):SetObtainZones(32239, {301,504,486,473,465}) -- Ebon Gryphon
        self:Add(63639, 29255):SetObtainZones(63639, {492}) -- Exodar Elekk
        self:Add(63638, 28571):SetObtainZones(63638, {492}) -- Gnomeregan Mechanostrider
        self:Add(32235, 17697, self.FLY):SetObtainZones(32235, {301,504,486,473,465}) -- Golden Gryphon
        self:Add(90621, 36213):SetObtainZones(90621, {301,504,481,471,341,381}) -- Golden King
        self:Add(61465, 27241):SetObtainZones(61465, {532}) -- Grand Black War Mammoth
        self:Add(135416, nil, self.FLY):SetObtainZones(135416, {857}) -- Grand Armored Gryphon
        self:Add(136163, nil, self.FLY):SetObtainZones(136163, {857}) -- Grand Gryphon
        self:Add(61470, 27242):SetObtainZones(61470, {495}) -- Grand Ice Mammoth
        self:Add(35710, 19869):SetObtainZones(35710, {471}) -- Gray Elekk
        self:Add(6777, 2736):SetObtainZones(6777, {27})  -- Gray Ram
        self:Add(35713, 19871):SetObtainZones(35713, {471}) -- Great Blue Elekk
        self:Add(35712, 19873):SetObtainZones(35712, {471}) -- Great Green Elekk
        self:Add(35714, 19872):SetObtainZones(35714, {471}) -- Great Purple Elekk
        self:Add(65637, 28606):SetObtainZones(65637, {492}) -- Great Red Elekk
        self:Add(17453, 10661):SetObtainZones(17453, {27}) -- Green Mechanostrider
        self:Add(59799, 27248):SetObtainZones(59799, {495}) -- Ice Mammoth
        self:Add(63636, 29258):SetObtainZones(63636, {492}) -- Ironforge Ram
        self:Add(60424, 25870) -- Mekgineer's Chopper
        self:Add(103195, 39096):SetObtainZones(103195, {381}) -- Mountain Horse
        self:Add(472, 2409):SetObtainZones(472, {301,40,141,30})   -- Pinto
        self:Add(35711, 19870):SetObtainZones(35711, {471}) -- Purple Elekk
        self:Add(66090, 28888):SetObtainZones(66090, {492}) -- Quel'dorei Steed
        self:Add(10873, 9473):SetObtainZones(10873, {27}) -- Red Mechanostrider
        self:Add(66087, 22474, self.FLY):SetObtainZones(66087, {492}) -- Silver Covenant Hippogryph
        self:Add(32240, 17696, self.FLY):SetObtainZones(32240, {301,504,486,473,465}) -- Snowy Gryphon
        self:Add(92231, 37160):SetObtainZones(92231, {709}) -- Spectral Steed
        self:Add(107516, 39546, self.FLY) -- Spectral Gryphon
        self:Add(10789, 6444):SetObtainZones(10789, {381}) -- Spotted Frostsaber
        self:Add(23510, 14777, self.GROUND, { pvp = 1 }):SetObtainZones(23510, {401}) -- Stormpike Battle Charger
        self:Add(63232, 28912):SetObtainZones(63232, {492}) -- Stormwind Steed
        self:Add(66847, 29755):SetObtainZones(66847, {381}) -- Striped Dawnsaber
        self:Add(8394, 6080):SetObtainZones(8394, {381})  -- Striped Frostsaber
        self:Add(10793, 6448):SetObtainZones(10793, {381})  -- Striped Nightsaber
        self:Add(68057, 29284, self.GROUND, { nlo = 1 }):SetObtainZones(68057, {543})  -- Swift Alliance Steed
        self:Add(32242, 17759, self.FLY):SetObtainZones(32242, {301,504,486,473,465})  -- Swift Blue Gryphon
        self:Add(23238, 14347):SetObtainZones(23238, {27})  -- Swift Brown Ram
        self:Add(23229, 14583):SetObtainZones(23229, {30,301,141})  -- Swift Brown Steed
        self:Add(23221, 14331):SetObtainZones(23221, {381})  -- Swift Frostsaber
        self:Add(23239, 14576):SetObtainZones(23239, {27})  -- Swift Gray Ram
        self:Add(65640, 29043):SetObtainZones(65640, {492})  -- Swift Gray Steed
        self:Add(32290, 17703, self.FLY):SetObtainZones(32290, {301,504,486,473,465})  -- Swift Green Gryphon
        self:Add(23225, 14374):SetObtainZones(23225, {27})  -- Swift Green Mechanostrider
        self:Add(23219, 14332):SetObtainZones(23219, {381})  -- Swift Mistsaber
        self:Add(103196, 39095):SetObtainZones(103196, {381})  -- Swift Mountain Horse
        self:Add(65638, 14333):SetObtainZones(65638, {492})  -- Swift Moonsaber
        self:Add(23227, 14582):SetObtainZones(23227, {30,301,141})  -- Swift Palomino
        self:Add(32292, 17717, self.FLY):SetObtainZones(32292, {301,504,486,473,465})  -- Swift Purple Gryphon
        self:Add(32289, 17718, self.FLY):SetObtainZones(32289, {301,504,486,473,465})  -- Swift Red Gryphon
        self:Add(23338, 14632):SetObtainZones(23338, {381})  -- Swift Stormsaber
        self:Add(65643, 28612):SetObtainZones(65643, {492})  -- Swift Violet Ram
        self:Add(23223, 14376):SetObtainZones(23223, {27})  -- Swift White Mechanostrider
        self:Add(23240, 14346):SetObtainZones(23240, {27})  -- Swift White Ram
        self:Add(23228, 14338):SetObtainZones(23228, {30,301,141})  -- Swift White Steed
        self:Add(23222, 14377):SetObtainZones(23222, {27})  -- Swift Yellow Mechanostrider
        self:Add(61425, 27237):SetObtainZones(61425, {504})  -- Traveler's Tundra Mammoth
        self:Add(65642, 14375):SetObtainZones(65642, {492})  -- Turbostrider
        self:Add(17454, 9476):SetObtainZones(17454, {27})  -- Unpainted Mechanostrider
        self:Add(100332, 38668, self.GROUND, { pvp = 1 }) -- Vicious War Steed
        self:Add(6898, 2786):SetObtainZones(6898, {27})   -- White Ram
        self:Add(16083, 2410, self.GROUND, { nlo = 1 })  -- White Stallion
        self:Add(17229, 10426):SetObtainZones(17229, {281})  -- Winterspring Frostsaber
        self:Add(59791, 27243):SetObtainZones(59791, {504})  -- Wooly Mammoth
        self:Add(130985, 45271, self.FLY) -- Pandaren Kite
        self:Add(142478, 48816, self.FLY) -- Armored Blue Dragonhawk
    end

    -- Horde Mounts
    if CollectMe.FACTION == "Horde" then
        self:Add(61230, 27914, self.FLY):SetObtainZones(61230, {504}) -- Armored Blue Wind Rider
        self:Add(60116, 27821):SetObtainZones(60116, {504}) -- Armored Brown Bear
        self:Add(35022, 19478):SetObtainZones(35022, {462}) -- Black Hawkstrider
        self:Add(64977, 29130):SetObtainZones(64977, {20}) -- Black Skeletal Horse
        self:Add(60119, 27819):SetObtainZones(60119, {381,471,341,301}) -- Black War Bear
        self:Add(22718, 14348, self.GROUND, { pvp = 1 }):SetObtainZones(22718, {321}) -- Black War Kodo
        self:Add(59788, 27245):SetObtainZones(59788, {501}) -- Black War Mammoth
        self:Add(22721, 14388, self.GROUND, { pvp = 1 }):SetObtainZones(22721, {321}) -- Black War Raptor
        self:Add(22724, 14334, self.GROUND, { pvp = 1 }):SetObtainZones(22724, {321}) -- Black War Wolf
        self:Add(64658, 207):SetObtainZones(64658, {321}) -- Black Wolf
        self:Add(35020, 19480):SetObtainZones(35020, {462}) -- Blue Hawkstrider
        self:Add(17463, 10671):SetObtainZones(17463, {20}) -- Blue Skeletal Horse
        self:Add(32244, 17700, self.FLY):SetObtainZones(32244, {321,504,465,473,486}) -- Blue Wind Rider
        self:Add(18990, 11641):SetObtainZones(18990, {9}) -- Brown Kodo
        self:Add(17464, 10672):SetObtainZones(17464, {20}) -- Brown Skeletal Horse
        self:Add(6654, 2328):SetObtainZones(6654, {321}) -- Brown Wolf
        self:Add(68188, 29938, self.GROUND, { nlo = 1 }):SetObtainZones(68188, {543}) -- Crusader's Black Warhorse
        self:Add(63635, 29261):SetObtainZones(63635, {492}) -- Darkspear Raptor
        self:Add(6653, 2327):SetObtainZones(6653, {321}) -- Dire Wolf
        self:Add(8395, 4806):SetObtainZones(8395, {4}) -- Emerald Raptor
        self:Add(63643, 29257):SetObtainZones(63643, {492}) -- Forsaken Warhorse
        self:Add(23509, 14776, self.GROUND, { pvp = 1 }):SetObtainZones(23509, {401,24}) -- Frostwolf Howler
        self:Add(61467, 27240):SetObtainZones(61467, {532}) -- Grand Black War Mammoth
        self:Add(61469, 27239):SetObtainZones(61469, {495}) -- Grand Ice Mammoth
        self:Add(135418, nil, self.FLY):SetObtainZones(135418, {857}) -- Grand Armored Wyvern
        self:Add(136164, nil, self.FLY):SetObtainZones(136164, {857}) -- Grand Wyvern
        self:Add(18989, 12246):SetObtainZones(18989, {9}) -- Gray Kodo
        self:Add(23249, 14578):SetObtainZones(23249, {9}) -- Great Brown Kodo
        self:Add(65641, 28556):SetObtainZones(65641, {492}) -- Great Golden Kodo
        self:Add(23248, 14579):SetObtainZones(23248, {9}) -- Great Gray Kodo
        self:Add(23247, 14349):SetObtainZones(23247, {9}) -- Great White Kodo
        self:Add(17465, 10720):SetObtainZones(17465, {20}) -- Green Skeletal Warhorse
        self:Add(32245, 17701, self.FLY):SetObtainZones(32245, {321,504,465,473,486}) -- Green Wind Rider
        self:Add(87090, 35249):SetObtainZones(87090, {321}) -- Goblin Trike
        self:Add(87091, 35250):SetObtainZones(87091, {321}) -- Goblin Turbo-Trike
        self:Add(59797, 27246):SetObtainZones(59797, {495}) -- Ice Mammoth
        self:Add(93644, 37138):SetObtainZones(93644, {321,504,362,382,480,481}) -- Kor'kron Annihilator
        self:Add(55531, 25871) -- Mechano-Hog
        self:Add(66846, 29754):SetObtainZones(66846, {20}) -- Ochre Skeletal Warhorse
        self:Add(63640, 29260):SetObtainZones(63640, {492}) -- Orgrimmar Wolf
        self:Add(35018, 19479):SetObtainZones(35018, {462}) -- Purple Hawkstrider
        self:Add(23246, 10721):SetObtainZones(23246, {20}) -- Purple Skeletal Warhorse
        self:Add(61997, 28402, self.FLY) -- Red Dragonhawk
        self:Add(34795, 18696):SetObtainZones(34795, {462}) -- Red Hawkstrider
        self:Add(17462, 10670):SetObtainZones(17462, {20}) -- Red Skeletal Horse
        self:Add(22722, 10719, self.GROUND, { pvp = 1 }):SetObtainZones(22722, {321}) -- Red Skeletal Warhorse
        self:Add(63642, 29262):SetObtainZones(63642, {492}) -- Silvermoon Hawkstrider
        self:Add(107517, 39547, self.FLY) -- Spectral Wind Rider
        self:Add(92232, 37159):SetObtainZones(92232, {709}) -- Spectral Wolf
        self:Add(66088, 29696, self.FLY):SetObtainZones(66088, {492}) -- Sunreaver Dragonhawk
        self:Add(66091, 28889):SetObtainZones(66091, {492}) -- Sunreaver Hawkstrider
        self:Add(23241, 14339):SetObtainZones(23241, {4}) -- Swift Blue Raptor
        self:Add(23250, 14573):SetObtainZones(23250, {321}) -- Swift Brown Wolf
        self:Add(65646, 14335):SetObtainZones(65646, {492}) -- Swift Burgundy Wolf
        self:Add(23252, 14574):SetObtainZones(23252, {321}) -- Swift Gray Wolf
        self:Add(35025, 19484):SetObtainZones(35025, {462}) -- Swift Green Hawkstrider
        self:Add(32295, 17720, self.FLY):SetObtainZones(32295, {321,504,465,473,486}) -- Swift Green Wind Rider
        self:Add(68056, 29283, self.GROUND, { nlo = 1 }):SetObtainZones(68056, {543}) -- Swift Horde Wolf
        self:Add(23242, 14344):SetObtainZones(23242, {4}) -- Swift Olive Raptor
        self:Add(23243, 14342):SetObtainZones(23243, {4}) -- Swift Orange Raptor
        self:Add(33660, 18697):SetObtainZones(33660, {462}) -- Swift Pink Hawkstrider
        self:Add(35027, 19482):SetObtainZones(35027, {462}) -- Swift Purple Hawkstrider
        self:Add(65644, 14343):SetObtainZones(65644, {492}) -- Swift Purple Raptor
        self:Add(32297, 17721, self.FLY):SetObtainZones(32297, {321,504,465,473,486}) -- Swift Purple Wind Rider
        self:Add(65639, 28607):SetObtainZones(65639, {492}) -- Swift Red Hawkstrider
        self:Add(32246, 17719, self.FLY):SetObtainZones(32246, {321,504,465,473,486}) -- Swift Red Wind Rider
        self:Add(23251, 14575):SetObtainZones(23251, {321}) -- Swift Timber Wolf
        self:Add(35028, 20359, self.GROUND, { pvp = 1 }):SetObtainZones(35028, {321}) -- Swift Warstrider
        self:Add(32296, 17722, self.FLY):SetObtainZones(32296, {321,504,465,473,486}) -- Swift Yellow Wind Rider
        self:Add(32243, 17699, self.FLY):SetObtainZones(32243, {321,504,465,473,486}) -- Tawny Wind Rider
        self:Add(63641, 29259):SetObtainZones(63641, {492}) -- Thunder Bluff Kodo
        self:Add(580, 247):SetObtainZones(580, {321}) -- Timber Wolf
        self:Add(61447, 27238):SetObtainZones(61447, {504}) -- Traveler's Tundra Mammoth
        self:Add(10796, 6472):SetObtainZones(10796, {4}) -- Turquoise Raptor
        self:Add(64659, 29102):SetObtainZones(64659, {201}) -- Venomhide Ravasaur
        self:Add(100333, 38607, self.GROUND, { pvp = 1 }) -- Vicious War Wolf
        self:Add(10799, 6473):SetObtainZones(10799, {4}) -- Violet Raptor
        self:Add(64657, 12241):SetObtainZones(64657, {9}) -- White Kodo
        self:Add(65645, 28605):SetObtainZones(65645, {492}) -- White Skeletal Warhorse
        self:Add(59793, 27244):SetObtainZones(59793, {504}) -- Wooly Mammoth
        self:Add(118737, 41903, self.FLY) -- Pandaren Kite
        self:Add(18992, 12242, self.GROUND, { nlo = 1 }) -- Teal Kodo
        self:Add(142266, 48815, self.FLY) -- Armored Red Dragonhawk
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

function CollectMe.MountDB:SetObtainZones(spell_id, value)
    return self:SetProperty(spell_id, "obtain_zones", value)
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
