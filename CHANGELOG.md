v1.0.0 (2016-06-14)
-------------------

These notes describe changes since the previous v0.3.0 version from
April 3 2013.

The new v1.0.0 version contains both many upstream fixes and
improvements from Git and a lot of specific user contributed features.

We think that Sharness is used and supported by enough projects and
developers, and stable enough, now to be ready for a v1.0.0 version.

Externally visible features:

* Add a 'cleanup' api to register cleanup actions, thanks to Dennis
  Kaarsemaker.
* Add simple test_seq(), thanks to Christian Couder.
* Add test_pause() from Git, thanks to Christian Couder.
* Add test_must_be_empty(), thanks to Konstantin Koroviev.
* Add SHARNESS_TEST_SRCDIR to run tests from a different directory,
  thanks to Mark A. Grondona.
* Implement --long-tests to run EXPENSIVE tests, thanks to Matthieu
  Moy.
* Support extensions in a sharness.d directory, thanks to Mark
  A. Grondona.
* Interactive tests, thanks to Dennis Kaarsemaker.

Internal improvements and bug fixes:

* Add a linter that detects broken && chains, thanks to Dennis
  Kaarsemaker.
* Export SHELL_PATH, thanks to Christian Couder.
* Fix color support when tput needs ~/.terminfo, thanks to Richard
  Hansen.
* Fix pathname of test-results/*.counts file, thanks to Richard
  Hansen.
* Sort test scripts before running them, thanks to Richard Hansen.
* Use SHARNESS_TRASH_DIRECTORY to enter the trash directory and drop
  the test_dir internal variable, thanks to Alexander Sulfrian.
* A lot of new TTY and sub sharness related tests, thanks to Mark
  A. Grondona.
* Build on Travis-CI using a container based build infrastructure,
  thanks to Mark A. Grondona.

Documentation improvements:

* Mention the Sharness Cookbook in the README, thanks to Mathias
  Lafeldt.
* Add alternatives to Sharness like Cram, rnt and ts to the README,
  thanks to Roman Neuhauser and Simon Chiang.
* Consistent Markdown headings, thanks to Mathias Lafeldt.
* Replace Contact with Author section, thanks to Mathias Lafeldt.
* New CONTRIBUTING.md document, thanks to Christian Couder.
* Mention Sharnessify a new installation tool, thanks to
  Christian Couder.
* Usage clarifications, thanks to Matthieu Moy.
* Improved flag descriptions in the README, thanks to Matthieu Moy.

Maintainer and project changes:

* Mathias Lafeldt, who created Sharness by extracting it from the
  Git codebase in April 2011, decided to step down and pass on the
  maintainership to Christian Couder. Thanks a lot, Mathias, for
  creating Sharness and maintaining it during all these years!

* Following the above point, Mathias transferred the Sharness
  GitHub repository to Christian, so the project can now be found on:
  https://github.com/chriscool/sharness and its web page is now:
  http://chriscool.github.io/sharness/

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
