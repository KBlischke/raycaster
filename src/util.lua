-- display x- and y-position of player (in pixels), angle of player (in radiants) and FPS (frames per second)
function displayData(x, y, entity)
    love.graphics.setFont(fonts['medium'])
    love.graphics.setColor(colors['lightRed'])

    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), x, y)

    love.graphics.print(string.format('X: %.2f', entity.x), x, y + 16)
    love.graphics.print(string.format('Y: %.2f', entity.y), x, y + 32)
    love.graphics.print(string.format('Tile: %d', entity.t), x, y + 48)
    love.graphics.print(string.format('Angle: %.2f', entity.a), x, y + 64)
end

-- display pressed keys
function displayControl(x, y, controller)
    love.graphics.setFont(fonts['medium'])
    love.graphics.setColor(colors['lightTransRed'])

    if love.keyboard.isDown('w') then
        love.graphics.setColor(colors['lightRed'])
    end
    love.graphics.print('W', x + 36, y + 16)
    love.graphics.setColor(colors['lightTransRed'])

    if love.keyboard.isDown('a') then
        love.graphics.setColor(colors['lightRed'])
    end
    love.graphics.print('A', x + 20, y + 32)
    love.graphics.setColor(colors['lightTransRed'])

    if love.keyboard.isDown('s') then
        love.graphics.setColor(colors['lightRed'])
    end
    love.graphics.print('S', x + 36, y + 32)
    love.graphics.setColor(colors['lightTransRed'])

    if love.keyboard.isDown('d') then
        love.graphics.setColor(colors['lightRed'])
    end
    love.graphics.print('D', x + 52, y + 32)
    love.graphics.setColor(colors['lightTransRed'])

    if love.keyboard.isDown('left') then
        love.graphics.setColor(colors['lightRed'])
    end
    love.graphics.print('Left', x, y + 56)
    love.graphics.setColor(colors['lightTransRed'])

    if love.keyboard.isDown('right') then
        love.graphics.setColor(colors['lightRed'])
    end
    love.graphics.print('Right', x + 50, y + 56)
    love.graphics.setColor(colors['lightTransRed'])

    if love.keyboard.isDown('space') then
        love.graphics.setColor(colors['lightRed'])
    end
    love.graphics.print('Space', x + 20, y + 80)
    love.graphics.setColor(colors['lightTransRed'])
end

-- calculate tile position of subject
function getTile(x, y, level)
    local ht = ((math.floor(x) - math.floor(x) % level.tile_size) / level.tile_size) -- horizontal tile position
    local vt = ((math.floor(y) - math.floor(y) % level.tile_size) / level.tile_size) -- vertical tile position

    return vt * level.width + (ht + 1)
end

-- limit radiant values inside a single radiant
function limitRadiant(radiant)
    if radiant < 0 then
        radiant = radiant + 2 * PI
    elseif radiant > 2 * PI then
        radiant = radiant - 2 * PI
    end

    return radiant
end

-- calculate hypothenuse of two coordinates (in pixels)
function distance(ax, ay, bx, by)
    return math.sqrt((bx - ax)^2 + (by - ay)^2)
end
