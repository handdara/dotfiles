MV := mv -f

SSHDIR := $(HOME)/.ssh

HANDK := $(SSHDIR)/id_ed25519
GATK := $(SSHDIR)/id_ed25519_gt

.PHONY: all enc dec giturl

all: dec giturl

giturl: dec
	git remote set-url origin git@github.com:handdara/dotfiles.git
	git config --global user.name "handdara"
	git config --global user.email "handdara.core@gmail.com"

enc: hsk gsk hskpu gskpu

dec: $(HANDK) $(HANDK).pub $(GATK) $(GATK).pub 

hsk: $(HANDK)
	gpg -c --cipher-algo AES256 -o $@ $<

hskpu: $(HANDK).pub
	gpg -c --cipher-algo AES256 -o $@ $<

gsk: $(GATK)
	gpg -c --cipher-algo AES256 -o $@ $<

gskpu: $(GATK).pub
	gpg -c --cipher-algo AES256 -o $@ $<

$(HANDK): hsk
	gpg -d $< > $(notdir $@)
	$(MV) $(notdir $@) $@

$(HANDK).pub: hskpu
	gpg -d $< > $(notdir $@)
	$(MV) $(notdir $@) $@

$(GATK): gsk
	gpg -d $< > $(notdir $@)
	$(MV) $(notdir $@) $@

$(GATK).pub: gskpu
	gpg -d $< > $(notdir $@)
	$(MV) $(notdir $@) $@

