Controller = Class{}

function Controller:init(def)
    self.player = def.player -- player representation to interact with
    self.level = def.level   -- level representation to interact with
    self.camera = def.camera -- camera representation to interact with
end

function Controller:update(dt)
    -- calculate speed of player
    local speed = 0
    local rotation = 0
    if love.keyboard.isDown('space') then
        speed = PLAYER_ENHANCED_SPEED
        rotation = PLAYER_BASE_ROTATION
    else
        speed = PLAYER_BASE_SPEED
        rotation = PLAYER_ENHANCED_ROTATION
    end

    -- reset player velocity 
    self.player.dx = 0
    self.player.dy = 0

    -- set vertical velocity to velocity of player
    if love.keyboard.isDown('s') then
        self.player.dy = -speed * math.sin(self.player.a)
        self.player.dx = -speed * math.cos(self.player.a)
    elseif love.keyboard.isDown('w') then
        self.player.dy = speed * math.sin(self.player.a)
        self.player.dx = speed * math.cos(self.player.a)
    end

    -- add horizontal velocity to velocity of player
    if love.keyboard.isDown('a') then
        self.player.dy = self.player.dy + -speed * math.sin(limitRadiant(self.player.a + PI / 2))
        self.player.dx = self.player.dx + -speed * math.cos(limitRadiant(self.player.a + PI / 2))
    elseif love.keyboard.isDown('d') then
        self.player.dy = self.player.dy + speed * math.sin(limitRadiant(self.player.a + PI / 2))
        self.player.dx = self.player.dx + speed * math.cos(limitRadiant(self.player.a + PI / 2))
    end

    -- claculate rotation of player
    if love.keyboard.isDown('left') then
        self.player.da = -rotation
    elseif love.keyboard.isDown('right') then
        self.player.da = rotation
    else
        self.player.da = 0
    end
end

function Controller:render()
end
