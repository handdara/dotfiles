import XMonad
import XMonad.Util.EZConfig (additionalKeysP)

keymaps = 
    [ ("M-<Return>", spawn "ghostty")
    , ("M-S-r", spawn "xmonad --recompile" >> spawn "xmonad --restart")
    , ("M-S-c", kill)
    ]

main = xmonad $ def
    { modMask = mod4Mask
    , terminal = "ghostty"
    }
    `additionalKeysP` keymaps
