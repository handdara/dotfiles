MKTREE := mkdir -p
CLONE := git clone 
CABAL := cabal

HOOGLE_SRC_DIR := $(HOME)/apps
HOOGLE_REPO_DIR := $(HOOGLE_SRC_DIR)/hoogle

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

default: install

$(HOOGLE_REPO_DIR):
	$(MKTREE) $(HOOGLE_SRC_DIR)
	cd $(HOOGLE_SRC_DIR) && $(CLONE) git@github.com:ndmitchell/hoogle.git

install: $(HOOGLE_REPO_DIR)
	cd $(HOOGLE_REPO_DIR) && $(CABAL) install


.PHONY: install
