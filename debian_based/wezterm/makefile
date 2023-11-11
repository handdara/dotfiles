SUDO := sudo
SH := sh
RM := rm -f
REMOVE_PKGS :=
DPKG := dpkg -i
# BUILD_SH := build.sh

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

all: install clean

ifeq ($(strip $(env)),wsl2_ubuntu)
install:
	$(error Should not be trying to install wezterm in wsl2_ubuntu)
else ifeq ($(strip $(env)),rpi_os)
install:
	$(error Install not configured for rpi_os environment)
else ifeq ($(strip $(env)),native_ubuntu)
install:
	curl -LO https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
	$(SUDO) $(DPKG) ./wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
	$(SUDO) apt-get install -f
else ifeq ($(strip $(env)),native_pop_os)
install:
	curl -LO https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
	$(SUDO) $(DPKG) ./wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb
	$(SUDO) apt-get install -f
endif

# $(SUDO) apt install -y ./wezterm-20230712-072601-f4abf8fd.Ubuntu22.04.deb

# build:
# 	$(SH) $(BUILD_SH) $(DUMPLOG)

clean:
	$(RM) *.deb

.PHONY: install build all

