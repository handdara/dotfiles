local hDirs = require('handdara.dirs')

return {
  name = 'mega-cmd',
  spawn = {
    args = { 'mega-cmd' },
    cwd = hDirs.home,
    domain = 'DefaultDomain',
  },
}
