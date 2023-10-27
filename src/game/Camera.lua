Camera = Class{}

function Camera:init(def)
    self.x = def.x                     -- x-position of camera (in pixels)
    self.y = def.y                     -- y-position of camera (in pixels)

    self.width = def.width             -- width of camera (in pixels)
    self.height = def.height           -- height of camera (in pixels)

    self.raycaster = def.raycaster     -- raycaster entity to render rays from

    self.view_height = def.view_height -- basic height of the view

    self.ln = self.raycaster.rays      -- number of lines to draw in camera
    self.lines = {}                    -- list of lines' heights to draw in camera
    self.ls = {}                       -- list of wether lines to draw in camera are darkened
end

function Camera:update()
    for i = 1, self.ln do
        -- get angle of ray (in radiants)
        local a = math.atan2(self.raycaster.ry[i] - self.raycaster.y, self.raycaster.rx[i] - self.raycaster.x)
        local ca = self.raycaster.entity.a - a
        if ca < 0 then
            ca = ca + 2 * PI
        elseif ca > 2 * PI then
            ca = ca - 2 * PI
        end

        -- normalize distance of shortest ray
        local distance = math.min(
            self.raycaster.hrd[i], self.raycaster.vrd[i]
        ) * math.cos(ca)

        if self.raycaster.hrd[i] < self.raycaster.vrd[i] then
            self.ls[i] = true
        else
            self.ls[i] = false
        end

        -- populate list of lines' heights
        local lh = (self.view_height * self.height) / distance
        if lh > self.height then
            lh = self.height
        end
        self.lines[i] = lh
    end
end

function Camera:render()
    local width = self.width / self.ln                     -- width of lines to draw on camera (in pixels)

    for i = 1, self.ln do
        local offset = self.height / 2 - self.lines[i] / 2 -- offset between lines' tops and camera's top

        love.graphics.setColor(colors['lightAzure'])
        love.graphics.rectangle(
            'fill',
            self.x + width * (i - 1),
            self.y,
            width,
            offset
        )

        if self.ls[i] then
            love.graphics.setColor(shadow(colors['mildOrange']))
        else
            love.graphics.setColor(colors['mildOrange'])
        end

        love.graphics.rectangle(
            'fill',
            self.x + width * (i - 1),
            self.y + offset,
            width,
            self.lines[i]
        )

        love.graphics.setColor(colors['mildGreen'])
        love.graphics.rectangle(
            'fill',
            self.x + width * (i - 1),
            self.y + offset + self.lines[i],
            width,
            self.height - (self.y + offset + self.lines[i])
        )
    end
end

-- calculate shadowed rgb values
function shadow(color)
    local rgb = {0, 0, 0}

    for i = 1, 3 do
        if color[i] >= 0.1 then
            rgb[i] = color[i] - 0.1
        end
    end

    return rgb
end
