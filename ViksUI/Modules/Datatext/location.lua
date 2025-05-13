local T, C, L = unpack(ViksUI)

-- Exit early if the location datatext is disabled
if not C.datatext.location or C.datatext.location <= 0 then return end

-- Create the Stat frame
local Stat = CreateFrame("Frame", "DataTextLocation", UIParent)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)

-- Create the FontString for displaying location information
local Text = Stat:CreateFontString(nil, "OVERLAY")
Text:SetTextColor(unpack(C.media.pxcolor1))
Text:SetFont(
    C.datatext.location >= 9 and C.media.pxfontHeader or C.media.pixel_font,
    C.datatext.location >= 9 and C.media.pxfontHsize or C.media.pixel_font_size,
    C.datatext.location >= 9 and C.media.pxfontHFlag or C.media.pixel_font_style
)

PP(C.datatext.location, Text)

-- Function to determine zone coloring based on PVP type
local function GetZoneColor()
    local pvpType = GetZonePVPInfo()
    if pvpType == "arena" or pvpType == "combat" or pvpType == "hostile" then
        return 0.84, 0.03, 0.03 -- Red
    elseif pvpType == "friendly" then
        return 0.05, 0.85, 0.03 -- Green
    elseif pvpType == "contested" then
        return 0.9, 0.85, 0.05 -- Yellow
    elseif pvpType == "sanctuary" then
        return 0.035, 0.58, 0.84 -- Blue
    else
        return 1, 1, 0 -- Default Yellow
    end
end

-- Cache for map rectangles
local mapRects, tempVec2D = {}, CreateVector2D(0, 0)

-- Function to get the player's map position
local function GetPlayerMapPosition(mapID)
    if not mapID then return 0, 0 end

    tempVec2D.x, tempVec2D.y = UnitPosition("player")
    if not tempVec2D.x then return 0, 0 end

    -- Retrieve or calculate the map rectangle
    local mapRect = mapRects[mapID]
    if not mapRect then
        local _, pos1 = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(0, 0))
        local _, pos2 = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(1, 1))
        if not pos1 or not pos2 then return 0, 0 end

        mapRect = { pos1, pos2 }
        mapRect[2]:Subtract(mapRect[1])
        mapRects[mapID] = mapRect
    end

    tempVec2D:Subtract(mapRect[1])
    return (tempVec2D.y / mapRect[2].y), (tempVec2D.x / mapRect[2].x)
end

-- Update function for the Stat frame
local function Update(self, elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed
    if self.elapsed < 0.3 then return end -- Throttle updates to every 0.3 seconds
    self.elapsed = 0

    local subZoneText = GetMinimapZoneText() or ""
    local zoneText = _G.GetRealZoneText() or _G.UNKNOWN
    local displayLine = (subZoneText ~= "" and subZoneText ~= zoneText) and (zoneText .. ": " .. subZoneText) or subZoneText

    local r, g, b = GetZoneColor()
    local _, instanceType = IsInInstance()

    if instanceType == "raid" or instanceType == "party" then
        Text:SetText(string.format("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, displayLine))
    else
        local unitMap = C_Map.GetBestMapForUnit("player")
        local x, y = GetPlayerMapPosition(unitMap)
        x, y = math.floor(100 * x), math.floor(100 * y)

        if C.datatext.showcoords then
            Text:SetText(string.format("%s%d %s |cff%02x%02x%02x%s|r %s%d", qColor, x, qColor, r * 255, g * 255, b * 255, displayLine, qColor, y))
        else
            Text:SetText(string.format("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, displayLine))
        end
    end
end

-- Set the OnUpdate script for the Stat frame
Stat:SetScript("OnUpdate", Update)
