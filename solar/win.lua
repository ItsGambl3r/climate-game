-----------------------------------------------------------------------------------------
--
-- options.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local homeBtn

-- 'onRelease' event listener for homeBtn
local function onHomeBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "menu", "fade", 500 )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.nil
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "Resources/youwin.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX
	background.y = 0 + display.screenOriginY

	-- create a widget button (which will loads level1.lua on release)
	homeBtn = widget.newButton{
		label = "Home",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "Resources/button.png",
		overFile = "Resources/button-over.png",
		width = 154, height = 40,
		onRelease = onHomeBtnRelease	-- event listener function
	}
	homeBtn.x = display.contentCenterX
	homeBtn.y = display.contentHeight - 100

    -- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( homeBtn )
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
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
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
	
	if homeBtn then
		homeBtn:removeSelf()	-- widgets must be manually removed
		homeBtn = nil
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