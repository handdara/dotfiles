import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Layout.Spacing

keymaps =
  [ ("M-<Return>", spawn "ghostty"),
    ("M-.", spawn "ghostty -e mg"),
    ("M-,", spawn "ghostty -e __h_pick_pass"),
    ("M-S-,", spawn "ghostty -e __h_pick_username"),
    ("M-S-s", spawn "flameshot gui"),
    ("M-S-r", spawn "xmonad --recompile" >> spawn "xmonad --restart"),
    ("M-S-c", kill)
  ]

startup :: X ()
startup = do
  spawn "sh ~/.fehbg"

layout = spacingWithEdge 3 $ layoutHook def

main =
  xmonad $
    def
      { modMask = mod4Mask,
        terminal = "ghostty",
        borderWidth = 2,
        focusedBorderColor = "#0080ff",
        normalBorderColor = "#808080",
        layoutHook = layout,
        startupHook = startup
      }
      `additionalKeysP` keymaps
