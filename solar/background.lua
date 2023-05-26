-----------------------------------------------------------------------------------------
--
-- background.lua
-- 
-----------------------------------------------------------------------------------------
-- soon to be background class
 
local lfs = require( "lfs" )

Background = {
}
Background.backgroundList = {}

Background.__index = Background

function Background.new(folder, layerSpeed)
    local self = setmetatable({}, Background)

    self.layer = {}
    self.layerMirror = {}

    self.layerSpeed = 1
    self.folder = folder

    self.path = system.pathForFile(self.folder, system.ResourceDirectory)

    for file in lfs.dir(self.path) do
        if file ~= "." and file ~= ".." and file ~= ".DS_Store" then
            self.layer[file] = table.insert(self.layer, tostring(("Caverns1/" .. file)))
            self.layerMirror[file] = table.insert(self.layerMirror, tostring(("Caverns1/" .. file)))
        end
    end
    return self
end


function Background:create()
    table.sort(self.layer)
    for i = 1, #self.layer do
        self.layer[i] = display.newImageRect(self.layer[i], display.actualContentWidth, display.actualContentHeight)
        self.layer[i].x = display.contentCenterX
        self.layer[i].y = display.contentCenterY
  
        self.layerMirror[i] = display.newImageRect(self.layerMirror[i], display.actualContentWidth, display.actualContentHeight)
        self.layerMirror[i].x = display.actualContentWidth + 175
        self.layerMirror[i].y = display.contentCenterY
    end
end
 
function Background:remove()
    for i = 1, #self.layer do
        self.layer[i]:removeSelf()
    end
    for i = 1, #self.layer do
        self.layerMirror[i]:removeSelf()
    end
end

function Background:repeatBg(event)
    for i = 1, #self.layer do
        if self.layer[i].x > display.actualContentWidth + 175 then
            self.layer[i].x = self.layerMirror[i].x - self.layer[i].width
        end

        if self.layerMirror[i].x > display.actualContentWidth + 175 then
            self.layerMirror[i].x = self.layer[i].x - self.layerMirror[i].width
        end

        if self.layer[i].x < -display.actualContentWidth + 180 then
            self.layer[i].x = self.layerMirror[i].x + self.layer[i].width
        end

        if self.layerMirror[i].x < -display.actualContentWidth + 180 then
            self.layerMirror[i].x = self.layer[i].x + self.layerMirror[i].width
        end
    end
end

function Background:scroll(hero)
    velX = hero:getVelocityX()
    if velX > 2 then 
        for i = 1, #self.layer do
            self.layer[i].x = self.layer[i].x - i * 0.2
            self.layerMirror[i].x = self.layerMirror[i].x - i * 0.2
        end
    end

    if velX < -2 then 
        for i = 1, #self.layer do
            self.layer[i].x = self.layer[i].x + i * 0.2
            self.layerMirror[i].x = self.layerMirror[i].x + i * 0.2
        end
    end
end

--function 

function Background:update(hero)
    self:repeatBg()
    self:scroll(hero)
    self:repeatBg()
end

return Background