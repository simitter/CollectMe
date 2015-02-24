local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Data = CollectMe:GetModule("Data")

CollectMe.ZoneDB = CollectMe:NewModule("ZoneDB")

function CollectMe.ZoneDB:OnInitialize()
    self.list, self.order = {}, {}
    self.loaded = false
end

function CollectMe.ZoneDB:GetList()
    if self.loaded == false then
        for _,v in ipairs(Data.Zones) do
            self.list[v] = GetMapNameByID(v)
            table.insert(self.order, v)
        end
        self.loaded = true
    end
    return self.list, self.order
end

function CollectMe.ZoneDB:Current()
    SetMapToCurrentZone()
    local zone = GetCurrentMapAreaID()
    return zone
end
