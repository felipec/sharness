#!/bin/sh

test_description="Show basic features of Sharness"

. ./sharness.sh

it "reports success" "
    echo hello world | grep hello
"

it "lets you chain commands" "
    test x = 'x' &&
    test 2 -gt 1 &&
    echo success
"

return_42() {
    echo "Will return soon"
    return 42
}

it "tests for a specific exit code" "
    test_expect_code 42 return_42
"

xit "expects this to fail" "
    test 1 = 2
"

test_done

# vi: set ft=sh :
