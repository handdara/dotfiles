SUDO := sudo
SH := sh
RM := rm -f
REMOVE_PKGS := docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc
INSTALL_NAME := install-docker.sh

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

all: install clean

install: $(REMOVE_PKGS)
	curl -fsSL https://get.docker.com -o install-docker.sh $(DUMPLOG)
	$(SH) install-docker.sh --dry-run $(DUMPLOG)
	$(SUDO) $(SH) install-docker.sh $(DUMPLOG)

$(REMOVE_PKGS):
	$(SUDO) apt-get -y remove $@ $(DUMPLOG)

clean:
	$(RM) install-docker.sh $(DUMPLOG)

.PHONY: $(REMOVE_PKGS) install all

