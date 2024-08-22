local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.RandomTitle = CollectMe:NewModule("RandomTitle", "AceHook-3.0")

function CollectMe.RandomTitle:Select()
    local selectable = {};

    for i,v in pairs(CollectMe.db.profile.random.titles) do
        if v == true then
            table.insert(selectable, i)
        end
    end

    if (#selectable > 0) then
        local select = math.random(1, #selectable)
        SetCurrentTitle(selectable[select])
    else
        CollectMe:Print(CollectMe.L["You haven't configured your title priorities yet. Please open the random title tab"])
    end
end
