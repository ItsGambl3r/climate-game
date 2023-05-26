-----------------------------------------------------------------------------------------
--
-- camera.lua
-- 
-----------------------------------------------------------------------------------------
-- 

Camera = {}

Camera.__index = Camera

function Camera.new(lb, rb, layerSpeed)
    local self = setmetatable({}, Camera)
    self.lb = lb or -5000
    self.rb = rb or 5000
    return self
end

--Not sure how to implement 
function Camera:size(width,height)
end

--Camera deadZones 
function Camera:deadZone(left,right)
    self.left = left or 120
    self.right = right or 200
end

--Duration in seconds
function Camera:shake(intensity, duration)
    while true do
        self.world.x = self.world.x + math.random(-intensity, intensity)
    end
end


--Must attach world 
function Camera:attach(world)
    self.world = world
end

--Updates camera position
function Camera:update(hero)
    if (hero.position.x > self.lb) and (hero.position.x < self.rb) then
        if hero.position.x > self.right then 
            self.world.x = -hero.position.x + 200
        end

        if hero.position.x < self.left then 
            self.world.x = -hero.position.x + 120
        end
    end

    if hero.position.y > 500 then 
        self.world.y = -hero.position.y + 500
    end

    if hero.position.y < 200 then 
        self.world.y = -hero.position.y + 200
    end
end

return Camera