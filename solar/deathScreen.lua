-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------
local deathMusic = audio.loadStream( "Resources/tragicDeath.mp3" )
deathMusicCall = audio.play( deathMusic, { channel=2, loops=-1, fadein=1000 } )
audio.setVolume( 0.1, { channel=2 } )
audio.pause(2)

local rtnHome
local retry

local function onRtnHomeRelease()
	-- go to level1.lua scene
	composer.gotoScene( "menu", "fade", 500 )
	return true	-- indicates successful touch
end

local function onRetryRelease()
	-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	return true	-- indicates successful touch
end

-- forward declarations and other locals

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "Resources/deathBackground.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- create/position logo/title image on upper-half of the screen
	local text = display.newImageRect( "Resources/youDied.png", 600, 250 )
	text.x = display.contentCenterX
	text.y = 150
	
	-- create a widget button (which will loads level1.lua on release)
	rtnHome = widget.newButton{
		label = "Return Home",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "Resources/button.png",
		overFile = "Resources/button-over.png",
		width = 154, height = 40,
		onRelease = onRtnHomeRelease	-- event listener function
	}
	rtnHome.x = display.contentCenterX
	rtnHome.y = display.contentHeight - 185

	retry = widget.newButton{
		label = "Retry Level",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "Resources/button.png",
		overFile = "Resources/button-over.png",
		width = 154, height = 40,
		onRelease = onRetryRelease	-- event listener function
	}
	retry.x = display.contentCenterX
	retry.y = display.contentHeight - 245
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( text )
	sceneGroup:insert( rtnHome )
	sceneGroup:insert( retry )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
	audio.resume(2)
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	audio.pause(2)
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	if rtnHome then
		rtnHome:removeSelf()	-- widgets must be manually removed
		retry:removeSelf()
		rtnHome = nil
		retry = nil
	end
	if retry then
		rtnHome:removeSelf()	-- widgets must be manually removed
		retry:removeSelf()
		rtnHome = nil
		retry = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
