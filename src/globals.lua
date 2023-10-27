PI = math.pi                        -- value of pi
NORTH = 3 * PI / 2                  -- value of most northern part of radiant
SOUTH = PI / 2                      -- value of most southern part of radiant
DEGREE = 0.0174533                  -- degree in radiants

WINDOW_WIDTH = 1080                 -- width of window
WINDOW_HEIGHT = 608                 -- width of window
VIRTUAL_WIDTH = 1000                -- virtual width of window
VIRTUAL_HEIGHT = 600                -- virtual height of window

ROOM_WIDTH = 16                     -- horizontal tile number of room
ROOM_HEIGHT = 16                    -- vertical tile number of room
TILE_SIZE = 32                      -- vertical and horizontal size of tiles (in pixels)

PLAYER_START_X = VIRTUAL_WIDTH / 4  -- starting x position of player (in pixels)
PLAYER_START_Y = VIRTUAL_HEIGHT / 2 -- starting y position of player (in pixels)
PLAYER_START_A = NORTH              -- starting angle of player (in radiants)
PLAYER_RADIUS = 5                   -- radius size of player (in pixels)

PLAYER_BASE_SPEED = 80              -- basic movement speed of player (in pixels)
PLAYER_ENHANCED_SPEED = 160         -- enhanced movement speed of player (in pixels)
PLAYER_BASE_ROTATION = 0.03         -- basic rotation speed of player (in radiants)
PLAYER_ENHANCED_ROTATION = 0.05     -- enhanced rotation speed of player (in radiants)
PLAYER_VIEW = 60                    -- view width of player (in degrees)
PLAYER_RESOLUTION = 300             -- number of player's raycaster's rays

VIEW_HEIGHT = 64                    -- basic view height of camera

MAP_RATIO = 0.5                     -- ratio of map's representation to representated elements
