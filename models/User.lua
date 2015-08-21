local json = require( "json" )
local LoadSave = require( "utils.loadsave" )

-- private method
local function getLoggedInUser( )
  local loggedInUser = LoadSave.loadTable("loggedInUser.json")
  if loggedInUser == nil then
    loggedInUser = {}
  end
  return loggedInUser
end

-- -------------------------------------------------------------------------------
-- Module starts here
-- -------------------------------------------------------------------------------
local M = {}

-- user singleton. before login() is called, load user from local json file
M.loggedInUser = getLoggedInUser()

M.getAvatar = function ( )
  -- default placeholder
  local result = "url" -- put avatar via url
  if M.loggedInUser.fbId then
    result = "https://graph.facebook.com/"..M.loggedInUser.fbId.."/picture?width=300&height=300"
  elseif M.loggedInUser.avatarUrl then
    result = M.loggedInUser.avatarUrl
  end
  return result
end

M.getLoginToken = function ( )
  return M.loggedInUser.loginToken and M.loggedInUser.loginToken or ""
end

M.isLogin = function ( )
  local isLogin = false
  if M.loggedInUser.loginToken then
    isLogin = true
  end
  return isLogin
end

M.logout = function ( )
  M.loggedInUser = {}
  LoadSave.saveTable( M.loggedInUser, "loggedInUser.json" )
  return M.loggedInUser
end

M.login = function ( user )
  M.loggedInUser = {
    username = user.username,
    displayName = user.displayName,
    avatarUrl = user.avatarUrl,
    loginToken = user.loginToken,
    fbId = user.fbId,
    access_token = user.access_token,
  }
  LoadSave.saveTable( M.loggedInUser, "loggedInUser.json" )
  return M.loggedInUser
end


-- M.downloadAvatar = function ( )
--   local networkListener = function ( event )
--     if not event.isError then
--       local avatarImg = event.target
--       avatarImg.isVisible = false
--       avatarImg:removeSelf( )
--       avatarImg = nil
--     end
--   end
--   display.loadRemoteImage( M.getAvatar(), "GET", networkListener, "avatar.jpg", system.DocumentsDirectory )
-- end

return M