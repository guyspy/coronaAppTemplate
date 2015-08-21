-----------------------------------------------------------------------------------------
--
-- A standard example for creating display objects
--
-----------------------------------------------------------------------------------------
local Styles = require( "styles" )
local AdaptiveDisplay = require( "utils.AdaptiveDisplay" )

local M = {}

M.create = function( )

  -- -------------------------------------------------------------------------------
  -- create diplay objects here
  -- -------------------------------------------------------------------------------
  -- create the group to return as an instance of Stage class
  local group = display.newGroup( )

  -- create background shade
  group.background = AdaptiveDisplay.newImageRect({
    parent = group,
    filename = "assets/mainPage_background.png",
    width = Styles.screenW,
    height = Styles.screenH,
    x = Styles.halfW,
    y = Styles.halfH,
  })  

  -- -- create logo text
  group.homeTitle = AdaptiveDisplay.newText({
    parent = group,
    text = "HomePage!!",
    fontSize = Styles.h1,
    x = Styles.halfW,
    y = Styles.halfH
  })
  group.homeTitle:setFillColor( 0,0,0 )


  -- -------------------------------------------------------------------------------
  -- instance methods goes here
  -- -------------------------------------------------------------------------------
  -- declare animation as an instance method
  local isAnimating = false
  function group.homeTitle:bounce(  )
    if not isAnimating then
      isAnimating = true
      transition.from( self,
        {
          xScale=0.1,
          yScale=0.1,
          time=1000,
          transition=easing.outElastic,
          onComplete=function( )
            isAnimating = false
          end
        }
      )
    end
  end


  return group
end

return M