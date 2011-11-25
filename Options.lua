knownCompanions = { };

function CollectMePanel_OnLoad (panel)
    panel.name = "Collect Me";
    InterfaceOptions_AddCategory(panel);
end

function CollectMePanel_OnShow (self)
    if (CollectMeSavedVars.Options == nil) then
        CollectMeSavedVars.Options = { };
    end
    _G[self:GetName().."CheckButton1"]:SetChecked(CollectMeSavedVars.Options["preview"]);
    _G[self:GetName().."CheckButton2"]:SetChecked(CollectMeSavedVars.Options["moving"]);
    _G[self:GetName().."CheckButton3"]:SetChecked(CollectMeSavedVars.Options["button_hide"]);
    _G[self:GetName().."CheckButton4"]:SetChecked(CollectMeSavedVars.Options["button_lock"]);
    _G[self:GetName().."CheckButton5"]:SetChecked(CollectMeSavedVars.Options["disableonpvp"]);
end

function CollectMePanel_OnClick (self, id)
    CollectMeSavedVars.Options[id] = self:GetChecked();
    if(id == "button_hide") then
        if(self:GetChecked() == 1) then
            CollectMeButtonFrame:Hide();
        else
            CollectMeButtonFrame:Show();
        end
    end
end

function CollectMePanelFilter_OnLoad (panel)
    panel.name = "Filters";
    panel.parent = "Collect Me";
    InterfaceOptions_AddCategory(panel);
end 

function CollectMePanelFilter_OnShow (self)
    if (CollectMeSavedVars.Filters == nil) then
        CollectMeSavedVars.Filters = { };
    end
    _G[self:GetName().."CheckButton1"]:SetChecked(CollectMeSavedVars.Filters["ComNlo"]);
    _G[self:GetName().."CheckButton2"]:SetChecked(CollectMeSavedVars.Filters["ComChi"]);
    _G[self:GetName().."CheckButton3"]:SetChecked(CollectMeSavedVars.Filters["ComPvp"]);
    _G[self:GetName().."CheckButton4"]:SetChecked(CollectMeSavedVars.Filters["ComTcg"]);
    _G[self:GetName().."CheckButton5"]:SetChecked(CollectMeSavedVars.Filters["ComCol"]);
    _G[self:GetName().."CheckButton6"]:SetChecked(CollectMeSavedVars.Filters["ComUnk"]);
    _G[self:GetName().."CheckButton7"]:SetChecked(CollectMeSavedVars.Filters["ComEng"]);
    _G[self:GetName().."CheckButton8"]:SetChecked(CollectMeSavedVars.Filters["ComSto"]);
    _G[self:GetName().."CheckButton9"]:SetChecked(CollectMeSavedVars.Filters["MouNlo"]);
    _G[self:GetName().."CheckButton10"]:SetChecked(CollectMeSavedVars.Filters["MouPvp"]);
    _G[self:GetName().."CheckButton11"]:SetChecked(CollectMeSavedVars.Filters["MouTcg"]);
    _G[self:GetName().."CheckButton12"]:SetChecked(CollectMeSavedVars.Filters["MouBsm"]);
    _G[self:GetName().."CheckButton13"]:SetChecked(CollectMeSavedVars.Filters["MouRfm"]);
end

function CollectMePanelFilterOption_OnClick (self, id, update)
    CollectMeSavedVars.Filters[id] = self:GetChecked();

    PanelTemplates_SetTab(CollectMeFrame, update);
    if(update == COLLECTME_CRITTER) then
        CollectMe_InitCompanionTable();
    else
        CollectMe_InitMountTable();
    end;    
    CollectMe_Update(update);
end

function CollectMePanelRndCom_OnLoad (panel)
    panel.name = "Random Companion";
    panel.parent = "Collect Me";
    InterfaceOptions_AddCategory(panel);
end 

function CollectMePanelRndCom_OnShow (self)
    if (CollectMeSavedVars.RndCom == nil) then
        CollectMeSavedVars.RndCom = { };
    end
    for i=1, GetNumCompanions("CRITTER") do
        local creatureID = GetCompanionInfo("CRITTER", i);
        table.insert(knownCompanions, i, creatureID);
    end
    for k,v in pairs(knownCompanions) do
        if(CollectMeSavedVars.RndCom[v] == nil) then
            CollectMeSavedVars.RndCom[v] = 5;
        end
    end 
    CollectMePanelScrollFrameUpdate();
end 

function CollectMePanelScrollFrameUpdate()
    if(knownCompanions ~= { } ) then
        local line;
        local linepulseoffset;
        local maxvalue = GetNumCompanions("CRITTER")+1;
        FauxScrollFrame_Update(CollectMePanelRndComScrollFrame,maxvalue,8,50);
        for line=1,8 do
            lineplusoffset = line + FauxScrollFrame_GetOffset(CollectMePanelRndComScrollFrame);
            if lineplusoffset < maxvalue then
                local creatureID, creatureName = GetCompanionInfo("CRITTER", lineplusoffset);
                if( CollectMeSavedVars.RndCom[creatureID] ~= nil ) then
                    _G["CollectMePanelRndComScrollFrameSlider"..line.."Text"]:SetText(creatureName);
                    _G["CollectMePanelRndComScrollFrameSlider"..line.."CreatureID"]:SetText(creatureID);
                    _G["CollectMePanelRndComScrollFrameSlider"..line]:SetValue( CollectMeSavedVars.RndCom[creatureID] );
                    _G["CollectMePanelRndComScrollFrameSlider"..line]:Show();
                end
            else
                _G["CollectMePanelRndComScrollFrameSlider"..line]:Hide();
            end
        end
    end
end

function CollectMeSlider_Change(id, value)
    local pid = tonumber(id);
    if(CollectMeSavedVars.RndCom[pid] ~= value) then
        CollectMeSavedVars.RndCom[pid] = value;
    end
end