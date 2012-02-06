# Run tests
#
# Copyright (c) 2011-2012 Mathias Lafeldt
# Copyright (c) 2005-2012 Git project
# Copyright (c) 2005-2012 Junio C Hamano
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/ .

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

.PHONY: pre-clean $(T) aggregate-results clean
