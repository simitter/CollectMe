local CollectMe = LibStub("AceAddon-3.0"):GetAddon("CollectMe")
local RandomMount = CollectMe:NewModule("RandomMount")
local MountDB = CollectMe:GetModule("MountDB")

function RandomMount:Summon(type)
    local db = CollectMe.db.profile
    
    if not IsMounted() then
        local zone_mounts, type_mounts, fallback_mounts, slow_mounts = {}, {}, {}, {}
        local zone_id, is_swimming, is_flyable_area = CollectMe.ZoneDB:GetZone(), IsSwimming(), IsFlyableArea()
        local InWaterSurface = is_swimming and GetTime()-MountDB:GetSurfaceDetectionTime()<1
        local collected, _, infos = MountDB:Get()
        local chat_notice = true

        --IsFlyableArea() falsely returns true for some Legion zones
        if (GetCurrentMapContinent() == -1 and select(4,GetBuildInfo()) == 70000) then
            is_flyable_area = false
        end
        
        for _,id in pairs(collected) do
            -- check if current mount is in priority pool and if it is usable here
            if db.random.mounts[id] ~= nil and db.random.mounts[id] ~= false and IsUsableSpell(id) ~= nil then
                local _,_,_,_,summonable=C_MountJournal.GetMountInfoByID(infos[id].mount_id)
                if (summonable==true) then
                    -- setting up zone table (aquatic handled by that too currently)
                    if infos[id].zones ~= nil and infos[id].zones[zone_id] ~= nil then
                        table.insert(zone_mounts, infos[id].mount_id)
                    end
                    
                    if(InWaterSurface and infos[id].type == MountDB.STRIDER) then
                        table.insert(zone_mounts, infos[id].mount_id)
                    end
                    
                    if #zone_mounts == 0 then
                        -- swimming mounts
                        if is_swimming == true then
                            if infos[id].type == MountDB.SWIM or infos[id].type == MountDB.AQUATIC or (db.summon.mounts.flying_in_water == true and infos[id].type == MountDB.FLY and is_flyable_area == true) then
                                table.insert(type_mounts, infos[id].mount_id)
                            end
                        -- flying mounts
                        elseif is_flyable_area == true then
                            if infos[id].type == MountDB.FLY then
                                table.insert(type_mounts, infos[id].mount_id)
                            end
                        end
                    end
                    if infos[id].type == MountDB.GROUND or infos[id].type == MountDB.STRIDER or (db.summon.mounts.flying_on_ground  == true and infos[id].type == MountDB.FLY) then
                        table.insert(fallback_mounts, infos[id].mount_id)
                    end
                    if infos[id].type == MountDB.SWIM then
                        table.insert(slow_mounts, infos[id].mount_id)
                    end
                else
                    chat_notice = false
                end
            end
        end

        if type == MountDB.GROUND and (#fallback_mounts > 0 or #slow_mounts > 0) then
            if #fallback_mounts > 0 then
                self:Mount(fallback_mounts)
            else
                self:Mount(slow_mounts)
            end
        elseif #zone_mounts > 0 then
            self:Mount(zone_mounts)
        elseif #type_mounts > 0 then
            self:Mount(type_mounts)
        elseif #fallback_mounts > 0 then
            self:Mount(fallback_mounts)
        elseif #slow_mounts > 0 then
            self:Mount(slow_mounts)
        else
            if IsIndoors() == false and UnitAffectingCombat("player") == false and chat_notice == true then
                CollectMe:Print(CollectMe.L["You haven't configured your mount priorities yet. Please open the random mount tab"])
            else
                --Try to summon unsummonable mount for ingame message
                C_MountJournal.SummonByID(infos[collected[1]].mount_id);
            end
        end

    elseif db.summon.mounts.no_dismount == false then
        Dismount()
    end
end

function RandomMount:Mount(t)
    local call = math.random(1, #t);
    C_MountJournal.SummonByID(t[call]);
end