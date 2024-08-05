function generateShortUUID()
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = {}
    for i = 1, 8 do
        local randomIndex = math.random(1, #charset)
        result[i] = charset:sub(randomIndex, randomIndex)
    end
    return table.concat(result)
end

function checkCollision(player, target)
    return not (
        player.x > target.x + target.w or
        player.x + player.w < target.x or
        player.y > target.y + target.h or
        player.y + player.h < target.y
    )
end

function countEntries(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end
