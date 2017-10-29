local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")

CollectMe.ModelPreview = CollectMe:NewModule("ModelPreview", "AceHook-3.0")

function CollectMe.ModelPreview:OnInitialize()
    self.display_creature = false

    self:Hook("DressUpItemLink", true)
    self:HookScript(DressUpFrameResetButton, "OnClick", "DressUpFrameResetButton")
end

function CollectMe.ModelPreview:DressUpItemLink(link)
    if link ~= nil and type(link) == "string" then
        local spell = tonumber(link:match("spell:(%d+)"));
        if spell ~= nil then
            local info = CollectMe:GetMountInfo(spell)
            if info ~= nil then
                self:PreviewCreature(info.display_id)
                return true
            end
        end
    end
    if self.display_creature == true then
        SetDressUpBackground(DressUpFrame, CollectMe.RACE);
        DressUpModel:SetUnit("player")
        self.display_creature = false
    end
end

function CollectMe.ModelPreview:DressUpFrameResetButton()
    SetDressUpBackground(DressUpFrame, CollectMe.RACE);
    DressUpModel:SetUnit("player");
end

function CollectMe.ModelPreview:PreviewCreature(display_id)
    if display_id ~= nil then
        self.display_creature = true
        if CollectMe.UI.active_group == CollectMe.COMPANION then
            DressUpModel:SetCreature(display_id)
        else
            DressUpModel:SetDisplayInfo(display_id)
        end
        if not DressUpFrame:IsShown() then
            ShowUIPanel(DressUpFrame);
        end
    end
end
