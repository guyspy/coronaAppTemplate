-----------------------------------------------------------------------------------------
--
-- Adaptive Display Helper. Wraper for generating display objects
--
-----------------------------------------------------------------------------------------
local Styles = require( "styles" )
local widget = require( "widget" )

local M = {}

M.toAdaptiveDisplayObject = function ( displayObject, options )
  local xScale, yScale = options.xScale, options.yScale
  local width, height = options.width, options.height
  local percentX, percentY = options.percentX, options.percentY
  local x, y = options.x, options.y
  local anchorX, anchorY = options.anchorX, options.anchorY
  local doAdaptive = options.doAdaptive
  local parent = options.parent

  -- default if nil
  xScale = yScale and xScale or 1
  yScale = xScale and yScale or 1

  -- adaptive resize displayObject to ensure same ratio
  if ( width and height ) then
    local w = doAdaptive and Styles.adaptiveResize( width, xScale ) or width
    local h = doAdaptive and Styles.adaptiveResize( height, yScale ) or height
    displayObject.width, displayObject.height = w, h
  end

  -- position the displayObject
  if ( doAdaptive ) then
    displayObject.x, displayObject.y = Styles.adaptiveCords( percentX, percentY )
  else
    displayObject.x, displayObject.y = x, y
  end

  -- set if not nil
  if ( anchorX ) then
    displayObject.anchorX = anchorX
  end
  if ( anchorY ) then
    displayObject.anchorY = anchorY
  end
  if ( parent ) then
    parent:insert( displayObject )
  end

  return displayObject
end


M.newImageRect = function( options )
  -- listing all option fields
  local filename = options.filename
  -- set baseDir if specified
  local baseDir = options.baseDir and options.baseDir or system.ResourceDirectory
  -- create img
  local img = display.newImageRect( filename, baseDir, options.width, options.height )
  return M.toAdaptiveDisplayObject( img, options )
end


M.newText = function( options )
  local text = display.newText( options )
  return M.toAdaptiveDisplayObject( text, options )
end


M.newButton = function ( options )
  local button = widget.newButton( options )
  return M.toAdaptiveDisplayObject( button, options )
end


return M