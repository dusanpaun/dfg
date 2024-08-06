Game = {
    version = "v0.0.1_1",
    background = love.graphics.newImage('assets/background.png'),
    panels = {
        play          = {x = 5, y = 60,  w = 1275, h = 655},
        notifications = {x = 5, y = 455, w = 1045, h = 260}
    },
    fonts = {
        regular_font      = love.graphics.newFont('assets/SpaceMono-Regular.ttf', 18),
        regular_bold_font = love.graphics.newFont('assets/SpaceMono-Bold.ttf', 18),
        title_font        = love.graphics.newFont('assets/SpaceMono-Regular.ttf', 22),
        title_bold_font   = love.graphics.newFont('assets/SpaceMono-Bold.ttf', 22)
    },
    states = {
        introNeeded = false,
        inventoryShown = false,
        helpScreenShown = false,
        notificationsShown = false,
        systemSettingsShown = false,
        quitConfirmationShown = false,
        panelPopupOpened = false
    },
    buttons = {
        {id = 1, x = 1120, y = 5, width = 35, height = 45, color = {0, 0, 0}, hoverColor = {0.8, 0.8, 0.8, 1}, text = "NTF", action = function() Notifications:toggle() end},
        {id = 2, x = 1160, y = 5, width = 35, height = 45, color = {0.9, 0.65, 0.2}, hoverColor = {0.8, 0.8, 0.8, 1}, text = "INV", action = function() Inventory:toggle() end},
        {id = 3, x = 1200, y = 5, width = 35, height = 45, color = {0.322, 0.102, 0.529}, hoverColor = {0.8, 0.8, 0.8, 1}, text = "HLP", action = function() HelpScreen:toggle() end},
        {id = 4, x = 1240, y = 5, width = 35, height = 45, color = {0, 0, 1}, hoverColor = {0.8, 0.8, 0.8, 1}, text = "SYS", action = function() systemSettings:toggle() end}
    },
    systemButtons = {
        {id = 1, x = 1145, y = 45, width = 40, height = 45, color = {1, 1, 1}, hoverColor = {1, 0, 0, 1}, text = "CLS", action = function() Game:popupClose() end},
    }
}

function Game:init()
    Notifications:add("Welcome to DFG! " .. self.version)
    love.graphics.setFont(self.fonts.regular_font)    -- Setting default game font
    math.randomseed(os.time())                        -- Providing random seed for uuid generator for each new game
end

function Game:intro()
    if self.states.introNeeded then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0 , 0, 1280, 720)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("My name is Bélgar Umrend, a dwarf.", 10, 10)
        love.graphics.print("A few days ago, I reached my 80th year and with it, I was granted the", 10, 50)
        love.graphics.print("right of passage to traverse what remains of our shattered world.", 10, 70)
        love.graphics.print("With me, I carry all that remains of my past: a small pendant etched with the name \"Bélgar\",", 10, 110)
        love.graphics.print("a sword weathered by countless battles, armor that echoes the remnants of a lost era and", 10, 130)
        love.graphics.print("all overshadowed by a deep, relentless yearning to learn to the place of my birth...", 10 , 150)
        love.graphics.print("Press SPACE to continue...", 10, 680)
    end
end

function Game:drawGui()
    love.graphics.setColor(0, 0.6, 0.6) -- used as a shader for bright image can be removed later on

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.draw(self.background, 0, 0, 0, screenWidth / self.background:getWidth(), screenHeight / self.background:getHeight())
    love.graphics.setColor(1, 1, 1)
end

function Game:popupClose()
    if self.states.inventoryShown then Inventory:close() end
    if self.states.helpScreenShown then HelpScreen:close() end
    if self.states.notificationsShown then Notifications:close() end
    if self.states.systemSettingsShown then systemSettings:close() end
end

function Game:drawPlayScreen()
    local barWidth = 150
    local barHight = 20
    local fillHealthWidth = (Player.health.cur / Player.health.max) * barWidth
    local fillStaminaWidth = (Player.stamina.cur / Player.stamina.max) * barWidth

    -- under
    love.graphics.setColor(0.4,0.7,0.4)
    love.graphics.rectangle("fill", 0, 0, 1280, 55)

    -- health
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", 5, 5, barWidth, barHight)
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line", 5, 5, barWidth, barHight)
    love.graphics.rectangle("fill", 5, 5, fillHealthWidth, barHight)
    love.graphics.setFont(self.fonts.regular_bold_font)
    love.graphics.print(Player.health.cur .. "/" .. Player.health.max .. "(" .. (Player.health.cur/Player.health.max)*100 .. "%)", 160, 0)
    love.graphics.setFont(self.fonts.regular_font)

    -- stamina
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", 5, 30, barWidth, barHight)
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("line", 5, 30, barWidth, barHight)
    love.graphics.rectangle("fill", 5, 30, fillStaminaWidth, barHight)
    love.graphics.setFont(self.fonts.regular_bold_font)
    love.graphics.print(Player.stamina.cur .. "/" .. Player.stamina.max .. "(" .. (Player.stamina.cur/Player.stamina.max)*100 .. "%)", 160, 25)
    love.graphics.setFont(self.fonts.regular_font)

    for _, button in ipairs(self.buttons) do
        if button == hoveredButton and not Game.states.panelPopupOpened then
            love.graphics.setColor(button.hoverColor)
        else
            love.graphics.setColor(button.color)
        end
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
        love.graphics.setColor(1, 1, 1)  -- White text
        love.graphics.printf(button.text, button.x, button.y + button.height / 2 - 10, button.width, "center")
    end
end

function Game:drawCloseButtons()
    for _, button in ipairs(self.systemButtons) do
        love.graphics.setColor(button.hoverColor)
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
        love.graphics.setColor(1, 1, 1)  -- White text
        love.graphics.printf(button.text, button.x, button.y + button.height / 2 - 10, button.width, "center")
    end
end
