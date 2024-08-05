HelpScreen = {}

function HelpScreen:init()
    self.colors = {
        background = { r = 0, g = 0, b = 0, a = 0.6 },
        help = {r = 0.322, g = 0.102, b = 0.529},
    }
    self.panels = {
        background = { x = 0, y = 0, w = 1280, h = 720 },
        help = { x = 100, y = 100, w = 1080, h = 520 }
    }
end

function HelpScreen:open()
    Game.states.helpScreenShown = true
    Game.panelPopupOpened = true
end

function HelpScreen:close()
    Game.states.helpScreenShown = false
    Game.panelPopupOpened = false
end

function HelpScreen:draw()
    if Game.states.helpScreenShown then

        -- background
        love.graphics.setColor(
            self.colors.background.r, 
            self.colors.background.g,
            self.colors.background.b,
            self.colors.background.a
        )
        love.graphics.rectangle(
            "fill", 
            self.panels.background.x,
            self.panels.background.y, 
            self.panels.background.w,
            self.panels.background.h
        )

        -- help
        love.graphics.setColor(
            self.colors.help.r, 
            self.colors.help.g,
            self.colors.help.b
        )
        love.graphics.rectangle(
            "fill", 
            self.panels.help.x,
            self.panels.help.y, 
            self.panels.help.w,
            self.panels.help.h
        )

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(Game.fonts.title_font)
        love.graphics.print("Game help", 110, 100)
        love.graphics.print("Move up:       " .. GameControls.keys.move.up.prm .. " or " .. GameControls.keys.move.up.sec, 110, 150)
        love.graphics.print("Move down:   " .. GameControls.keys.move.down.prm .. " or " .. GameControls.keys.move.down.sec, 110, 180)
        love.graphics.print("Move left:   " .. GameControls.keys.move.left.prm .. " or " .. GameControls.keys.move.left.sec, 110, 210)
        love.graphics.print("Move right: " .. GameControls.keys.move.right.prm .. " or " .. GameControls.keys.move.right.sec, 110, 240)
        love.graphics.print("Action:    " .. GameControls.keys.action, 110, 300)
        love.graphics.print("Inventory: " .. GameControls.keys.inventory, 110, 330)
        love.graphics.print("Skip:      " .. GameControls.keys.skip, 110, 360)
        love.graphics.print("Quit:      " .. GameControls.keys.quit, 110, 390)
        love.graphics.setFont(Game.fonts.regular_font)
    end
end
