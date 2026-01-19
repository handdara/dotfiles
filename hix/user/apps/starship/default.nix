{ config, ... }:
let
  bothThemes = import ../../../util/color;
  theme =
    if (config.handdara.lightworks == true)
    then bothThemes.light
    else bothThemes.dark;
  st =
    theme.starship
      or (
      if (config.handdara.lightworks == true)
      then {
        fg1 = theme.hexcodes.black; # os
        bg1 = theme.hexcodes.white;
        fg2 = theme.hexcodes.bright_black; # directory
        bg2 = theme.hexcodes.bright_white;
        fg3 = theme.hexcodes.black; # git
        bg3 = theme.hexcodes.white;
        fg4 = theme.hexcodes.bright_black; # lang/env
        bg4 = theme.hexcodes.bright_white;
        fg5 = theme.hexcodes.black; # time
        bg5 = theme.hexcodes.white;
        bgchar = theme.hexcodes.white;
      }
      else {
        fg1 = theme.hexcodes.white;
        bg1 = theme.hexcodes.black; # os
        fg2 = theme.hexcodes.bright_white;
        bg2 = theme.hexcodes.bright_black; # directory
        fg3 = theme.hexcodes.white;
        bg3 = theme.hexcodes.black; # git
        fg4 = theme.hexcodes.bright_white;
        bg4 = theme.hexcodes.bright_black; # lang/env
        fg5 = theme.hexcodes.white;
        bg5 = theme.hexcodes.black; # time
        bgchar = theme.hexcodes.black;
      }
    );

  # SYMBOLS
  os_sym = " ";
  trunc_sym = "󱑼 /"; # other opts:   
  err_sym = "󰲉 "; # other opts: 󰚑
  time_sym = " ";
  home_sym = " ";
  custom_latex = "\${custom.latex}";
  regular_cfg = ''
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
    style_root = 'bold fg:${theme.hexcodes.red} bg:${st.bg1}'
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
    style = 'bold fg:${theme.hexcodes.red} bg:${st.bg1}'

    [[battery.display]]
    threshold = 25
    style = 'fg:${theme.hexcodes.white} bg:${st.bg1}'
    discharging_symbol = '  '

    [character]
    success_symbol = '[ 󱞪 ](fg:${theme.hexcodes.cyan} bg:${st.bgchar}) '
    vimcmd_symbol = '[  ](fg:${theme.hexcodes.bright_blue} bg:${st.bgchar}) '
    vimcmd_visual_symbol = '[  ](fg:${theme.hexcodes.magenta} bg:${st.bgchar}) '
    vimcmd_replace_symbol = '[  ](fg:${theme.hexcodes.yellow} bg:${st.bgchar}) '
    error_symbol = '[ ${err_sym}](bold fg:${theme.hexcodes.bright_red} bg:${st.bgchar}) '
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
  simple_cfg = ''
    format = """
    [░▒▓](bg:black fg:blue)\
    [ NixOS ](bold bg:blue fg:bright-blue)\
    $username\
    $hostname\
    $battery\
    [▓▒░](bg:black fg:prev_bg)\
    $directory\
    $git_branch\
    $git_status\
    $nix_shell\
    $time\
    [▓▒░](fg:black)\
    $cmd_duration\
    \n\
    $character\
    """

    [username]
    style_root = 'bold fg:white bg:red'
    style_user = 'bold fg:black bg:bright-blue'
    show_always = true
    format = '[ $user]($style)'

    [hostname]
    ssh_only = false
    style = 'fg:black bg:bright-blue'
    ssh_symbol = ' via \(ssh\)'
    format = '[::$hostname](bold $style)[$ssh_symbol ](italic $style)'

    [directory]
    style = "italic fg:white bg:black"
    format = "[ $path ]($style)"
    truncation_length = 4
    truncation_symbol = "*/"

    [battery]
    full_symbol = '\[≡≡≡\]:'
    charging_symbol = '\[>>>\]:'
    unknown_symbol = '\[|||\]:'
    format = '[ $symbol $percentage ]($style)'

    [[battery.display]]
    threshold = 100
    discharging_symbol = '\[===\]:'
    charging_symbol = '\[>>>\]:'
    style = 'fg:white bg:blue'

    [[battery.display]]
    threshold = 90
    discharging_symbol = '\[==-\]:'
    charging_symbol = ' \[>>>\]: '
    style = 'fg:white bg:blue'

    [[battery.display]]
    threshold = 75
    discharging_symbol = '\[== \]:'
    charging_symbol = '\[>> \]:'
    style = 'fg:white bg:blue'

    [[battery.display]]
    threshold = 60
    discharging_symbol = '\[=- \]:'
    charging_symbol = ' \[>> \]: '
    style = 'fg:white bg:blue'

    [[battery.display]]
    threshold = 40
    discharging_symbol = '\[=  \]:'
    charging_symbol = ' \[>> \]:'
    style = 'fg:white bg:blue'

    [[battery.display]]
    threshold = 25
    discharging_symbol = '\[-  \]:'
    charging_symbol = '\[>  \]:'
    style = 'fg:yellow bg:blue'

    [[battery.display]]
    threshold = 10
    discharging_symbol = '\[!  \]: LOW!'
    charging_symbol = '\[>  \]: LOW!'
    style = 'bg:red fg:white'

    [character]
    success_symbol = '[*>](cyan) '
    vimcmd_symbol = '[N>](blue)'
    vimcmd_visual_symbol = '[V>](blue) '
    vimcmd_replace_symbol = '[R>](blue) '
    error_symbol = '[!!](red) '
    format = '[$symbol]()'

    [git_branch]
    symbol = "|/"
    style = "fg:white bg:black"
    format = '[ $symbol $branch ]($style)'

    [git_status]
    style = "fg:white bg:black"
    format = '[($all_status$ahead_behind )]($style)'

    [nix_shell]
    symbol = "*"
    disabled = false
    style = "fg:prev_fg bg:prev_bg"
    format = '[via ](italic $style)[▒$symbol $state \($name\)▒](inverted $style)'

    [time]
    disabled = false
    time_format = "%R" # Hour:Minute Format
    style = "bold fg:bright-blue bg:black"
    format = '[ $time ]($style)'

    [cmd_duration]
    show_milliseconds = false
    disabled = false
    style = "italic purple"
    format = "[ $duration ]($style)"
  '';
in
{
  programs.starship =
    if config.handdara.shprompt != "off"
    then {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    }
    else { };

  home.file = {
    ".config/starship.toml".text =
      if config.handdara.shprompt == "simple"
      then simple_cfg
      else regular_cfg;
  };
}
