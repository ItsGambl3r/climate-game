--------------------------------------

---  Class for Platform Objects in a Level

---------------------------------------
--- Stefan


physics = require("physics")

---Initialization
Platform = {
    position = {
        x = x,
        y = y
    } or {
        x = 0,
        y = 0
    },

    model = model or {},

    velocity = {
        x = 0,
        y = 0
    },
   
}

Platform.__index = Platform

function Platform.new( x, y, newX, newY, modelname, friction)
    friction = friction or 0.5
    local self = setmetatable({}, Platform)
    modelname = modelname or 'Resources/Platform.png'
    self:setModel(display.newImageRect(modelname, newX, newY))
    self:setPosition(x,y)
    physics.addBody(
        self.model, "static",
        {density=1.0},
        {box={ halfWidth=(newX/2), halfHeight=(newY/2), }, isSensor=false, friction=friction })
	self.model.isFixedRotation = false
    self.model.x = x
    self.model.y = y
    return self
end

function Platform:setModel(model)
    self.model = model
end

function Platform:setPosition(x, y)
    self.position.x = x
    self.position.y = y
    self.model.x = x
    self.model.y = y
end

return Platform