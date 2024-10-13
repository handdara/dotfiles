-- later will use this to change launching programs based on the system
-- local hMchn = require 'handdara.machines'

local shells = {
  bash = { 'bash' },
  fish = { 'fish' }
}

return {
  launch_menu = {
    { args = { 'htop' }, },
    -- { args = { 'gitui' }, },
    -- { args = { 'fish', '-c', 'bat (find ~/code -type f | fzf)' }, },
  },
  shells = shells
}
