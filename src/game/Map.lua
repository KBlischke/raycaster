Map = Class{}

function Map:init(def)
    self.x = def.x                 -- x-position of map (in pixels)
    self.y = def.y                 -- y-position of map (in pixels)

    self.ratio = def.ratio         -- ratio of map's representation to represented elements

    self.display = true            -- wether map is displayed

    self.level = def.level         -- level representation of map
    self.player = def.player       -- player representation of map
    self.raycaster = def.raycaster -- raycaster representation of map
end

function Map:update(dt)
end

function Map:render()
    -- display level
    for i = 1, self.level.height do
        for j = 1, self.level.width do
            if self.level.tiles[(i - 1) * self.level.width + j] == 1 then
                love.graphics.setColor(colors['transWhite'])

                love.graphics.rectangle(
                    'fill',
                    math.floor(self.level.tile_size * self.ratio) * (j - 1),
                    math.floor(self.level.tile_size * self.ratio) * (i - 1),
                    math.floor(self.level.tile_size * self.ratio) - 1,
                    math.floor(self.level.tile_size * self.ratio) - 1
                )
            else
                love.graphics.setColor(colors['transBlack'])

                love.graphics.rectangle(
                    'fill',
                    math.floor(self.level.tile_size * self.ratio) * (j - 1),
                    math.floor(self.level.tile_size * self.ratio) * (i - 1),
                    math.floor(self.level.tile_size * self.ratio) - 1,
                    math.floor(self.level.tile_size * self.ratio) - 1
                )
            end
        end
    end

    -- display raycaster
    love.graphics.setColor(colors['lightMaxTransGreen'])

    for i = 1, self.raycaster.rays do
        love.graphics.line(
            (self.raycaster.x * self.ratio),
            (self.raycaster.y * self.ratio),
            (self.raycaster.rx[i] * self.ratio),
            (self.raycaster.ry[i] * self.ratio)
        )
    end

    -- display player
    love.graphics.setColor(colors['lightTransBlue'])
    love.graphics.line(
        self.player.x * self.ratio,
        self.player.y * self.ratio,
        self.player.xo * self.ratio,
        self.player.y * self.ratio)
    love.graphics.line(
        self.player.x * self.ratio,
        self.player.y * self.ratio,
        self.player.x * self.ratio,
        self.player.yo * self.ratio)

    love.graphics.setColor(self.player.rgb)
    love.graphics.circle(
        'fill',
        self.player.x * self.ratio,
        self.player.y * self.ratio,
        self.player.radius * self.ratio)
end
