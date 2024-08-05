Enemy = {}

function Enemy:generate(enemyType, x, y, w, h)
    self.uuid = generateShortUUID()
    self.kind = enemyDatabase[enemyType].kind
    self.healthPoints = enemyDatabase[enemyType].healthPoints
    self.experiencePoints = enemyDatabase[enemyType].experiencePoints
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.killed = false
    self.loot = { gold = math.random(1, tonumber(enemyDatabase[enemyType].loot.maxGold)) }
    self.sprite = love.graphics.newImage('assets/enemy.png')
    self.canvas = love.graphics.newCanvas(64, 64)

    love.graphics.setCanvas(self.canvas)
    love.graphics.draw(self.sprite, 0, 0, 0, 2, 2)
    love.graphics.setCanvas()
end

function Enemy:update(player)
    if checkCollision(player, self) then
        self.killed = true
    end
    if self.killed then
        Notifications:add("You have defeten " .. self.kind .. "!")
        self:dropLoot(Loot)
        self:generate(
            "goblin", 
            math.random(Game.panels.play.x + 5, Game.panels.play.w - 60), 
            math.random(Game.panels.play.y + 5, Game.panels.play.h - 60), 
            50, 
            50
        )
    end
end

function Enemy:draw()
	if not self.killed then
        love.graphics.draw(self.canvas, self.x, self.y)
    end
end

function Enemy:dropLoot(loot)
    loot.drop[self.uuid] = { gold = self.loot.gold, x = self.x + self.w/2, y = self.y + self.h/2, w = 40, h = 40 }
end
