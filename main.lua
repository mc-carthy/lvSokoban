function love.load()
    -- level = {
    --     {' ', ' ', '#', '#', '#'},
    --     {' ', ' ', '#', '.', '#'},
    --     {' ', ' ', '#', ' ', '#', '#', '#', '#'},
    --     {'#', '#', '#', '$', ' ', '$', '.', '#'},
    --     {'#', '.', ' ', '$', '@', '#', '#', '#'},
    --     {'#', '#', '#', '#', '$', '#'},
    --     {' ', ' ', ' ', '#', '.', '#'},
    --     {' ', ' ', ' ', '#', '#', '#'},
    -- }

    level = {
        {'#', '#', '#', '#', '#'},
        {'#', '@', ' ', '.', '#'},
        {'#', ' ', '$', ' ', '#'},
        {'#', '.', '$', ' ', '#'},
        {'#', ' ', '$', '.', '#'},
        {'#', '.', '$', '.', '#'},
        {'#', '.', '*', ' ', '#'},
        {'#', ' ', '*', '.', '#'},
        {'#', ' ', '*', ' ', '#'},
        {'#', '.', '*', '.', '#'},
        {'#', '#', '#', '#', '#'},
    }

    player = '@'
    playerOnStorage = '+'
    box = '$'
    boxOnStorage = '*'
    storage = '.'
    wall = '#'
    empty = ' '

    love.graphics.setBackgroundColor(255, 255, 215)
end

function love.draw()
    for y, row in ipairs(level) do
        for x, cell in ipairs(row) do
            if cell ~= ' ' then
                local cellSize = 70

                local colours = {
                    [player] = { 159, 127, 255 },
                    [playerOnStorage] = { 159, 127, 255 },
                    [box] = { 255, 125, 127 },
                    [boxOnStorage] = { 159, 255, 127 },
                    [storage] = { 159, 215, 255 },
                    [wall] = { 255, 127, 215},
                }

                love.graphics.setColor(colours[cell])
                love.graphics.rectangle(
                    'fill',
                    (x - 1) * cellSize,
                    (y - 1) * cellSize,
                    cellSize,
                    cellSize
                )
                love.graphics.setColor(255, 255, 255)
                love.graphics.print(
                    level[y][x],
                    (x - 1) * cellSize,
                    (y - 1) * cellSize
                )
            end
        end
    end
end

function love.keypressed(key)
    if key == "up" or key == "down" or key == "left" or key == "right" then
        local playerX
        local playerY
        for testY, row in ipairs(level) do
            for testX, cell in ipairs(row) do
                if cell == player or cell == playerOnStorage then
                    playerX = testX
                    playerY = testY
                end
            end
        end
        
        local dx = 0
        local dy = 0
        if key == 'left' then
            dx = -1
        elseif key == 'right' then
            dx = 1
        elseif key == 'up' then
            dy = -1
        elseif key == 'down' then
            dy = 1
        end

        local current = level[playerY][playerX]
        local adjacent = level[playerY + dy][playerX + dx]
        local beyond

        if level[playerY + dy + dy] then
            beyond = level[playerY + dy + dy][playerX + dx + dx]
        end

        local nextCurrent = {
            [player] = empty,
            [playerOnStorage] = storage,
        }

        local nextAdjacent = {
            [empty] = player,
            [storage] = playerOnStorage,
        }

        local nextBeyond = {
            [empty] = box,
            [storage] = boxOnStorage,
        }

        local nextAdjacentPush = {
            [box] = player,
            [boxOnStorage] = playerOnStorage,
        }

        if nextAdjacent[adjacent] then
            level[playerY][playerX] = nextCurrent[current]
            level[playerY + dy][playerX + dx] = nextAdjacent[adjacent]
        elseif nextBeyond[beyond] and nextAdjacentPush[adjacent] then
            level[playerY][playerX] = nextCurrent[current]
            level[playerY + dy][playerX + dx] = nextAdjacentPush[adjacent]
            level[playerY + dy + dy][playerX + dx + dx] = nextBeyond[beyond]
        end


        print('current = level['..playerY..']['..playerX..'] ('..current..')')
        print('adjacent = level['..playerY + dy..']['..playerX + dx..'] ('..adjacent..')')
        print()
    end
    if key == "escape" then
        love.event.quit()
    end
end