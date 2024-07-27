local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end
		
----------------------------------------------------------------------------------------
--	WorldMap skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	if IsAddOnLoaded("Mapster") then return end

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("VARIABLES_LOADED")
	frame:SetScript("OnEvent", function()
		SetCVar("miniWorldMap", 1)
	end)

	WorldMapFrame:StripTextures()
	WorldMapFramePortrait:SetAlpha(0)
	WorldMapFrame:CreateBackdrop("Default")
	WorldMapFrame.backdrop:ClearAllPoints()
	WorldMapFrame.ScrollContainer:CreateBackdrop()
	
	WorldMapFrame.backdrop:SetPoint("TOPLEFT", WorldMapFrame, "TOPLEFT", -4, 0)
	WorldMapFrame.backdrop:SetPoint("BOTTOMRIGHT", WorldMapFrame, "BOTTOMRIGHT", 0, -9)
	WorldMapFrame.Header = CreateFrame("Frame", nil, WorldMapFrame)
	WorldMapFrame.Header:SetTemplate("Overlay")

	WorldMapFrame.BorderFrame:StripTextures()
	WorldMapFrame.BorderFrame.NineSlice:Hide()
	WorldMapFrame.BorderFrame.Tutorial:Kill()
	WorldMapFrame.BorderFrame:SetFrameStrata(WorldMapFrame:GetFrameStrata())

	QuestMapFrame:StripTextures()
	QuestMapFrame:CreateBackdrop("Overlay")
	QuestMapFrame.backdrop:ClearAllPoints()
	QuestMapFrame.backdrop:SetPoint("BOTTOMLEFT", WorldMapFrame.ScrollContainer, "BOTTOMRIGHT", 4, -2)
	QuestMapFrame.backdrop:SetSize(326, 469)

	QuestMapFrame.SettingsDropdown:ClearAllPoints()
	QuestMapFrame.SettingsDropdown:SetPoint("TOPRIGHT", QuestMapFrameBackdrop, "TOPRIGHT", -5, -3)

	QuestScrollFrame:ClearAllPoints()
	QuestScrollFrame:SetPoint("TOP", QuestMapFrameBackdrop, "TOP", 0, -3)
	QuestScrollFrame:SetPoint("LEFT", QuestMapFrameBackdrop, "LEFT", -3, 0)

	QuestScrollFrame.Contents.Separator.Divider:Hide()
	QuestScrollFrame.Edge:Hide()
	QuestScrollFrame.Background:Hide()
	T.SkinEditBox(QuestScrollFrame.SearchBox)

	local CampaignOverview = QuestMapFrame.CampaignOverview
	CampaignOverview:StripTextures()
	CampaignOverview.ScrollFrame:StripTextures()
	T.SkinScrollBar(CampaignOverview.ScrollFrame.ScrollBar)
	CampaignOverview:CreateBackdrop("Overlay")
	CampaignOverview.backdrop:SetPoint("TOPLEFT", CampaignOverview.Header, "TOPLEFT",  8, -2)
	CampaignOverview.backdrop:SetPoint("BOTTOMRIGHT", CampaignOverview.Header, "BOTTOMRIGHT", -4, 10)
	CampaignOverview.backdrop.overlay:SetVertexColor(1, 1, 1, 0.2)
	CampaignOverview.Header.Background:SetAlpha(0)
	CampaignOverview.Header.TopFiligree:Hide()

	do
		local frame = QuestScrollFrame.Contents.StoryHeader
		frame:CreateBackdrop("Overlay")
		frame.backdrop:SetPoint("TOPLEFT", 6, -9)
		frame.backdrop:SetPoint("BOTTOMRIGHT", -6, 11)
		frame.HighlightTexture:Hide()
		frame.Background:SetAlpha(0)
		frame.Divider:SetAlpha(0)
		frame.backdrop.overlay:SetVertexColor(1, 1, 1, 0.2)
	end

	QuestScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestScrollFrame, "TOPRIGHT", 2, -18)
	QuestScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestScrollFrame, "BOTTOMRIGHT", 2, 15)
	T.SkinScrollBar(QuestScrollFrame.ScrollBar)

	local QuestScrollFrameTopBorder = CreateFrame("Frame", "$parentBorder", QuestScrollFrame)
	QuestScrollFrameTopBorder:CreateBackdrop("Overlay")
	QuestScrollFrameTopBorder.backdrop:ClearAllPoints()
	QuestScrollFrameTopBorder.backdrop:SetSize(326, 23)
	QuestScrollFrameTopBorder.backdrop:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)

	local QuestScrollFrameTopBorder = CreateFrame("Frame", "$parentBorder", QuestMapFrame.CampaignOverview)
	QuestScrollFrameTopBorder:CreateBackdrop("Overlay")
	QuestScrollFrameTopBorder.backdrop:ClearAllPoints()
	QuestScrollFrameTopBorder.backdrop:SetSize(326, 23)
	QuestScrollFrameTopBorder.backdrop:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)

	QuestMapFrame.DetailsFrame:ClearAllPoints()
	QuestMapFrame.DetailsFrame:SetPoint("TOPRIGHT", QuestMapFrame, "TOPRIGHT", -12, -1)
	QuestMapDetailsScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestMapDetailsScrollFrame, "TOPRIGHT", 1, -26)
	QuestMapDetailsScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestMapDetailsScrollFrame, "BOTTOMLEFT", 13, 27)
	T.SkinScrollBar(QuestMapDetailsScrollFrame.ScrollBar)

	QuestScrollFrame.BorderFrame:StripTextures()

	QuestMapDetailsScrollFrame:SetHeight(340)
	QuestMapDetailsScrollFrame:SetPoint("TOPLEFT", QuestMapFrame.DetailsFrame, "TOPLEFT", 1, -35)

	QuestMapFrame.DetailsFrame:StripTextures()
	QuestMapFrame.DetailsFrame.RewardsFrameContainer.RewardsFrame:StripTextures()
	QuestMapFrame.DetailsFrame.Bg:Hide()

	QuestMapFrame.DetailsFrame.BackFrame:StripTextures()
	QuestMapFrame.DetailsFrame.BackFrame.BackButton:SkinButton()
	QuestMapFrame.DetailsFrame.BackFrame.BackButton:ClearAllPoints()
	QuestMapFrame.DetailsFrame.BackFrame.BackButton:SetPoint("TOPLEFT", QuestMapFrame, "TOPLEFT", 2, -8)
	QuestMapFrame.DetailsFrame.BackFrame.BackButton:SetSize(326, 23)
	
	local AbandonButton = QuestMapFrame.DetailsFrame.AbandonButton
	AbandonButton:SkinButton()
	AbandonButton:ClearAllPoints()
	AbandonButton:SetPoint("BOTTOMLEFT", QuestMapFrame.backdrop, "BOTTOMLEFT", 4, 4)

	local TrackButton = QuestMapFrame.DetailsFrame.TrackButton
	TrackButton:SkinButton()
	TrackButton:SetSize(90, 22)
	TrackButton:ClearAllPoints()
	TrackButton:SetPoint("BOTTOMRIGHT", QuestMapFrame.backdrop, "BOTTOMRIGHT", -4, 4)

	local ShareButton = QuestMapFrame.DetailsFrame.ShareButton
	ShareButton:SkinButton(true)
	ShareButton:ClearAllPoints()
	ShareButton:SetPoint("LEFT", AbandonButton, "RIGHT", 3, 0)
	ShareButton:SetPoint("RIGHT", TrackButton, "LEFT", -3, 0)

	--FIXME QuestMapFrame.DetailsFrame.CompleteQuestFrame:StripTextures()
	-- QuestMapFrame.DetailsFrame.CompleteQuestFrame.CompleteButton:SkinButton(true)
	-- QuestMapFrame.DetailsFrame.CompleteQuestFrame.CompleteButton:SetPoint("TOP", 0, 4)

	-- Quests Buttons
	for i = 1, 2 do
		local button = i == 1 and WorldMapFrame.SidePanelToggle.CloseButton or WorldMapFrame.SidePanelToggle.OpenButton
		local texture = i == 1 and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up"

		button:ClearAllPoints()
		button:SetPoint("BOTTOMRIGHT", -2, 2)
		button:SetSize(20, 20)
		button:StripTextures()
		button:SetTemplate("Default")
		button:StyleButton()

		button.icon = button:CreateTexture(nil, "BORDER")
		button.icon:SetTexture(texture)
		button.icon:SetTexCoord(0.3, 0.29, 0.3, 0.79, 0.65, 0.29, 0.65, 0.79)
		button.icon:ClearAllPoints()
		button.icon:SetPoint("TOPLEFT", 2, -2)
		button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
	end

	WorldMapFrame.NavBar:StripTextures()
	WorldMapFrame.NavBar.overlay:StripTextures()
	WorldMapFrameHomeButton:SkinButton(true)
	WorldMapFrame.NavBar.homeButton.xoffset = 1
	WorldMapFrame.NavBar.homeButton.text:SetFont(C.media.normal_font, 14)
	
	WorldMapFrame.BorderFrame.TitleContainer.TitleText:ClearAllPoints()
	WorldMapFrame.BorderFrame.TitleContainer.TitleText:SetPoint("CENTER", WorldMapFrame.Header)

	T.SkinCloseButton(WorldMapFrameCloseButton)
	T:HandleMaxMinFrame(WorldMapFrame.BorderFrame.MaximizeMinimizeFrame)
	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame:ClearAllPoints()
	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame:SetPoint('RIGHT', WorldMapFrame.BorderFrame.CloseButton, 'LEFT', 6, 0)															 

	local MapLegend = QuestMapFrame.MapLegend
	MapLegend.BackButton:SkinButton()
	MapLegend.BorderFrame:SetAlpha(0)

	local MapLegendScroll = MapLegend.ScrollFrame
	MapLegendScroll:StripTextures()
	MapLegendScroll:SetTemplate()
	T.SkinScrollBar(MapLegendScroll.ScrollBar)
	
	-- Floor Dropdown
	local function WorldMapFloorNavigationDropDown(frame)
		T.SkinDropDownBox(frame)
		frame:SetPoint("TOPLEFT", 6, -68)
	end

	-- Tracking Button
	local function WorldMapTrackingOptionsButton(button)
		local shadow = button:GetRegions()
		shadow:Hide()

		button.Background:Hide()
		button.Border:Hide()

		local tex = button:GetHighlightTexture()
		tex:SetTexture([[Interface\Minimap\Tracking\None]], "ADD")
		tex:SetAllPoints(button.Icon)
	end

	-- Tracking Pin
	local function WorldMapTrackingPinButton(button)
		local shadow = button:GetRegions()
		shadow:Hide()

		button.Background:Hide()
		button.IconOverlay:SetAlpha(0)
		button.Border:Hide()

		local tex = button:GetHighlightTexture()
		tex:SetAtlas("Waypoint-MapPin-Untracked")
		tex:SetAllPoints(button.Icon)
	end

	local function HandyNotesButton(button)
		local shadow = button:GetRegions()
		shadow:Hide()

		button.Background:Hide()
		button.IconOverlay:SetAlpha(0)
		button.Border:Hide()

		local tex = button:GetHighlightTexture()
		tex:SetAtlas(button.Icon:GetTexture())
		tex:SetAllPoints(button.Icon)
	end

	-- Elements
	WorldMapFloorNavigationDropDown(WorldMapFrame.overlayFrames[1])
	WorldMapTrackingOptionsButton(WorldMapFrame.overlayFrames[2])
	WorldMapTrackingPinButton(WorldMapFrame.overlayFrames[3])

	for i = 1, 10 do
		local button = _G["Krowi_WorldMapButtons"..i]
		if button then
			HandyNotesButton(button)
		end
	end

	for i = 3, #WorldMapFrame.overlayFrames do
		local frame = WorldMapFrame.overlayFrames[i]
		if frame.BountyDropdownButton then
			T.SkinNextPrevButton(frame.BountyDropdownButton)
			break
		end
	end

	-- QuestSessionManagement skin (based on skin from Aurora)
	QuestMapFrame.QuestSessionManagement:StripTextures()

	local ExecuteSessionCommand = QuestMapFrame.QuestSessionManagement.ExecuteSessionCommand
	ExecuteSessionCommand:SetTemplate("Default")
	ExecuteSessionCommand:StyleButton()

	local icon = ExecuteSessionCommand:CreateTexture(nil, "ARTWORK")
	icon:SetPoint("TOPLEFT", 0, 0)
	icon:SetPoint("BOTTOMRIGHT", 0, 0)
	ExecuteSessionCommand.normalIcon = icon

	local sessionCommandToButtonAtlas = { -- Skin from Aurora
		[_G.Enum.QuestSessionCommand.Start] = "QuestSharing-DialogIcon",
		[_G.Enum.QuestSessionCommand.Stop] = "QuestSharing-Stop-DialogIcon"
	}

	hooksecurefunc(QuestMapFrame.QuestSessionManagement, "UpdateExecuteCommandAtlases", function(self, command)
		self.ExecuteSessionCommand:SetNormalTexture(0)
		self.ExecuteSessionCommand:SetPushedTexture(0)
		self.ExecuteSessionCommand:SetDisabledTexture(0)

		local atlas = sessionCommandToButtonAtlas[command]
		if atlas then
			self.ExecuteSessionCommand.normalIcon:SetAtlas(atlas)
		end
	end)

	hooksecurefunc(QuestSessionManager, "NotifyDialogShow", function(_, dialog)
		if not dialog.isSkinned then
			dialog:StripTextures()
			dialog:SetTemplate("Transparent")
			dialog.ButtonContainer.Confirm:SkinButton()
			dialog.ButtonContainer.Decline:SkinButton()
			if dialog.MinimizeButton then
				T.SkinCloseButton(dialog.MinimizeButton, nil, "-")
			end
			dialog.isSkinned = true
		end
	end)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)