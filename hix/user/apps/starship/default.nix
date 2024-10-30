{/* config, pkgs, */ ... }:
let 

  # COLOR OPTIONS: 
  # c = import ./../../../util/color/tartan.nix;
  # c = import ./../../../util/color/navy-and-ivory.nix;
  # c = import ./../../../util/color/oxocarbon.nix;
  # c = import ./../../../util/color/kasugano.nix;
  c = import ./../../../util/color/count-von-count.nix;

  st = {
    fg1 = c.black; # os
    # bg1 = c.blue;
    fg2 = c.black; # directory
    bg2 = c.red;
    # fg3 = c.red; # git
    bg3 = c.black;
    fg4 = c.black; # lang/env
    bg4 = c.cyan;
    # fg5 = c.cyan; # time
    # bg5 = c.black;
    bgchar = c.black;
  };

  # count von count overrides
  st.bg1 = c.white;
  st.fg3 = c.green;
  st.fg5 = c.red;
  st.bg5 = c.bright_black;

  # SYMBOLS
  os_sym = " ";
  trunc_sym = "󱑼 /"; # other opts:    
  err_sym = "󰲉 "; # other opts: 󰚑 
  time_sym = " ";
  home_sym = " ";
  custom_latex = "\${custom.latex}";
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/starship.toml".text = ''
      format = """
      [░▒▓](${st.bg1})\
      [ ${os_sym} ](bg:${st.bg1} fg:${st.fg1})\
      $username\
      $battery\
      [](bg:${st.bg2} fg:${st.bg1})\
      $directory\
      [](bg:${st.bg3} fg:${st.bg2})\
      $git_branch\
      $git_status\
      [](bg:${st.bg4} fg:${st.bg3})\
      $rust\
      $c\
      $golang\
      $haskell\
      $conda\
      $lua\
      $nix_shell\
      ${custom_latex}\
      [](bg:${st.bg5} fg:${st.bg4})\
      $time\
      $cmd_duration\
      \n\
      $character\
      [](${st.bgchar}) """

      [directory]
      style = "fg:${st.fg2} bg:${st.bg2}"
      format = "[ $path ]($style)"
      truncation_length = 2
      truncation_symbol = "${trunc_sym}"
      home_symbol = "${home_sym}"

      [directory.substitutions]
      "Documents" = "󰈙 "
      "Downloads" = " "
      "Music" = " "
      "Pictures" = " "
      "code" = " "
      "MEGA" = "󰰐 "
      "dotfiles" = " "

      [username]
      style_root = 'bold fg:${c.red} bg:${st.bg1}'
      style_user = 'bold fg:${st.fg1} bg:${st.bg1}'
      show_always = true
      format = '[$user ]($style)'

      [battery]
      full_symbol = '  '
      charging_symbol = '   '
      format = '[$symbol]($style)'

      [[battery.display]]
      threshold = 10
      discharging_symbol = ' ! '
      style = 'bold fg:${c.red} bg:${st.bg1}'

      [[battery.display]]
      threshold = 25
      style = 'fg:${c.white} bg:${st.bg1}'
      discharging_symbol = '  '

      [character]
      success_symbol = '[ 󱞪 ](fg:${c.cyan} bg:${st.bgchar}) '
      vimcmd_symbol = '[  ](fg:${c.bright_blue} bg:${st.bgchar}) '
      vimcmd_visual_symbol = '[  ](fg:${c.magenta} bg:${st.bgchar}) '
      vimcmd_replace_symbol = '[  ](fg:${c.yellow} bg:${st.bgchar}) '
      error_symbol = '[ ${err_sym}](bold fg:${c.red} bg:${st.bgchar}) '
      format = '[$symbol](bg:${st.bgchar})'

      [git_branch]
      symbol = "󰙁 "
      style = "fg:${st.fg3} bg:${st.bg3}"
      format = '[ $symbol $branch ]($style)'

      [git_status]
      style = "fg:${st.fg3} bg:${st.bg3}"
      format = '[($all_status$ahead_behind )]($style)'

      [rust]
      symbol = " "
      style = "fg:${st.fg4} bg:${st.bg4}"
      format = '[ $symbol ($version)]($style)'

      [c]
      symbol = " "
      style = "fg:${st.fg4} bg:${st.bg4}"
      format = '[ $symbol ($version)]($style)'

      [haskell]
      symbol = " "
      style = "fg:${st.fg4} bg:${st.bg4}"
      format = '[ $symbol ($version)]($style)'

      [custom.latex]
      symbol = " "
      detect_extensions = ["tex", "bibtex", "bib"]
      style = "fg:${st.fg4} bg:${st.bg4}"
      format = '[ $symbol]($style)'

      [zig]
      symbol = " "
      style = "fg:${st.fg4} bg:${st.bg4}"
      format = '[ $symbol ($version)]($style)'

      [golang]
      symbol = "GO"
      style = "bold fg:${st.fg4} bg:${st.bg4}"
      format = '[ $symbol ($version)]($style)'

      [conda]
      style = "fg:${st.fg4} bg:${st.bg4}"
      format = "[ $symbol ($environment)]($style)"
      ignore_base = false

      [nix_shell]
      symbol = " "
      disabled = false
      style = "fg:${st.fg4} bg:${st.bg4}"
      format = '[ via $symbol$state( \($name\))]($style)'

      [lua]
      symbol = "󰢱 "
      style = "fg:${st.fg4} bg:${st.bg4}"
      format = '[ $symbol ($version)]($style)'

      [time]
      disabled = false
      time_format = "%R" # Hour:Minute Format
      style = "fg:${st.fg5} bg:${st.bg5}"
      format = '[ ${time_sym} $time ]($style)[](fg:${st.bg5})'

      [cmd_duration]
      show_milliseconds = false
      disabled = false
      style = "italic #394260"
      format = "[$duration]($style)"
    '';
  };
}
