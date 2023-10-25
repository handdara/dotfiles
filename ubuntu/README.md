# handdara dotfiles

## makefile usage
notes:
1. ensure in this directory and run *without* sudo, which will break `$(PWD)` and `$(HOME)`
1. pass a logfile name to redirect as much output as possible into logfile by append
1. for pretty much everything (besides backup) passing `env` is necessary
1. it's a wip, but run `make help` for more
1. the whole repo is a big wip
1. when using flags, recursive `make` calls will pass flags when called with  `$(MAKE)`
1. this is mainly for ubuntu 22, but my wsl2 is on 20 b/c im lazy

### main cmds
To update configuration file symlinks: `make env=<ENV> link`
To install everything possible: `make env=<ENV> install`
  - can also replace `install` with specific app
To update pack list backups: `make env=<ENV> backup`
  - this is made to be run after things are installed
To do everything: `make env=<ENV> all` 
