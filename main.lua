-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local ga = require( "utils.GoogleAnalytics.ga" )

-----------------------------
--   init google analytics
-----------------------------
ga.init({ -- Only initialize once, not in every file
  isLive = true, -- REQUIRED
  testTrackingID = "UA-58649048-3", -- REQUIRED Tracking ID from Google
  productionTrackingID = "",
  debug = false, -- Recomended when starting
})
-- a global catcher for exceptions
Runtime:addEventListener(
  "unhandledError",
  function( event )
    ga.error(event.errorMessage, true)
    return true
  end
)

-- load splash screen
composer.gotoScene( "scenes.splash" )