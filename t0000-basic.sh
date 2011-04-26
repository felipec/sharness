#!/bin/sh
#
# Copyright (c) 2011 Mathias Lafeldt
# Copyright (c) 2005-2011 Git project
# Copyright (c) 2005-2011 Junio C Hamano
#

test_description='Test test harness library'

. ./test-lib.sh

test_expect_success 'success is reported like this' '
    :
'
test_expect_failure 'pretend we have a known breakage' '
    false
'

test_expect_success 'pretend we have fixed a known breakage (run in sub test-lib)' "
    mkdir passing-todo &&
    (cd passing-todo &&
    cat >passing-todo.sh <<EOF &&
#!$SHELL_PATH

test_description='A passing TODO test

This is run in a sub test-lib so that we do not get incorrect passing
metrics
'

# Point to the t/test-lib.sh, which isn't in ../ as usual
TEST_DIRECTORY=\"$TEST_DIRECTORY\"
. \"\$TEST_DIRECTORY\"/test-lib.sh

test_expect_failure 'pretend we have fixed a known breakage' '
    :
'

test_done
EOF
    chmod +x passing-todo.sh &&
    ./passing-todo.sh >out 2>err &&
    ! test -s err &&
sed -e 's/^> //' >expect <<EOF &&
> ok 1 - pretend we have fixed a known breakage # TODO known breakage
> # fixed 1 known breakage(s)
> # passed all 1 test(s)
> 1..1
EOF
    test_cmp expect out)
"
test_set_prereq HAVEIT
haveit=no
test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
    test_have_prereq HAVEIT &&
    haveit=yes
'
donthaveit=yes
test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be skipped' '
    donthaveit=no
'
if test $haveit$donthaveit != yesyes
then
	say "bug in test framework: prerequisite tags do not work reliably"
	exit 1
fi

test_set_prereq HAVETHIS
haveit=no
test_expect_success HAVETHIS,HAVEIT 'test runs if prerequisites are satisfied' '
    test_have_prereq HAVEIT &&
    test_have_prereq HAVETHIS &&
    haveit=yes
'
donthaveit=yes
test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes test to be skipped' '
    donthaveit=no
'
donthaveiteither=yes
test_expect_success DONTHAVEIT,HAVEIT 'unmet prerequisites causes test to be skipped' '
    donthaveiteither=no
'
if test $haveit$donthaveit$donthaveiteither != yesyesyes
then
	say "bug in test framework: multiple prerequisite tags do not work reliably"
	exit 1
fi

clean=no
test_expect_success 'tests clean up after themselves' '
    test_when_finished clean=yes
'

if test $clean != yes
then
	say "bug in test framework: basic cleanup command does not work reliably"
	exit 1
fi

test_expect_success 'tests clean up even on failures' "
    mkdir failing-cleanup &&
    (cd failing-cleanup &&
    cat >failing-cleanup.sh <<EOF &&
#!$SHELL_PATH

test_description='Failing tests with cleanup commands'

# Point to the t/test-lib.sh, which isn't in ../ as usual
TEST_DIRECTORY=\"$TEST_DIRECTORY\"
. \"\$TEST_DIRECTORY\"/test-lib.sh

test_expect_success 'tests clean up even after a failure' '
    touch clean-after-failure &&
    test_when_finished rm clean-after-failure &&
    (exit 1)
'

test_expect_success 'failure to clean up causes the test to fail' '
    test_when_finished \"(exit 2)\"
'

test_done
EOF
    chmod +x failing-cleanup.sh &&
    test_must_fail ./failing-cleanup.sh >out 2>err &&
    ! test -s err &&
    ! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
sed -e 's/Z$//' -e 's/^> //' >expect <<\EOF &&
> not ok - 1 tests clean up even after a failure
> #	Z
> #	    touch clean-after-failure &&
> #	    test_when_finished rm clean-after-failure &&
> #	    (exit 1)
> #	Z
> not ok - 2 failure to clean up causes the test to fail
> #	Z
> #	    test_when_finished \"(exit 2)\"
> #	Z
> # failed 2 among 2 test(s)
> 1..2
EOF
    test_cmp expect out)
"

test_done
