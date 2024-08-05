Notifications = {}

function Notifications:init()
    self.messages = {}
    self.maxShow = 12
    self.h = 20
    self.area = { 
        x = Game.panels.notifications.x, 
        y = Game.panels.notifications.y, 
        w = Game.panels.notifications.w, 
        h = Game.panels.notifications.h
    }
end

function Notifications:add(message)
    table.insert(self.messages, message)
    if #self.messages > self.maxShow then
        table.remove(self.messages, 1)
    end
end

function Notifications:draw()
    love.graphics.setLineWidth(3)
    love.graphics.setColor(0.1, 0.1, 0.1, 0.8)
    love.graphics.rectangle("fill", self.area.x, self.area.y, self.area.w, self.area.h)

    love.graphics.setColor(1, 1, 1)
    local startIndex = math.max(1, #self.messages - self.maxShow + 1)

    -- Draw notifications in reverse order to show the latest one at the top
    for i = #self.messages, startIndex, -1 do
        local yPosition = self.area.y + (#self.messages - i) * self.h
        -- Ensure notifications are drawn within the fixed area
        if yPosition >= self.area.y and yPosition < self.area.y + self.area.h then
            love.graphics.print(self.messages[i], self.area.x + 5, yPosition)
        end
    end
end