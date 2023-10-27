Level = Class{}

function Level:init(def)
    self.current = def.room

    self.width = self.current.width                      -- horizontal size of level (in tiles)
    self.height = self.current.height                    -- vertical size of level (in tiles)
    self.size = self.current.width * self.current.height -- size of level (in tiles)
    self.tile_size = self.current.tile_size              -- horizontal and vertical size of level's tiles (in pixels)

    self.tiles = self.current.tiles
end

function Level:update(dt)
end

function Level:render()
end
