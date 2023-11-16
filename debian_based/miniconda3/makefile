MKTREE := mkdir -p
RMTREE := rm -Rf
RM := rm -f
WGET := wget
BASH := bash

MINI_INSTALL_DIR := $(HOME)/apps/miniconda3

MINICONDA_L64_SH := Miniconda3-latest-Linux-x86_64.sh
MINICONDA_L64_LINK := https://repo.anaconda.com/miniconda/$(MINICONDA_L64_SH)

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

.PHONY: all install clean

define installer_cmds = 
	$(BASH) $(MINI_INSTALL_DIR)/$(MINICONDA_L64_SH) -b -u -p $(MINI_INSTALL_DIR)
	$(RM) -rf $(MINI_INSTALL_DIR)/$(MINICONDA_L64_SH) 
endef

# begin targets

all: install

ifeq ($(strip $(env)),wsl2_ubuntu)
install:
	$(error Install not configured for wsl2_ubuntu environment)
else ifeq ($(strip $(env)),rpi_os)
install:
	$(error Install not configured for rpi_os environment)
else ifeq ($(strip $(env)),native_ubuntu)
install: $(MINI_INSTALL_DIR)/$(MINICONDA_L64_SH)
	$(call installer_cmds)
else ifeq ($(strip $(env)),native_pop_os)
install: $(MINI_INSTALL_DIR)/$(MINICONDA_L64_SH)
	$(call installer_cmds)
else 
	$(error Didn't recognized env variable, was it passed?)
endif

$(MINI_INSTALL_DIR)/$(MINICONDA_L64_SH): $(MINI_INSTALL_DIR)
	$(WGET) $(MINICONDA_L64_LINK) -O $@
	
$(MINI_INSTALL_DIR):
	$(MKTREE) $@

clean:
	$(RM) 
