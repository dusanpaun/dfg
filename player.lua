Player = {
    name = "Bélgar Umrend",
    health = { max = 10, cur = 10 },
    stamina = { max = 20, cur = 20 },
    alive = true,
	level = 1,
	experience = 0,
	x = 100,
	y = 100,
    w = 64,
    h = 64,
	speed = 500,
    gold = 10,
    sprite = love.graphics.newImage('assets/dwarf.png'),
    canvas = love.graphics.newCanvas(64, 64)
}

function Player:init()
    love.graphics.setCanvas(self.canvas)
    love.graphics.draw(self.sprite, 0, 0, 0, 2, 2)
    love.graphics.setCanvas()
end

function Player:update(dt, loot)
    self:move(dt)
    self:nearLoot(loot)
end

function Player:move(dt)
    local dx, dy = 0, 0
    local playArea = {
        x = Game.panels.play.x,
        y = Game.panels.play.y,
        w = Game.panels.play.w,
        h = Game.panels.play.h
    }
    if not gameIntroState then
        if love.keyboard.isDown(GameControls.keys.move.up.prm) or
            love.keyboard.isDown(GameControls.keys.move.up.sec) then
            dy = dy - 1
        end
        if love.keyboard.isDown(GameControls.keys.move.down.prm) or
        love.keyboard.isDown(GameControls.keys.move.down.sec) then
            dy = dy + 1
        end
        if love.keyboard.isDown(GameControls.keys.move.left.prm) or
        love.keyboard.isDown(GameControls.keys.move.left.sec) then
            dx = dx - 1
        end
        if love.keyboard.isDown(GameControls.keys.move.right.prm) or
        love.keyboard.isDown(GameControls.keys.move.right.sec) then
            dx = dx + 1
        end
    end

    -- Normalize direction vector if it's not zero
    local length = math.sqrt(dx * dx + dy * dy)
    if length > 0 then
        dx = dx / length
        dy = dy / length
    end

    -- Update player position
    self.x = self.x + dx * self.speed * dt
    self.y = self.y + dy * self.speed * dt

    -- Limit player movement to playArea
    if self.x < playArea.x then
        self.x = playArea.x
    elseif self.x + self.w > playArea.x + playArea.w then
        self.x = playArea.x + playArea.w - self.w
    end

    if self.y < playArea.y then
        self.y = playArea.y
    elseif self.y + self.h > playArea.y + playArea.h then
        self.y = playArea.y + playArea.h - self.h
    end
end

function Player:draw()
    love.graphics.draw(self.canvas, self.x, self.y)
end

function Player:pickUpLoot(lootId)
    if Loot.drop[lootId] then
        self.gold = self.gold + Loot.drop[lootId].gold
        Notifications:add("You picked up gold " .. Loot.drop[lootId].gold)
        Loot.drop[lootId] = nil
    end
end

function Player:nearLoot(loot)
    for id, info in pairs(loot.drop) do
        if self.x < info.x + info.w and self.x + self.w > info.x and self.y < info.y + info.h and self.y + self.h > info.y then
            return id -- Return the ID of the loot item if there is a collision
        end
    end
    return nil -- No collision detected
end

function Player:maxHealthInc(x)
    self.health.max = self.health.max + x
end

function Player:maxHealthDec(x)
    self.health.max = self.health.max - x
end

function Player:curHealthInc(x)
    self.health.cur = self.health.cur + x
end

function Player:curHealthDec(x)
    self.health.cur = self.health.cur - x
end
