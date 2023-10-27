Raycaster = Class{}

function Raycaster:init(def)
    self.entity = def.entity                     -- entity to hold on to
    self.level = def.level                           -- level representation to interact with

    self.x = self.entity.x                       -- x-position of raycaster (in pixels)
    self.y = self.entity.y                       -- y-position of raycaster (in pixels)
    self.a = self.entity.a                       -- angle of raycaster (in radiants)

    self.dx = self.entity.dx                     -- velocity of raycaster towards x (in pixels)
    self.dy = self.entity.dy                     -- velocity of raycaster towards y (in pixels)
    self.da = self.entity.da                     -- velocity of raycaster's angle towards pi (in radiants)

    self.rays = def.rays                         -- number of raycaster's rays
    self.view = def.view                         -- view width of raycaster (in degrees)
    self.rgap = DEGREE * (self.view / self.rays) -- degrees between raycaster's rays

    self.rx = {}                                 -- list of x-endpositions of raycaster's rays (in pixels)
    self.ry = {}                                 -- list of y-endpositions of raycaster's rays (in pixels)
    self.hrd = {}                                -- list of distances of raycaster's horizontal rays (in pixels)
    self.vrd = {}                                -- list of distances of raycaster's vertical rays (in pixels)
end

function Raycaster:update()
    self.x = self.entity.x
    self.y = self.entity.y
    self.a = self.entity.a - self.rgap * (self.rays / 2)

    self.dx = self.entity.dx
    self.dy = self.entity.dy
    self.da = self.entity.da

    local rhx = 0 -- x endposition of raycaster's horizontal rays (in pixels)
    local rhy = 0 -- y endposition of raycaster's horizontal rays (in pixels)
    local rvx = 0 -- x endposition of raycaster's vertical rays (in pixels)
    local rvy = 0 -- y endposition of raycaster's vertical rays (in pixels)

    -- calculate x- and y-endpositions and distances of every raycaster's ray (in pixels)
    for i = 1, self.rays do
        self.a = limitRadiant(self.a)

        rhx, rhy = self:horizontalRay(self.x, self.y, self.a, self.level)
        rvx, rvy = self:verticalRay(self.x, self.y, self.a, self.level)

        self.hrd[i] = distance(self.x, self.y, rhx, rhy)
        self.vrd[i] = distance(self.x, self.y, rvx, rvy)

        if self.hrd[i] < self.vrd[i] then
            self.rx[i] = rhx
            self.ry[i] = rhy
        else
            self.rx[i] = rvx
            self.ry[i] = rvy
        end

        self.a = self.a + self.rgap
    end
end

function Raycaster:render()
end

-- calculate x- and y-endposition of raycaster's horizontal rays (in pixels)
function Raycaster:horizontalRay(x, y, a, level)
    local rx = 0                  -- x endposition of ray (in pixels)
    local ry = 0                  -- y endposition of ray (in pixels)

    local rxo = 0                 -- offset for tiles on x axis (in pixels)
    local ryo = 0                 -- offset for tiles on y axis (in pixels)

    local mx = 0                  -- endposition of ray on horizontal tiles
    local my = 0                  -- endposition of ray on vertical tiles
    local mp = 0                  -- endposition of ray on tiles

    local itan = -1 / math.tan(a) -- inversed tangent of angle

    if a > PI then
        ry = (
            ((math.floor(y) - math.floor(y) % level.tile_size) / level.tile_size) * level.tile_size
        ) - 0.0001
        rx = (y - ry) * itan + x
        ryo = -level.tile_size
        rxo = -ryo * itan
    elseif a < PI and a ~= 0 then
        ry = (
            ((math.floor(y) - math.floor(y) % level.tile_size) / level.tile_size) * level.tile_size
        ) + level.tile_size
        rx = (y - ry) * itan + x
        ryo = level.tile_size
        rxo = -ryo * itan
    else
        rx = self.distance
        ry = self.distance
        goto ignoreHorizontal
    end

    for j = 1, level.height do
        mx = (math.floor(rx) - math.floor(rx) % level.tile_size) / level.tile_size
        my = (math.floor(ry) - math.floor(ry) % level.tile_size) / level.tile_size
        mp = (my * level.height + mx) + 1

        if mp > 0 and mp <= level.size and level.tiles[mp] ~= 0 then
            break
        else
            rx = rx + rxo
            ry = ry + ryo
        end
    end

    :: ignoreHorizontal ::

    return rx, ry
end

-- calculate x- and y-endposition of raycaster's vertical rays (in pixels)
function Raycaster:verticalRay(x, y, a, level)
    local rx = 0              -- x endposition of ray (in pixels)
    local ry = 0              -- y endposition of ray (in pixels)

    local rxo = 0             -- offset for tiles on x axis (in pixels)
    local ryo = 0             -- offset for tiles on y axis (in pixels)

    local mx = 0              -- endposition of ray on horizontal tiles
    local my = 0              -- endposition of ray on vertical tiles
    local mp = 0              -- endposition of ray on tiles

    local ntan = -math.tan(a) -- negated tangent of angle

    if a > SOUTH and a < NORTH then
        rx = (
            ((math.floor(x) - math.floor(x) % level.tile_size) / level.tile_size) * level.tile_size
        ) - 0.0001
        ry = (x - rx) * ntan + y
        rxo = -level.tile_size
        ryo = -rxo * ntan
    elseif a < NORTH or a > SOUTH then
        rx = (
            ((math.floor(x) - math.floor(x) % level.tile_size) / level.tile_size) * level.tile_size
        ) + level.tile_size
        ry = (x - rx) * ntan + y
        rxo = level.tile_size
        ryo = -rxo * ntan
    else
        rx = self.distance
        ry = self.distance
        goto ignoreVertical
    end

    for j = 1, level.width do
        mx = (math.floor(rx) - math.floor(rx) % level.tile_size) / level.tile_size
        my = (math.floor(ry) - math.floor(ry) % level.tile_size) / level.tile_size
        mp = (my * level.width + mx) + 1

        if mp > 0 and mp <= level.size and level.tiles[mp] ~= 0 then
            break
        else
            rx = rx + rxo
            ry = ry + ryo
        end
    end

    :: ignoreVertical ::

    return rx, ry
end
