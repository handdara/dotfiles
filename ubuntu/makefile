# === Constants ===
MKDIR := mkdir
MKTREE := mkdir -p
LN := ln -svf
LNDIR := ln -sv
RMTREE := rm -Rf

allowed_envs_help := wsl2 | native
allowed_envs := $(filter-out |, $(allowed_envs_help))

alacritty_fr_to = $(PWD)/alacritty/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml
fish_fr_to = $(PWD)/fish/config.fish $(HOME)/.config/fish/config.fish
gitui_remap_fr_to = $(PWD)/gitui/key_bindings.ron $(HOME)/.config/key_bindings.ron 
gitui_theme_fr_to = $(PWD)/gitui/theme.ron $(HOME)/.config/theme.ron 
starship_fr_to = $(PWD)/starship/starship.toml $(HOME)/.config/starship.toml
zellij_conf_fr_to = $(PWD)/zellij/config.kdl $(HOME)/.config/zellij/config.kdl
zellij_layout_dir_to = $(PWD)/zellij/layouts $(HOME)/.config/zellij/layouts
neovim_dir_to = $(PWD)/nvim $(HOME)/.config/nvim

# === Calcs ===
compname:=$(shell hostname)

ifneq (,$(strip $(logname)))
	DUMPLOG := >> $(logname).log
else
	DUMPLOG := 
endif

# === Recipes ===
.PHONY: all link checkopts backup help 

all: link checkopts backup

checkopts:
ifeq ($(strip $(env)),wsl2)
else ifeq ($(strip $(env)),native)
else
	$(error Must pass env variable, run `make help` for more)
endif

link: checkopts
ifeq ($(strip $(env)),wsl2)
else ifeq ($(strip $(env)),native)
	$(LN) $(alacritty_fr_to) $(DUMPLOG)
endif
	$(LN) $(fish_fr_to) $(DUMPLOG)
	$(LN) $(gitui_remap_fr_to) $(DUMPLOG)
	$(LN) $(gitui_theme_fr_to) $(DUMPLOG)
	$(LN) $(starship_fr_to) $(DUMPLOG)
	$(LN) $(zellij_conf_fr_to) $(DUMPLOG)
	$(RMTREE) $(word 2,$(zellij_layout_dir_to)) $(DUMPLOG)
	$(LNDIR) $(zellij_layout_dir_to) $(DUMPLOG)
	$(RMTREE) $(word 2,$(neovim_dir_to)) $(DUMPLOG)
	$(LNDIR) $(neovim_dir_to) $(DUMPLOG)
	@echo 'finished linking for env='$(env) $(DUMPLOG)

backup: 
	apt-mark showmanual > aptmanual_$(compname).backup
	cargo install --list > cargo_$(compname).backup

help:
	@echo 'mandatory options:'
	@echo '  env=($(allowed_envs_help))'
	@echo 'optional options:'
	@echo '  logname=<filebasename> will append output into `<filebasename>.log`'
