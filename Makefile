### woptic/Makefile
###
###    woptic main Makefile
###
### Copyright 2015 Elias Assmann
###
### $Id: Makefile 399 2015-06-03 20:28:10Z assmann $

VERSION := new

SUBDIRS := src doc

.PHONY: all clean $(SUBDIRS) dist

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
		rm -f $$dir/Makefile.orig; \
	done

distclean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir distclean; \
	done

%/Makefile.orig: %/Makefile
	perl -pe 's/^\#.orig\#//' $^ >$@

Morig := $(addsuffix /Makefile.orig,SRC_w2w SRC_wplot SRC_trig)

dist: dir     = wien2wannier-$(VERSION)
dist: scripts = $(notdir $(wildcard SRC/*))
dist: distclean doc/wien2wannier_userguide.pdf
	mkdir $(dir); \
	cd $(dir); \
	ln -s -t . ../SRC* ../doc/wien2wannier_userguide.pdf ../COPYING \
           ../README ../NEWS ../CHEATSHEET ../Makefile; \
	ln -s ../make.sys make.sys.example; \
	cp ../wien2k/VERSION WIEN-VERSION

	tar --exclude-vcs -chzf $(dir).tar.gz $(dir)
	rm -rf $(dir) $(Morig)

old-dist: dir     = wien2wannier-$(VERSION)
old-dist: scripts = $(notdir $(wildcard SRC/*))
old-dist: distclean doc/wien2wannier_userguide.pdf $(Morig)
	mkdir $(dir); \
	cd $(dir); \
	ln -s -t . ../SRC* ../doc/wien2wannier_userguide.pdf ../COPYING \
           ../README ../INSTALL ../NEWS ../CHEATSHEET ../Makefile \
	   ../compile_wien2wannier.sh; \
	ln -s ../make.sys make.sys.example; \
	ln -s -t . SRC/*; \
	cp ../wien2k/VERSION WIEN-VERSION; \
	tar --exclude-vcs -chf wien2wannier.tar SRC* $(scripts); \
	for f in $(scripts); do ln -s $$f `echo $$f | sed s/_lapw//`; done; \
	ln -s w2wpara w2wcpara; ln -s wplotpara wplotcpara; \
	tar -rf wien2wannier.tar $(scripts:_lapw=) w2wcpara wplotcpara; \
	rm -f SRC* $(scripts) $(scripts:_lapw=) w2wcpara wplotcpara

	tar --exclude-vcs -chzf $(dir).tar.gz $(dir)
	rm -rf $(dir) $(Morig)

wien-dist: dir     = wien2wannier-$(VERSION)-wien
wien-dist: scripts = $(notdir $(wildcard SRC/*))
wien-dist: w2wlinks= ../doc/wien2wannier_userguide.pdf ../COPYING ../README \
		     ../NEWS ../CHEATSHEET
wien-dist: distclean doc/wien2wannier_userguide.pdf $(Morig)
	mkdir $(dir); \
	cd $(dir); \
	ln -s -t . ../SRC*; \
	ln -s -t . SRC/*; \
	ln -s -t SRC_w2w $(w2wlinks); \
	tar --exclude-vcs -chf wien2wannier.tar SRC* $(scripts); \
	rm -f SRC* $(scripts)

	tar --exclude-vcs -chzf $(dir).tar.gz $(dir)
	for l in $(notdir $(w2wlinks)); do rm SRC_w2w/$$l; done
	rm -rf $(dir) $(Morig)


## Time-stamp: <2015-06-01 22:48:46 elias@hupuntu>
