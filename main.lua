
brickSprites = {}
index = 1
moveTowerLeft = false
startTowerPos = 125
endTowerPos = 125 + 10*50 + 10

--Platform data
platformX = {}
platformY = {}
platformMovingRight = {}
platformLength = {}
platformDetractLength = {}
platformDetractStarted = {}

platformMaxDecreaseLength = 5

function love.load()
    getBrickImages()
    addPlatforms(12)
end

function love.update()
    updateTower()
    updatePlatforms()
end

function love.draw()
    drawTower()
    drawPlatforms()
end

function love.keypressed(key)
    moveTower(key)
end

function getBrickImages()
    for i=1,9 do 
        dummy = love.graphics.newImage("/Brick Sprites/brick_" .. tostring(i-1) .. ".png")
        table.insert(brickSprites,dummy)
    end
end

function moveTower(key)
    if key == "left" then
        moveTowerLeft = true
    end
    if key == "right" then
        moveTowerLeft = false
    end
end

function drawTower()
    for y=0,119 do
        for x=0,50 do
            --love.graphics.setColor(255,0,0)
            love.graphics.draw(brickSprites[index],125+x*10,y*5)
        end
    end
end

function updateTower()
    if moveTowerLeft == true then
        if index == 9 then
            index = 1
        else
            index = index + 1
        end
    end

    if moveTowerLeft == false then
        if index == 1 then
            index = 9
        else
            index = index - 1
        end
    end
end

function drawPlatforms()
    for i=1,#platformX do
        love.graphics.rectangle("fill",platformX[i],platformY[i],platformLength[i],10)
    end
end

function addPlatforms(range)
    for i=0,range do
        table.insert(platformX, startTowerPos + i * 50)
        print(platformX[i])
        table.insert(platformY, i * 50)
        table.insert(platformLength, 50)
        table.insert(platformDetractLength,false)
        table.insert(platformDetractStarted,false)
    end

    for i=1,#platformX do
        if platformX[i] < endTowerPos then
            table.insert(platformMovingRight,true)
        else
            table.insert(platformMovingRight,false)
        end
        print(platformMovingRight[i])
    end

    --Flips all platforms that are supposed to be moving left
    for i=1,#platformMovingRight do
        if platformMovingRight[i] == false then
            platformX[i] = platformX[i] - (platformX[i] - endTowerPos) * 2
        end
    end

end

function updatePlatforms()
    updatePlatformPositions()
end

function updatePlatformPositions()
    for i=1,#platformX do

        arePlatformsAtBoundaries(i)

        movePlatforms(i)

    end
end

function arePlatformsAtBoundaries(i)
    if platformX[i] >= 635 and platformX[i] < 636.5 then
        platformMovingRight[i] = false
        -- if platformDetractStarted[i] == false then
        --     platformDetractStarted[i] = true
        --     platformDetractLength[i] = true
        -- end

        -- if platformDetractStarted[i] == false then
        --     platformMovingRight[i] = false
        -- end
    end

    if platformX[i] >= 124 and platformX[i] < 125.5 then
        platformMovingRight[i] = true     
    --     if platformDetractStarted[i] == false then
    --         platformDetractLength[i] = true
    --         platformDetractLength[i] = true
    --     end
    end
end

function movePlatforms(i)
    if platformX[i] < endTowerPos and platformMovingRight[i] == true then
        platformX[i] = platformX[i] + 1.1
    end

    if platformX[i] > startTowerPos and platformMovingRight[i] == false then
        platformX[i] = platformX[i] - 1.1
    end
end