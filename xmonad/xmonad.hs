-- Imports.
 import XMonad
 import XMonad.Hooks.DynamicLog
 import XMonad.Util.EZConfig
 import XMonad.Hooks.SetWMName
 import XMonad.Hooks.EwmhDesktops
 import XMonad.Layout.NoBorders
 import XMonad.Hooks.ManageHelpers 

 -- The main function.
 main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
 -- Command to launch the bar.
 myBar = "xmobar"

 -- Custom PP, configure it as you like. It determines what is being written to the bar.
 myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"  }

 -- Key binding to toggle the gap for the bar.
 toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

 myManageHook = composeAll
   [ className =? "Dolphin-emu"  --> doFloatAt 0 0
   , isFullscreen --> doFullFloat
   , isDialog --> doCenterFloat
   ]


 -- Main configuration, override the defaults to your liking.
 myConfig = defaultConfig 
  {  layoutHook = smartBorders $ layoutHook defaultConfig
     , handleEventHook    = handleEventHook def <+> XMonad.Hooks.EwmhDesktops.fullscreenEventHook
     , modMask = mod4Mask 
     , manageHook =  myManageHook <+> manageHook defaultConfig
     , terminal = "lxterminal" 
     , startupHook = setWMName "LG3D" 
  } `additionalKeys` [ 
	((mod4Mask,xK_f),spawn "x-www-browser")
	, ((mod4Mask,xK_y),spawn "lxterminal")
	, ((controlMask, xK_Print), spawn "sleep 0.2; scrot-and-copy -s")
    , ((0, xK_Print), spawn "scrot-and-copy")
    , ((mod4Mask,xK_o), spawn "xscreensaver-command -lock")
  ]

