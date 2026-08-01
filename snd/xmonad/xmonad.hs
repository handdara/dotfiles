import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig (additionalKeysP)

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

layout =
  avoidStruts $
    spacingWithEdge 3 $
      layoutHook def

hXmobarPP :: PP
hXmobarPP =
  def
    { ppCurrent = xmobarColor "#0db9d7" "",
      ppHidden = xmobarColor "#a9b1d6" "",
      ppHiddenNoWindows = xmobarColor "#444b6a" ""
    }

statBar = statusBarProp "xmobar" (pure hXmobarPP)

main =
  xmonad $
    withEasySB statBar defToggleStrutsKey $
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
