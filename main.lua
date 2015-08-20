-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local GA = require( "utils.GoogleAnalytics.ga" )
local ApiKeys = require( "apikeys" )
local Util = require( "utils.util" )
local Application = require( "controllers.Application" )

-----------------------------
--   init google analytics
-----------------------------
GA.init({ -- Only initialize once, not in every file
  isLive = false, -- REQUIRED
  testTrackingID = ApiKeys.ga_testTrackingID, -- REQUIRED Tracking ID from Google
  productionTrackingID = ApiKeys.ga_productionTrackingID,
  debug = false, -- Recomend to set to true to start with. 
})
-- a global catcher for exceptions
Runtime:addEventListener(
  "unhandledError",
  function( event )
    GA.error(event.errorMessage, true)
    return true
  end
)


-- Prints all launch arguments
local launchArguments = ...
  if launchArguments then
    print("### --- Launch Arguments ---")
    Util.printTable(launchArguments)
    ---------------------------
    --  Listener FB Request  --
    ---------------------------
    -- Application.handleFBAppRequest( launchArguments )
end

-- Prints the event table when an "applicationOpen" event occurs.
local function onSystemEvent(event)
  if event.type == "applicationOpen" then
    print("### --- Application Open ---")
    Util.printTable(event)
    ---------------------------
    --  Listener FB Request  --
    ---------------------------
    -- Application.handleFBAppRequest( event )
  end
end
Runtime:addEventListener("system", onSystemEvent)

-- load slogan screen
composer.gotoScene( "views.slogan" )

-- -- load homepage screen
-- composer.gotoScene( "views.home" )