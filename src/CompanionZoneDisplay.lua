CollectMe.LdbDisplay = CollectMe:NewModule("LdbDisplay", "AceEvent-3.0", "AceConsole-3.0")

function CollectMe.LdbDisplay:OnInitialize()

    self.dataObject = LibStub("LibDataBroker-1.1"):NewDataObject( "Collect Me - Companions in Zone", {
        type = "data source",
        icon = "Interface\\Icons\\INV_PET_BABYBLIZZARDBEAR",
        text = CollectMe.L["Companions in this Zone"],

        OnClick = function( dataObject )
            CollectMe.tabs:SelectTab(2)
            CollectMe.frame:Show()
        end
    })

end


