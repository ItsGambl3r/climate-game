----------

  ---Creates a jumppad from platforn---

----------


physics = require("physics")
platform = require("platform")

JumpPad = {
    bounce = bounce or {}
}

JumpPad.__index = JumpPad
JumpPad = setmetatable(JumpPad, platform)

function JumpPad.new(x, y, bounce)
    local instance = setmetatable({}, JumpPad)
    instance:setModel(display.newImageRect('Resources/JumpPad.png', 60, 15))
    instance:setBounce(bounce)
    instance:setPosition(x,y)
    physics.addBody(
        instance.model, "static",
        {density=1.0, friction=5, bounce=bounce},
        {box={ halfWidth=(30), halfHeight=(7), }, isSensor=false })
    return instance
end

function JumpPad:setBounce(bounce)
    self.bounce = bounce
end

function JumpPad:bouncePlayer(player)
    heroX = player.model.x
    heroY = player.model.y
    
    if (instance.model.x < (heroX + 40)) and (instance.model.x > (heroX)) then
        if (instance.model.y == (heroY + 130)) then
            player.model:applyLinearImpulse(0, -55, player.model.x, player.model.y)
        end
    end
end
return JumpPad