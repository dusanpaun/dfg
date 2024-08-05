GameControls = {}

function GameControls:init()
    self.keys = {
        move = {
            up = {
                prm = "up",
                sec = "w"
            },
            down = {
                prm = "down",
                sec = "s"
            },
            left = {
                prm = "left",
                sec = "a"
            },
            right = {
                prm = "right",
                sec = "d"
            }
        },
        action = "e",
        inventory = "i",
        help = "h",
        quit = "q",
        skip = "space"
    }
end

function love.keypressed(key)
    if key == GameControls.keys.quit then
        love.event.quit()
    end
    if key == GameControls.keys.skip then
        Game.states.introNeeded = false
    end
    if key == GameControls.keys.action then
        if Player:nearLoot(Loot) then
            Player:pickUpLoot(Player:nearLoot(Loot))
        else
            print("There is no loot to pick up")
        end
    end
    if key == GameControls.keys.inventory then
        if Game.states.inventoryShown then
            Inventory:close()
        else
            Inventory:open()
        end
    end
    if key == GameControls.keys.help then
        if Game.states.helpScreenShown then
            HelpScreen:close()
        else
            HelpScreen:open()
        end
    end
end

hoveredButton = nil
clickedButton = nil

function love.mousemoved(x, y, dx, dy, istouch)
    hoveredButton = nil
    for _, button in ipairs(Game.buttons) do
        if x >= button.x and x <= button.x + button.width and
           y >= button.y and y <= button.y + button.height then
            hoveredButton = button
            break
        end
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    print("Mouse pressed detected at: ", x, y)  -- Debug print
    if button == 1 then  -- Left mouse button
        for _, btn in ipairs(Game.buttons) do
            if x >= btn.x and x <= btn.x + btn.width and
               y >= btn.y and y <= btn.y + btn.height then
                print("Button clicked: ", btn.id)  -- Debug print
                if btn.action then
                    btn.action()  -- Call the action function
                else
                    print("No action defined for button " .. btn.id)
                end
                break
            end
        end
    end
end