local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Data = CollectMe:NewModule("Data")

Data.Zones = {
    204, -- Abyssal Depths
    132, -- Ahn'kahet: The Old Kingdom
    327, -- Ahn'Qiraj: The Fallen Kingdom
    91, -- Alterac Valley
    468, -- Ammen Vale MoP
    885, -- Antoran Wastes
    909, -- Antorus, the Burning Throne
    93, -- Arathi Basin
    14, -- Arathi Highlands
    994, -- Argus
    63, -- Ashenvale
    588, -- Ashran
    732, -- Assault on Violet Hold
    934, -- Atal'Dazar
    256, -- Auchenai Crypts
    593, -- Auchindoun
    947, -- Azeroth
    157, -- Azjol-Nerub
    76, -- Azshara
    630, -- Azsuna
    97, -- Azuremyst Isle
    15, -- Badlands
    282, -- Baradin Hold
    751, -- Black Rook Hold
    339, -- Black Temple
    221, -- Blackfathom Deeps
    284, -- Blackrock Caverns
    243, -- Blackrock Depths
    596, -- Blackrock Foundry
    250, -- Blackrock Spire
    285, -- Blackwing Descent
    287, -- Blackwing Lair
    105, -- Blade's Edge Mountains
    17, -- Blasted Lands
    573, -- Bloodmaul Slag Mines
    106, -- Bloodmyst Isle
    114, -- Borean Tundra
    503, -- Brawl'gar Arena
    646, -- Broken Shore
    36, -- Burning Steppes
    462, -- Camp Narache MoP
    845, -- Cathedral of Eternal Night
    571, -- Celestial Tournament
    427, -- Coldridge Valley MoP
    761, -- Court of Stars
    127, -- Crystalsong Forest
    627, -- Dalaran
    125, -- Dalaran
    733, -- Darkheart Thicket
    407, -- Darkmoon Island
    62, -- Darkshore
    89, -- Darnassus
    42, -- Deadwind Pass
    465, -- Deathknell MoP
    207, -- Deepholm
    66, -- Desolace
    234, -- Dire Maul
    409, -- Dragon Soul
    115, -- Dragonblight
    160, -- Drak'Tharon Keep
    422, -- Dread Wastes MoP
    1197, -- Drustvar
    27, -- Dun Morogh
    1, -- Durotar
    47, -- Duskwood
    70, -- Dustwallow Marsh
    23, -- Eastern Plaguelands
    463, -- Echo Isles MoP
    37, -- Elwynn Forest
    401, -- End Time
    94, -- Eversong Woods
    790, -- Eye of Azshara
    713, -- Eye of Azshara
    112, -- Eye of the Storm
    77, -- Felwood
    69, -- Feralas
    367, -- Firelands
    936, -- Freehold
    525, -- Frostfire Ridge
    585, -- Frostwall
    437, -- Gate of the Setting Sun MoP
    95, -- Ghostlands
    179, -- Gilneas
    202, -- Gilneas City
    226, -- Gnomeregan
    543, -- Gorgrond
    293, -- Grim Batol
    606, -- Grimrail Depot
    116, -- Grizzly Hills
    330, -- Gruul's Lair
    153, -- Gundrak
    138, -- Halls of Lightning
    297, -- Halls of Origination
    185, -- Halls of Reflection
    140, -- Halls of Stone
    703, -- Halls of Valor
    474, -- Heart of Fear MoP
    649, -- Helheim
    661, -- Hellfire Citadel
    100, -- Hellfire Peninsula
    347, -- Hellfire Ramparts
    610, -- Highmaul
    650, -- Highmountain
    25, -- Hillsbrad Foothills
    399, -- Hour of Twilight
    117, -- Howling Fjord
    170, -- Hrothgar's Landing
    329, -- Hyjal Summit
    118, -- Icecrown
    186, -- Icecrown Citadel
    595, -- Iron Docks
    87, -- Ironforge
    169, -- Isle of Conquest
    507, -- Isle of Giants
    122, -- Isle of Quel'Danas
    504, -- Isle of Thunder
    350, -- Karazhan
    201, -- Kelp'thar Forest
    194, -- Kezan
    1004, -- Kings' Rest
    418, -- Krasarang Wilds MoP
    830, -- Krokuun
    992, -- Kul Tiras
    379, -- Kun-Lai Summit MoP
    48, -- Loch Modan
    277, -- Lost City of the Tol'vir
    579, -- Lunarfall
    882, -- Mac'Aree
    348, -- Magisters' Terrace
    331, -- Magtheridon's Lair
    272, -- Mana-Tombs
    280, -- Maraudon
    706, -- Maw of Souls
    453, -- Mogu'Shan Palace MoP
    471, -- Mogu'shan Vaults MoP
    232, -- Molten Core
    338, -- Molten Front
    80, -- Moonglade
    198, -- Mount Hyjal
    7, -- Mulgore
    107, -- Nagrand
    550, -- Nagrand
    162, -- Naxxramas
    1194, -- Nazmir
    731, -- Neltharion's Lair
    109, -- Netherstorm
    469, -- New Tinkertown MoP
    10, -- Northern Barrens
    50, -- Northern Stranglethorn
    425, -- Northshire MoP
    274, -- Old Hillsbrad Foothills
    248, -- Onyxia's Lair
    85, -- Orgrimmar
    184, -- Pit of Saron
    124, -- Plaguelands: The Scarlet Enclave
    213, -- Ragefire Chasm
    300, -- Razorfen Downs
    301, -- Razorfen Kraul
    49, -- Redridge Mountains
    809, -- Return to Karazhan
    247, -- Ruins of Ahn'Qiraj
    217, -- Ruins of Gilneas
    218, -- Ruins of Gilneas City
    302, -- Scarlet Monastery
    306, -- Scholomance
    32, -- Searing Gorge
    332, -- Serpentshrine Cavern
    258, -- Sethekk Halls
    443, -- Shado-Pan Monastery MoP
    260, -- Shadow Labyrinth
    310, -- Shadowfang Keep
    460, -- Shadowglen MoP
    574, -- Shadowmoon Burial Grounds
    104, -- Shadowmoon Valley
    539, -- Shadowmoon Valley
    111, -- Shattrath City
    205, -- Shimmering Expanse
    119, -- Sholazar Basin
    393, -- Shrine of Seven Stars MoP
    1039, -- Shrine of the Storm
    391, -- Shrine of Two Moons MoP
    1162, -- Siege of Boralus
    457, -- Siege of Niuzao Temple MoP
    556, -- Siege of Orgrimmar
    81, -- Silithus
    110, -- Silvermoon City
    21, -- Silverpine Forest
    601, -- Skyreach
    199, -- Southern Barrens
    542, -- Spires of Arak
    65, -- Stonetalon Mountains
    634, -- Stormheim
    622, -- Stormshield
    1198, -- Stormsong Valley
    439, -- Stormstout Brewery MoP
    84, -- Stormwind City
    128, -- Strand of the Ancients
    224, -- Stranglethorn Vale
    317, -- Stratholme
    220, -- Sunken Temple
    467, -- Sunstrider Isle MoP
    335, -- Sunwell Plateau
    680, -- Suramar
    51, -- Swamp of Sorrows
    535, -- Talador
    534, -- Tanaan Jungle
    577, -- Tanaan Jungle - Assault on the Dark Portal
    71, -- Tanaris
    57, -- Teldrassil
    319, -- Temple of Ahn'Qiraj
    1038, -- Temple of Sethraliss
    429, -- Temple of the Jade Serpent MoP
    108, -- Terokkar Forest
    456, -- Terrace of Endless Spring MoP
    269, -- The Arcatraz
    749, -- The Arcway
    294, -- The Bastion of Twilight
    275, -- The Battle for Gilneas
    273, -- The Black Morass
    261, -- The Blood Furnace
    266, -- The Botanica
    210, -- The Cape of Stranglethorn
    130, -- The Culling of Stratholme
    291, -- The Deadmines
    777, -- The Emerald Nightmare
    620, -- The Everbloom
    103, -- The Exodar
    334, -- The Eye
    141, -- The Eye of Eternity
    183, -- The Forge of Souls
    26, -- The Hinterlands
    371, -- The Jade Forest MoP
    174, -- The Lost Isles
    276, -- The Maelstrom
    267, -- The Mechanar
    1010, -- The MOTHERLODE!!
    129, -- The Nexus
    764, -- The Nighthold
    155, -- The Obsidian Sanctum
    142, -- The Oculus
    200, -- The Ruby Sanctum
    903, -- The Seat of the Triumvirate
    246, -- The Shattered Halls
    265, -- The Slave Pens
    263, -- The Steamvault
    225, -- The Stockade
    324, -- The Stonecore
    120, -- The Storm Peaks
    262, -- The Underbog
    1041, -- The Underrot
    433, -- The Veiled Stair MoP
    168, -- The Violet Hold
    325, -- The Vortex Pinnacle
    378, -- The Wandering Isle MoP
    64, -- Thousand Needles
    328, -- Throne of the Four Winds
    322, -- Throne of the Tides
    508, -- Throne of Thunder
    88, -- Thunder Bluff
    554, -- Timeless Isle
    1196, -- Tiragarde Sound
    18, -- Tirisfal Glades
    244, -- Tol Barad
    245, -- Tol Barad Peninsula
    974, -- Tol Dagor
    850, -- Tomb of Sargeras
    388, -- Townlong Steppes MoP
    171, -- Trial of the Champion
    172, -- Trial of the Crusader
    806, -- Trial of Valor
    739, -- Trueshot Lodge
    241, -- Twilight Highlands
    206, -- Twin Peaks
    230, -- Uldaman
    1148, -- Uldir
    147, -- Ulduar
    249, -- Uldum
    78, -- Un'Goro Crater
    90, -- Undercity
    616, -- Upper Blackrock Spire
    133, -- Utgarde Keep
    136, -- Utgarde Pinnacle
    641, -- Val'sharah
    390, -- Vale of Eternal Blossoms MoP
    376, -- Valley of the Four Winds MoP
    461, -- Valley of Trials MoP
    203, -- Vashj'ir
    156, -- Vault of Archavon
    710, -- Vault of the Wardens
    1195, -- Vol'dun
    279, -- Wailing Caverns
    92, -- Warsong Gulch
    624, -- Warspear
    1015, -- Waycrest Manor
    398, -- Well of Eternity
    22, -- Western Plaguelands
    52, -- Westfall
    56, -- Wetlands
    123, -- Wintergrasp
    83, -- Winterspring
    991, -- Zandalar
    102, -- Zangarmarsh
    333, -- Zul'Aman
    121, -- Zul'Drak
    219, -- Zul'Farrak
    337, -- Zul'Gurub
    1193, -- Zuldazar
}
