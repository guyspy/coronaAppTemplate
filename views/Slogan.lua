-----------------------------------------------------------------------------------------
--
-- splash.lua. This is also a basic template
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local GA = require( "utils.GoogleAnalytics.ga" )
local socket = require("socket")

-- call the ui renderer tool
local Slogan = require( "views.display.Slogan" )

-- create scene
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function startApp(  )
  timer.performWithDelay(
      2000,
      function()
        composer.gotoScene( "views.home", "fade" )
      end
    )
end

------------------------------------------------------
--   check internet and start app which need internet
------------------------------------------------------
local function hasInternet(  )
  local netConn = socket.connect("google.com", 80)
  if netConn == nil then
    return false
  end
  netConn:close()
  return true
end

local function startAppIfHasInternet(  )
  if hasInternet() then
    timer.performWithDelay(
      2000,
      function()
        composer.gotoScene( "views.home", "fade" )
      end
    )
  else
    native.showAlert(
      "無網路連線",
      "無法連線至網際網路，請稍候再試",
      {"OK"},
      function ( event )
        if event.action == "clicked" then
          startAppIfHasInternet( )
        end
      end
    )
  end
end


-- "scene:create()"
function scene:create( event )

  local sceneGroup = self.view

  -- Initialize the scene here.
  -- Example: add display objects to "sceneGroup", add touch listeners, etc.
  local sloganDisplay = Slogan.create()

  sceneGroup:insert( sloganDisplay )
end


-- "scene:show()"
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Called when the scene is still off screen (but is about to come on screen).
  elseif ( phase == "did" ) then

    -- send to ga
    -- change the "splash" to scene's name
    GA.enterScene("splash")
    startApp( )
    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
  end
end


-- "scene:hide()"
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.

  elseif ( phase == "did" ) then
    -- Called immediately after scene goes off screen.
  end
end


-- "scene:destroy()"
function scene:destroy( event )

  local sceneGroup = self.view

  -- Called prior to the removal of scene's view ("sceneGroup").
  -- Insert code here to clean up the scene.
  -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene