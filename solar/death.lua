local composer = require( 'composer' )

Death = {}
Death.__index = Death

function Death:setBound(y)
    self.y = y
end

function Death:getBound()
    return self.y
end

function Death:checkBound(hero)
    if hero.position.y > self.y then
        hero.isAlive = false
    end
end

function Death:checkHp(hero)
    if hero.health <= 0 then
        hero.isAlive = false
    end
end

-- Keeping just in case we want to use this function to set hero back to default state
function Death:isDead(hero)
    hero:RemoveEvents()
    -- remove the hero from the scene
    display.remove(hero.model)
    -- remove health bar and text
    display.remove(healthBar)
    display.remove(healthText)
    -- remove camera and world
    display.remove(camera)
    display.remove(world)
    composer.removeScene("level1")
    composer.gotoScene("deathScreen", "fade", 500)
end

return Death