Sharness
========

Sharness is a portable shell library to write, run, and analyze automated tests
for Unix programs. Since all tests output TAP, the [Test Anything Protocol], they
can be run with any TAP harness.

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


Usage
-----

The following files are essential to using Sharness:

* `sharness.sh` - core shell library providing test functionality, see separate
   [API documentation]
* `aggregate-results.sh` - helper script to aggregate test results
* `Makefile` - test driver

Copy them to the project you want to write automated tests for, e.g. to a folder
named `test`.

To learn how to write and run actual test scripts based on `sharness.sh`, please
read [README.git] until I come up with more documentation myself.


Projects using Sharness
-----------------------

See how Sharness is used in real-world projects:

* [cb2util](https://github.com/mlafeldt/cb2util/tree/master/test)
* [dabba](https://github.com/eroullit/dabba)
* [rdd.py](https://github.com/mlafeldt/rdd.py/tree/master/test/integration)
* [timedb](http://git.cryptoism.org/cgit.cgi/timedb.git)
* [tomdoc.sh](https://github.com/mlafeldt/tomdoc.sh/tree/master/test)
* [Sharness itself](https://github.com/mlafeldt/sharness/blob/master/test)


Alternatives
------------

* [Bats](https://github.com/sstephenson/bats)
* [roundup](https://github.com/bmizerany/roundup)
* [shUnit2](https://code.google.com/p/shunit2/)
* [testlib.sh](https://gist.github.com/3877539)


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
[Test Anything Protocol]: http://testanything.org/
[prove(1)]: http://linux.die.net/man/1/prove
