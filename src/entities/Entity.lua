Entity = Class{}

function Entity:init(def, rgb)
    self.level = def.level        -- level representation to interact with

    self.x = def.x            -- x-position of entity (in pixels)
    self.y = def.y            -- x-position of entity (in pixels)
    self.t = getTile(         -- tile position of entity
        self.x,
        self.y,
        self.level
    )
    self.a = def.a            -- angle of entity (in radiants)

    self.radius = def.radius  -- radius of entity (in pixels)

    self.rgb = rgb            -- red RGB values of entity

    self.dx = 0               -- velocity of entity towards x (in pixels)
    self.dy = 0               -- velocity of entity towards y (in pixels)
    self.da = 0               -- velocity of entity's angle towards pi (in radiants)

    self.xo = 0               -- offset x-position of entity (in pixels)
    self.yo = 0               -- offset y-position of entity (in pixels)
    self.hto = 0              -- offset horizontal tile position of entity
    self.vto = 0              -- offset vertical tile position of entity
end

function Entity:update(dt)
    local xov = 0 -- offset value of entity in on x-axis (in pixels)
    local yov = 0 -- offset value of entity in on y-axis (in pixels)

    -- calculate offset x-position (in pixels) and horizontal offset position (in tiles) of entity
    if self.dx < 0 then
        xov = -self.radius * 2
    elseif self.dx > 0 then
        xov = self.radius * 2
    else
        xov = 0
    end
    self.xo = self.x + xov
    self.hto = getTile(self.xo, self.y, self.level)

    -- calculate offset y-position (in pixels) and vertical offset position (in tiles) of entity
    if self.dy < 0 then
        yov = -self.radius * 2
    elseif self.dy > 0 then
        yov = self.radius * 2
    else
        yov = 0
    end
    self.yo = self.y + yov
    self.vto = getTile(self.x, self.yo, self.level)

    -- calculate x- and y-position of entity (in pixels)
    if self.level.tiles[self.hto] == 0 then
        self.x = self.x + self.dx * dt
    end
    if self.level.tiles[self.vto] == 0 then
        self.y = self.y + self.dy * dt
    end

    -- calculate tile position of entity
    self.t = getTile(self.x, self.y, self.level)

    -- calculate rotation of entity
    self.a = limitRadiant(self.a + self.da)
end

function Entity:render()
end
