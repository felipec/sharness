Sharness
========

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


Installation
------------

First, clone the Git repository:

    $ git clone git://github.com/mlafeldt/sharness.git

Then choose an installation method that works best for you:

### Per-project installation

If you like to add Sharness to the sources of a project you want to use it for,
simply copy the files `sharness.sh`, `aggregate-results.sh`, and `test/Makefile`
to a folder named `test` inside that project.

Alternatively, you can also add Sharness as a Git submodule to your project.

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


Usage
-----

The following files are essential to using Sharness:

* `sharness.sh` - core shell library providing test functionality, see separate
   [API documentation]
* `aggregate-results.sh` - helper script to aggregate test results
* `test/Makefile` - test driver

To learn how to write and run actual test scripts based on `sharness.sh`, please
read [README.git] until I come up with more documentation myself.


Projects using Sharness
-----------------------

See how Sharness is used in real-world projects:

* [cb2util](https://github.com/mlafeldt/cb2util/tree/master/test)
* [dabba](https://github.com/eroullit/dabba)
* [git-integration](https://github.com/johnkeeping/git-integration/tree/master/t)
* [rdd.py](https://github.com/mlafeldt/rdd.py/tree/master/test/integration)
* [timedb](http://git.cryptoism.org/cgit.cgi/timedb.git)
* [tomdoc.sh](https://github.com/mlafeldt/tomdoc.sh/tree/master/test)
* [Sharness itself](https://github.com/mlafeldt/sharness/blob/master/test)

Furthermore, as Sharness was derived from Git, [Git's test suite](https://github.com/git/git/tree/master/t)
is worth examining as well, especially if you're interested in managing a big
number of tests.


Alternatives
------------

Here is a list of other shell testing libraries (sorted alphabetically):

* [Bats](https://github.com/sstephenson/bats)
* [roundup](https://github.com/bmizerany/roundup)
* [shUnit2](https://code.google.com/p/shunit2/)
* [shspec](https://github.com/shpec/shpec)
* [testlib.sh](https://gist.github.com/3877539)
* [ts](https://github.com/thinkerbot/ts)

License
-------

Sharness is licensed under the terms of the GNU General Public License version
2 or higher. See file [COPYING] for full license text.


Contact
-------

* Web: <http://mlafeldt.github.com/sharness>
* Mail: <mathias.lafeldt@gmail.com>
* Twitter: [@mlafeldt](https://twitter.com/mlafeldt)


[API documentation]: https://github.com/mlafeldt/sharness/blob/master/API.md
[COPYING]: https://github.com/mlafeldt/sharness/blob/master/COPYING
[Git]: http://git-scm.com/
[README.git]: https://github.com/mlafeldt/sharness/blob/master/README.git
[Sharness cookbook]: https://github.com/mlafeldt/sharness-cookbook
[Test Anything Protocol]: http://testanything.org/
[prove(1)]: http://linux.die.net/man/1/prove
