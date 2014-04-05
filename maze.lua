-- creates a maze of x columns and y rows
function getMaze(x, y)
    -- creates the matrix
    maze = {}
    for i = 1, x do
        maze[i] = {}
        for j = 1, y do
            maze[i][j] = 0
        end
    end
    
    -- hard-wired maze of 10 by 10 squares
    maze = {
        {1,1,0,0,0,0,0,0,0,0},
        {0,1,0,1,1,1,0,1,1,1},
        {0,1,1,1,0,1,0,1,0,1},
        {0,0,0,0,0,1,0,1,0,1},
        {0,1,1,1,1,1,0,1,0,1},
        {0,1,0,0,0,0,0,1,0,1},
        {0,1,0,0,0,1,1,1,0,1},
        {0,1,0,0,0,1,0,0,0,1},
        {0,1,0,0,0,1,0,1,1,1},
        {0,1,1,1,1,1,0,2,0,0}
    }

    return maze
end