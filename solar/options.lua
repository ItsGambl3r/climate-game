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
local backBtn
local keysBtn
local generalBtn

-- 'onRelease' event listener for backBtn
local function onBackBtnRelease()
	
	-- go to menu.lua scene
	composer.gotoScene( "menu", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- 'onRelease' event listener for keysBtn
local function onKeysBtnRelease()
	
	-- go to keybinds.lua scene
	composer.gotoScene( "keybinds", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- 'onRelease' event listener for generalBtn
local function onGeneralBtnRelease()
	
	-- go to general.lua scene
	composer.gotoScene( "general", "fade", 500 )
	
	return true	-- indicates successful touch
end


function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.nil
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
	local titleLogo = display.newImageRect( "Resources/options.png", 264, 70 )
	titleLogo.x = display.contentCenterX
	titleLogo.y = 100

    -- create a widget button (which will loads level1.lua on release)
	backBtn = widget.newButton{
		label = "Back",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "Resources/button.png",
		overFile = "Resources/button-over.png",
		width = 154, height = 40,
		onRelease = onBackBtnRelease	-- event listener function
	}
    backBtn.x = display.screenOriginX + 117
	backBtn.y = display.screenOriginY + 586

    keysBtn = widget.newButton{
		label = "Keybinds",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "Resources/button.png",
		overFile = "Resources/button-over.png",
		width = 154, height = 40,
		onRelease = onKeysBtnRelease	-- event listener function
	}
    keysBtn.x = display.contentCenterX
	keysBtn.y = display.contentHeight - 185

    generalBtn = widget.newButton{
		label = "General",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "Resources/button.png",
		overFile = "Resources/button-over.png",
		width = 154, height = 40,
		onRelease = onGeneralBtnRelease	-- event listener function
	}
    generalBtn.x = display.contentCenterX
	generalBtn.y = display.contentHeight - 245

    -- all display objects must be inserted into group
	sceneGroup:insert( background )
    sceneGroup:insert( titleLogo )
	sceneGroup:insert( backBtn )
	sceneGroup:insert( keysBtn )
	sceneGroup:insert( generalBtn )
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
	
	if backBtn then
		backBtn:removeSelf()	-- widgets must be manually removed
		keysBtn.removeSelf()
		generalBtn.removeSelf()
		backBtn = nil
		keysBtn = nil
		generalBtn = nil
	end

	if keysBtn then
		backBtn:removeSelf()	-- widgets must be manually removed
		keysBtn.removeSelf()
		generalBtn.removeSelf()
		backBtn = nil
		keysBtn = nil
		generalBtn = nil
	end

    if generalBtn then
		backBtn:removeSelf()	-- widgets must be manually removed
		keysBtn.removeSelf()
		generalBtn.removeSelf()
		backBtn = nil
		keysBtn = nil
		generalBtn = nil
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