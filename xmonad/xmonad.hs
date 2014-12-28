import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.NoBorders

import Codec.Binary.UTF8.String (encode)
import Data.List
import Data.Maybe
import Data.Monoid

import XMonad
import Control.Monad
import qualified XMonad.StackSet as W
import XMonad.Hooks.SetWMName
import XMonad.Util.XUtils (fi)
import XMonad.Util.WorkspaceCompare
import XMonad.Util.WindowProperties (getProp32)

import System.IO

main = do
 xmproc <- spawnPipe "/usr/bin/xmobar /home/jammers/.xmobarrc"
 xmonad $ ewmh defaultConfig
  { terminal = "lxterm"
    , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"
    , modMask = mod4Mask
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = smartBorders $ avoidStruts  $  layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppTitle = xmobarColor "green" "" . shorten 49
        }
   , handleEventHook = fullscreenEventHook2
  } `additionalKeys` [ 
	((mod4Mask,xK_f),spawn "chromium-browser")
	, ((mod4Mask,xK_y),spawn "lxterm")
	, ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, xK_Print), spawn "scrot")
    , ((mod4Mask,xK_o), spawn "sleep 1; xset dpms force off")
  ]





-- |
-- An event hook to handle applications that wish to fullscreen using the
-- _NET_WM_STATE protocol. This includes users of the gtk_window_fullscreen()
-- function, such as Totem, Evince and OpenOffice.org.
fullscreenEventHook2 :: Event -> X All
fullscreenEventHook2 (ClientMessageEvent _ _ _ dpy win typ (action:dats)) = do
  state <- getAtom "_NET_WM_STATE"
  fullsc <- getAtom "_NET_WM_STATE_FULLSCREEN"
  wstate <- fromMaybe [] `fmap` getProp32 state win

  let isFull = fromIntegral fullsc `elem` wstate

      -- Constants for the _NET_WM_STATE protocol:
      remove = 0
      add = 1
      toggle = 2
      ptype = 4 -- The atom property type for changeProperty
      chWstate f = io $ changeProperty32 dpy win state ptype propModeReplace (f wstate)

  when (typ == state && fi fullsc `elem` dats) $ do
    when (action == add || (action == toggle && not isFull)) $ do
      chWstate (fi fullsc:)
      windows $ W.float win $ W.RationalRect 0 0 1 1
    when (action == remove || (action == toggle && isFull)) $ do
      chWstate $ delete (fi fullsc)
      windows $ W.sink win

  return $ All True

fullscreenEventHook2 _ = return $ All True





