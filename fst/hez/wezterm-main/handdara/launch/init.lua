local hd = require 'handdara.domains'
-- later will use this to change launching programs based on the system
-- local hMchn = require 'handdara.machines'

local shells = {
  bash = require('handdara.launch.bash'),
  fish = require('handdara.launch.fish'),
}

local programs = {
  top = require('handdara.launch.top'),
  -- htop = require('handdara.launch.htop'),
  btop = require('handdara.launch.btop'),
  gitui = require('handdara.launch.gitui'),
}

local commands = {
  searchFonts = require('handdara.launch.searchFonts')
}

local launch_menu = {
  -- programs.top,
  -- programs.htop,
  programs.btop,
  -- programs.gitui,
  shells.bash,
  shells.fish,
  commands.searchFonts,
}

local function apply_to_config(config, target_triple)
  if config.keys then
    error('must apply before settings keymaps')
  end

  config.default_prog = shells.fish.args
  config.unix_domains = hd.unix_domains
  config.launch_menu = launch_menu

  if target_triple == "x86_64-windows-msvc" then
    config.default_domain = hd.wsl_domain
  elseif target_triple == "x86_64-unknown-linux-gnu" then
    config.default_gui_startup_args = {
      'start',
      'fish',
      '-i',
      '-C',
      'neofetch',
    }
  else
    error("unrecognized target_triple")
  end
end

return {
  launch_menu = launch_menu,
  shells = shells,
  programs = programs,
  commands = commands,
  default_monitor = programs.btop,
  system_shell = shells.fish,
  apply_to_config = apply_to_config,
}
