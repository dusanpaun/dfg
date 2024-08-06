systemSettings = {
    colors = {
        background = { r = 0, g = 0, b = 0, a = 0.6 },
        systemSettings = {r = 0, g = 0, b = 1},
    },
    panels = {
        background = { x = 0, y = 0, w = 1280, h = 720 },
        systemSettings = { x = 100, y = 100, w = 1030, h = 520 }
    }
}

function systemSettings:toggle()
    if not Game.states.panelPopupOpened and not Game.states.systemSettingsShown then
        Game.states.systemSettingsShown = true
        Game.states.panelPopupOpened = true
    elseif Game.states.panelPopupOpened and Game.states.systemSettingsShown then
        Game.states.systemSettingsShown = false
        Game.states.panelPopupOpened = false
    else
        Game.states.systemSettingsShown = false
    end
end

function systemSettings:close()
    Game.states.systemSettingsShown = false
    Game.states.panelPopupOpened = false
end

function systemSettings:draw()
    if Game.states.systemSettingsShown then

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

        -- notifications
        love.graphics.setColor(
            self.colors.systemSettings.r,
            self.colors.systemSettings.g,
            self.colors.systemSettings.b
        )
        love.graphics.rectangle(
            "fill",
            self.panels.systemSettings.x,
            self.panels.systemSettings.y,
            self.panels.systemSettings.w,
            self.panels.systemSettings.h
        )

        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 1145, 45, 40, 40) -- close
        love.graphics.setFont(Game.fonts.title_font)

        love.graphics.print("To quit game press q", 200, 200)
    end
end
