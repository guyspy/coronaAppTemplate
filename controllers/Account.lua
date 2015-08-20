local composer = require( "composer" )
local GA = require( "utils.GoogleAnalytics.ga" )
local User = require( "models.User" )
local Application = require( "controllers.Application" )
local facebook = require( "facebook" )
local json = require( "json" )
local ApiKeys = require( "apikeys" )

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

M.facebookLogin = function (  )

  -- get fbAppId
  local fbAppID = ApiKeys.fb_appID

  -- forward declaring required objects
  local facebookListener, sendLoginRequest, doLogin, handleLoginResponse
  local access_token, fbId, expires, name, email

  -- facebook listener
  facebookListener = function ( event )
    for k, v in pairs( event ) do
      print("[facebookListener]", k, ":", v )
    end
    if ( "session" == event.type ) then
      if ( "login" == event.phase ) then
        -- set access_token
        access_token = event.token
        -- set expires
        expires = event.expiration
        -- call get me info
        facebook.request( "me" )
      end
    elseif ( "request" == event.type ) then
      local response = json.decode( event.response )
      -- check if the response is the result of get "/me"
      if ( response.id ) then
        -- set fbId
        fbId = response.id
        -- set name
        name = response.name and response.name or ""
        -- set email
        email = response.email and response.email or ""
        -- perform login
        sendLoginRequest()
      end
    end
  end

  -- connecting to uniwish server and get user response
  sendLoginRequest = function (  )
    local params = {}
    params.body = "access_token="..access_token.."&expires="..expires.."&fbId="..fbId.."&name="..name.."&email="..email
    network.request( ApiKeys.fbLoginAPI, "POST", doLogin, params )
  end

  doLogin = function ( event )
    if event.isError or event.status ~= 200 then
      native.showAlert( "無法連線", "無法連線至主機，請稍候再試", {"OK"} )
    elseif event.phase == "ended" then
      handleLoginResponse( event.response )
    end
  end

  handleLoginResponse = function ( response )
    response = response and response or "{}"
    print( "handleLoginResponse", response )
    local data = json.decode( response )
    if data then
      if data.error then
        native.showAlert( "錯誤", data.error.message, {"OK"} )
      else
        local user = data.success
        user.access_token = access_token
        User.login( user )
        Application.closeLoginPage()
      end
    end
  end

  -- call fb login
  if system.getInfo("environment") == "simulator" then
    print("In simulator, use dummy fb login data to bypass login ")
    ----------------------------------
    --set Developer test FB account--
    ----------------------------------
    -- access_token = "CAAV0ATyQU3wBAPqK5ZCjdrN8WKZCUD3oLGCWZBJxts0RKxOC5S1R1ZAftm2cIv92grhDZCCvlOZB8tXQyq3gOGEfBH0ZCs33ui8ZATeqEFfrch2yATbueQQfj0rsMpd283NvVz8ZCl4qZBOkrfgq9woDHRLyYIV7CDZCj3qULZAyMGIoCjcjZB3Yk7E7GmCZAaMMz47T8bWM2LmNJSuhkYAQSRRXu0X5JYMJh3Mw08qZCk2z10gXAZDZD"
    -- handleLoginResponse( " {\"success\":{\"username\":\"d95b43002@ntu.edu.tw\",\"displayName\":\"Peng-Han Su\",\"avatarUrl\":\"https://graph.facebook.com/10205140288762722/picture?type\u003dlarge\",\"loginToken\":\"be24f843774ecb4af174a78ba7162ed5491b22c19326dfcfeef424049140ccb5\", \"fbId\":\"10205140288762722\"}}" )
  else
    facebook.login( fbAppID, facebookListener, { "user_friends", "email" } )
  end

end


M.logout = function (  )
  User.logout()
  Application.closeLoginPage()
end



return M