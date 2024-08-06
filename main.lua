require "enemy"
require "game"
require "gameControls"
require "gameDatabase"
require "helpScreen"
require "inventory"
require "loot"
require "notifications"
require "player"
require "system"
require "tools"

function love.load()
    Game:init()
    Player:init()
    Loot:init()
    Enemy:generate("goblin", 250, 250, 50, 50)
end

function love.update(dt)
    Player:update(dt, Loot)
    Enemy:update(Player)
end

function love.draw()
    Game:drawGui()
    Loot:draw()
    Enemy:draw()
    Player:draw()
    Game:intro()
    if not Game.states.introNeeded then Game:drawPlayScreen() end
    Inventory:draw()
    HelpScreen:draw()
    Notifications:draw()
end
