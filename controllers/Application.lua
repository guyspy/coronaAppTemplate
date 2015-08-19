local composer = require( "composer" )
local GA = require( "utils.GoogleAnalytics.ga" )
local User = require( "models.User" )
local facebook = require( "facebook" )
local json = require( "json" )
local ApiKeys = require( "apikeys" )
local URL = require( "utils.net.url" )

-- -------------------------------------------------------------------------------
-- View Object instances are created in scenes. To access them, use setters to put them here
-- -------------------------------------------------------------------------------
local webView

-- -------------------------------------------------------------------------------
-- Module starts here
-- -------------------------------------------------------------------------------
local M = {}

M.setWebView = function ( _webView )
  webView = _webView
end

M.enterLoginPage = function (  )
  composer.gotoScene( "views.login", {effect="slideLeft", time=400}  )
end

M.closeLoginPage = function (  )
  composer.gotoScene( "views.home", {effect="slideRight", time=400}  )
end

M.handleTabBarEvent = function ( event )

  -- Define actions ( represented by button id ) that need login. See views.TabBar for all button ids
  local needLoginToAccess = {
    wishes = true,
    start = true,
  }

  -- get the id of the btn clicked
  local eId = event.target._id
  if (eId == "account") then

    M.enterLoginPage()

  elseif needLoginToAccess[eId] then
    -- check login status before going into pages that require login
    if User.isLogin() then
      webView:gotoPageWithToken( eId, User.getLoginToken() )
    else
      native.showAlert( "需要登入", "請先登入", {"OK"}, M.enterLoginPage  )
    end
  else
    webView:gotoPage( eId )
    GA.enterScene( eId )
  end
end

M.handleFBAppRequest = function ( data )
  local request_ids
  -- case if is android
  if (data.androidIntent and data.androidIntent.url) then
    local url = data.androidIntent.url
    local query = URL.parseQuery(url)
    request_ids = query.request_ids

    -- set these vars and when home.lua is shown, user will be guided to gotoFacebookCanvas() in WebView.lua
    if (request_ids) then
      composer.setVariable("request_ids", request_ids)
      composer.setVariable("openPage", "fbc")
    end


  end

end


return M