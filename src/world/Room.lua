Room = Class{}

function Room:init(def)
    self.width = def.width             -- horizontal size of room (in tiles)
    self.height = def.height           -- vertical size of room (in tiles)
    self.size = def.width * def.height -- size of room (in tiles)
    self.tile_size = def.tile_size     -- horizontal and vertical size of room's tiles (in pixels)
end

function Room:update(dt)
end

function Room:render()
end
