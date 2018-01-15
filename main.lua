function love.load()
    level = {
        {' ', ' ', '#', '#', '#'},
        {' ', ' ', '#', '.', '#'},
        {' ', ' ', '#', ' ', '#', '#', '#', '#'},
        {'#', '#', '#', '$', ' ', '$', '.', '#'},
        {'#', '.', ' ', '$', '@', '#', '#', '#'},
        {'#', '#', '#', '#', '$', '#'},
        {' ', ' ', ' ', '#', '.', '#'},
        {' ', ' ', ' ', '#', '#', '#'},
    }

    love.graphics.setBackgroundColor(255, 255, 215)
end

function love.draw()
    for y, row in ipairs(level) do
        for x, cell in ipairs(row) do
            if cell ~= ' ' then
                local cellSize = 70

                local colours = {
                    ['@'] = { 159, 127, 255 },
                    ['+'] = { 159, 127, 255 },
                    ['$'] = { 255, 125, 127 },
                    ['*'] = { 159, 255, 127 },
                    ['.'] = { 159, 215, 255 },
                    ['#'] = { 255, 127, 215},
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