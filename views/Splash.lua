-----------------------------------------------------------------------------------------
--
-- A standard example for creating display objects
--
-----------------------------------------------------------------------------------------
local styles = require( "styles" )

local M = {}

M.create = function( )

  -- -------------------------------------------------------------------------------
  -- create diplay objects here
  -- -------------------------------------------------------------------------------
  -- create the group to return as an instance of Stage class
  local group = display.newGroup( )

  -- create background shade
  group.background = display.newRect( group, styles.halfW, styles.halfH, styles.screenW, styles.screenH )
  group.background:setFillColor( 1,1,1 )

  -- create logo text
  group.slogan = display.newText({
    parent = group,
    text = "Splash!!",
    fontSize = styles.h1,
    x = styles.halfW,
    y = styles.halfH
  })
  group.slogan:setFillColor( 0,0,0 )

  -- -------------------------------------------------------------------------------
  -- instance methods goes here
  -- -------------------------------------------------------------------------------
  -- declare animation as an instance method
  local isAnimating = false
  function group.slogan:bounce(  )
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