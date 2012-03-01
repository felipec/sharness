Sharness
========

Sharness is a portable shell library to write, run, and analyze automated tests.
Since all tests output TAP, the [Test Anything Protocol], they can be run with
any TAP harness.

Sharness was derived from the [Git] project - see [README.git] for the original
documentation.


Usage
-----

The following files are essential to using Sharness:

* `sharness.sh` -- core shell library providing test functionality
* `aggregate-results.sh` -- helper script to aggregate test results
* `Makefile` -- test driver

Copy them to the project you want to write automated tests for, e.g. to a folder
named `test`.

To learn how to write and run actual test scripts based on `sharness.sh`, please
read [README.git] until I come up with some sexy markup-powered documentation.


Projects using Sharness
-----------------------

See how Sharness is used in real-world projects:

* [tomdoc.sh](https://github.com/mlafeldt/tomdoc.sh/tree/master/test)
* [rdd.py](https://github.com/mlafeldt/rdd.py/tree/master/test)
* [cb2util](https://github.com/mlafeldt/cb2util/tree/master/test)
* [Sharness itself](https://github.com/mlafeldt/Sharness/blob/master/test)


License
-------

Sharness is licensed under the terms of the GNU General Public License version
2 or higher. See file [COPYING] for full license text.


Contact
-------

* Web: <https://github.com/mlafeldt/Sharness>
* Mail: <mathias.lafeldt@gmail.com>
* Twitter: [@mlafeldt](https://twitter.com/mlafeldt)


[COPYING]: https://github.com/mlafeldt/Sharness/blob/master/COPYING
[Git]: http://git-scm.com/
[README.git]: https://github.com/mlafeldt/Sharness/blob/master/README.git
[Test Anything Protocol]: http://testanything.org/
