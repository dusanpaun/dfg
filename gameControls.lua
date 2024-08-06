GameControls = {
    keys = {
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
        notifications = "n",
        skip = "space",
        closer = "escape"
    }
}

function love.keypressed(key)
    print("Detecting key: " .. key)
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
        Inventory:toggle()
    end
    if key == GameControls.keys.help then
        HelpScreen:toggle()
    end
    if key == GameControls.keys.notifications then
        Notifications:toggle()
    end
    if key == GameControls.keys.closer then
        print("Detected escape")
        if Game.states.panelPopupOpened then
            if Game.states.helpScreenShown then
                HelpScreen:close()
            end
            if Game.states.inventoryShown then
                Inventory:close()
            end
            if Game.states.notificationsShown then
                Notifications:close()
            end
            if Game.states.systemSettingsShown then
                systemSettings:close()
            end
        else
            systemSettings:toggle()
        end
    end
    if key == GameControls.keys.quit and Game.states.systemSettingsShown then
        love.event.quit()
    end
end

hoveredButton = nil
hoveredSystemButton = nil
clickedButton = nil

function love.mousemoved(x, y, dx, dy, istouch)
    for _, button in ipairs(Game.buttons) do
        if x >= button.x and x <= button.x + button.width and
           y >= button.y and y <= button.y + button.height then
            hoveredButton = button
            break
        else
            hoveredButton = nil
        end
    end
    for _, button in ipairs(Game.systemButtons) do
        if x >= button.x and x <= button.x + button.width and
           y >= button.y and y <= button.y + button.height then
            hoveredSystemButton = button
            break
        else
            hoveredSystemButton = nil
        end
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    print("Mouse pressed detected at: ", x, y)  -- Debug print
    if button == 1 and not Game.states.panelPopupOpened then  -- Left mouse button
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
    if button == 1 and Game.states.panelPopupOpened then  -- Left mouse button
        for _, btn in ipairs(Game.systemButtons) do
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
