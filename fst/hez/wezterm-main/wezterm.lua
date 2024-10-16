local wezterm = require 'wezterm'

local function check_for_xclip()
  local success, stdout, stderr = wezterm.run_child_process({ "which", "xclip" })
  return success
end

local xclipFound = check_for_xclip()
-- wezterm.log_info('xclipFound',xclipFound) -- debugging

return require('handdara').mkConfig(xclipFound)
