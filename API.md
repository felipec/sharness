# Sharness API

`SHARNESS_VERSION`
------------------

Public: Current version of Sharness.


`SHARNESS_TEST_EXTENSION`
-------------------------

Public: The file extension for tests.  By default, it is set to "t".


`SHARNESS_TEST_DIRECTORY`
-------------------------

Public: Root directory containing tests. Tests can override this variable, e.g. for testing Sharness itself.


`SHARNESS_TEST_SRCDIR`
----------------------

Public: Source directory of test code and sharness library. This directory may be different from the directory in which tests are being run.


`SHARNESS_TEST_OUTDIR`
----------------------

Public: Directory where the output of the tests should be stored (i.e. trash directories).


`SHARNESS_ORIG_TERM`
--------------------

Public: The unsanitized TERM under which sharness is originally run


`test_untraceable`
------------------

Public: When set to a non-empty value, the current test will not be traced, unless it's run with a Bash version supporting BASH_XTRACEFD, i.e. v4.1 or later.


`SHARNESS_TEST_NB`
------------------

Public: The current test number, starting at 0.


`SHARNESS_BUILD_DIRECTORY`
--------------------------

Public: Build directory that will be added to PATH. By default, it is set to the parent directory of SHARNESS_TEST_DIRECTORY.


`SHARNESS_TEST_FILE`
--------------------

Public: Path to test script currently executed.


`SHARNESS_TRASH_DIRECTORY`
--------------------------

Public: Empty trash directory, the test area, provided for each test. The HOME variable is set to that directory too.


`test_set_prereq()`
-------------------

Public: Define that a test prerequisite is available.

The prerequisite can later be checked explicitly using test_have_prereq or implicitly by specifying the prerequisite name in calls to test_expect_success or test_expect_failure.

* $1 - Name of prerequisite (a simple word, in all capital letters by convention)

Examples

    # Set PYTHON prerequisite if interpreter is available.
    command -v python >/dev/null && test_set_prereq PYTHON

    # Set prerequisite depending on some variable.
    test -z "$NO_GETTEXT" && test_set_prereq GETTEXT

Returns nothing.


`test_have_prereq()`
--------------------

Public: Check if one or more test prerequisites are defined.

The prerequisites must have previously been set with test_set_prereq. The most common use of this is to skip all the tests if some essential prerequisite is missing.

* $1 - Comma-separated list of test prerequisites.

Examples

    # Skip all remaining tests if prerequisite is not set.
    if ! test_have_prereq PERL; then
        skip_all='skipping perl interface tests, perl not available'
        test_done
    fi

Returns 0 if all prerequisites are defined or 1 otherwise.


`test_debug()`
--------------

Public: Execute commands in debug mode.

Takes a single argument and evaluates it only when the test script is started with --debug. This is primarily meant for use during the development of test scripts.

* $1 - Commands to be executed.

Examples

    test_debug "cat some_log_file"

Returns the exit code of the last command executed in debug mode or 0    otherwise.


`test_pause()`
--------------

Public: Stop execution and start a shell.

This is useful for debugging tests and only makes sense together with "-v". Be sure to remove all invocations of this command before submitting.


`test_expect_success()`
-----------------------

Public: Run test commands and expect them to succeed.

When the test passed, an "ok" message is printed and the number of successful tests is incremented. When it failed, a "not ok" message is printed and the number of failed tests is incremented.

With --immediate, exit test immediately upon the first failed test.

Usually takes two arguments:
* $1 - Test description
* $2 - Commands to be executed.

With three arguments, the first will be taken to be a prerequisite:
* $1 - Comma-separated list of test prerequisites. The test will be skipped if not all of the given prerequisites are set. To negate a prerequisite, put a "!" in front of it.
* $2 - Test description
* $3 - Commands to be executed.

Examples

    test_expect_success \
        'git-write-tree should be able to write an empty tree.' \
        'tree=$(git-write-tree)'

    # Test depending on one prerequisite.
    test_expect_success TTY 'git --paginate rev-list uses a pager' \
        ' ... '

    # Multiple prerequisites are separated by a comma.
    test_expect_success PERL,PYTHON 'yo dawg' \
        ' test $(perl -E 'print eval "1 +" . qx[python -c "print 2"]') == "4" '

Returns nothing.


`test_expect_failure()`
-----------------------

Public: Run test commands and expect them to fail. Used to demonstrate a known breakage.

This is NOT the opposite of test_expect_success, but rather used to mark a test that demonstrates a known breakage.

When the test passed, an "ok" message is printed and the number of fixed tests is incremented. When it failed, a "not ok" message is printed and the number of tests still broken is incremented.

Failures from these tests won't cause --immediate to stop.

Usually takes two arguments:
* $1 - Test description
* $2 - Commands to be executed.

With three arguments, the first will be taken to be a prerequisite:
* $1 - Comma-separated list of test prerequisites. The test will be skipped if not all of the given prerequisites are set. To negate a prerequisite, put a "!" in front of it.
* $2 - Test description
* $3 - Commands to be executed.

Returns nothing.


`test_expect_unstable()`
------------------------

Public: Run test commands and expect anything from them. Used when a test is not stable or not finished for some reason.

When the test passed, an "ok" message is printed, but the number of fixed tests is not incremented.

When it failed, a "not ok ... # TODO known breakage" message is printed, and the number of tests still broken is incremented.

Failures from these tests won't cause --immediate to stop.

Usually takes two arguments:
* $1 - Test description
* $2 - Commands to be executed.

With three arguments, the first will be taken to be a prerequisite:
* $1 - Comma-separated list of test prerequisites. The test will be skipped if not all of the given prerequisites are set. To negate a prerequisite, put a "!" in front of it.
* $2 - Test description
* $3 - Commands to be executed.

Returns nothing.


`test_must_fail()`
------------------

Public: Run command and ensure that it fails in a controlled way.

Use it instead of "! <command>". For example, when <command> dies due to a segfault, test_must_fail diagnoses it as an error, while "! <command>" would mistakenly be treated as just another expected failure.

This is one of the prefix functions to be used inside test_expect_success or test_expect_failure.

* $1.. - Command to be executed.

Examples

    test_expect_success 'complain and die' '
        do something &&
        do something else &&
        test_must_fail git checkout ../outerspace
    '

Returns 1 if the command succeeded (exit code 0). Returns 1 if the command died by signal (exit codes 130-192) Returns 1 if the command could not be found (exit code 127). Returns 0 otherwise.


`test_might_fail()`
-------------------

Public: Run command and ensure that it succeeds or fails in a controlled way.

Similar to test_must_fail, but tolerates success too. Use it instead of "<command> || :" to catch failures caused by a segfault, for instance.

This is one of the prefix functions to be used inside test_expect_success or test_expect_failure.

* $1.. - Command to be executed.

Examples

    test_expect_success 'some command works without configuration' '
        test_might_fail git config --unset all.configuration &&
        do something
    '

Returns 1 if the command died by signal (exit codes 130-192) Returns 1 if the command could not be found (exit code 127). Returns 0 otherwise.


`test_expect_code()`
--------------------

Public: Run command and ensure it exits with a given exit code.

This is one of the prefix functions to be used inside test_expect_success or test_expect_failure.

* $1   - Expected exit code.
* $2.. - Command to be executed.

Examples

    test_expect_success 'Merge with d/f conflicts' '
        test_expect_code 1 git merge "merge msg" B master
    '

Returns 0 if the expected exit code is returned or 1 otherwise.


`test_cmp()`
------------

Public: Compare two files to see if expected output matches actual output.

The TEST_CMP variable defines the command used for the comparison; it defaults to "diff -u". Only when the test script was started with --verbose, will the command's output, the diff, be printed to the standard output.

This is one of the prefix functions to be used inside test_expect_success or test_expect_failure.

* $1 - Path to file with expected output.
* $2 - Path to file with actual output.

Examples

    test_expect_success 'foo works' '
        echo expected >expected &&
        foo >actual &&
        test_cmp expected actual
    '

Returns the exit code of the command set by TEST_CMP.


`test_seq()`
------------

Public: portably print a sequence of numbers.

seq is not in POSIX and GNU seq might not be available everywhere, so it is nice to have a seq implementation, even a very simple one.

* $1 - Starting number.
* $2 - Ending number.

Examples

    test_expect_success 'foo works 10 times' '
        for i in $(test_seq 1 10)
        do
            foo || return
        done
    '

Returns 0 if all the specified numbers can be displayed.


`test_must_be_empty()`
----------------------

Public: Check if the file expected to be empty is indeed empty, and barfs otherwise.

* $1 - File to check for emptiness.

Returns 0 if file is empty, 1 otherwise.


`test_when_finished()`
----------------------

Public: Schedule cleanup commands to be run unconditionally at the end of a test.

If some cleanup command fails, the test will not pass. With --immediate, no cleanup is done to help diagnose what went wrong.

This is one of the prefix functions to be used inside test_expect_success or test_expect_failure.

* $1.. - Commands to prepend to the list of cleanup commands.

Examples

    test_expect_success 'test core.capslock' '
        git config core.capslock true &&
        test_when_finished "git config --unset core.capslock" &&
        do_something
    '

Returns the exit code of the last cleanup command executed.


`final_cleanup`
---------------

Public: Schedule cleanup commands to be run unconditionally when all tests have run.

This can be used to clean up things like test databases. It is not needed to clean up temporary files, as test_done already does that.

Examples:

    cleanup mysql -e "DROP DATABASE mytest"

Returns the exit code of the last cleanup command executed.


`test_done()`
-------------

Public: Summarize test results and exit with an appropriate error code.

Must be called at the end of each test script.

Can also be used to stop tests early and skip all remaining tests. For this, set skip_all to a string explaining why the tests were skipped before calling test_done.

Examples

    # Each test script must call test_done at the end.
    test_done

    # Skip all remaining tests if prerequisite is not set.
    if ! test_have_prereq PERL; then
        skip_all='skipping perl interface tests, perl not available'
        test_done
    fi

Returns 0 if all tests passed or 1 if there was a failure.


Generated by tomdoc.sh version 0.1.10
