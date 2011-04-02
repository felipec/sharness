# Run tests
#
# Copyright (c) 2005 Junio C Hamano
#

SHELL_PATH ?= $(SHELL)
PERL_PATH ?= /usr/bin/perl
TAR ?= $(TAR)
RM ?= rm -f
PROVE ?= prove
DEFAULT_TEST_TARGET ?= test

# Shell quote;
SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))

T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)

all: $(DEFAULT_TEST_TARGET)

test: pre-clean $(TEST_LINT)
	$(MAKE) aggregate-results-and-cleanup

prove: pre-clean $(TEST_LINT)
	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(PROVE_OPTS) $(T) :: $(TEST_OPTS)
	$(MAKE) clean

$(T):
	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(TEST_OPTS)

pre-clean:
	$(RM) -r test-results

clean:
	$(RM) -r 'trash directory'.* test-results
	$(RM) -r valgrind/bin
	$(RM) .prove

test-lint: test-lint-duplicates test-lint-executable

test-lint-duplicates:
	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
		test -z "$$dups" || { \
		echo >&2 "duplicate test numbers:" $$dups; exit 1; }

test-lint-executable:
	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
		test -z "$$bad" || { \
		echo >&2 "non-executable tests:" $$bad; exit 1; }

aggregate-results-and-cleanup: $(T)
	$(MAKE) aggregate-results
	$(MAKE) clean

aggregate-results:
	for f in test-results/t*-*.counts; do \
		echo "$$f"; \
	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh

valgrind:
	TEST_OPTS=--valgrind $(MAKE)

# Smoke testing targets
test-results:
	mkdir -p test-results

test-results/smoke.tar.gz: test-results
	$(PERL_PATH) ./harness \
		--archive="test-results/smoke.tar.gz" \
		$(T)

smoke: test-results/smoke.tar.gz

.PHONY: pre-clean $(T) aggregate-results clean valgrind smoke
