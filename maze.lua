local inspect = require('inspect')

local width = 0
local height = 0

function debugPrint()
    local tab = {}
    
    tab = getMaze(10,10)
    
    print(inspect(tab))

end

-- creates a maze of x columns and y rows
function getMaze(x, y)
    math.randomseed(os.time())

    width = x
    height = y
    
    -- creates the matrix
    maze = {}
    for i = 1, x do
        maze[i] = {}
        for j = 1, y do
            maze[i][j] = 0
        end
    end
    
    --[[ MAZE SEMANTICS:
        0: wall
        1: path
        2: goal
        3: starting
    ]]
    
    --[[ sample 'hard-wired' maze of 10 by 10 squares
    maze = {
        {3,1,0,0,0,0,0,0,0,0},
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
    ]]
    
    -- randomize starting generation position
    startR = math.random(1, x)
    while (startR % 2) ~= 0 do
        startR = math.random(1, x)
    end
    
    startC = math.random(1, y)
    while (startC % 2) ~= 0 do
        startC = math.random(1, y)
    end
    
    generate(startR,startC)
    
    -- set starting to the farthest point to the left
    for i = 1, width do
        for j = 1, height do
            if maze[i][j] == 1 then
                maze[i][j] = 3
            end
        end
    end
    
    -- set goal to the farthest point to the right
    for i = width, 1, -1 do
        for j = height, 1, -1 do
            if maze[i][j] == 1 then
                maze[i][j] = 2
            end
        end
    end
    
    return maze
end

function generate(r, c)
    directions = getRandomDirections()
    
    for i = 1, 4 do
        if directions[i] == 1 then -- up
            if r-2 > 1 then -- check if out of bounds
                if maze[r-2][c] ~= 1 then
                    maze[r-2][c] = 1
                    maze[r-1][c] = 1
                    generate(r-2,c)
                end
            end
            
        elseif directions[i] == 2 then -- right
            if c+2 < width then -- check if out of bounds
                if maze[r][c+2] ~= 1 then
                    maze[r][c+2] = 1
                    maze[r][c+1] = 1
                    generate(r,c+2)
                end
            end        
        
        elseif directions[i] == 3 then -- down
            if r+2 < height then -- check if out of bounds
                if maze[r+2][c] ~= 1 then
                    maze[r+2][c] = 1
                    maze[r+1][c] = 1
                    generate(r+2,c)
                end
            end
        
        elseif directions[i] == 4 then -- left
            if c-2 > 1 then --check if out of bounds
                if maze[r][c-2] ~= 1 then
                    maze[r][c-2] = 1
                    maze[r][c-1] = 1
                    generate(r,c-2)
                end
            end
        
        end
    end
end

-- randomize directions
function getRandomDirections()
    randoms = {}
    
    for i = 1, 4 do
        randoms[i] = i
    end
    
    randoms = shuffle(randoms)
    
    print(inspect(randoms))
    
    return randoms
end

-- returns a shuffled version of the passed table
function shuffle(tab)    
    local n, order, res = #tab, {}, {}
 
    for i=1,n do
        order[i] = { rnd = math.random(), idx = i }
    end
    
    table.sort(order, function(a,b) return a.rnd < b.rnd end)
    
    for i=1,n do res[i] = tab[order[i].idx] end
    
    return res
end