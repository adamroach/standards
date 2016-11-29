XML2RFC := xml2rfc
KRAMDOWN := kramdown-rfc2629

IDNITS  := scripts/idnits-2.12.17/idnits --verbose

MD      := $(wildcard *.md)
SRC     := $(wildcard *.xml) $(patsubst %.md,%.xml,$(MD))
HTML    := $(patsubst %.xml,%.html,$(SRC))
DIFF    := $(filter-out %-00-diff.html,$(patsubst draft-%.xml,draft-%-diff.html,$(SRC)))
TXT     := $(patsubst %.xml,%.txt,$(SRC))
NITS    := $(patsubst %.xml,%-nits.txt,$(SRC))
PDF     := $(patsubst %.xml,%.pdf,$(SRC))

#all: $(TXT) $(NITS) $(HTML) index.html
all: $(TXT) $(NITS)
html: $(HTML)
pdf: $(PDF)
diff: $(DIFF)

nits: $(NITS)

%.xml: %.md
	cat $< | $(KRAMDOWN) > $@
#	perl -pe 's/\xe2\x80\x9d/"/g; s/\xe2\x80(\x98|\x99)/\x27/g; s/\xe2\x80\x94/ -- /g; s/\xe2\x8a\xbb/XOR/g; s/([\x80-\xff])/"\\x".unpack("H*",$$1)/ge;s/#heading=h\.[a-z0-9]*/#introduction/g;s/</&lt;/g' $< | $(KRAMDOWN) > $@

%-nits.txt: %.txt
	$(IDNITS) $^ | tee $@

draft-%-diff.html: draft-%.txt
	-OLD=draft-$(shell echo $* | perl -pe 's/([0-9]{2})$$/sprintf("%02d.txt",$$1-1)/e') && make $$OLD && scripts/htmlwdiff.sh $$OLD $< > $@

%.ps: %.txt
	enscript --margins 76::76: -B -q -p $@ $<

%.pdf: %.ps
	ps2pdf $< $@

#%.html: %.xml
#	$(XML2RFC) $^ $@

#%.html: %.xml
#	xsltproc -o $@ ../rfc2629.xslt $^

%.html: %.xml
	$(XML2RFC) --html $^ $@

%.txt: %.xml
ifdef SPELL
	aspell -H check $^
endif
	$(XML2RFC) $^ $@

index.html: $(TXT) scripts/mkindex.pl
	scripts/mkindex.pl -q

clean:
	$(RM) $(HTML) $(TXT) $(DIFF) $(NITS)

rmdiff:
	$(RM) $(DIFF)


###########################################################################
# THE FOLLOWING RULES ARE OUTDATED AND NO LONGER WORK
###########################################################################
# Magic repository diff code. Just call for a diff file like this:
#
# make draft-mcmurry-dime-overload-reqs-00-diff-4920-4940.htm 
# ...or use the special token "curr"...
# make draft-mcmurry-dime-overload-reqs-00-diff-4920-curr.htm 
#
# Due to the magic nature of this code, you can call for only one
# file at a time. That is, you can't ask for multiple diff files
# with a single invocation of make.
#

DIFF_VER   := $(subst -, ,$(subst .htm,,$(MAKECMDGOALS)))
DIFF_TOKEN :=
ifeq ($(word 1,$(DIFF_VER)), draft)
DIFF_TOKEN := $(word $(words $(wordlist 3,100,$(DIFF_VER))),$(DIFF_VER))
endif
ifeq ($(DIFF_TOKEN),diff)
TO         := $(lastword $(DIFF_VER))
FROM       := $(word $(words $(wordlist 2,100,$(DIFF_VER))),$(DIFF_VER))
BASE       := $(shell svn info | grep URL | cut -f2 -d' ')
endif

%-curr.xml: %.xml
	ln -s $< $@

%-$(FROM).xml:
	svn export -r $(FROM) $(BASE)/$*.xml $@

ifneq ($(TO),curr)
%-$(TO).xml:
	svn export -r $(TO) $(BASE)/$*.xml $@
endif

%-diff-$(FROM)-$(TO).htm: %-$(FROM).txt %-$(TO).txt
	scripts/htmlwdiff.sh $*-$(FROM).txt $*-$(TO).txt > $@
###########################################################################
