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
    filename = "assets/background.png",
    width = Styles.screenW,
    height = Styles.screenH,
    x = Styles.halfW,
    y = Styles.halfH,
  })  

  -- -- create logo text
  group.slogan = AdaptiveDisplay.newText({
    parent = group,
    text = "Slogan!!",
    fontSize = Styles.h1,
    x = Styles.halfW,
    y = Styles.halfH
  })
  group.slogan:setFillColor( 0,0,0 )


  -- -------------------------------------------------------------------------------
  -- instance methods goes here
  -- -------------------------------------------------------------------------------




  return group
end

return M