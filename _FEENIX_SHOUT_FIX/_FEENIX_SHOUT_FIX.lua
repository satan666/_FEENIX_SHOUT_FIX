local flf = CreateFrame("frame",nil, UIParent); 

flf:RegisterEvent("ADDON_LOADED");
flf:RegisterEvent("PLAYER_AURAS_CHANGED");

FLF_Event = function()
	if event == "ADDON_LOADED" then
		flf:UnregisterEvent("ADDON_LOADED");
		DEFAULT_CHAT_FRAME:AddMessage("_FEENIX_SHOUT_FIX by Ogrisch loaded");
	elseif event == "PLAYER_AURAS_CHANGED" then
		Fix_CancelBattleShout();
	end
end

flf:SetScript("OnEvent",FLF_Event);

function Fix_CancelBattleShout()
	local buff = {"Ability_Warrior_BattleShout"}
	local counter = 0
	while GetPlayerBuff(counter) >= 0 do
		local index, untilCancelled = GetPlayerBuff(counter)
		if untilCancelled ~= 1 then
			local i =1
			while buff[i] do
				if string.find(GetPlayerBuffTexture(index), buff[i]) then
					CancelPlayerBuff(index);
					UIErrorsFrame:Clear();
					UIErrorsFrame:AddMessage("Battle Shout Removed");
					return
				end
				i = i + 1
			end	
		end
		counter = counter + 1
	end
	return nil
end