Loot = {
    drop = {}, -- tabled used for all drops on screen
    sprite = love.graphics.newImage('assets/loot.png'),
    canvas = love.graphics.newCanvas(64, 64)
}

function Loot:init()
    love.graphics.setCanvas(self.canvas)
    love.graphics.draw(self.sprite, 0, 0, 0, 2, 2)
    love.graphics.setCanvas()
end

function Loot:draw()
    if countEntries(self.drop) > 0 then
        for id, l in pairs(self.drop) do
            love.graphics.draw(self.canvas, l.x, l.y)
        end
    end
end