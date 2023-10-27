Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def, colors['lightTransYellow'])
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
end
