import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myTerminal :: String
myTerminal = "termite"

myModMask :: KeyMask
myModMask = mod4Mask

myKeys :: [(String, X())]
myKeys =
	[ ("M-<Return>", spawn (myTerminal))
	]

main = do
	xmproc <- spawnPipe "xmobar"
	xmonad $ docks defaultConfig
		{ layoutHook = avoidStruts $ layoutHook defaultConfig
		, logHook = dynamicLogWithPP xmobarPP
			{ ppOutput = hPutStrLn xmproc
			, ppTitle = xmobarColor "green" "" . shorten 50
		}
		, modMask = myModMask
	}
