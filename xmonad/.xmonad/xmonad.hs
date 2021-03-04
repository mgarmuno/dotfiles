import XMonad
import qualified XMonad.StackSet as W

import XMonad.Actions.CopyWindow(kill1)
import XMonad.Actions.WithAll(sinkAll, killAll)

import XMonad.Config.Desktop

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.WorkspaceHistory

import XMonad.Layout.ShowWName

import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Run(spawnPipe)

import Data.Maybe(fromJust)
import qualified Data.Map as M
import System.IO

myTerminal :: String
myTerminal = "termite"

myManageHook = composeAll
    [ className =? "Gimp"     --> doFloat
    , className =? "rdesktop" --> doFloat
    ]

xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable .(map xmobarEscape) $ ["sys", "dev", "www", "mail", "med", "play", "chat", "virt", "trnt"]
	where 
		clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                             (i,ws) <- zip [1..9] l,                                        
								let n = i ]

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

myModMask :: KeyMask
myModMask = mod4Mask

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myKeys :: [(String, X())]
myKeys =
	[ ("M-C-r", spawn "xmonad --recompile")
    , ("M-S-r", spawn "xmonad --restart")
	, ("M-c", kill1)
	, ("M-S-c", killAll)
	, ("M-<Return>", spawn myTerminal)
	]

main = do
	xmproc <- spawnPipe "xmobar"
	xmonad $ desktopConfig
		{manageHook = manageDocks <+> myManageHook 
			<+> manageHook desktopConfig
		, layoutHook = avoidStruts $ layoutHook defaultConfig
		, workspaces = myWorkspaces
		, logHook = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
			{ ppOutput = hPutStrLn xmproc
			, ppCurrent = xmobarColor "#98BE65" "" . wrap "[" "]"
			, ppVisible = xmobarColor "#98BE65" ""
			, ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""
            , ppHiddenNoWindows = xmobarColor "#C792EA" ""
			, ppTitle = xmobarColor "#b3afc2" "" . shorten 60
            , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"
            , ppExtras  = [windowCount]
            , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
		}
		, modMask = myModMask
	} `additionalKeysP` myKeys
