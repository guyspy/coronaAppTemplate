-----------------------------------------------------------------------------------------
--
-- ruler.lua. this is designed to parameterize all dimensions and corrdinates of the ui elements. e.g. navHeight, footerHeight, ect
--
-----------------------------------------------------------------------------------------
local M = {}

-- when using "adaptive" scale mode, set the standard screen height that the desinger used to layout the whole project here
M.standardDesignTemplateHeight = 1920;

M.screenW = display.contentWidth
M.screenH = display.contentHeight
M.halfW = display.contentWidth*0.5
M.halfH = display.contentHeight*0.5

M.adaptiveResize = function ( originalSize, scale )
  return M.screenH * ( originalSize / M.standardDesignTemplateHeight ) * scale
end

M.adaptiveX = function ( percent )
  return M.screenW * percent
end

M.adaptiveY = function ( percent )
  return M.screenH * percent
end

M.adaptiveCords = function ( percentX, percentY )
  return M.screenW * percentX, M.screenH * percentY
end

M.h1 = M.adaptiveResize(120, 1)
M.h2 = M.adaptiveResize(90, 1)
M.h3 = M.adaptiveResize(60, 1)
M.h4 = M.adaptiveResize(40, 1)
M.h5 = M.adaptiveResize(30, 1)

return M