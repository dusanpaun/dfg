require "game"
require "gameDatabase"
require "gameControls"
require "enemy"
require "player"
require "notifications"
require "tools"
require "loot"
require "inventory"
require "help"
require "system"

function love.load()
    Game:init()
    Player:init()
    Loot:init()
    Inventory:init()
    SystemSettings:init()
    HelpScreen:init()
    GameControls:init()
    Enemy:generate("robot", 250, 250, 50, 50)
end

function love.update(dt)
    Player:update(dt, Loot)
    Enemy:update(Player)
end

function love.draw()
    Game:drawGui()
    Notifications:draw()
    Loot:draw()
    Enemy:draw()
    Player:draw()
    Game:intro()
    if not Game.states.introNeeded then
        Game:drawPlayScreen()
    end
    Inventory:draw()
    HelpScreen:draw()
end
