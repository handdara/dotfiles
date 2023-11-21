GPG := gpg -c --cipher-algo AES256
GPG_DEC := gpg -d

GRC_NB := github-recovery-codes-nb.txt 

.PHONY: all enc dec 

all: enc dec

enc: grc-nb

dec: $(GRC_NB)

grc-nb: $(GRC_NB)
	$(GPG) -o $@ $<

$(GRC_NB): grc-nb
	$(GPG_DEC) $< > $(notdir $@)
