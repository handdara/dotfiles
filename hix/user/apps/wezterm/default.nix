{
  pkgs,
  user_opts,
  ...
}: let
  c = import ./../../../util/color/marrissa-term.nix;
in {
  home.packages = [pkgs.wezterm];
  home.file = {
    ".config/wezterm" = {
      source = ../../../../fst/hez/wezterm-main;
      recursive = true;
    };
    ".config/wezterm/handdara/colors/default.lua".text = ''
      return {
          -- The default text color
          foreground = '#FFFADE',
          -- The default background color
          background = '#000000',

          -- Overrides the cell background color when the current cell is occupied by the
          -- cursor and the cursor style is set to Block
          cursor_bg = '#47A8A1',
          -- Overrides the text color when the current cell is occupied by the cursor
          cursor_fg = 'black',
          -- Specifies the border color of the cursor when the cursor style is set to Block,
          -- or the color of the vertical or horizontal bar when the cursor style is set to
          -- Bar or Underline.
          cursor_border = '#47A8A1',

          -- the foreground color of selected text
          selection_fg = '#18191E',
          -- the background color of selected text
          selection_bg = '#1D918B',

          -- The color of the scrollbar "thumb"; the portion that represents the current viewport
          scrollbar_thumb = '#222222',

          -- The color of the split lines between panes
          split = '#444444',

          ansi = { '#373C45', '#000000', '#44B273', '#ED722E', '#1D918B', '#D16BB7', '#00BFA4', '#8E8D8D' },
          brights = { '#CCCCCC', '#FF4D00', '#10B981', '#FFFF00', '#0DB9D7', '#D68EB2', '#5AD1AA', '#FFFADE' },

          -- -- Arbitrary colors of the palette in the range from 16 to 255
          indexed = { [136] = '#FFFF00' },

          -- Since: 20220319-142410-0fcdea07
          -- When the IME, a dead key or a leader key are being processed and are effectively
          -- holding input pending the result of input composition, change the cursor
          -- to this color to give a visual cue about the compose state.
          compose_cursor = '#1D918B',
      }
    '';
    ".config/wezterm/colors/marrissa-term.toml".text = ''
      [colors]
      background = '${
        if user_opts.term_invert or false
        then c.fg
        else c.bg
      }'
      foreground = '${
        if user_opts.term_invert or false
        then c.bg
        else c.fg
      }'
      cursor_bg = '${
        if user_opts.term_invert
        then c.black
        else c.white
      }'
      cursor_border = '${
        if user_opts.term_invert
        then c.black
        else c.white
      }'
      cursor_fg = '${
        if user_opts.term_invert
        then c.white
        else c.black
      }'

      ansi = [
          '${c.black}',
          '${c.red}',
          '${c.green}',
          '${c.yellow}',
          '${c.blue}',
          '${c.magenta}',
          '${c.cyan}',
          '${c.white}',
      ]
      brights = [
          '${c.bright_black}',
          '${c.bright_red}',
          '${c.bright_green}',
          '${c.bright_yellow}',
          '${c.bright_blue}',
          '${c.bright_magenta}',
          '${c.bright_cyan}',
          '${c.bright_white}',
      ]

      [colors.tab_bar]
      background = "#262626"

      [colors.tab_bar.active_tab]
      bg_color = '#161616'
      fg_color = '#ffffff'
      intensity = 'Normal'
      italic = false
      strikethrough = false
      underline = 'None'

      [colors.tab_bar.inactive_tab]
      bg_color = '#262626'
      fg_color = '#ffffff'
      intensity = 'Normal'
      italic = false
      strikethrough = false
      underline = 'None'

      [colors.tab_bar.new_tab]
      bg_color = '#262626'
      fg_color = '#ffffff'
      intensity = 'Normal'
      italic = false
      strikethrough = false
      underline = 'None'


      [metadata]
      name = 'marrissa-term'
      # origin_url = '''
    '';
  };
}
