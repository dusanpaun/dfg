Inventory = {}

function Inventory:init()
    self.items = {}
    self.colors = {
        background = { r = 0, g = 0, b = 0, a = 0.6 },
        inventory = {r = 0.9, g = 0.65, b = 0.2},
        slot_outline = { r = 1, g = 1, b = 1, lt = 2 }
    }
    self.panels = {
        background = { x = 0, y = 0, w = 1280, h = 720 },
        inventory = { x = 100, y = 100, w = 1030, h = 520 }
    }
end

function Inventory:addItems()
end

function Inventory:open()
    Game.states.inventoryShown = true
end

function Inventory:close()
    Game.states.inventoryShown = false
end

function Inventory:draw()
    if Game.states.inventoryShown then

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

        -- inventory
        love.graphics.setColor(
            self.colors.inventory.r,
            self.colors.inventory.g,
            self.colors.inventory.b
        )
        love.graphics.rectangle(
            "fill",
            self.panels.inventory.x,
            self.panels.inventory.y,
            self.panels.inventory.w,
            self.panels.inventory.h
        )

        -- slots
        love.graphics.setColor(
            self.colors.slot_outline.r,
            self.colors.slot_outline.g,
            self.colors.slot_outline.b
        )

        love.graphics.rectangle("fill", 1145, 45, 40, 40) -- close
        love.graphics.rectangle("fill", 1145, 520, 80, 100) -- trash

        -- 1
        love.graphics.rectangle("fill", 650, 110, 70, 70)
        love.graphics.rectangle("fill", 730, 110, 70, 70)
        love.graphics.rectangle("fill", 810, 110, 70, 70)
        love.graphics.rectangle("fill", 890, 110, 70, 70)
        love.graphics.rectangle("fill", 970, 110, 70, 70)
        love.graphics.rectangle("fill", 1050, 110, 70, 70)
        -- 2
        love.graphics.rectangle("fill", 650, 190, 70, 70)
        love.graphics.rectangle("fill", 730, 190, 70, 70)
        love.graphics.rectangle("fill", 810, 190, 70, 70)
        love.graphics.rectangle("fill", 890, 190, 70, 70)
        love.graphics.rectangle("fill", 970, 190, 70, 70)
        love.graphics.rectangle("fill", 1050, 190, 70, 70)
        -- 3
        love.graphics.rectangle("fill", 650, 270, 70, 70)
        love.graphics.rectangle("fill", 730, 270, 70, 70)
        love.graphics.rectangle("fill", 810, 270, 70, 70)
        love.graphics.rectangle("fill", 890, 270, 70, 70)
        love.graphics.rectangle("fill", 970, 270, 70, 70)
        love.graphics.rectangle("fill", 1050, 270, 70, 70)
        -- 4
        love.graphics.rectangle("fill", 650, 350, 70, 70)
        love.graphics.rectangle("fill", 730, 350, 70, 70)
        love.graphics.rectangle("fill", 810, 350, 70, 70)
        love.graphics.rectangle("fill", 890, 350, 70, 70)
        love.graphics.rectangle("fill", 970, 350, 70, 70)
        love.graphics.rectangle("fill", 1050, 350, 70, 70)
        -- 5
        love.graphics.rectangle("fill", 650, 430, 70, 70)
        love.graphics.rectangle("fill", 730, 430, 70, 70)
        love.graphics.rectangle("fill", 810, 430, 70, 70)
        love.graphics.rectangle("fill", 890, 430, 70, 70)
        love.graphics.rectangle("fill", 970, 430, 70, 70)
        love.graphics.rectangle("fill", 1050, 430, 70, 70)

        -- Info
        love.graphics.print("Health Points: " .. Player.health.cur, 650, 510)
        love.graphics.print("Magic points:  " .. Player.magicPoints, 650, 530)
        love.graphics.print("Gold: " .. Player.gold, 650, 550)
        love.graphics.print("Level:  " .. Player.level, 890, 510)
        love.graphics.print("Experience:  " .. Player.experience, 890, 530)

        love.graphics.setFont(Game.fonts.title_font)
        love.graphics.print(Player.name .. ", a Dwarf", 110, 100)
        love.graphics.setFont(Game.fonts.regular_font)
    end
end
