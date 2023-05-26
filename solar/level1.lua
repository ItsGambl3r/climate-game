-----------------------------------------------------------------------------------------
--
-- level1.lua
--
----------------------------------------------------------------------
Camera = require('camera')
Player = require('player')
Death = require('death')
Background = require('background')
Platform = require('platform')
JumpPad = require('jumppad')

require "pause"
Runtime:addEventListener( "key", gamePause)
--Runtime:addEventListener( "key", isHolding)

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"

local background = Background.new("Caverns1", 2)
background:create()


world = display.newGroup()
content = display.newGroup()
world:insert(content)



------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )

    -- Called when the scene's view does not exist.
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

    local sceneGroup = self.view

    -- We need physics started to add bodies, but we don't want the simulaton
    -- running until the scene is on the screen.

    physics.start()
    physics.setGravity(0, 10 )
    camera = Camera.new()
    camera:attach(world)
    Camera:deadZone()
    
	hero = Player.new(0, 500)
    hero.model.name = "hero"
    health = hero.health
    deathCon = setmetatable({}, Death)
    deathCon:setBound(900)

    -- create health bar in top left corner
    healthBar = display.newRect( 0, 0, 200, 20 )
    healthBar:setFillColor( 0, 1, 0 )
    healthBar.x = display.contentCenterX
    healthBar.y = 20
    healthBar.anchorX = 0.5
    healthBar.anchorY = 0.5
    healthBar.strokeWidth = 3
    healthBar:setStrokeColor( 0, 0, 0 )
    healthBar.alpha = 0.5
    healthBar.isVisible = true
    healthBar:toFront()

    -- create health text
    healthText = display.newText( health .. " / 100", 0, 0, native.systemFont, 16 )
    healthText.x = display.contentCenterX
    healthText.y = 20
    healthText.anchorX = 0.5
    healthText.anchorY = 0.5
    healthText:setFillColor( 255, 255, 255 )
    healthText.isVisible = true
    healthText:toFront()

    --player = hero.model


    -- create a grey rectangle as the backdrop
    -- the physical screen will likely be a different shape than our defined content area

    -- make a boomba (off-screen), position it, and rotate slightly

    boomba1 = display.newImageRect( "Resources/boomba.png", 120, 100 )
    boomba1.direction = "right"
    boomba1.velocity = 0
    boomba1.rotation = 0
    boomba1.type = "boomba"
    boomba1.bodytype = "dynamic"
    boomba1.collision = onCollision
    boomba1:addEventListener( "collision" )

    boomba2 = display.newImageRect( "Resources/boomba.png", 120, 100 )
    boomba2.direction = "right"
    boomba2.velocity = 0
    boomba2.rotation = 0
    boomba2.type = "boomba"
    boomba2.bodytype = "dynamic"
    boomba2.collision = onCollision
    boomba2:addEventListener( "collision" )

    boomba3 = display.newImageRect( "Resources/boomba.png", 120, 100 )
    boomba3.direction = "right"
    boomba3.velocity = 0
    boomba3.rotation = 0
    boomba3.type = "boomba"
    boomba3.bodytype = "dynamic"
    boomba3.collision = onCollision
    boomba3:addEventListener( "collision" )

    boomba4 = display.newImageRect( "Resources/boomba.png", 120, 100 )
    boomba4.direction = "right"
    boomba4.velocity = 0
    boomba4.rotation = 0
    boomba4.type = "boomba"
    boomba4.bodytype = "dynamic"
    boomba4.collision = onCollision
    boomba4:addEventListener( "collision" )

    pad1 = JumpPad.new(250, 300, 2)
    pad3 = JumpPad.new(-80, 0, 2)

    pad1.model.name = "pad1"


    -- higher y value == lower
    -- lower/more negative y value == higher // minimum plat distance height should be around 150 (any higher and player can't reach it)
    -- higher x == left
    -- lower x == right
    plat00 = Platform.new(-150, 300, 100, 10)
    plat01 = Platform.new(-300, 150, 100, 10)
    plat02 = Platform.new(0, 0, 100, 10)
    plat03 = Platform.new(-250, -150, 100, 10)
    cp0 = Platform.new(300, -300, 600, 30)
    plat10 = Platform.new(-200, -450, 100, 10)
    plat11 = Platform.new(-300, -600, 100, 10)
    plat12 = Platform.new(0, -750, 100, 10)
    plat13 = Platform.new(250, -900, 100, 10)

    spike1 = Platform.new(285, -925, 25, 50, "Resources/spike.png")
    spike1.model.type = "spike"

    pad4 = JumpPad.new(450, -1000, 2)
    cp1 = Platform.new(-200, -1050, 600, 30)
    boomba1.x, boomba1.y = -200, -1050
    boomba1.rightBounds, boomba1.leftBounds = 50, -450
    plat20 = Platform.new(-150, -1200, 100, 10)
    plat21 = Platform.new(-300, -1350, 100, 10)
    plat22 = Platform.new(0, -1500, 100, 10)

    icePlat1 = Platform.new(350, -1450, 100, 10, "Resources/icePlatform.png", 0)

    plat24 = Platform.new(475, -1625, 100, 10)
    cp2 = Platform.new(0, -1800, 600, 30)
    pad5 = JumpPad.new(-400, -1900, 1.75)
    boomba2.x, boomba2.y = 0, -1800
    boomba2.rightBounds, boomba2.leftBounds = 250, -250
    plat30 = Platform.new(600, -1950, 100, 10)
    plat31 = Platform.new(220, -2100, 100, 10)

    icePlat2 = Platform.new(350, -2290, 100, 10, "Resources/icePlatform.png", 0)
    
    plat33 = Platform.new(600, -2400, 100, 10)
    cp3 = Platform.new(150, -2550, 600, 30)
    boomba3.x, boomba3.y = 150, -2550
    boomba3.rightBounds, boomba3.leftBounds = 400, -100
    plat40 = Platform.new(-510, -2650, 100, 10)
    plat41 = Platform.new(-760, -2840, 100, 10)
    plat42 = Platform.new(-390, -3000, 100, 10)
    plat43 = Platform.new(-650, -3190, 100, 10)
    plat44 = Platform.new(-250, -3210, 100, 10)

    cp4 = Platform.new(300, -3300, 600, 30, "Resources/icePlatform.png", 0)

    boomba4.x, boomba4.y = 300, -3300
    boomba4.rightBounds, boomba4.leftBounds = 550, 50
    -- plat50 = Platform.new(-150, 300, 100, 10)
    -- plat51 = Platform.new(-300, 150, 100, 10)
    -- plat52 = Platform.new(0, 0, 100, 10)
    -- plat53 = Platform.new(-250, -150, 100, 10)


    -- add physics to the player

    -- add physics to the boomba
    physics.addBody( boomba1, { density=1.0, friction=0.1, bounce=0.0 } )
    physics.addBody( boomba2, { density=1.0, friction=0.1, bounce=0.0 } )
    physics.addBody( boomba3, { density=1.0, friction=0.1, bounce=0.0 } )
    physics.addBody( boomba4, { density=1.0, friction=0.1, bounce=0.0 } )

    -- create a grass object and add physics (with custom shape)
    local ground = display.newImageRect( "Resources/Platform.png", screenW  , 200 )
    ground.anchorX = 0
    ground.anchorY = 1

    -- draw a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)

    ground.x, ground.y = display.screenOriginX + 100, display.actualContentHeight + display.screenOriginY

    -- add physics to the ground

    physics.addBody( ground, "static", { friction=0.3 } )
    
    -- all display objects must be inserted into group

    world:insert(ground)
    world:insert(boomba1)
    world:insert(boomba2)
    world:insert(boomba3)
    world:insert(boomba4)
    world:insert(pad1.model)
    world:insert(pad3.model)
    world:insert(spike1.model)
    world:insert(plat00.model)
    world:insert(plat01.model)
    world:insert(plat02.model)
    world:insert(plat03.model)
    world:insert(cp0.model)
    world:insert(plat10.model)
    world:insert(plat11.model)
    world:insert(plat12.model)
    world:insert(plat13.model)
    world:insert(cp1.model)
    world:insert(pad4.model)
    world:insert(plat20.model)
    world:insert(plat21.model)
    world:insert(plat22.model)
    world:insert(icePlat1.model)
    world:insert(plat24.model)
    world:insert(cp2.model)
    world:insert(pad5.model)
    world:insert(plat30.model)
    world:insert(plat31.model)
    world:insert(icePlat2.model)
    world:insert(plat33.model)
    world:insert(cp3.model)
    world:insert(plat40.model)
    world:insert(plat41.model)
    world:insert(plat42.model)
    world:insert(plat43.model)
    world:insert(plat44.model)
    world:insert(cp4.model)
    sealevelHeight = 800
    sealevel = display.newImageRect("Resources/water.png", screenW * 5, sealevelHeight)
    sealevel.x = 160
    sealevel.y = 1200
    sealevel.alpha = 0.5


    -- world:insert(plat50.model)
    -- world:insert(plat51.model)
    -- world:insert(plat52.model)
    -- world:insert(plat53.model)
    content:insert(hero.model)
    --i need to 
    world:insert(sealevel)
    sealevel:toFront()
end
    
function scene:hide( event )
    local sceneGroup = self.view
    
    local phase = event.phase
    
    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
        physics.stop()
    elseif phase == "did" then
        -- Called when the scene is now off screen
    end 
end

function scene:destroy( event )
    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listenaers, save state, etc.
    local sceneGroup = self.view
    package.loaded[physics] = nil
    physics = nil
end

function onCollision( self, event )
    if ( event.phase == "began" ) then
        -- print( self .. ": collision began with " .. event.other )
    elseif ( event.phase == "ended" ) then
        -- print( self .. ": collision ended with " .. event.other )
    end
end

function moveBoomba()
    if boomba1.direction == "right" then
        boomba1.x = boomba1.x + 2
        if boomba1.x > boomba1.rightBounds then
            boomba1.direction = "left"
        end
    elseif boomba1.direction == "left" then
        boomba1.x = boomba1.x - 2
        if boomba1.x < boomba1.leftBounds then
            boomba1.direction = "right"
        end
    end
    if boomba2.direction == "right" then
        boomba2.x = boomba2.x + 2
        if boomba2.x > boomba2.rightBounds then
            boomba2.direction = "left"
        end
    elseif boomba2.direction == "left" then
        boomba2.x = boomba2.x - 2
        if boomba2.x < boomba2.leftBounds then
            boomba2.direction = "right"
        end
    end
    if boomba3.direction == "right" then
        boomba3.x = boomba3.x + 2
        if boomba3.x > boomba3.rightBounds then
            boomba3.direction = "left"
        end
    elseif boomba3.direction == "left" then
        boomba3.x = boomba3.x - 2
        if boomba3.x < boomba3.leftBounds then
            boomba3.direction = "right"
        end
    end
    if boomba4.direction == "right" then
        boomba4.x = boomba4.x + 2
        if boomba4.x > boomba4.rightBounds then
            boomba4.direction = "left"
        end
    elseif boomba4.direction == "left" then
        boomba4.x = boomba4.x - 2
        if boomba4.x < boomba4.leftBounds then
            boomba4.direction = "right"
        end
    end
end

function detectDamage()
    if hero.health < health then
        health = hero.health
        healthText.text = health .. " / 100"
        healthBar.width = health * 2
        if health <= 0 then
            detectDeath()
        end
    end
end


function detectWin()
    if hero.model.y <= -3310 and hero.model.x > 350 then
        -- remove the hero event listeners
        hero:RemoveEvents()
        -- remove the hero from the scene
        display.remove(hero.model)
        -- remove health bar and text
        display.remove(healthBar)
        display.remove(healthText)
        -- display.remove(camera)
        display.remove(content)
        display.remove(world)
        composer.removeScene("level1")
        Runtime:removeEventListener("enterFrame", gameUpdate)
        background:remove()
        Runtime:removeEventListener("enterFrame", detectWin)
        Runtime:removeEventListener("enterFrame", detectDeath)
        Runtime:removeEventListener('enterFrame', count)
        Runtime:removeEventListener('enterFrame', decelerate)
        Runtime:removeEventListener("key", gamePause)
        Runtime:removeEventListener("enterFrame", raiseLevel)
        Runtime:removeEventListener("enterFrame", moveBoomba)
        composer.gotoScene("win", "fade", 500 )
    end
end

function detectDeath()
    deathCon:checkBound(hero)
    deathCon:checkHp(hero)
    if hero.isAlive == false then
        Runtime:removeEventListener("enterFrame", gameUpdate)
        background:remove()
        Runtime:removeEventListener("enterFrame", detectWin)
        Runtime:removeEventListener("enterFrame", detectDeath)
        Runtime:removeEventListener('enterFrame', count)
        Runtime:removeEventListener('enterFrame', decelerate)
        Runtime:removeEventListener("key", gamePause)
        Runtime:removeEventListener("enterFrame", raiseLevel)
        Runtime:removeEventListener("enterFrame", moveBoomba)
        deathCon:isDead(hero)
    end
end



function raiseLevel()
    sealevel.y = sealevel.y - 1
    if hero.model.y >= (sealevel.y - (sealevelHeight / 2 + 30)) then
        hero.isAlive = false
        detectDeath()
    end
end

function collision(event)
    local phase = event.phase
    local other = event.other

    obj1 = nil
    obj2 = nil

    if other == Platform then
        print("Platform")
    end
    
    for k,v in pairs(event.object1) do
        if k == "name" then
            obj1 = v
        end
    end
    for k,v in pairs(event.object2) do
        if k == "type" then
            obj2 = v
        end
    end
    if obj1 == "hero" and obj2 == "spike" then
        if phase == "began" then
            hero.isAlive = false
            detectDeath()
        end
    end
    if obj1 == "hero" and obj2 == "boomba" then
        if phase == "began" then
            hero.isAlive = false
            detectDeath()
        end
    end
end

function gameUpdate(event)
    camera:update(hero)
    background:update(hero)

    for i=1, world.numChildren do
        local child = world[i]
        childHeight = child.height
        --Set all objects to be affected by forces to "dynamic" please
        if child.bodytype == "dynamic" then
            if child.y > (sealevel.y - (sealevelHeight / 2 - childHeight / 2)) then
                child.y = child.y - 0.75
                child.gravityScale = 0
            end
        end
    end
end


---------------------------------------------------------------------------------

-- Listener setup

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

Runtime:addEventListener("enterFrame", gameUpdate)
Runtime:addEventListener("enterFrame", detectWin)
Runtime:addEventListener("enterFrame", detectDeath)
Runtime:addEventListener('collision', collision)
Runtime:addEventListener('enterFrame', raiseLevel)
Runtime:addEventListener('enterFrame', moveBoomba)

-----------------------------------------------------------------------------------------

return scene
