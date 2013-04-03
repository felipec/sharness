v0.3.0 (2013-04-03)
-------------------

This release is all about bringing upstream fixes and improvements from Git to
Sharness ([GH-7]).

List of merged upstream changes:

* Make test number come first in `not ok $count - $message`.
* Paint known breakages in yellow.
* Paint unexpectedly fixed known breakages in bold red.
* Paint skipped tests in blue.
* Change info messages from yellow/brown to cyan.
* Fix `say_color()` to not interpret `\a\b\c` in the message.
* Add check for invalid use of `skip_all` facility.
* Rename `$satisfied` to `$satisfied_prereq`.
* Allow negation of prerequisites with "!".
* Retain cache file `test/.prove` across prove runs.
* Replace `basic.t` with `sharness.t` which is an adapted version of
  `t0000-basic.sh` from upstream.
* Update `README.git` with upstream changes.

Other changes:

* Add [git-integration] to the list of projects using Sharness. Also pay tribute
  to Git's test suite.
* Let Travis only test the master branch (and pull requests).

[GH-7]: https://github.com/mlafeldt/sharness/pull/7
[git-integration]: https://github.com/johnkeeping/git-integration

v0.2.5 (2013-03-29)
-------------------

* Allow to install Sharness via `make install` and to uninstall it via
  `make uninstall`. See brand-new installation instructions in README. ([GH-5])
* Allow users to override the test extension via `SHARNESS_TEST_EXTENSION` if
  they wish to. ([GH-6])
* Don't set a variable and export it at the same time. ([GH-6])
* Remove `TEST_INSTALLED` -- use `SHARNESS_BUILD_DIRECTORY` instead.
* Add vi modeline to `sharness.sh`.
* Add `AGGREGATE_SCRIPT` variable to `test/Makefile`.
* Remove superfluous `SHARNESS_TEST_DIRECTORY` assignments from `test/basic.t`.
* Add [timedb] to the list of projects using Sharness.
* Add Sharness alternatives to README.
* Rename HISTORY.md to CHANGELOG.md.

[GH-5]: https://github.com/mlafeldt/sharness/pull/5
[GH-6]: https://github.com/mlafeldt/sharness/pull/6
[timedb]: http://git.cryptoism.org/cgit.cgi/timedb.git

v0.2.4 (2012-07-13)
-------------------

* Add `simple.t` to tests and README.
* Provide `SHARNESS_TEST_FILE` which is the path to the test script currently
  being executed.
* Add [dabba] to the list of projects using Sharness.

[dabba]: https://github.com/eroullit/dabba

v0.2.3 (2012-06-20)
-------------------

* Make `.t` the new test file extension, which is the default extension used by
  `prove(1)`. (You can still use the `t????-*` scheme, but you need to rename
  the `.sh` ending of all tests.)
* Rename, export, and document public variables `SHARNESS_TEST_DIRECTORY`,
  `SHARNESS_BUILD_DIRECTORY`, and `SHARNESS_TRASH_DIRECTORY`.
* TomDoc `SHARNESS_TEST_EXTENSION`.

v0.2.2 (2012-04-27)
-------------------

* Document all public API functions using [TomDoc] and let [tomdoc.sh] generate
  documentation in markdown format from it, see `API.md`.
* Rename `test_skip` to `test_skip_` as it is internal.
* Clean up `test/Makefile`.
* Sync Git README with upstream.

[TomDoc]: http://tomdoc.org/
[tomdoc.sh]: https://github.com/mlafeldt/tomdoc.sh

v0.2.1 (2012-03-01)
-------------------

* Fix: Redirect stdin of tests (by @peff).
* Unify coding style across all shell scripts.
* Remove superfluous functions `sane_unset` and `test_declared_prereq`.
* Get rid of variables `DIFF` and `TEST_CMP_USE_COPIED_CONTEXT`.
* Remove dysfunctional smoke testing targets from `test/Makefile`.
* Add Travis CI config.
* Add top-level Makefile to say `make test`.
* Add GPL header to all files from Git.

v0.2.0 (2011-12-13)
-------------------

* Rename `test-lib.sh` to `sharness.sh`.
* Strip more Git-specific functionality.
* Add variable `SHARNESS_VERSION`.
* Move self-tests to `test` folder; keep essential files in root.
* Update README.
* Add this history file.

v0.1.1 (2011-11-02)
-------------------

* Merge changes to test harness library from Git v1.7.8-rc0

v0.1.0 (2011-05-02)
-------------------

* First version based on test harness library from Git v1.7.5
* Remove Git-specific functions, variables, prerequisites, make targets, etc.
* Remove `GIT_` prefix from global variables.
