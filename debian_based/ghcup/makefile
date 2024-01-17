# requirements for ubuntu Version >= 20.10 && < 23
SYS_REQS := build-essential curl libffi-dev libffi8ubuntu1 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5
SUDO := sudo

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

install: export DEBIAN_FRONTEND:=noninteractive
install: requirements
	sh install.sh $(DUMPLOG)

requirements:
	$(SUDO) apt-get -y install $(SYS_REQS) $(DUMPLOG)

.PHONY: install requirements
