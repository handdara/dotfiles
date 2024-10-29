{/* config, pkgs, */ ... }:
let 
  # COLOR OPTIONS: 
  #   tartan.nix 
  #   navy-and-ivory.nix
  #   oxocarbon.nix
  #   kasugano.nix
  #   count-von-count.nix
  #   dark-ocean.nix
  c = import ./../../../util/color/oxocarbon.nix; 
  custom_latex = "\${custom.latex}";
  # COLORS
  fg1 = c.black; # os
  bg1 = c.blue;
  fg2 = c.black; # directory
  bg2 = c.red;
  fg3 = c.red; # git
  bg3 = c.black;
  fg4 = c.black; # lang/env
  bg4 = c.cyan;
  fg5 = c.cyan; # time
  bg5 = c.bright_black;
  bgchar = c.bright_black;
  # SYMBOLS
  os_sym = " ";
  trunc_sym = "󱑼 /"; # other opts:    
  err_sym = "󰲉 "; # other opts: 󰚑 
  time_sym = " ";
  home_sym = " ";
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
      [░▒▓](${bg1})\
      [ ${os_sym} ](bg:${bg1} fg:${fg1})\
      $username\
      $battery\
      [](bg:${bg2} fg:${bg1})\
      $directory\
      [](bg:${bg3} fg:${bg2})\
      $git_branch\
      $git_status\
      [](bg:${bg4} fg:${bg3})\
      $rust\
      $c\
      $golang\
      $haskell\
      $conda\
      $lua\
      $nix_shell\
      ${custom_latex}\
      [](bg:${bg5} fg:${bg4})\
      $time\
      $cmd_duration\
      \n\
      $character\
      [](${bgchar}) """

      [directory]
      style = "fg:${fg2} bg:${bg2}"
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
      style_root = 'bold fg:${c.red} bg:${bg1}'
      style_user = 'bold fg:${fg1} bg:${bg1}'
      show_always = true
      format = '[$user ]($style)'

      [battery]
      full_symbol = '  '
      charging_symbol = '   '
      format = '[$symbol]($style)'

      [[battery.display]]
      threshold = 10
      discharging_symbol = ' ! '
      style = 'bold fg:${c.red} bg:${bg1}'

      [[battery.display]]
      threshold = 25
      style = 'fg:${c.white} bg:${bg1}'
      discharging_symbol = '  '

      [character]
      success_symbol = '[ 󱞪 ](fg:${c.cyan} bg:${bgchar}) '
      vimcmd_symbol = '[  ](fg:${c.bright_blue} bg:${bgchar}) '
      vimcmd_visual_symbol = '[  ](fg:${c.magenta} bg:${bgchar}) '
      vimcmd_replace_symbol = '[  ](fg:${c.yellow} bg:${bgchar}) '
      error_symbol = '[ ${err_sym}](bold fg:${c.red} bg:${bgchar}) '
      format = '[$symbol](bg:${bgchar})'

      [git_branch]
      symbol = "󰙁 "
      style = "fg:${fg3} bg:${bg3}"
      format = '[ $symbol $branch ]($style)'

      [git_status]
      style = "fg:${fg3} bg:${bg3}"
      format = '[($all_status$ahead_behind )]($style)'

      [rust]
      symbol = " "
      style = "fg:${fg4} bg:${bg4}"
      format = '[ $symbol ($version)]($style)'

      [c]
      symbol = " "
      style = "fg:${fg4} bg:${bg4}"
      format = '[ $symbol ($version)]($style)'

      [haskell]
      symbol = " "
      style = "fg:${fg4} bg:${bg4}"
      format = '[ $symbol ($version)]($style)'

      [custom.latex]
      symbol = " "
      detect_extensions = ["tex", "bibtex", "bib"]
      style = "fg:${fg4} bg:${bg4}"
      format = '[ $symbol]($style)'

      [zig]
      symbol = " "
      style = "fg:${fg4} bg:${bg4}"
      format = '[ $symbol ($version)]($style)'

      [golang]
      symbol = "GO"
      style = "bold fg:${fg4} bg:${bg4}"
      format = '[ $symbol ($version)]($style)'

      [conda]
      style = "fg:${fg4} bg:${bg4}"
      format = "[ $symbol ($environment)]($style)"
      ignore_base = false

      [nix_shell]
      symbol = " "
      disabled = false
      style = "fg:${fg4} bg:${bg4}"
      format = '[ via $symbol$state( \($name\))]($style)'

      [lua]
      symbol = "󰢱 "
      style = "fg:${fg4} bg:${bg4}"
      format = '[ $symbol ($version)]($style)'

      [time]
      disabled = false
      time_format = "%R" # Hour:Minute Format
      style = "fg:${fg5} bg:${bg5}"
      format = '[ ${time_sym} $time ]($style)[](fg:${bg5})'

      [cmd_duration]
      show_milliseconds = false
      disabled = false
      style = "italic #394260"
      format = "[$duration]($style)"
    '';
  };
}
