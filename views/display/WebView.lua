-----------------------------------------------------------------------------------------
--
-- A standard example for creating display objects
--
-----------------------------------------------------------------------------------------
local Styles = require( "styles" )
local AdaptiveDisplay = require( "utils.AdaptiveDisplay" )
local ApiKeys = require( "apikeys" )
local User = require( "models.User" )
local Application = require( "controllers.Application" )
local Account = require( "controllers.Account" )
local Util = require( "utils.util" )
local composer = require( "composer" )

local domain = ApiKeys.serverDomain

-- the key will correspond to the id of the TabBar button
local paths = {
  home = "/mobile/index",
}

local isBusy = false

local function markBusy(  )
  isBusy = true
  native.setActivityIndicator( true )
end

local function markLoaded(  )
  if (isBusy) then
    isBusy = false
  end
  native.setActivityIndicator( false )
end

local M = {}

M.create = function( )

  -- -------------------------------------------------------------------------------
  -- create diplay objects here
  -- -------------------------------------------------------------------------------
  -- local webView = native.newWebView( Styles.halfW, Styles.tabBarHeight, Styles.screenW, Styles.screenH - Styles.tabBarHeight - Styles.navBarHeight )
  local webView = native.newWebView( Styles.halfW, 0, Styles.screenW, Styles.screenH - Styles.tabBarHeight )
  webView.anchorY = 0

  local function webListener( event )
    --print( event.type, event.url )
    if ( event.type == "loaded" ) then
      markLoaded()
    end
  ----------------------------
  -- Login/Logout Listener --
  ----------------------------
    -- -- intercept logout link ckicked
    -- local logoutUrl = domain.."/logout"
    -- if ( event.type == "link" and event.url == logoutUrl ) then
    --   User.logout()
    -- end
    -- -- intercept login
    -- local loginUrl = domain.."/login"
    -- if (event.type == "link" and event.url == loginUrl) then
    --   webView:stop()
    --   Application.enterLoginPage()
    -- end
  end
  webView:addEventListener( "urlRequest", webListener )


  -- -------------------------------------------------------------------------------
  -- instance methods goes here
  -- -------------------------------------------------------------------------------
  function webView:gotoPage( pathName )
    local url = domain..paths[pathName]
    local loginToken = User.getLoginToken()
    
    if (loginToken) then
      url = url.."?loginToken="..loginToken
    end

    webView:request(url)
    markBusy()
  end

  function webView:gotoPageWithToken( pathName, loginToken )
    webView:request(domain..paths[pathName].."?loginToken="..loginToken)
    markBusy()
  end

  return webView
end

return M