require 'src/dependencies'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    love.window.setTitle('Raycaster')

    math.randomseed(os.time())

    debug = true
end

function love.update(dt)
    level:update(dt)
    controller:update(dt)
    player:update(dt)
    raycaster:update(dt)
    camera:update(dt)
    map:update(dt)
end

function love.draw()
    push:apply('start')

    camera:render()

    if debug then
        displayData(1, VIRTUAL_HEIGHT - 81, player)
        displayControl(VIRTUAL_WIDTH - 100, VIRTUAL_HEIGHT - 97)
        map:render()
    end

    push:apply('end')
end

-- resize virtual window dimensions to real window dimensions
function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    -- quit game when 'escape' was pressed
    if key == 'escape' then
        love.event.quit()
    end

    -- handle display of debug information
    if key == 'lctrl' or key == 'rctrl' then
        if debug then
            debug = false
        else
            debug = true
        end
    end
end
