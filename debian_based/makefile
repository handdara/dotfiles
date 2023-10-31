# === Constants ===
MKDIR := mkdir
MKTREE := mkdir -p
LN := ln -svf
LNDIR := ln -sv
RMTREE := rm -Rf
SUDO := sudo

allowed_envs_help := wsl2_ubuntu | native_ubuntu | rpi_os
allowed_envs := $(filter-out |, $(allowed_envs_help))

alacritty_fr_to = $(PWD)/alacritty/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml
fish_fr_to = $(PWD)/fish/config.fish $(HOME)/.config/fish/config.fish
fish_funcs_fr_to = $(PWD)/fish/functions/* $(HOME)/.config/fish/functions
gitui_remap_fr_to = $(PWD)/gitui/key_bindings.ron $(HOME)/.config/key_bindings.ron 
gitui_theme_fr_to = $(PWD)/gitui/theme.ron $(HOME)/.config/theme.ron 
starship_fr_to = $(PWD)/starship/starship.toml $(HOME)/.config/starship.toml
zellij_conf_fr_to = $(PWD)/zellij/config.kdl $(HOME)/.config/zellij/config.kdl
zellij_layout_dir_to = $(PWD)/zellij/layouts $(HOME)/.config/zellij/layouts
neovim_dir_to = $(PWD)/nvim $(HOME)/.config/nvim

# === Calcs ===
compname:=$(shell hostname)

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

# === Recipes ===

# default behaviour is to just refresh configs
refresh: link

all: install link checkopts backup 

checkopts:
ifeq ($(strip $(env)),wsl2_ubuntu)
else ifeq ($(strip $(env)),native_ubuntu)
else
	$(error Must pass env variable, run `make help` for more)
endif

install: checkopts install-base

install-base: checkopts ghcup cargo docker fish

curl:
	$(SUDO) apt-get -y install curl $(DUMPLOG)

ghcup: curl
	cd ghcup && $(MAKE) 

cargo: curl
	cd cargo && $(MAKE)

docker: curl
	cd docker && $(MAKE)

fish: curl
	cd fish && $(MAKE)

link: checkopts
ifeq ($(strip $(env)),wsl2_ubuntu)
else ifeq ($(strip $(env)),rpi_os)
	$(LN) $(starship_fr_to) $(DUMPLOG)
else ifeq ($(strip $(env)),native_ubuntu)
	$(LN) $(alacritty_fr_to) $(DUMPLOG)
	$(LN) $(starship_fr_to) $(DUMPLOG)
endif
	$(LN) $(fish_fr_to) $(DUMPLOG)
	$(MKTREE) $(word 2,$(fish_funcs_fr_to)) $(DUMPLOG)
	$(LN) $(fish_funcs_fr_to) $(DUMPLOG)
	$(LN) $(gitui_remap_fr_to) $(DUMPLOG)
	$(LN) $(gitui_theme_fr_to) $(DUMPLOG)
	$(LN) $(zellij_conf_fr_to) $(DUMPLOG)
	$(RMTREE) $(word 2,$(zellij_layout_dir_to)) $(DUMPLOG)
	$(LNDIR) $(zellij_layout_dir_to) $(DUMPLOG)
	$(RMTREE) $(word 2,$(neovim_dir_to)) $(DUMPLOG)
	$(LNDIR) $(neovim_dir_to) $(DUMPLOG)
	@echo 'finished linking for env='$(env) $(DUMPLOG)

backup: 
	apt-mark showmanual > backups/aptmanual_$(compname).backup
	cargo install --list > backups/cargo_$(compname).backup

help:
	@echo 'mandatory options:'
	@echo '  env=($(allowed_envs_help))'
	@echo 'optional options:'
	@echo '  logfile=<filebasename> will append output into `<filebasename>.log`'

.PHONY: all install install-base curl ghcup docker link checkopts backup help fish
