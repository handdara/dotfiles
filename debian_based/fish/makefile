MKTREE := mkdir -p
SUDO := sudo
APT  := apt

FISH_SRC_DIR := $(HOME)/apps

ifneq (,$(strip $(logfile)))
	DUMPLOG := >> $(logfile).log
else
	DUMPLOG := 
endif

install: export DEBIAN_FRONTEND:=noninteractive
install:
ifeq ($(strip $(env)),rpi_os) # will have to compile from src
	$(MKTREE) $(FISH_SRC_DIR) 
	$(SUDO) $(APT) install cmake
	$(SUDO) apt-get install clang-format clang-tidy clang-tools clang libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm 
	cd $(FISH_SRC_DIR) && git clone https://github.com/fish-shell/fish-shell.git
	cd $(FISH_SRC_DIR)/fish-shell && cmake . && $(MAKE) && $(SUDO) make install
else
	sudo apt-add-repository -y ppa:fish-shell/release-3 $(DUMPLOG)
	sudo apt-get -y update $(DUMPLOG)
	sudo apt-get -y install fish $(DUMPLOG)
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
endif

.PHONY: install
