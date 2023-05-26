-----------------------------------------------------------------------------------------
--
-- actor.lua
-- 
-----------------------------------------------------------------------------------------
-- Parent class for any playable, friendly or hostile character (maybe projectiles too)
Physics = require("physics")

-- init --
Actor = {
    name = name or '',
    model = model or {},
    position = {
        x = x,
        y = y
    } or {},
    velocity = {
        x = 0,
        y = 0
    },
    health = health or 0,
    isAttacking = false,
    isMoving = false,
    isGrounded = true,
    isAlive = true
}
Actor.__index = Actor

-- Setters --
function Actor:setName(name)
    self.name = name
end

function Actor:setHealth(hp)
    self.health = hp
end

function Actor:setModel(model)
    self.model = model
end

function Actor:setVelocity(vx, vy)
    self.velocity.x = vx
    self.velocity.y = vy
end

function Actor:setPosition(x, y)
    self.position.x = x
    self.position.y = y
    self.model.x = x
    self.model.y = y
end

-- Getters --
function Actor:getName()
    return self.name
end

function Actor:getHealth()
    return self.health
end

function Actor:getPosition()
    return self.position
end

function Actor:getVelocityY()
    return self.velocity.y
end

function Actor:getPositionX()
    return self.position.x
end

function Actor:getPositionY()
    return self.position.Y
end

function Actor:getVelocityX()
    return self.velocity.x
end
-- checks --
-- checks if actor is touching the ground
function Actor:grounded()
    if self.velocity.y == 0 then
        self.isGrounded = true
    else
        self.isGrounded = false
    end
end

-- checks in the actor is moving
function Actor:moving()
    if self.velocity == {0, 0} then
        self.isMoving = false
    else
        self.isMoving = true
    end
end

-- Handels when the actor attacks, (might be overwritten or moved to a different file)
function Actor:attack()
    -- Code for attack function goes here
end

-- Handels when the actor takes damage
function Actor:damaged()
end

-- checks is actor is alive
function Actor:alive()
end

-- handels when the actor dies goes here (might need to be overwritten or just moved to a different file) 
-- ex. friendly NPC/dummy could just respawn instantly, while player has to be reset and enemies have to stay dead
function Actor:death()
end

-- Any code that needs to be checked every frame goes here
function Actor:update()
    self:moving()
    self:grounded()
    -- self:attack()
    -- self:alive()
end

return Actor