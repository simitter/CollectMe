local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Data = CollectMe:NewModule("Data")

Data.Zones = {
    614, -- Abyssal Depths
    522, -- Ahn'kahet: The Old Kingdom
    772, -- Ahn'Qiraj: The Fallen Kingdom
    401, -- Alterac Valley
    894, -- Ammen Vale MoP
    461, -- Arathi Basin
    16, -- Arathi Highlands
    43, -- Ashenvale
    722, -- Auchenai Crypts
    533, -- Azjol-Nerub
    181, -- Azshara
    464, -- Azuremyst Isle
    17, -- Badlands
    752, -- Baradin Hold
    796, -- Black Temple
    688, -- Blackfathom Deeps
    753, -- Blackrock Caverns
    704, -- Blackrock Depths
    721, -- Blackrock Spire
    754, -- Blackwing Descent
    755, -- Blackwing Lair
    475, -- Blade's Edge Mountains
    19, -- Blasted Lands
    476, -- Bloodmyst Isle
    486, -- Borean Tundra
    29, -- Burning Steppes
    890, -- Camp Narache MoP
    866, -- Coldridge Valley MoP
    510, -- Crystalsong Forest
    504, -- Dalaran
    823, -- Darkmoon Island
    42, -- Darkshore
    381, -- Darnassus
    32, -- Deadwind Pass
    892, -- Deathknell MoP
    640, -- Deepholm
    101, -- Desolace
    699, -- Dire Maul
    824, -- Dragon Soul
    488, -- Dragonblight
    534, -- Drak'Tharon Keep
    858, -- Dread Wastes MoP
    27, -- Dun Morogh
    4, -- Durotar
    34, -- Duskwood
    141, -- Dustwallow Marsh
    23, -- Eastern Plaguelands
    891, -- Echo Isles MoP
    30, -- Elwynn Forest
    820, -- End Time
    462, -- Eversong Woods
    482, -- Eye of the Storm
    182, -- Felwood
    121, -- Feralas
    800, -- Firelands
    875, -- Gate of the Setting Sun MoP
    463, -- Ghostlands
    545, -- Gilneas
    611, -- Gilneas City
    691, -- Gnomeregan
    757, -- Grim Batol
    490, -- Grizzly Hills
    776, -- Gruul's Lair
    530, -- Gundrak
    525, -- Halls of Lightning
    759, -- Halls of Origination
    603, -- Halls of Reflection
    526, -- Halls of Stone
    897, -- Heart of Fear MoP
    465, -- Hellfire Peninsula
    797, -- Hellfire Ramparts
    24, -- Hillsbrad Foothills
    819, -- Hour of Twilight
    491, -- Howling Fjord
    541, -- Hrothgar's Landing
    775, -- Hyjal Summit
    492, -- Icecrown
    604, -- Icecrown Citadel
    341, -- Ironforge
    540, -- Isle of Conquest
    929, -- Isle of Giants
    499, -- Isle of Quel'Danas
    928, -- Isle of Thunder
    799, -- Karazhan
    610, -- Kelp'thar Forest
    605, -- Kezan
    857, -- Krasarang Wilds MoP
    809, -- Kun-Lai Summit MoP
    35, -- Loch Modan
    747, -- Lost City of the Tol'vir
    798, -- Magisters' Terrace
    779, -- Magtheridon's Lair
    732, -- Mana-Tombs
    750, -- Maraudon
    885, -- Mogu'Shan Palace MoP
    896, -- Mogu'shan Vaults MoP
    696, -- Molten Core
    795, -- Molten Front
    241, -- Moonglade
    606, -- Mount Hyjal
    9, -- Mulgore
    477, -- Nagrand
    535, -- Naxxramas
    479, -- Netherstorm
    895, -- New Tinkertown MoP
    11, -- Northern Barrens
    37, -- Northern Stranglethorn
    864, -- Northshire MoP
    734, -- Old Hillsbrad Foothills
    718, -- Onyxia's Lair
    321, -- Orgrimmar
    602, -- Pit of Saron
    680, -- Ragefire Chasm
    760, -- Razorfen Downs
    761, -- Razorfen Kraul
    36, -- Redridge Mountains
    717, -- Ruins of Ahn'Qiraj
    684, -- Ruins of Gilneas
    685, -- Ruins of Gilneas City
    762, -- Scarlet Monastery
    763, -- Scholomance
    28, -- Searing Gorge
    780, -- Serpentshrine Cavern
    723, -- Sethekk Halls
    877, -- Shado-pan Monastery MoP
    724, -- Shadow Labyrinth
    764, -- Shadowfang Keep
    888, -- Shadowglen MoP
    473, -- Shadowmoon Valley
    481, -- Shattrath City
    615, -- Shimmering Expanse
    493, -- Sholazar Basin
    905, -- Shrine of Seven Stars MoP
    903, -- Shrine of Two Moons MoP
    887, -- Siege of Niuzao Temple MoP
    261, -- Silithus
    480, -- Silvermoon City
    21, -- Silverpine Forest
    607, -- Southern Barrens
    81, -- Stonetalon Mountains
    876, -- Stormstout Brewery MoP
    301, -- Stormwind City
    512, -- Strand of the Ancients
    689, -- Stranglethorn Vale
    765, -- Stratholme
    893, -- Sunstrider Isle MoP
    789, -- Sunwell Plateau
    38, -- Swamp of Sorrows
    161, -- Tanaris
    41, -- Teldrassil
    766, -- Temple of Ahn'Qiraj
    867, -- Temple of the Jade Serpent MoP
    478, -- Terokkar Forest
    886, -- Terrace of Endless Spring MoP
    731, -- The Arcatraz
    758, -- The Bastion of Twilight
    736, -- The Battle for Gilneas
    733, -- The Black Morass
    725, -- The Blood Furnace
    729, -- The Botanica
    673, -- The Cape of Stranglethorn
    521, -- The Culling of Stratholme
    756, -- The Deadmines
    471, -- The Exodar
    782, -- The Eye
    527, -- The Eye of Eternity
    601, -- The Forge of Souls
    26, -- The Hinterlands
    806, -- The Jade Forest MoP
    544, -- The Lost Isles
    737, -- The Maelstrom
    730, -- The Mechanar
    520, -- The Nexus
    531, -- The Obsidian Sanctum
    528, -- The Oculus
    609, -- The Ruby Sanctum
    502, -- The Scarlet Enclave
    710, -- The Shattered Halls
    728, -- The Slave Pens
    727, -- The Steamvault
    690, -- The Stockade
    768, -- The Stonecore
    495, -- The Storm Peaks
    687, -- The Temple of Atal'Hakkar
    726, -- The Underbog
    873, -- The Veiled Stair MoP
    536, -- The Violet Hold
    769, -- The Vortex Pinnacle
    808, -- The Wandering Isle MoP
    61, -- Thousand Needles
    773, -- Throne of the Four Winds
    767, -- Throne of the Tides
    930, -- Throne of Thunder
    362, -- Thunder Bluff
    20, -- Tirisfal Glades
    708, -- Tol Barad
    709, -- Tol Barad Peninsula
    810, -- Townlong Steppes MoP
    542, -- Trial of the Champion
    543, -- Trial of the Crusader
    700, -- Twilight Highlands
    626, -- Twin Peaks
    692, -- Uldaman
    529, -- Ulduar
    720, -- Uldum
    201, -- Un'Goro Crater
    382, -- Undercity
    523, -- Utgarde Keep
    524, -- Utgarde Pinnacle
    811, -- Vale of Eternal Blossoms MoP
    807, -- Valley of the Four Winds MoP
    889, -- Valley of Trials MoP
    613, -- Vashj'ir
    532, -- Vault of Archavon
    749, -- Wailing Caverns
    443, -- Warsong Gulch
    816, -- Well of Eternity
    22, -- Western Plaguelands
    39, -- Westfall
    40, -- Wetlands
    501, -- Wintergrasp
    281, -- Winterspring
    467, -- Zangarmarsh
    781, -- Zul'Aman
    496, -- Zul'Drak
    686, -- Zul'Farrak
    793, -- Zul'Gurub
}
