local T, C, L = unpack(ViksUI)

if C.datatext.Profession and C.datatext.Profession > 0 then
    local GetProfessionInfo = _G["GetProfessionInfo"]
    local GetProfessions = _G["GetProfessions"]
    local IsShiftKeyDown = _G["IsShiftKeyDown"]
    local IsControlKeyDown = _G["IsControlKeyDown"]
    local C_TradeSkillUI = _G["C_TradeSkillUI"]

    local format = string.format
    local join = string.join

    local Stat = CreateFrame("Frame", "DataTextProfession", UIParent)
    Stat:EnableMouse(true)
    Stat:SetFrameStrata("BACKGROUND")
    Stat:SetFrameLevel(3)

    local Text = Stat:CreateFontString(nil, "OVERLAY")
    Stat.text = Text -- Assign Text to Stat.text to ensure it is initialized

    if C.datatext.Profession >= 9 then
        Text:SetTextColor(unpack(C.media.pxcolor1))
        Text:SetFont(C.media.pxfontHeader, C.media.pxfontHsize, C.media.pxfontHFlag)
    else
        Text:SetTextColor(unpack(C.media.pxcolor1))
        Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
    end

    PP(C.datatext.Profession, Text)

    local function OnEvent(self)
        Text:SetText(TRADE_SKILLS) -- Tooltip holder
        self:SetAllPoints(Text)
    end

    -- OnMouseDown function to handle clicks
    local function Click(self, button)
        local prof1, prof2, archy, fishing, cooking = GetProfessions()
        
        if button == "LeftButton" then
            if IsControlKeyDown() then
                ToggleProfessionsBook() -- Open the professions book when Control + LeftButton is clicked
            elseif IsShiftKeyDown() and archy then
                local _, _, _, _, _, _, skillLineID = GetProfessionInfo(archy)
                if skillLineID then
                    C_TradeSkillUI.OpenTradeSkill(skillLineID)
                end
            elseif prof1 then
                local _, _, _, _, _, _, skillLineID = GetProfessionInfo(prof1)
                if skillLineID then
                    C_TradeSkillUI.OpenTradeSkill(skillLineID)
                end
            else
                ToggleProfessionsBook()
            end
        elseif button == "RightButton" then
            if IsShiftKeyDown() and cooking then
                local _, _, _, _, _, _, skillLineID = GetProfessionInfo(cooking)
                if skillLineID then
                    C_TradeSkillUI.OpenTradeSkill(skillLineID)
                end
            elseif prof2 then
                local _, _, _, _, _, _, skillLineID = GetProfessionInfo(prof2)
                if skillLineID then
                    C_TradeSkillUI.OpenTradeSkill(skillLineID)
                end
            end
        end
    end

    -- OnEnter function for tooltip
    local function OnEnter(self)
        local prof1, prof2, archy, fishing, cooking = GetProfessions()
        local professions = {}

        if prof1 then
            local name, texture, rank, maxRank = select(1, GetProfessionInfo(prof1))
            professions[#professions + 1] = {
                name = name,
                texture = texture,
                rank = rank,
                maxRank = maxRank
            }
        end

        if prof2 then
            local name, texture, rank, maxRank = select(1, GetProfessionInfo(prof2))
            professions[#professions + 1] = {
                name = name,
                texture = texture,
                rank = rank,
                maxRank = maxRank
            }
        end

        if archy then
            local name, texture, rank, maxRank = select(1, GetProfessionInfo(archy))
            professions[#professions + 1] = {
                name = name,
                texture = texture,
                rank = rank,
                maxRank = maxRank
            }
        end

        if fishing then
            local name, texture, rank, maxRank = select(1, GetProfessionInfo(fishing))
            professions[#professions + 1] = {
                name = name,
                texture = texture,
                rank = rank,
                maxRank = maxRank
            }
        end

        if cooking then
            local name, texture, rank, maxRank = select(1, GetProfessionInfo(cooking))
            professions[#professions + 1] = {
                name = name,
                texture = texture,
                rank = rank,
                maxRank = maxRank
            }
        end

        if #professions == 0 then return end
        sort(professions, function(a, b) return a.name < b.name end)

        GameTooltip:SetOwner(self, "ANCHOR_TOP", -20, 6)
        GameTooltip:ClearAllPoints()
        GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
        GameTooltip:ClearLines()

        for i = 1, #professions do
            GameTooltip:AddDoubleLine(
                join("", "|T", professions[i].texture, ":12:12:1:0|t  ", professions[i].name),
                join("", professions[i].rank, " / ", professions[i].maxRank),
                1, 1, 1, 1, 1, 1
            )
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("Left Click:", "Open Profession page", 1, 1, 1, 1, 1, 0)
        GameTooltip:AddDoubleLine("Shift + Left Click:", "Open Archaeology", 1, 1, 1, 1, 1, 0)
        GameTooltip:AddDoubleLine("Shift + Right Click:", "Open Cooking", 1, 1, 1, 1, 1, 0)
        GameTooltip:AddDoubleLine("Control + Left Click:", "Open Professions Book", 1, 1, 1, 1, 1, 0) -- Added tooltip for Control + LeftButton

        GameTooltip:Show()
    end

    -- OnLeave function to hide tooltip
    local function OnLeave(self)
        GameTooltip:Hide()
    end

    -- Register events and handlers
    Stat:SetScript("OnEvent", OnEvent)
    Stat:SetScript("OnMouseDown", Click)
    Stat:SetScript("OnEnter", OnEnter)
    Stat:SetScript("OnLeave", OnLeave)
    Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
    Stat:RegisterEvent("CHAT_MSG_SKILL")
    Stat:RegisterEvent("TRADE_SKILL_LIST_UPDATE")
    Stat:RegisterEvent("TRADE_SKILL_DETAILS_UPDATE")
end
