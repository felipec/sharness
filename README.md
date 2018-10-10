# Sharness

Sharness is a portable shell library to write, run, and analyze automated tests
for Unix programs. Since all tests output TAP, the [Test Anything Protocol],
they can be run with any TAP harness.

Each test is written as a shell script, for example:

```sh
#!/bin/sh

test_description="Show basic features of Sharness"

. ./sharness.sh

test_expect_success "Success is reported like this" "
    echo hello world | grep hello
"

test_expect_success "Commands are chained this way" "
    test x = 'x' &&
    test 2 -gt 1 &&
    echo success
"

return_42() {
    echo "Will return soon"
    return 42
}

test_expect_success "You can test for a specific exit code" "
    test_expect_code 42 return_42
"

test_expect_failure "We expect this to fail" "
    test 1 = 2
"

test_done
```

Running the above test script returns the following (TAP) output:

    $ ./simple.t
    ok 1 - Success is reported like this
    ok 2 - Commands are chained this way
    ok 3 - You can test for a specific exit code
    not ok 4 - We expect this to fail # TODO known breakage
    # still have 1 known breakage(s)
    # passed all remaining 3 test(s)
    1..4

Alternatively, you can run the test through [prove(1)]:

    $ prove simple.t
    simple.t .. ok
    All tests successful.
    Files=1, Tests=4,  0 wallclock secs ( 0.02 usr +  0.00 sys =  0.02 CPU)
    Result: PASS

Sharness was derived from the [Git] project - see [README.git] for the original
documentation.

## Installation

First, clone the Git repository:

    $ git clone git://github.com/chriscool/sharness.git

Then choose an installation method that works best for you:

### Per-project installation

If you like to add Sharness to the sources of a project you want to use it for,
simply copy the files `sharness.sh`, `aggregate-results.sh`, and `test/Makefile`
to a folder named `test` inside that project.

Another way is to use [Sharnessify](https://github.com/chriscool/sharnessify).

Alternatively, you can also add Sharness as a Git submodule to your project.

In per-project installation, Sharness will optionally load extensions from
`sharness.d/*.sh` if a `sharness.d` directory is found in the same directory
as `sharness.sh`. This allows per-project extensions and enhancements to
be added to the test library without requiring modification of `sharness.sh`.

### Per-user installation

    $ cd sharness
    $ make install

This will install Sharness to `$HOME/share/sharness`, and its documentation and
examples to `$HOME/share/doc/sharness`.

### System-wide installation

    $ cd sharness
    # make install prefix=/usr/local

This will install Sharness to `/usr/local/share/sharness`, and its documentation
and examples to `/usr/local/share/doc/sharness`.

Of course, you can change the _prefix_ parameter to install Sharness to any
other location.

### Installation via Chef

If you want to install Sharness with Opscode Chef, the [Sharness cookbook] is
for you.

## Usage

The following files are essential to using Sharness:

* `sharness.sh` - core shell library providing test functionality, see separate
   [API documentation]. Meant to be sourced from test scripts, but not executed.
* `aggregate-results.sh` - helper script to aggregate test results
* `test/Makefile` - test driver. The default target runs the complete testsuite.

To learn how to write and run actual test scripts based on `sharness.sh`, please
read [README.git] until I come up with more documentation myself.

### Command-line options

The `*.t` test scripts have the following options (again, read
[README.git] for details) :

* `--debug`, `-d`: helps debugging
* `--immediate`, `-i`: stop execution after the first failing test
* `--long-tests`, `-l`: run tests marked with prereq EXPENSIVE
* `--interactive-tests`: run tests marked with prereq INTERACTIVE
* `--help`, `-h`: show test description
* `--verbose`, `-v`: show additional debug output
* `--quiet`, `-q`: show less output
* `--chain-lint`/`--no-chain-lint`: check &&-chains in scripts
* `--no-color`: don't color the output
* `--tee`: also write output to a file
* `--verbose-log`: write output to a file, but not on stdout
* `--root=<dir>`: create trash directories in `<dir>` instead of current directory.

## Projects using Sharness

See how Sharness is used in real-world projects:

* [azuki](https://github.com/seveas/azuki/tree/master/test)
* [cb2util](https://github.com/mlafeldt/cb2util/tree/master/test)
* [dabba](https://github.com/eroullit/dabba/tree/master/dabba/test)
* [git-integration](https://github.com/johnkeeping/git-integration/tree/master/t)
* [git-multimail](https://github.com/git-multimail/git-multimail/tree/master/t)
* [git-spindle](https://github.com/seveas/git-spindle/tree/master/test)
* [git-svn-fast-import](https://github.com/satori/git-svn-fast-import/tree/master/t)
* [go-ipfs](https://github.com/ipfs/go-ipfs/tree/master/test/sharness)
* [go-multihash](https://github.com/jbenet/go-multihash/tree/master/test/sharness)
* [ipfs-update](https://github.com/ipfs/ipfs-update/tree/master/sharness)
* [rdd.py](https://github.com/mlafeldt/rdd.py/tree/master/test/integration)
* [Sharness itself](/test)
* [tomdoc.sh](https://github.com/mlafeldt/tomdoc.sh/tree/master/test)

Furthermore, as Sharness was derived from Git, [Git's test suite](https://github.com/git/git/tree/master/t)
is worth examining as well, especially if you're interested in managing a big
number of tests.

## Alternatives

Here is a list of other shell testing libraries (sorted alphabetically):

* [Bats](https://github.com/sstephenson/bats)
* [Cram](https://bitheap.org/cram)
* [rnt](https://github.com/roman-neuhauser/rnt)
* [roundup](https://github.com/bmizerany/roundup)
* [shove](https://github.com/progrhyme/shove)
* [shUnit2](https://code.google.com/p/shunit2/)
* [shspec](https://github.com/shpec/shpec)
* [testlib.sh](https://gist.github.com/3877539)
* [ts](https://github.com/thinkerbot/ts)

## License

Sharness is licensed under the terms of the GNU General Public License version
2 or higher. See file [COPYING] for full license text.

## Contributing

Contributions are welcome, see file [CONTRIBUTING] for details.

## Authors

Sharness was created in April 2011 and maintained until June 2016 by
[Mathias Lafeldt][twitter]. The library is derived from the
[Git] project's test-lib.sh. It is currently maintained by
[Christian Couder][chriscool], thanks to sponsorship from
[Protocol Labs][protocollabs].

See [Github's "contributors" page][contributors] for a list of
developers.

A complete list of authors should include Git contributors to
test-lib.sh too.

[API documentation]: https://github.com/chriscool/sharness/blob/master/API.md
[chriscool]: https://github.com/chriscool
[CONTRIBUTING]: https://github.com/chriscool/sharness/blob/master/CONTRIBUTING.md
[contributors]: https://github.com/chriscool/sharness/graphs/contributors
[COPYING]: https://github.com/chriscool/sharness/blob/master/COPYING
[Git]: http://git-scm.com/
[protocollabs]: https://protocol.ai/
[prove(1)]: http://linux.die.net/man/1/prove
[README.git]: https://github.com/chriscool/sharness/blob/master/README.git
[Sharness cookbook]: https://github.com/mlafeldt/sharness-cookbook
[Test Anything Protocol]: http://testanything.org/
[twitter]: https://twitter.com/mlafeldt
