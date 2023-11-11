ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

install:
	sh install.sh $(DUMPLOG)
	echo ". $(HOME)/.cargo/env" >> $(HOME)/.bashrc

.PHONY: install

