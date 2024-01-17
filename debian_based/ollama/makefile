SUDO := sudo

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

install: export DEBIAN_FRONTEND:=noninteractive
install:
	fish -c "curl https://ollama.ai/install.sh | sh"

.PHONY: install
