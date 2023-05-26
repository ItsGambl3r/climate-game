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

-- forward declarations and other locals
local playBtn
-- local optionBtn
local quitBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- -- 'onRelease' event listener for optionBtn
-- local function onOptionBtnRelease()
	
-- 	-- go to options page
-- 	composer.gotoScene( "options", "fade", 500 )
	
-- 	return true	-- indicates successful touch
-- end

-- 'onRelease' event listener for optionBtn
local function onQuitBtnRelease()
	
	-- quits the application
	native.requestExit()
	
	return true	-- indicates successful touch
end



function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "Resources/background.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "Resources/logo.png", 264, 42 )
	titleLogo.x = display.contentCenterX
	titleLogo.y = 100
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label = "Play Now",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "Resources/button.png",
		overFile = "Resources/button-over.png",
		width = 154, height = 40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.contentHeight - 245

	-- optionBtn = widget.newButton{
	-- 	label = "Options",
	-- 	labelColor = { default={ 1.0 }, over={ 0.5 } },
	-- 	defaultFile = "Resources/button.png",
	-- 	overFile = "Resources/button-over.png",
	-- 	width = 154, height = 40,
	-- 	onRelease = onOptionBtnRelease	-- event listener function
	-- }
	-- optionBtn.x = display.contentCenterX
	-- optionBtn.y = display.contentHeight - 185

	quitBtn = widget.newButton{
		label = "Quit",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "Resources/button.png",
		overFile = "Resources/button-over.png",
		width = 154, height = 40,
		onRelease = onQuitBtnRelease	-- event listener function
	}
	quitBtn.x = display.contentCenterX
	quitBtn.y = display.contentHeight - 185
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playBtn )
	-- sceneGroup:insert( optionBtn )
	sceneGroup:insert( quitBtn )
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
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		optionBtn.removeSelf()
		quitBtn.removeSelf()
		playBtn = nil
		optionBtn = nil
		quitBtn = nil
	end

	-- if optionBtn then
	-- 	playBtn:removeSelf()	-- widgets must be manually removed
	-- 	optionBtn:removeSelf()
	-- 	quitBtn:removeSelf()
	-- 	playBtn = nil
	-- 	optionBtn = nil
	-- 	quitBtn = nil
	-- end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
