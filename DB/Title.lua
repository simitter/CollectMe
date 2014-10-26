local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local Data = CollectMe:GetModule("Data")

CollectMe.TitleDB = CollectMe:NewModule("TitleDB")

function CollectMe.TitleDB:OnInitialize()
    self.filters = { "nlo", "pvp", "are", "umo", "tmp" }
end

function CollectMe.TitleDB:Get()
    return Data.Titles, Data.TitlesSort
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
        if IsTitleKnown(i) == true and Data.Titles[i] == nil then
            local name = GetTitleName(i)
            if name ~= nil then
                CollectMe:Print(CollectMe.L["Title"] .. " " .. name:gsub("^%s*(.-)%s*$", "%1") .. "("..i..") " .. CollectMe.L["is missing"] .. ". " .. CollectMe.L["Please inform the author"])
            end
        end
    end
end
