Notifications = {
    messages_full = {},
    messages_quick = {},
    maxShow_full = 25,
    maxShow_quick = 3,
    h = 20,
    h_quick = 15,
    colors = {
        background = { r = 0, g = 0, b = 0, a = 0.6 },
        notifications = {r = 0, g = 0, b = 0},
    },
    panels = {
        background = { x = 0, y = 0, w = 1280, h = 720 },
        notifications_full = { x = 100, y = 100, w = 1030, h = 520 },
        notifications_quick = { x = 290, y = 0, w = 825, h = 55 }
    }
}

function Notifications:add(message)
    table.insert(self.messages_full, message)
    if #self.messages_full > self.maxShow_full then
        table.remove(self.messages_full, 1)
    end
    table.insert(self.messages_quick, message)
    if #self.messages_quick > self.maxShow_quick then
        table.remove(self.messages_quick, 1)
    end
end

function Notifications:toggle()
    if not Game.states.panelPopupOpened and not Game.states.notificationsShown then
        Game.states.notificationsShown = true
        Game.states.panelPopupOpened = true
    elseif Game.states.panelPopupOpened and Game.states.notificationsShown then
        Game.states.notificationsShown = false
        Game.states.panelPopupOpened = false
    else
        Game.states.notificationsShown = false
    end
end

function Notifications:close()
    Game.states.notificationsShown = false
    Game.states.panelPopupOpened = false
end

function Notifications:draw()
    if Game.states.notificationsShown then

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
            self.colors.notifications.r,
            self.colors.notifications.g,
            self.colors.notifications.b
        )
        love.graphics.rectangle(
            "fill",
            self.panels.notifications_full.x,
            self.panels.notifications_full.y,
            self.panels.notifications_full.w,
            self.panels.notifications_full.h
        )

        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 1145, 45, 40, 40) -- close
        love.graphics.setFont(Game.fonts.title_font)

        local startIndex = math.max(1, #self.messages_full - self.maxShow_full + 1)

        for i = #self.messages_full, startIndex, -1 do -- Draw notifications in reverse order to show the latest one at the top
            local yPosition = self.panels.notifications_full.y + (#self.messages_full - i) * self.h
            if yPosition >= self.panels.notifications_full.y and yPosition < self.panels.notifications_full.y + self.panels.notifications_full.h then -- Ensure notifications are drawn within the fixed area
                love.graphics.print(self.messages_full[i], self.panels.notifications_full.x + 5, yPosition)
            end
        end
    end
    love.graphics.setFont(Game.fonts.regular_font)
    love.graphics.setColor(
            self.colors.background.r,
            self.colors.background.g,
            self.colors.background.b
        )
    love.graphics.rectangle(
        "fill",
        self.panels.notifications_quick.x,
        self.panels.notifications_quick.y,
        self.panels.notifications_quick.w,
        self.panels.notifications_quick.h
    )

    if Game.states.panelPopupOpened then
        love.graphics.setColor(1,1,1,0.6)
    else
        love.graphics.setColor(1,1,1)
    end

    local startIndexQ = math.max(1, #self.messages_quick - self.maxShow_quick + 1)
    for i = #self.messages_quick, startIndexQ, -1 do -- Draw notifications in reverse order to show the latest one at the top
        local yPositionQ = self.panels.notifications_quick.y + (#self.messages_quick - i) * self.h_quick
        if yPositionQ >= self.panels.notifications_quick.y and yPositionQ < self.panels.notifications_quick.y + self.panels.notifications_quick.h then -- Ensure notifications are drawn within the fixed area
            love.graphics.print(self.messages_quick[i], self.panels.notifications_quick.x + 5, yPositionQ - 3) -- -3 is an offset to increase draw position
        end
    end

    love.graphics.setColor(1,1,1)
end
