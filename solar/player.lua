-----------------------------------------------------------------------------------------
--
-- Player.lua
--
-----------------------------------------------------------------------------------------
-- Class for defining the playable character

local composer = require( 'composer' )
Actor = require('actor')
heroPhysics = require('physics')

Player = {
    health = 100,
    lastKey = nil,
    moveSpeed = 200,
    count = 0,
    hold = false,
    a = false,
    d = false,
}
Player.__index = Player
Player = setmetatable(Player, Actor)

-- Instantiates Player
function Player.new(x, y)
    local instance = setmetatable({}, Player)
    
    instance:setName('Hero')
	instance:setModel(display.newImageRect('Resources/Player.png', 40, 120))
	instance:setPosition(x, y)
	instance:setHealth(100)

    heroPhysics.addBody(
        instance.model,
        {density=1, friction=5, bounce=0.005}, 
        {box={ halfWidth=20, halfHeight=60, x=0, y=0 }, isSensor=true }
)
	instance.model.isFixedRotation = true --stop player from rotating


    -- Setters


    -- Getters


    -- Checks

    local function checkMove()
        instance.velocity.x, instance.velocity.y = instance.model:getLinearVelocity()
        instance.position.x, instance.position.y = instance.model.x, instance.model.y
        if instance.a == true then
            if instance.velocity.x > -instance.moveSpeed then
                instance.model:applyForce(-instance.moveSpeed, 0, instance.position.x, instance.position.y)
            elseif instance.velocity.x < -instance.moveSpeed then
                if instance.velocity.x > -1 then
                    instance.velocity.x = instance.velocity.x * 2
                end
                instance.model:setLinearVelocity(-instance.moveSpeed, instance.velocity.y)
            end
        elseif instance.d then
            if instance.velocity.x < instance.moveSpeed then
                instance.model:applyForce(instance.moveSpeed, 0, instance.position.x, instance.position.y)
            elseif instance.velocity.x > instance.moveSpeed then
                if instance.velocity.x < 1 then
                    instance.velocity.x = instance.velocity.x * 2
                end
                instance.model:setLinearVelocity(instance.moveSpeed, instance.velocity.y)
            end
        end
    end

    function decelerate()
        instance.velocity.x, instance.velocity.y = instance.model:getLinearVelocity()
        if instance.velocity.y < 0 then
            instance.model:setLinearVelocity(instance.velocity.x, instance.velocity.y + 10)
        elseif instance.velocity.y > 0 then
            instance.model:setLinearVelocity(instance.velocity.x, instance.velocity.y * 1.025)
        end
        if instance.velocity.y == 0 then
            Runtime:removeEventListener('enterFrame', decelerate)
        end
    end

    function count()
        instance.count = instance.count + 1
        if instance.hold == false then
            Runtime:addEventListener('enterFrame', decelerate)
            Runtime:removeEventListener('enterFrame', count)
        elseif instance.count >= 10 then
            Runtime:removeEventListener('enterFrame', count)
            instance.count = 0
            instance.hold = false
            Runtime:addEventListener('enterFrame', decelerate)
        else
            if instance.velocity.y == 0 then
                instance.model:applyLinearImpulse(0, -0.25, instance.position.x, instance.position.y) --jump
            else 
                instance.model:setLinearVelocity(instance.velocity.x, instance.velocity.y * 1.1)
            end
        end


    end

    -- allows player to move using WASD
    local function move(event)
        local phase = event.phase
        local key = event.keyName
        instance:update() -- calls the update() function to check if the player is already moving/jumping
        instance.velocity.x, instance.velocity.y = instance.model:getLinearVelocity()

        if phase == 'down' then -- handles when the key is pressed, has a bug where the player does not keep moving in the direction 
            if key == 'a' then
                instance.a = true
            end
            if key == 'd' then
                instance.d = true
            end
            if key == 'x' then
                instance.health = 0
            end
        end

        if phase == 'up' and (key == 'a' or key == 'd') and instance.isGrounded == false then
            if key == 'a' then
                instance.a = false
            elseif key == 'd' then
                instance.d = false
            end
        elseif phase == 'up' and (key == 'a' or key == 'd') then -- handles when the key is released
            if key == 'a' then
                instance.a = false
            elseif key == 'd' then
                instance.d = false
            end
        end
    end

    local function jump(event)
        local phase = event.phase
        local key = event.keyName
        local type = 'short'

        if phase == 'down' then
            if (key == 'w' or key == 'space') and instance.isGrounded then
                if instance.hold == false then
                    Runtime:addEventListener('enterFrame', count)
                end
                instance.hold = true
                instance.model:applyLinearImpulse(0, -45, instance.position.x, instance.position.y) --jump
            end
        end

        if phase == 'up' and instance.isGrounded == false then
            if key == 'w' or key == 'space' then
                instance.hold = false
                instance.count = 0
            end
        end
    end

    function instance:RemoveEvents()
        Runtime:removeEventListener('enterFrame', checkMove)
        Runtime:removeEventListener('key', move)
        Runtime:removeEventListener('key', jump)
    end
    
    --Calls the events for keyPresses
    Runtime:addEventListener('enterFrame', checkMove)
    Runtime:addEventListener('key', move)
    Runtime:addEventListener('key', jump)
    return instance
end
return Player