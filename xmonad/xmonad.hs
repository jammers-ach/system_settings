-- Imports.
 import XMonad
 import XMonad.Hooks.DynamicLog
 import XMonad.Util.EZConfig 

 import XMonad.Layout.NoBorders

 -- The main function.
 main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
 -- Command to launch the bar.
 myBar = "xmobar"

 -- Custom PP, configure it as you like. It determines what is being written to the bar.
 myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"  }

 -- Key binding to toggle the gap for the bar.
 toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

 -- Main configuration, override the defaults to your liking.
 myConfig = defaultConfig 
  {  layoutHook = smartBorders $ layoutHook defaultConfig
     , modMask = mod4Mask 
     , terminal = "lxterminal" 
  } `additionalKeys` [ 
	((mod4Mask,xK_f),spawn "x-www-browser")
	, ((mod4Mask,xK_y),spawn "lxterminal")
	, ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, xK_Print), spawn "scrot")
    , ((mod4Mask,xK_o), spawn "sleep 1; xset dpms force off")
  ]

