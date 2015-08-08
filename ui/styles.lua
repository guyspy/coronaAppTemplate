-----------------------------------------------------------------------------------------
--
-- ruler.lua. this is designed to parameterize all dimensions and corrdinates of the ui elements. e.g. navHeight, footerHeight, ect
--
-----------------------------------------------------------------------------------------
local M = {}

M.screenW, M.screenH, M.halfW, M.halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5, display.contentHeight*0.5

M.h1 = 25

return M