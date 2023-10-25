SUDO := sudo

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

install: export DEBIAN_FRONTEND:=noninteractive
install:
	sudo apt-add-repository -y ppa:fish-shell/release-3 $(DUMPLOG)
	sudo apt-get -y update $(DUMPLOG)
	sudo apt-get -y install fish $(DUMPLOG)

.PHONY: install
