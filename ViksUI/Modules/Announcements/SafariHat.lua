local T, C, L = unpack(ViksUI)
if C.announcements.safari_hat ~= true then return end

----------------------------------------------------------------------------------------
--	Check Safari Hat
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_Collections" then
		if not PlayerHasToy(92738) then return end
		local button = CreateFrame("Button", "PetJournalSafariButton", PetJournal, "SecureActionButtonTemplate")
		button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
		button:SetSize(36, 36)
		button:SetAttribute("type", "toy")
		button:SetAttribute("toy", 92738)

		if not button.icon then
			button.icon = button:CreateTexture("$parentIcon")
			button.icon:SetAllPoints()

			button.border = button:CreateTexture("$parentBorder")
			button.border:SetOutside(button)

			button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
			button:GetHighlightTexture():SetBlendMode("ADD")
		end

		if C.skins.blizzard_frames == true then
			button:SetPoint("TOPLEFT", PetJournal, "TOPRIGHT", 1, 0)
			button:SetTemplate("Default")
			button:StyleButton()
			button:SetNormalTexture(0)
			button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			button.icon:ClearAllPoints()
			button.icon:SetPoint("TOPLEFT", 2, -2)
			button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
			button.icon:SetDrawLayer("OVERLAY")
		else
			button:SetPoint("TOPLEFT", PetJournal, "TOPRIGHT", 3, -24)
			button.border:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")
			button.border:SetTexCoord(0.01562500, 0.67187500, 0.39843750, 0.72656250)
		end

		button.icon:SetTexture(774766)

		button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 5, 0)
			GameTooltip:SetToyByItemID(92738)
		end)

		button:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	end
end)

local announceFrame = CreateFrame("Frame")
announceFrame:RegisterEvent("PET_BATTLE_OPENING_DONE")
announceFrame:RegisterEvent("PET_BATTLE_OVER")
announceFrame:SetScript("OnEvent", function(_, event)
	if event == "PET_BATTLE_OPENING_DONE" then
		local name = GetSpellInfo(158486)
		if PlayerHasToy(92738) and not T.CheckPlayerBuff(name) then
			local maxlevel = true
			for i = 1, 3 do
				local level = C_PetBattles.GetLevel(1, i)
				if level and level < 25 then
					maxlevel = false
				end
			end
			if maxlevel then return end
			PlaySound(12867, "master")
			RaidNotice_AddMessage(RaidWarningFrame, RESISTANCE_NONE.." "..C_Spell.GetSpellLink(158486).."!", ChatTypeInfo["RAID_WARNING"])
			print("|cffff3300"..RESISTANCE_NONE.." "..C_Spell.GetSpellLink(158486).."|cffff3300!|r")
		end
	end
end)