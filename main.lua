require 'maze'
require 'random'

function love.load()
    -- get the maze from maze.lua
    local maze = {}
    maze = getMaze(10,10)
    
    -- load resources
    goalSprite = love.graphics.newImage("res/sprites/goal.png")
    tileSprite = love.graphics.newImage("res/sprites/tile.png")
    wallSprite = love.graphics.newImage("res/sprites/wall.png")
    playerSprite = love.graphics.newImage("res/sprites/player.png")
    
    local xPos = 1
    local yPos = 1
    
    love.graphics.setBackgroundColor(255,255,255)
end

function love.update(dt)

end

function love.draw()
    for i = 1, 10 do
        for j = 1, 10 do
            love.graphics.draw(tileSprite, i*16, j*16)
            
            if (maze[i][j] == 0) then
                love.graphics.draw(wallSprite, i*16, j*16)

            elseif (maze[i][j] == 2) then
                love.graphics.draw(goalSprite, i*16, j*16)
            end
            
        end
    end
end

--function createMap()