testRoom = TestRoom({
    width = ROOM_WIDTH,
    height = ROOM_HEIGHT,
    tile_size = TILE_SIZE
})

level = Level({
    room = testRoom
})

player = Player({
    x = PLAYER_START_X,
    y = PLAYER_START_Y,
    a = PLAYER_START_A,
    radius = PLAYER_RADIUS,
    level = level
})

raycaster = Raycaster({
    entity = player,
    level = level,
    rays = PLAYER_RESOLUTION,
    view = PLAYER_VIEW
})

camera = Camera({
    x = 0,
    y = 0,
    width = VIRTUAL_WIDTH,
    height = VIRTUAL_HEIGHT,
    raycaster = raycaster,
    view_height = VIEW_HEIGHT
})

controller = Controller({
    player = player,
    level = level,
    camera = camera
})

map = Map({
    x = 0,
    y = 0,
    ratio = MAP_RATIO,
    level = level,
    player = player,
    raycaster = raycaster
})
