# Authorizations
There are several types authorisation. With Auth0, with google, with facebook


**AUTH0**

This is where you provide two pieces of information that Auth0 needs to know about the app, which are:
1. A callback URL: the URL that Auth0 will redirect to after the user successfully logs in. There can be more than one of these.
2. A logout URL: the URL that Auth0 will redirect to after the user logs out. There can be more than one of these.
callBack URSL

{BUNDLE_IDENTIFIER}://{YOUR_DOMAIN}/ios/{BUNDLE_IDENTIFIER}/callback
* Replace {BUNDLE_IDENTIFIER} with the app’s bundle identifier. If you didn’t change the bundle identifier in the starter project, this value is com.example.login. Note that {BUNDLE_IDENTIFIER} appears twice in the URL; you’ll need to replace it twice.
* Replace {YOUR_DOMAIN} with the value from the Domain field that you saw earlier on this page.

Auth0
  .webAuth()
  .scope()
  .audience()
  .start()
  
  
scopes from Auth0:
* openid: Required for the app to use OpenID Connect (OIDC) to authenticate the user. 
* This is the only scope required in scope()’s argument; all other scopes are optional.
* profile: Information stored in the user’s profile. 
* The profile stores a limited set of information — the user’s various names (full name, family name, given name, middle name, nickname),
*  the URL for the user’s picture, and when the user profile was last updated.
* email: Information about the user’s email, namely their email address and whether the email address was verified.
* read:current_user: Read-only access to the user’s profile.
* update:current_user_metadata: Read and write access to the user’s metadata. 
* This allows the app to get and set the favorite color value in the user’s metadata.
audience() specifies the API that the app will use: the Auth0 Management API, which we’ll use to get information about the user.
Finally, start() takes the WebAuth object constructed by all the previous methods in the chain and opens the browser window to display the login page.
It has a single parameter, a closure that takes an argument containing one of two possible values: .failure and .success.
