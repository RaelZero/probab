require 'maze'
require 'random'

local xPos = 1
local yPos = 1
local xSize = 16
local ySize = 16

function love.load()
    -- get the maze from maze.lua
    local maze = {}
    maze = getMaze(xSize,ySize)
    
    -- load resources
    goalSprite = love.graphics.newImage("res/sprites/goal.png")
    tileSprite = love.graphics.newImage("res/sprites/tile.png")
    wallSprite = love.graphics.newImage("res/sprites/wall.png")
    playerSprite = love.graphics.newImage("res/sprites/player.png")
    
    -- sets BGCOLOR to black
    love.graphics.setBackgroundColor(255,255,255)
    
    -- find where to position the player
    for i = 1, xSize do
        for j = 1, ySize do
            if maze[i][j] == 3 then
                xPos = i
                yPos = j
            end
        end
    end
end

function love.update(dt)
    love.draw()
    if (maze[xPos][yPos] == 2) then
        love.quit()
    end
    
end

function love.keypressed(key)
    if (key == 'w' or key == 'up') then
        if (maze [xPos][yPos-1] ~= nil
            and maze [xPos][yPos-1] ~= 0
            and xPos > 0
            and xPos <= 16
            and yPos-1 > 0
            and yPos-1 <= 16)
            then yPos = yPos-1 end
            
    elseif (key == 'a' or key == 'left') then
        if (maze [xPos-1][yPos] ~= nil
            and maze [xPos-1][yPos] ~= 0
            and xPos-1 > 0
            and xPos-1 <= 16
            and yPos > 0
            and yPos <= 16)
            then xPos = xPos-1 end
            
    elseif (key == 's' or key == 'down') then
        if (maze [xPos][yPos+1] ~= nil
            and maze [xPos][yPos+1] ~= 0
            and xPos > 0
            and xPos <= 16
            and yPos+1 > 0
            and yPos+1 <= 16)
            then yPos = yPos+1 end
            
    elseif (key == 'd' or key == 'right') then
        if (maze [xPos+1][yPos] ~= nil
            and maze [xPos+1][yPos] ~= 0
            and xPos+1 > 0
            and xPos+1 <= 16
            and yPos > 0
            and yPos <= 16)
            then xPos = xPos+1 end
    else end

end

function love.draw()
    -- draw the matrix
    for i = 1, xSize do
        for j = 1, ySize do
            love.graphics.draw(tileSprite, i*16, j*16)
            
            if (maze[i][j] == 0) then
                love.graphics.draw(wallSprite, i*16, j*16)

            elseif (maze[i][j] == 2) then
                love.graphics.draw(goalSprite, i*16, j*16)
            end
            
        end
    end
    
    -- draw the player icon
    love.graphics.draw(playerSprite, xPos*16, yPos*16)
end

function love.quit()
    print("Thanks for playing!")
end

--function createMap()