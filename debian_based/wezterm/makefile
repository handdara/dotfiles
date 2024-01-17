SUDO := sudo
SH := sh
RM := rm -f
REMOVE_PKGS :=
DPKG := dpkg -i
CURL := curl -LO
# BUILD_SH := build.sh

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

.PHONY: install-nightly install clean uninstall all

all: install-nightly
	$(RM) *.deb

ifeq ($(strip $(env)),wsl2_ubuntu)
uninstall:
	$(error Install not configured for rpi_os environment)
else ifeq ($(strip $(env)),rpi_os)
uninstall:
	$(error Install not configured for rpi_os environment)
else ifeq ($(strip $(env)),native_ubuntu)
uninstall:
	sudo apt remove wezterm
else ifeq ($(strip $(env)),native_pop_os)
uninstall:
	sudo apt remove wezterm
else 
	$(error Didn't recognized env variable, was it passed?)
endif

ifeq ($(strip $(env)),wsl2_ubuntu)
install:
	$(error Should not be trying to install wezterm in wsl2_ubuntu)
else ifeq ($(strip $(env)),rpi_os)
install:
	$(error Install not configured for rpi_os environment)
else ifeq ($(strip $(env)),native_ubuntu)
install:
	$(CURL) https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
	$(SUDO) $(DPKG) ./wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
	$(SUDO) apt-get install -f
else ifeq ($(strip $(env)),native_pop_os)
install:
	$(CURL) https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
	$(SUDO) $(DPKG) ./wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
	$(SUDO) apt-get install -f
else 
	$(error Didn't recognized env variable, was it passed?)
endif

ifeq ($(strip $(env)),wsl2_ubuntu)
install-nightly:
	$(error Should not be trying to install wezterm in wsl2_ubuntu)
else ifeq ($(strip $(env)),rpi_os)
install-nightly:
	$(error Install not configured for rpi_os environment)
else ifeq ($(strip $(env)),native_ubuntu)
install-nightly:
	$(CURL) https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu22.04.deb
	$(SUDO) $(DPKG) ./wezterm-nightly.Ubuntu22.04.deb
	$(SUDO) apt-get install -f
else ifeq ($(strip $(env)),native_pop_os)
install-nightly:
	$(CURL) https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu22.04.deb
	$(SUDO) $(DPKG) ./wezterm-nightly.Ubuntu22.04.deb
	$(SUDO) apt-get install -f
else 
	$(error Didn't recognized env variable, was it passed?)
endif

# $(SUDO) apt install -y ./wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb

# build:
# 	$(SH) $(BUILD_SH) $(DUMPLOG)

clean:
	$(RM) *.deb
