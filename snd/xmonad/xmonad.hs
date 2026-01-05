import XMonad
import XMonad.Util.EZConfig (additionalKeysP)

myKeys = 
    [ ("M-<Return>", spawn "ghostty")
    , ()
    ]

main = xmonad def
    { modMask = mod4Mask
    , terminal = "ghostty"
    }
