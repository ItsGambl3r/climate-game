local widget = require "widget"
local composer = require( "composer" )

local backgroundMusic = audio.loadStream( "Resources/ddlc.mp3" )
backgroundMusics = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )
audio.setVolume( 0.1, { channel=1 } )
audio.pause(1)

function keyIsPressed(event) --optional arguments in lua?
    if event.phase == "down" and (event.keyName == "p" or event.keyName == "escape") then

        return true --key is held
    elseif event.phase == "up" and (event.keyName == "p" or event.keyName == "escape") then

        return false --key is released
    end
end

function keyHasReleased(event) --optional arguments in lua?
    if event.phase == "up" and (event.keyName == "p" or event.keyName == "escape") then

        return true
    end
end

function keyIsReleased(event)
    if event.phase == "up" and (event.keyName == "p" or event.keyName == "escape") then

        return true
    end
end

gameIsActive = true 

function gamePause(event)
    if gameIsActive and keyIsPressed(event) then
        
        gameIsActive = false
        keyIsReleased = false
        physics.pause()

        Runtime:removeEventListener("enterFrame", gameUpdate)
        Runtime:removeEventListener("enterFrame", detectWin)
        Runtime:removeEventListener("enterFrame", detectDeath)
        Runtime:removeEventListener('enterFrame', decelerate)
        Runtime:removeEventListener('enterFrame', raiseLevel)
        Runtime:removeEventListener('enterFrame', moveBoomba)
        
        rect = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
        rect:setFillColor(0, 0, 0)
        rect.alpha = 0.75
        text = display.newText("Game Paused", display.contentCenterX, display.contentCenterY, native.systemFont, 50)

    elseif gameIsActive == false and keyIsPressed(event) then
        if keyReleased == true then

            physics.start()
            gameIsActive = true
            Runtime:removeEventListener('key', gamePause)
    

            Runtime:addEventListener("enterFrame", gameUpdate)
            Runtime:addEventListener("enterFrame", detectWin)
            Runtime:addEventListener("enterFrame", detectDeath)
            Runtime:addEventListener('enterFrame', raiseLevel)
            Runtime:addEventListener('enterFrame', decelerate)
            Runtime:addEventListener('enterFrame', moveBoomba)
            
            display.remove(text)
            display.remove(rect)

            timer.performWithDelay(300, function() Runtime:addEventListener('key', gamePause) end)

        end
    end
    keyReleased = keyHasReleased(event)
end
