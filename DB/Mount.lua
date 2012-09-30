CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.MOUNTS = {}
CollectMe.MOUNT_SPELLS = {}

local GROUND = 1
local FLY = 2
local SWIM = 3
local AQUATIC = 4

function CollectMe:BuildMountDB()
    -- Common Mounts
    self:AddMount(75207, 34956, AQUATIC, {}, { 614, 615, 610 }) -- Abyssal Seahorse
    self:AddMount(60025, 25836, FLY) -- Albino Drake
    self:AddMount(96503, 37800, FLY, { tcg = 1 }) -- Amani Dragonhawk
    self:AddMount(98204, 38261) -- Amani Battle Bear
    self:AddMount(43688, 22464, GROUND, { nlo = 1 }) -- Amani War Bear
    self:AddMount(63844, 22471) -- Argent Hippogryph
    self:AddMount(67466, 28918) -- Argent Warhorse
    self:AddMount(96491, 14341) -- Armored Razzashi Raptor
    self:AddMount(40192, 17890, FLY) -- Ashes of Al'ar
    self:AddMount(41514, 21521, FLY) -- Azure Netherwing Drake
    self:AddMount(59567, 27785, FLY) -- Azure Drake
    self:AddMount(51412, 25335, GROUND, { tcg = 1 }) -- Big Battle Bear
    self:AddMount(58983, 27567, GROUND, { nlo = 1 }) -- Big Blizzard Bear
    self:AddMount(71342, 30989, FLY) -- Big Love Rocket
    self:AddMount(59650, 25831, FLY) -- Black Drake
    self:AddMount(59976, 28040, FLY, { nlo = 1 }) -- Black Proto-Drake
    self:AddMount(26656, 15676, GROUND, { nlo = 1 }) -- Black Qiraji Battle Tank
    self:AddMount(107842, 39561, FLY) -- Blazing Drake
    self:AddMount(74856, 31803, FLY, { tcg = 1 }) -- Blazing Hippogryph
    self:AddMount(72808, 31156, FLY) -- Bloodbathed Frostbrood Vanquisher
    self:AddMount(59568, 25832, FLY) -- Blue Drake
    self:AddMount(59996, 28041, FLY) -- Blue Proto-Drake
    self:AddMount(25953, 15672, GROUND, {}, { 766 }) -- Blue Qiraji Battle Tank
    self:AddMount(39803, 21156, FLY) -- Blue Riding Nether Ray
    self:AddMount(43899, 22265, GROUND, { nlo = 1 }) -- Brewfest Ram
    self:AddMount(59569, 25833, FLY) -- Bronze Drake
    self:AddMount(88748, 35136) -- Brown Riding Camel
    self:AddMount(58615, 27507, FLY, { are = 1, nlo = 1 }) -- Brutal Nether Drake
    self:AddMount(75614, 31958, FLY, { bsm = 1 }) -- Celestial Steed
    self:AddMount(43927, 22473, FLY) -- Cenarion War Hippogryph
    self:AddMount(41515, 21525, FLY) -- Cobalt Netherwing Drake
    self:AddMount(39315, 21073) -- Cobalt Riding Talbuk
    self:AddMount(34896, 19375) -- Cobalt War Talbuk
    self:AddMount(97560, 38046, FLY) -- Corrupted Fire Hawk
    self:AddMount(102514, 38972, FLY, { tcg = 1 })  -- Corrupted Hippogryph
    self:AddMount(73313, 25279)  -- Crimson Deathcharger
    self:AddMount(88990, 37145, FLY)  -- Dark Phoenix
    self:AddMount(39316, 21074, GROUND, { pvp = 1 })  -- Dark Riding Talbuk
    self:AddMount(34790, 19303, GROUND, { pvp = 1 })  -- Dark War Talbuk
    self:AddMount(103081, 39060)  -- Darkmoon Dancing Bear
    self:AddMount(64927, 25511, FLY, { are = 1, nlo = 1 })         -- Deadly Gladiator's Frost Wyrm
    self:AddMount(88335, 35757, FLY)         -- Drake of the East Wind
    self:AddMount(88742, 35553, FLY)         -- Drake of the North Wind
    self:AddMount(88744, 35755, FLY)         -- Drake of the South Wind
    self:AddMount(88741, 35754, FLY)         -- Drake of the West Wind
    self:AddMount(110039, 39229, FLY)   -- Experiment 12-B
    self:AddMount(113120, 40568, FLY, { tcg = 1 })   -- Feldrake
    self:AddMount(36702, 19250)   -- Fiery Warhorse
    self:AddMount(101542, 38783, FLY)   -- Flametalon of Alysrazor
    self:AddMount(97359, 38018, FLY)   -- Flameward Hippogryph
    self:AddMount(61451, 28082, FLY, nil, nil, { tai = 300 })   -- Flying Carpet
    self:AddMount(44153, 22719, FLY, nil, nil, { eng = 300 })   -- Flying Machine
    self:AddMount(84751, 34410)   -- Fossilized Raptor
    self:AddMount(75596, 28063, FLY, nil, nil, { tai = 425 })   -- Frosty Flying Carpet
    self:AddMount(65439, 25593, FLY, { are = 1, nlo = 1 })   -- Furious Gladiator's Frost Wyrm
    self:AddMount(49379, 24757)   -- Great Brewfest Kodo
    self:AddMount(61294, 28053, FLY)   -- Green Proto-Drake
    self:AddMount(26056, 15679, GROUND, {}, { 766 })   -- Green Qiraji Battle Tank
    self:AddMount(39798, 21152, FLY)   -- Green Riding Nether Ray
    self:AddMount(88750, 35135)   -- Grey Riding Camel
    self:AddMount(110051, 40029, FLY, { bsm = 1 })  -- Heart of the Aspects
    self:AddMount(48025, 25159, FLY)  -- Headless Horseman's Mount
    self:AddMount(72807, 31154, FLY)  -- Icebound Frostbrood Vanquisher
    self:AddMount(124659, 43254, FLY) -- Imperial Quilen
    self:AddMount(72286, 31007, FLY)  -- Invincible
    self:AddMount(63956, 28953, FLY)  -- Ironbound Proto-Drake
    self:AddMount(107845, 39563, FLY)  -- Life-Binder's Handmaiden
    self:AddMount(65917, 29344, GROUND, { tcg = 1 })  -- Magic Rooster
    self:AddMount(61309, 28060, FLY, nil, nil, { tai = 425 })  -- Magnificent Flying Carpet
    self:AddMount(44744, 22620, FLY, { are = 1, nlo = 1})  -- Merciless Nether Drake
    self:AddMount(63796, 28890, FLY)  -- Mimiron's Head
    self:AddMount(93623, 37231, FLY, { tcg = 1 })  -- Mottled Drake
    self:AddMount(121820, 42498, FLY, { rfm = 1 })  -- Obsidian Nightwing
    self:AddMount(69395, 30346, FLY)  -- Onyxian Drake
    self:AddMount(41513, 21520, FLY)  -- Onyx Netherwing Drake
    self:AddMount(88718, 35740, FLY)  -- Phosphorescent Stone Drake
    self:AddMount(60021, 28042, FLY, { nlo = 1 })  -- Plagued Proto-Drake
    self:AddMount(97493, 38031, FLY)  -- Pureblood Fire Hawk
    self:AddMount(41516, 21523, FLY)  -- Purple Netherwing Drake
    self:AddMount(39801, 21155, FLY)  -- Purple Riding Nether Ray
    self:AddMount(41252, 21473)  -- Raven Lord
    self:AddMount(59570, 25835, FLY)  -- Red Drake
    self:AddMount(59961, 28044, FLY)  -- Red Proto-Drake
    self:AddMount(26054, 15681, GROUND, {}, { 766 })  -- Red Qiraji Battle Tank
    self:AddMount(39800, 21158, FLY)  -- Red Riding Nether Ray
    self:AddMount(67336, 29794, FLY, { are = 1, nlo = 1})  -- Relentless Gladiator's Frost Wyrm
    self:AddMount(30174, 17158, SWIM, { tcg = 1 })  -- Riding Turtle
    self:AddMount(17481, 10718)  -- Rivendare's Deathcharger
    self:AddMount(63963, 28954, FLY)  -- Rusted Proto-Drake
    self:AddMount(101821, 38755, FLY, { are = 1 })  -- Ruthless Gladiator's Twilight Drake
    self:AddMount(93326, 35750, FLY)  -- Sandstone Drake
    self:AddMount(97581, 38048, GROUND, { tcg = 1 })  -- Savage Raptor
    self:AddMount(64731, 29161, SWIM)  -- Sea Turtle
    self:AddMount(39802, 21157, FLY)  -- Silver Riding Nether Ray
    self:AddMount(39317, 21075)  -- Silver Riding Talbuk
    self:AddMount(34898, 19378)  -- Silver War Talbuk
    self:AddMount(42776, 21973, GROUND, { tcg = 1 })  -- Spectral Tiger
    self:AddMount(98718, 34955, AQUATIC, {}, { 614, 615, 610 })  -- Subdued Seahorse
    self:AddMount(43900, 22350)  -- Swift Brewfest Ram
    self:AddMount(102346, 1281)  -- Swift Forest Strider
    self:AddMount(102350, 1961)  -- Swift Lovebird
    self:AddMount(101573, 17011, GROUND, { tcg = 1 })  -- Swift Shorestrider
    self:AddMount(37015, 20344, FLY, { are = 1, nlo = 1})  -- Swift Nether Drake
    self:AddMount(24242, 15289, GROUND, { nlo = 1 })  -- Swift Razzashi Raptor
    self:AddMount(42777, 21974, GROUND, { tcg = 1 })  -- Swift Spectral Tiger
    self:AddMount(102349, 16992)  -- Swift Springstrider
    self:AddMount(46628, 19483)  -- Swift White Hawkstrider
    self:AddMount(49322, 24745, GROUND, { rfm = 1, nlo = 1 })  -- Swift Zhevra
    self:AddMount(96499, 37799)  -- Swift Zulian Panther
    self:AddMount(24252, 15290, GROUND, { nlo = 1 })  -- Swift Zulian Tiger
    self:AddMount(88749, 35134)  -- Tan Riding Camel
    self:AddMount(39318, 21077)  -- Tan Riding Talbuk
    self:AddMount(34899, 19376)  -- Tan War Talbuk
    self:AddMount(60002, 28045, FLY)  -- Time-Lost Proto-Drake
    self:AddMount(44151, 22720, FLY, nil, nil, { eng = 375 })  -- Turbo-Charged Flying Machine
    self:AddMount(59571, 27796, FLY)  -- Twilight Drake
    self:AddMount(107844, 39562, FLY)  -- Twilight Harbinger
    self:AddMount(107203, 39530, FLY, { ptm = 1 })  -- Tyrael's Charger
    self:AddMount(92155, 15672)  -- Ultramarine Qiraji Battle Tank
    self:AddMount(49193, 24725, FLY, { are = 1, nlo = 1})  -- Vengeful Nether Drake
    self:AddMount(41517, 21522, FLY)  -- Veridian Netherwing Drake
    self:AddMount(41518, 21524, FLY)  -- Violet Netherwing Drake
    self:AddMount(60024, 28043, FLY)  -- Violet Proto-Drake
    self:AddMount(88746, 35751, FLY)  -- Vitreous Stone Drake
    self:AddMount(88331, 35551, FLY)  -- Volcanic Stone Drake
    self:AddMount(54753, 28428)  -- White Polar Bear Mount
    self:AddMount(102488, 37204, GROUND, { tcg = 1 })  -- White Riding Camel
    self:AddMount(39319, 21076)  -- White Riding Talbuk
    self:AddMount(34897, 19377)  -- White War Talbuk
    self:AddMount(98727, 38260, FLY, { bsm = 1 })  -- Winged Guardian
    self:AddMount(74918, 31721, GROUND, { tcg = 1 })  -- Wooly White Rhino
    self:AddMount(46197, 23656, FLY, { tcg = 1 })  -- X-51 Nether-Rocket
    self:AddMount(46199, 23647, FLY, { tcg = 1 })  -- X-51 Nether-Rocket X-TREME
    self:AddMount(75973, 31992, FLY, { rfm = 1, nlo = 1 })  -- X-53 Touring Rocket
    self:AddMount(26055, 15680, GROUND, {}, { 766 })  -- Yellow Qiraji Battle Tank
    self:AddMount(71810, 31047, FLY, { are = 1, nlo = 1}) -- Wrathful Gladiator's Frost Wyrm
    self:AddMount(127180, 43708) -- Albino Riding Crane
    self:AddMount(123886, 43090) -- Amber Scorpion
    self:AddMount(132117, 45521, FLY) -- Ashen Pandaren Phoenix
    self:AddMount(127170, 46087, FLY) -- Astral Cloud Serpent
    self:AddMount(123992, 41989, FLY) -- Azure Cloud Serpent
    self:AddMount(127174, 43704) -- Azure Riding Crane
    self:AddMount(118089, 41711) -- Azure Water Strider
    self:AddMount(127286, 43717) -- Black Dragon Turtle
    self:AddMount(130138, 44836) -- Black Riding Goat
    self:AddMount(127209, 43709) -- Black Riding Yak
    self:AddMount(127220, 43712) -- Blonde Riding Yak
    self:AddMount(127287, 43718) -- Blue Dragon Turtle
    self:AddMount(129934, 43900) -- Blue Shado-Pan Riding Tiger
    self:AddMount(127288, 43719) -- Brown Dragon Turtle
    self:AddMount(130086, 44807) -- Brown Riding Goat
    self:AddMount(127213, 43710) -- Brown Riding Yak
    self:AddMount(124550, 38757, FLY, { are = 1}) -- Cataclysmic Gladiator's Twilight Drake
    self:AddMount(127156, 41592, FLY) -- Crimson Cloud Serpent
    self:AddMount(129552, 44633, FLY) -- Crimson Pandaren Phoenix
    self:AddMount(123160, 42837) -- Crimson Riding Crane
    self:AddMount(127271, 43713) -- Crimson Water Strider
    self:AddMount(126507, 43637, FLY) -- Depleted-Kyparium Rocket
    self:AddMount(132118, 45520, FLY) -- Emerald Pandaren Phoenix
    self:AddMount(126508, 43638, FLY) -- Geosynchronous World Spinner
    self:AddMount(123993, 41991, FLY) -- Golden Cloud Serpent
    self:AddMount(127176, 43705) -- Golden Riding Crane
    self:AddMount(127278, 43716) -- Golden Water Strider
    self:AddMount(122708, 42703) -- Grand Expedition Yak
    self:AddMount(127295, 43723) -- Great Black Dragon Turtle
    self:AddMount(127302, 43724) -- Great Blue Dragon Turtle
    self:AddMount(127308, 43725) -- Great Brown Dragon Turtle
    self:AddMount(127293, 43722) -- Great Green Dragon Turtle
    self:AddMount(127310, 43726) -- Great Purple Dragon Turtle
    self:AddMount(120822, 42352) -- Great Red Dragon Turtle
    self:AddMount(120395, 42250) -- Green Dragon Turtle
    self:AddMount(129932, 44759) -- Green Shado-Pan Riding Tiger
    self:AddMount(127216, 43711) -- Grey Riding Yak
    self:AddMount(127169, 43697, FLY) -- Heavenly Azure Cloud Serpent
    self:AddMount(127161, 43692, FLY) -- Heavenly Crimson Cloud Serpent
    self:AddMount(127164, 43693, FLY) -- Heavenly Golden Cloud Serpent
    self:AddMount(127165, 43695, FLY) -- Heavenly Jade Cloud Serpent
    self:AddMount(127158, 43689, FLY) -- Heavenly Onyx Cloud Serpent
    self:AddMount(113199, 40590, FLY) -- Jade Cloud Serpent
    self:AddMount(121837, 42502) -- Jade Panther
    self:AddMount(127274, 43714) -- Jade Water Strider
    self:AddMount(120043, 42185, FLY) -- Jeweled Onyx Panther
    self:AddMount(127178, 43707) -- Jungle Riding Crane
    self:AddMount(127154, 41990, FLY) -- Onyx Cloud Serpent
    self:AddMount(127272, 43715) -- Orange Water Strider
    self:AddMount(127289, 43910) -- Purple Dragon Turtle
    self:AddMount(127290, 43721) -- Red Dragon Turtle
    self:AddMount(130092, 44808, FLY) -- Red Flying Cloud
    self:AddMount(129935, 44757) -- Red Shado-Pan Riding Tiger
    self:AddMount(127177, 43706) -- Regal Riding Crane
    self:AddMount(121838, 42499) -- Ruby Panther
    self:AddMount(121836, 42500) -- Sapphire Panther
    self:AddMount(130965, 45264) -- Son of Galleon
    self:AddMount(121839, 42501, FLY) -- Sunstone Panther
    self:AddMount(129918, 43686, FLY) -- Thundering August Cloud Serpent
    self:AddMount(124408, 43562, FLY) -- Thundering Jade Cloud Serpent
    self:AddMount(132036, 45797, FLY) -- Thundering Ruby Cloud Serpent
    self:AddMount(132119, 45522, FLY) -- Violet Pandaren Phoenix
    self:AddMount(130137, 44837) -- White Riding Goat
    self:AddMount(123182, 41089) -- White Riding Yak

    -- Alliance Mounts
    if self.FACTION == "Alliance" then
        self:AddMount(60114, 27820) -- Armored Brown Bear
        self:AddMount(61229, 27913, FLY) -- Armored Snowy Gryphon
        self:AddMount(22719, 14372, GROUND, { pvp = 1 }) -- Black Battlestrider
        self:AddMount(470, 2402)   -- Black Stallion Bridle
        self:AddMount(60118, 27818) -- Black War Bear
        self:AddMount(48027, 23928, GROUND, { pvp = 1 }) -- Black War Elekk
        self:AddMount(59785, 27247) -- Black War Mammoth
        self:AddMount(22720, 14577, GROUND, { pvp = 1 }) -- Black War Ram
        self:AddMount(22717, 14337, GROUND, { pvp = 1 }) -- Black War Steed
        self:AddMount(22723, 14330, GROUND, { pvp = 1 }) -- Black War Tiger
        self:AddMount(61996, 27525, FLY) -- Blue Dragonhawk
        self:AddMount(10969, 6569) -- Blue Mechanostrider
        self:AddMount(34406, 17063) -- Brown Elekk
        self:AddMount(458, 2404)   -- Brown Horse
        self:AddMount(6899, 2785)  -- Brown Ram
        self:AddMount(6648, 2405)  -- Chestnut Mare
        self:AddMount(68187, 29937, GROUND, { nlo = 1 }) -- Crusader's White Warhorse
        self:AddMount(63637, 29256) -- Darnassian Nightsaber
        self:AddMount(32239, 17694, FLY) -- Ebon Gryphon
        self:AddMount(63639, 29255) -- Exodar Elekk
        self:AddMount(63638, 28571) -- Gnomeregan Mechanostrider
        self:AddMount(32235, 17697, FLY) -- Golden Gryphon
        self:AddMount(90621, 36213) -- Golden King
        self:AddMount(61465, 27241) -- Grand Black War Mammoth
        self:AddMount(61470, 27242) -- Grand Ice Mammoth
        self:AddMount(35710, 19869) -- Gray Elekk
        self:AddMount(6777, 2736)  -- Gray Ram
        self:AddMount(35713, 19871) -- Great Blue Elekk
        self:AddMount(35712, 19873) -- Great Green Elekk
        self:AddMount(35714, 19872) -- Great Purple Elekk
        self:AddMount(65637, 28606) -- Great Red Elekk
        self:AddMount(17453, 10661) -- Green Mechanostrider
        self:AddMount(59799, 27248) -- Ice Mammoth
        self:AddMount(63636, 29258) -- Ironforge Ram
        self:AddMount(60424, 25870) -- Mekgineer's Chopper
        self:AddMount(103195, 39096) -- Mountain Horse
        self:AddMount(472, 2409)   -- Pinto
        self:AddMount(35711, 19870) -- Purple Elekk
        self:AddMount(66090, 28888) -- Quel'dorei Steed
        self:AddMount(10873, 9473) -- Red Mechanostrider
        self:AddMount(66087, 22474, FLY) -- Silver Covenant Hippogryph
        self:AddMount(32240, 17696, FLY) -- Snowy Gryphon
        self:AddMount(92231, 37160) -- Spectral Steed
        self:AddMount(107516, 39546, FLY) -- Spectral Gryphon
        self:AddMount(10789, 6444) -- Spotted Frostsaber
        self:AddMount(23510, 14777, GROUND, { pvp = 1 }) -- Stormpike Battle Charger
        self:AddMount(63232, 28912) -- Stormwind Steed
        self:AddMount(66847, 29755) -- Striped Dawnsaber
        self:AddMount(8394, 6080)  -- Striped Frostsaber
        self:AddMount(10793, 6448)  -- Striped Nightsaber
        self:AddMount(68057, 29284, GROUND, { nlo = 1 })  -- Swift Alliance Steed
        self:AddMount(32242, 17759, FLY)  -- Swift Blue Gryphon
        self:AddMount(23238, 14347)  -- Swift Brown Ram
        self:AddMount(23229, 14583)  -- Swift Brown Steed
        self:AddMount(23221, 14331)  -- Swift Frostsaber
        self:AddMount(23239, 14576)  -- Swift Gray Ram
        self:AddMount(65640, 29043)  -- Swift Gray Steed
        self:AddMount(32290, 17703, FLY)  -- Swift Green Gryphon
        self:AddMount(23225, 14374)  -- Swift Green Mechanostrider
        self:AddMount(23219, 14332)  -- Swift Mistsaber
        self:AddMount(103196, 39095)  -- Swift Mountain Horse
        self:AddMount(65638, 14333)  -- Swift Moonsaber
        self:AddMount(23227, 14582)  -- Swift Palomino
        self:AddMount(32292, 17717, FLY)  -- Swift Purple Gryphon
        self:AddMount(32289, 17718, FLY)  -- Swift Red Gryphon
        self:AddMount(23338, 14632)  -- Swift Stormsaber
        self:AddMount(65643, 28612)  -- Swift Violet Ram
        self:AddMount(23223, 14376)  -- Swift White Mechanostrider
        self:AddMount(23240, 14346)  -- Swift White Ram
        self:AddMount(23228, 14338)  -- Swift White Steed
        self:AddMount(23222, 14377)  -- Swift Yellow Mechanostrider
        self:AddMount(61425, 27237)  -- Traveler's Tundra Mammoth
        self:AddMount(65642, 14375)  -- Turbostrider
        self:AddMount(17454, 9476)  -- Unpainted Mechanostrider
        self:AddMount(100332, 38668, GROUND, { pvp = 1 }) -- Vicious War Steed
        self:AddMount(6898, 2786)   -- White Ram
        self:AddMount(16083, 2410, GROUND, { nlo = 1 })  -- White Stallion
        self:AddMount(17229, 10426)  -- Winterspring Frostsaber
        self:AddMount(59791, 27243)  -- Wooly Mammoth
        self:AddMount(130985, 45271, FLY) -- Pandaren Kite
    end

    -- Horde Mounts
    if self.FACTION == "Horde" then
        self:AddMount(61230, 27914, FLY) -- Armored Blue Wind Rider
        self:AddMount(60116, 27821) -- Armored Brown Bear
        self:AddMount(35022, 19478) -- Black Hawkstrider
        self:AddMount(64977, 29130) -- Black Skeletal Horse
        self:AddMount(60119, 27819) -- Black War Bear
        self:AddMount(22718, 14348, GROUND, { pvp = 1 }) -- Black War Kodo
        self:AddMount(59788, 27245) -- Black War Mammoth
        self:AddMount(22721, 14388, GROUND, { pvp = 1 }) -- Black War Raptor
        self:AddMount(22724, 14334, GROUND, { pvp = 1 }) -- Black War Wolf
        self:AddMount(64658, 207) -- Black Wolf
        self:AddMount(35020, 19480) -- Blue Hawkstrider
        self:AddMount(17463, 10671) -- Blue Skeletal Horse
        self:AddMount(32244, 17700, FLY) -- Blue Wind Rider
        self:AddMount(18990, 11641) -- Brown Kodo
        self:AddMount(17464, 10672) -- Brown Skeletal Horse
        self:AddMount(6654, 2328) -- Brown Wolf
        self:AddMount(68188, 29938, GROUND, { nlo = 1 }) -- Crusader's Black Warhorse
        self:AddMount(63635, 29261) -- Darkspear Raptor
        self:AddMount(6653, 2327) -- Dire Wolf
        self:AddMount(8395, 4806) -- Emerald Raptor
        self:AddMount(63643, 29257) -- Forsaken Warhorse
        self:AddMount(23509, 14776, GROUND, { pvp = 1 }) -- Frostwolf Howler
        self:AddMount(61467, 27240) -- Grand Black War Mammoth
        self:AddMount(61469, 27239) -- Grand Ice Mammoth
        self:AddMount(18989, 12246) -- Gray Kodo
        self:AddMount(23249, 14578) -- Great Brown Kodo
        self:AddMount(65641, 28556) -- Great Golden Kodo
        self:AddMount(23248, 14579) -- Great Gray Kodo
        self:AddMount(23247, 14349) -- Great White Kodo
        self:AddMount(17465, 10720) -- Green Skeletal Warhorse
        self:AddMount(32245, 17701, FLY) -- Green Wind Rider
        self:AddMount(87090, 35249) -- Goblin Trike
        self:AddMount(87091, 35250) -- Goblin Turbo-Trike
        self:AddMount(59797, 27246) -- Ice Mammoth
        self:AddMount(93644, 37138) -- Kor'kron Annihilator
        self:AddMount(55531, 25871) -- Mechano-Hog
        self:AddMount(66846, 29754) -- Ochre Skeletal Warhorse
        self:AddMount(63640, 29260) -- Orgrimmar Wolf
        self:AddMount(35018, 19479) -- Purple Hawkstrider
        self:AddMount(23246, 10721) -- Purple Skeletal Warhorse
        self:AddMount(61997, 28402, FLY) -- Red Dragonhawk
        self:AddMount(34795, 18696) -- Red Hawkstrider
        self:AddMount(17462, 10670) -- Red Skeletal Horse
        self:AddMount(22722, 10719, GROUND, { pvp = 1 }) -- Red Skeletal Warhorse
        self:AddMount(63642, 29262) -- Silvermoon Hawkstrider
        self:AddMount(107517, 39547, FLY) -- Spectral Wind Rider
        self:AddMount(92232, 37159) -- Spectral Wolf
        self:AddMount(66088, 29696, FLY) -- Sunreaver Dragonhawk
        self:AddMount(66091, 28889) -- Sunreaver Hawkstrider
        self:AddMount(23241, 14339) -- Swift Blue Raptor
        self:AddMount(23250, 14573) -- Swift Brown Wolf
        self:AddMount(65646, 14335) -- Swift Burgundy Wolf
        self:AddMount(23252, 14574) -- Swift Gray Wolf
        self:AddMount(35025, 19484) -- Swift Green Hawkstrider
        self:AddMount(32295, 17720, FLY) -- Swift Green Wind Rider
        self:AddMount(68056, 29283, GROUND, { nlo = 1 }) -- Swift Horde Wolf
        self:AddMount(23242, 14344) -- Swift Olive Raptor
        self:AddMount(23243, 14342) -- Swift Orange Raptor
        self:AddMount(33660, 18697) -- Swift Pink Hawkstrider
        self:AddMount(35027, 19482) -- Swift Purple Hawkstrider
        self:AddMount(65644, 14343) -- Swift Purple Raptor
        self:AddMount(32297, 17721, FLY) -- Swift Purple Wind Rider
        self:AddMount(65639, 28607) -- Swift Red Hawkstrider
        self:AddMount(32246, 17719, FLY) -- Swift Red Wind Rider
        self:AddMount(23251, 14575) -- Swift Timber Wolf
        self:AddMount(35028, 20359, GROUND, { pvp = 1 }) -- Swift Warstrider
        self:AddMount(32296, 17722, FLY) -- Swift Yellow Wind Rider
        self:AddMount(32243, 17699, FLY) -- Tawny Wind Rider
        self:AddMount(63641, 29259) -- Thunder Bluff Kodo
        self:AddMount(580, 247) -- Timber Wolf
        self:AddMount(61447, 27238) -- Traveler's Tundra Mammoth
        self:AddMount(10796, 6472) -- Turquoise Raptor
        self:AddMount(64659, 29102) -- Venomhide Ravasaur
        self:AddMount(100333, 38607, GROUND, { pvp = 1 }) -- Vicious War Wolf
        self:AddMount(10799, 6473) -- Violet Raptor
        self:AddMount(64657, 12241) -- White Kodo
        self:AddMount(65645, 28605) -- White Skeletal Warhorse
        self:AddMount(59793, 27244) -- Wooly Mammoth
        self:AddMount(118737, 41903, FLY) -- Pandaren Kite
    end

    -- Paladin Mounts for Humans and Dwarfs
    if self.CLASS == "PALADIN" and (self.RACE == "Human" or self.RACE == "Dwarf") then
        self:AddMount(66906, 28919) -- Argent Charger
        self:AddMount(23214, 14584) -- Charger
        self:AddMount(13819, 8469) -- Warhorse
    end

    -- Paladin Mounts for Draenei
    if self.CLASS == "PALADIN" and self.RACE == "Draenei" then
        self:AddMount(66906, 28919) -- Argent Charger
        self:AddMount(73629, 31367) -- Exarch's Elekk
        self:AddMount(73630, 31368) -- Great Exarch's Elekk
    end

    -- Paladin Mounts for Blood Elves
    if self.CLASS == "PALADIN" and self.RACE == "BloodElf" then
        self:AddMount(66906, 28919) -- Argent Charger
        self:AddMount(34767, 19085) -- Horde Charger
        self:AddMount(34769, 19296) -- Horde Warhorse
    end

    -- Paladin Mounts for Tauren
    if self.CLASS == "PALADIN" and self.RACE == "Tauren" then
        self:AddMount(66906, 28919) -- Argent Charger
        self:AddMount(69826, 30501) -- Great Sunwalker Kodo
        self:AddMount(69820, 30366) -- Sunwalker Kodo
    end

    -- Warlock Mounts
    if self.CLASS == "WARLOCK" then
        self:AddMount(23161, 14554) -- Dreadsteed
        self:AddMount(5784, 2346) -- Felsteed
    end

    -- Death Knight Mounts
    if self.CLASS == "DEATHKNIGHT" then
        self:AddMount(48778, 25280) -- Acherus Deathcharger
        self:AddMount(54729, 28108, FLY) -- Winged Steed of the Ebon Blade
    end

    self:SortTable(self.MOUNTS)
end

function CollectMe:AddMount(spell_id, display_id, type, filters, zones, professions)
    if spell_id ~= nil then
        local name, _, icon = GetSpellInfo(spell_id)
        local link = GetSpellLink(spell_id)

        table.insert(self.MOUNTS, {
            name       = name,
            icon       = icon,
            link       = link,
            id         = spell_id,
            display_id = display_id,
            type       = (type == nil and GROUND or type),
            filters    = filters,
            zones      = zones,
            professions = professions
        })

        table.insert(self.MOUNT_SPELLS, spell_id)
    end
end
