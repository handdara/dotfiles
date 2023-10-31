ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

install:
	sh install.sh $(DUMPLOG)

.PHONY: install

