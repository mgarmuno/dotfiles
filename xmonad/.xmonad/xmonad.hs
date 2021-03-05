import XMonad
import qualified XMonad.StackSet as W

import XMonad.Actions.CopyWindow(kill1)
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll

import XMonad.Config.Desktop

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.WorkspaceHistory

import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows
import XMonad.Layout.GridVariants(Grid(Grid))
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle(mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.SubLayouts
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowArranger(windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T(toggleLayouts, ToggleLayout(Toggle))

import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Run(spawnPipe, safeSpawn)
import XMonad.Util.SpawnOnce

import Data.Maybe(fromJust)
import qualified Data.Map as M

import System.IO

myStartupHook :: X ()
myStartupHook = do
          spawnOnce "feh --bg-scale ~/.config/walls/welcome_home_dracula.png"
          spawnOnce "setxkbmap -layout us -variant altgr-intl -option nodeadkeys"
          spawnOnce "xrdb -merge ~/.Xresources"
          spawnOnce "sh ~/.config/mtools/cliplistner.sh"

myFont :: String
myFont = "xft:Hack:regular:size=9:antialias=true:hinting=true"


myTerminal :: String
myTerminal = "termite"

doomEmacs :: String
doomEmacs = "/home/magneto/.emacs.d/bin/doom"

myManageHook = composeAll
    [ className =? "Gimp"     --> doFloat
    , className =? "rdesktop" --> doFloat
    ]

myWorkspaces =  ["sys", "dev", "www", "mail", "med", "play", "chat", "virt", "trnt"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

myModMask :: KeyMask
myModMask = mod4Mask

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True


myKeys :: [(String, X())]
myKeys =
	[ ("M-C-r", spawn "xmonad --recompile")
    , ("M-S-r", spawn "xmonad --restart")
	, ("M-c", kill1)
	, ("M-S-c", killAll)

	, ("M-<Return>", spawn myTerminal)
	, ("M-e", safeSpawn doomEmacs ["run"])
	]

myTabTheme = def { fontName            = myFont , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

tall     = renamed [Replace "tall"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 0
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme

myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Hack:bold:size=20"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     tall
                                 ||| magnify
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs
                                 ||| grid
                                 ||| spirals
                                 ||| threeCol
                                 ||| threeRow

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh def
        {manageHook = manageDocks <+> myManageHook
            <+> manageHook desktopConfig
        , layoutHook = showWName' myShowWNameTheme $ myLayoutHook
        , workspaces = myWorkspaces
        , startupHook = myStartupHook
        , logHook = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppCurrent = xmobarColor "#98BE65" "" . wrap "[" "]"
            , ppVisible = xmobarColor "#98BE65" "" . clickable
            , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" "" . clickable
            , ppHiddenNoWindows = xmobarColor "#C792EA" "" . clickable
            , ppTitle = xmobarColor "#b3afc2" "" . shorten 60
            , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"
            , ppExtras  = [windowCount]
            , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
            }
        , modMask = myModMask
        } `additionalKeysP` myKeys
