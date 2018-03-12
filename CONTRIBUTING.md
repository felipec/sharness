# Contributing to Sharness

You want to contribute to Sharness, great!

Now, before you start using the
[Sharness GitHub repository](https://github.com/mlafeldt/sharness/)
to help us improve Sharness, please read on to know more about how to
proceed.

As you probably know, Sharness was created in 2011 by extracting the
shell test framework that Git developers had been developing since
2005 to test Git itself.

We would like to keep the same code quality and portability that Git
enjoys. And we would like as much as possible to benefit from
enhancements and fixes that are still made by Git developers on their
version of Sharness.

That's why we would like you to follow the following guidelines:

- The same coding rules as in git.git should be followed. See
  [Git CodingGuidelines](https://github.com/git/git/blob/master/Documentation/CodingGuidelines)
  to get a grasp of the shell features we rely on and those that are
  frown upon, and the style we prefer.

- If some similar changes can benefit Git, it is a good idea to first
  send patches to the
  [Git mailing list](http://vger.kernel.org/vger-lists.html#git).
  Please follow the
  [Git documentation](https://github.com/git/git/blob/master/Documentation/SubmittingPatches)
  when sending patches to the Git mailing list.

- The code in `sharness.sh` should be kept as much as possible similar as
  [git/git/t/test-lib.sh](https://github.com/git/git/blob/master/t/test-lib.sh).
  This means that you should be careful about variable names, function
  names, ...

- If some changes do not depend on each other, it is better to send
  different Pull Requests (PR) with as few changes as possible in each
  PR, rather than a big PR with everything.

- It is better to have tests with each PR, as Sharness has its own
  test suite.

- API.md should be updated using `make doc` when new public functions
  or variables are added. They should be documented in
  [TomDoc](https://github.com/tests-always-included/tomdoc.sh).

Resources that might be helpful:

- [Git CodingGuidelines](https://github.com/git/git/blob/master/Documentation/CodingGuidelines)
- [Git test directory](https://github.com/git/git/blob/master/t)
