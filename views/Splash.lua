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
  local background = display.newRect( styles.halfW, styles.halfH, styles.screenW, styles.screenH )
  background:setFillColor( 1,1,1 )
  -- insert into group at index 1
  group:insert( 1, background )
  -- an easy way to access child object from outside
  group.background = group[1]

  -- create logo text
  local slogan = display.newText({
    text = "Splash!!",
    fontSize = styles.h1,
    x = styles.halfW,
    y = styles.halfH
  })
  slogan:setFillColor( 0,0,0 )
  -- insert into group at index 2
  group:insert( 2, slogan )
  -- an easy way to access child object from outside
  group.slogan = group[2]

  -- -------------------------------------------------------------------------------
  -- instance methods goes here
  -- -------------------------------------------------------------------------------
  -- declare animation as an instance method
  local isAnimating = false
  function slogan:bounce(  )
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