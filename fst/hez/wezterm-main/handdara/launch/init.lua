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
  searchFonts = require('handdara.launch.searchFonts'),
}

return {
  launch_menu = {
    -- programs.top,
    -- programs.htop,
    programs.btop,
    -- programs.gitui,
    shells.bash,
    shells.fish,
    commands.searchFonts,
  },
  shells = shells,
  programs = programs,
  commands = commands,
  default_monitor = programs.btop,
}
