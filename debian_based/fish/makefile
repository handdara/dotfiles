SUDO := sudo

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

install: export DEBIAN_FRONTEND:=noninteractive
install:
ifeq ($(strip $(env)),rpi_os)
	sudo apt-get install software-properties-common
end
	sudo apt-add-repository -y ppa:fish-shell/release-3 $(DUMPLOG)
	sudo apt-get -y update $(DUMPLOG)
	sudo apt-get -y install fish $(DUMPLOG)
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

.PHONY: install
