local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Data = CollectMe:GetModule("Data")

CollectMe.ZoneDB = CollectMe:NewModule("ZoneDB")

local zone = nil;

function CollectMe.ZoneDB:OnInitialize()
    self.list, self.order = {}, {}
    self.loaded = false
end

function CollectMe.ZoneDB:GetList()
    if self.loaded == false then
        for _,v in ipairs(Data.Zones) do
			if C_Map.GetMapInfo(v) then
				self.list[v] = C_Map.GetMapInfo(v).name
			else
				self.list[v] = v .. " - MapInfo null"
			end
            table.insert(self.order, v)
        end
        self.loaded = true
    end
    return self.list, self.order
end

function CollectMe.ZoneDB:Current()
    zone = C_Map.GetBestMapForUnit("player")
    return zone
end

function CollectMe.ZoneDB:GetZone()
	if zone~= nil then
		return zone
	else
		return self:Current()
	end
end

function CollectMe.ZoneDB:PrintZones()
    for i = 1, 1200, 1 do
        if C_Map.GetMapInfo(i) ~= nil then
            CollectMe:Print(i.. " - " ..C_Map.GetMapInfo(i).name)
        end
    end
end