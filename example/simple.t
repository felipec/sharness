#!/bin/sh

test_description='Show basic features of Sharness'

. ./sharness.sh

test_expect_success 'Success is reported like this' '
    echo hello world | grep hello
'

test_expect_success 'Commands are chained this way' '
    test x = "x" &&
    test 2 -gt 1 &&
    echo success
'

test_expect_failure 'We expect this to fail' '
    test 1 = 2
'

test_done

# vi: set ft=sh.sharness :
