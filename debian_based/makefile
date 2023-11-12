# === Constants ===
MKDIR := mkdir
MKTREE := mkdir -p
LN := ln -svf
LNDIR := ln -sv
RMTREE := rm -Rf
SUDO := sudo

allowed_envs_help := wsl2_ubuntu | native_ubuntu | rpi_os | native_pop_os
allowed_envs := $(filter-out |, $(allowed_envs_help))

dotfiles_dir_to = $(abspath $(PWD)/..) $(HOME)/.dotfiles
alacritty_fr_to = $(PWD)/alacritty/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml
fish_fr_to = $(PWD)/fish/config.fish $(HOME)/.config/fish/config.fish
fish_funcs_fr_to = $(PWD)/fish/functions/* $(HOME)/.config/fish/functions
gitui_remap_fr_to = $(PWD)/gitui/key_bindings.ron $(HOME)/.config/gitui/key_bindings.ron 
gitui_theme_fr_to = $(PWD)/gitui/theme.ron $(HOME)/.config/gitui/theme.ron 
starship_fr_to = $(PWD)/starship/starship.toml $(HOME)/.config/starship.toml
zellij_conf_fr_to = $(PWD)/zellij/config.kdl $(HOME)/.config/zellij/config.kdl
zellij_layout_dir_to = $(PWD)/zellij/layouts $(HOME)/.config/zellij/layouts
neovim_dir_to = $(PWD)/nvim/conf $(HOME)/.config/nvim
wezterm_dir_to = $(PWD)/wezterm/conf $(HOME)/.config/wezterm
spotifytui_fr_to = $(PWD)/spotify-tui/config.yml $(HOME)/.config/spotify-tui/config.yml

# === Calcs ===
compname:=$(shell hostname)

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

.PHONY: all install install-base curl ghcup docker link checkopts backup help fish wezterm

# === Recipes ===

# default behaviour is to just refresh configs and backup
refresh: link backup

all: install link checkopts backup 

checkopts:
ifeq ($(strip $(env)),wsl2_ubuntu)
else ifeq ($(strip $(env)),native_ubuntu)
else ifeq ($(strip $(env)),native_pop_os)
else ifeq ($(strip $(env)),rpi_os)
else
	$(error Must pass accepted env variable, run `make help` for more)
endif

ifeq ($(strip $(env)),wsl2_ubuntu)
install: checkopts install-base
else ifeq ($(strip $(env)),rpi_os)
install: checkopts install-base
else ifeq ($(strip $(env)),native_ubuntu)
install: checkopts install-base wezterm
else ifeq ($(strip $(env)),native_pop_os)
install: checkopts install-base wezterm
endif

install-base: checkopts ghcup cargo docker fish

ghcup: checkopts
ifeq (, $(shell which ghcup))
	cd ghcup && $(MAKE) 
else 
	@echo "ghcup executable found, to reinstall try: $ cd ghcup && $(MAKE)"
endif

cargo: checkopts
ifeq (, $(shell which cargo))
	cd cargo && $(MAKE)
else 
	@echo "cargo executable found, to reinstall try: $ cd cargo && $(MAKE)"
endif

docker: checkopts
ifeq (, $(shell which docker))
	cd docker && $(MAKE)
else 
	@echo "docker executable found, to reinstall try: $ cd docker && $(MAKE)"
endif

fish: checkopts
ifeq (, $(shell which fish))
	cd fish && $(MAKE)
else 
	@echo "fish executable found, to reinstall try: $ cd fish && $(MAKE)"
endif

wezterm: checkopts
ifeq (, $(shell which wezterm))
	cd wezterm && $(MAKE)
else 
	@echo "wezterm executable found, to reinstall try: $ cd wezterm && $(MAKE)"
endif

link: checkopts
ifeq ($(strip $(env)),wsl2_ubuntu)
else ifeq ($(strip $(env)),rpi_os)
	$(LN) $(starship_fr_to) $(DUMPLOG)
else ifeq ($(strip $(env)),native_ubuntu)
	$(MKTREE) $(dir $(word 2,$(alacritty_fr_to))) $(DUMPLOG)
	$(LN) $(alacritty_fr_to) $(DUMPLOG)
	$(LN) $(starship_fr_to) $(DUMPLOG)
	$(MKTREE) $(dir $(word 2,$(spotifytui_fr_to))) $(DUMPLOG)
	$(LN) $(spotifytui_fr_to) $(DUMPLOG)
else ifeq ($(strip $(env)),native_pop_os)
	$(MKTREE) $(dir $(word 2,$(alacritty_fr_to))) $(DUMPLOG)
	$(LN) $(alacritty_fr_to) $(DUMPLOG)
	$(LN) $(starship_fr_to) $(DUMPLOG)
	$(MKTREE) $(dir $(word 2,$(spotifytui_fr_to))) $(DUMPLOG)
	$(LN) $(spotifytui_fr_to) $(DUMPLOG)
endif
	$(MKTREE) $(dir $(word 2,$(fish_fr_to))) $(DUMPLOG)
	$(LN) $(fish_fr_to) $(DUMPLOG)
	$(MKTREE) $(word 2,$(fish_funcs_fr_to)) $(DUMPLOG)
	$(LN) $(fish_funcs_fr_to) $(DUMPLOG)
	$(MKTREE) $(dir $(word 2,$(gitui_remap_fr_to))) $(DUMPLOG)
	$(LN) $(gitui_remap_fr_to) $(DUMPLOG)
	$(LN) $(gitui_theme_fr_to) $(DUMPLOG)
	$(MKTREE) $(dir $(word 2,$(zellij_conf_fr_to))) $(DUMPLOG)
	$(LN) $(zellij_conf_fr_to) $(DUMPLOG)
	$(RMTREE) $(word 2,$(zellij_layout_dir_to)) $(DUMPLOG)
	$(LNDIR) $(zellij_layout_dir_to) $(DUMPLOG)
	$(RMTREE) $(word 2,$(neovim_dir_to)) $(DUMPLOG)
	$(LNDIR) $(neovim_dir_to) $(DUMPLOG)
	$(RMTREE) $(word 2,$(wezterm_dir_to)) $(DUMPLOG)
	$(LNDIR) $(wezterm_dir_to) $(DUMPLOG)
	$(RM) $(word 2,$(dotfiles_dir_to)) $(DUMPLOG)
	$(LNDIR) $(dotfiles_dir_to) $(DUMPLOG)
	@echo 'finished linking for env='$(env) $(DUMPLOG)

backup:
	apt-mark showmanual > backups/aptmanual_$(compname).backup
ifeq (, $(shell which cargo))
else 
	cargo install --list > backups/cargo_$(compname).backup
endif

help:
	@echo 'mandatory options:'
	@echo '  env=($(allowed_envs_help))'
	@echo 'optional options:'
	@echo '  logfile=<filebasename> will append output into `<filebasename>.log`'
