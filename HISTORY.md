History
=======

0.2.2 (2012-04-27)
------------------

* Document all public API functions using [TomDoc] and let [tomdoc.sh] generate
  documentation in markdown format from it, see `API.md`.
* Rename `test_skip` to `test_skip_` as it is internal.
* Clean up `test/Makefile`.
* Sync Git README with upstream.

[TomDoc]: http://tomdoc.org/
[tomdoc.sh]: https://github.com/mlafeldt/tomdoc.sh

0.2.1 (2012-03-01)
------------------

* Fix: Redirect stdin of tests (by @peff).
* Unify coding style across all shell scripts.
* Remove superfluous functions `sane_unset` and `test_declared_prereq`.
* Get rid of variables `DIFF` and `TEST_CMP_USE_COPIED_CONTEXT`.
* Remove dysfunctional smoke testing targets from `test/Makefile`.
* Add Travis CI config.
* Add top-level Makefile to say `make test`.
* Add GPL header to all files from Git.

0.2.0 (2011-12-13)
------------------

* Rename `test-lib.sh` to `sharness.sh`.
* Strip more Git-specific functionality.
* Add variable `SHARNESS_VERSION`.
* Move self-tests to `test` folder; keep essential files in root.
* Update README.
* Add this history file.

0.1.1 (2011-11-02)
------------------

* Merge changes to test harness library from Git v1.7.8-rc0

0.1.0 (2011-05-02)
------------------

* First version based on test harness library from Git v1.7.5
* Remove Git-specific functions, variables, prerequisites, make targets, etc.
* Remove `GIT_` prefix from global variables.
