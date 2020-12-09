let b:is_bash=1
runtime! syntax/sh.vim

syn keyword shsStatement test_done
syn keyword shsStatement test_set_editor test_set_index_version test_decode_color lf_to_nul nul_to_q q_to_nul q_to_cr q_to_tab qz_to_tab_space append_cr remove_cr generate_zero_bytes sane_unset test_tick test_pause debug test_commit test_merge test_commit_bulk test_chmod test_modebits test_unconfig test_config test_config_global write_script test_unset_prereq test_set_prereq test_have_prereq test_declared_prereq test_verify_prereq test_external test_external_without_stderr test_path_is_file test_path_is_dir test_path_exists test_dir_is_empty test_file_not_empty test_path_is_missing test_line_count test_file_size list_contains test_must_fail_acceptable test_must_fail test_might_fail test_expect_code test_i18ncmp test_i18ngrep verbose test_must_be_empty test_cmp_rev test_cmp_fspath test_seq test_when_finished test_atexit test_create_repo test_ln_s_add test_write_lines perl test_bool_env test_skip_or_die mingw_test_cmp test_env test_match_signal test_copy_bytes nongit depacketize hex2oct test_set_hash test_detect_hash test_oid_init test_oid_cache test_oid test_oid_to_path test_set_port test_bitmap_traversal test_path_is_hidden test_subcommand
syn keyword shsStatement test_cmp test_cmp_config test_cmp_bin packetize

syn region shsTest fold start="\<test_expect_\w\+\>" end="$" contains=shsTestTitle
syn region shsTest fold start="\<test_expect_\w\+\>\s\+\<[A-Z_,]\+\>" end="$" contains=shsPrereq
syn region shsTest fold start="\<test_lazy_prereq\>\s\+\<[A-Z_,]\+\>" end="$" contains=shsPrereqLazy

syn keyword shsTestStatement contained containedin=shsTest test_expect_success test_expect_failure test_expect_unstable test_lazy_prereq

syn region shsTestTitle contained start=' 'hs=s+1 end=' 'me=e-1 nextgroup=shsTestBody contains=shSingleQuote,shDoubleQuote

" multiple line body
syn region shsTestBody contained transparent excludenl matchgroup=shQuote start=+ '$+hs=s+1,rs=e end=+'$+ contains=@shSubShList
syn region shsTestBody contained transparent excludenl matchgroup=shQuote start=+ "$+hs=s+1,rs=e end=+"$+ contains=@shSubShList

" single line body
syn region shsTestBody contained oneline transparent excludenl keepend matchgroup=shQuote start=+ '+hs=s+1 end=+'$+ contains=@shSubShList
syn region shsTestBody contained oneline transparent excludenl keepend matchgroup=shQuote start=+ "+hs=s+1 end=+"$+ contains=@shSubShList

syn match shsPrereq contained "\<[A-Z_,]\+\>" nextgroup=shsTestTitle
syn match shsPrereqLazy contained "\<[A-Z_,]\+\>" nextgroup=shsTestBody

syn cluster shCommandSubList add=shsTest,shsStatement

hi def link shsStatement Statement
hi def link shsTestStatement Function
hi def link shsPrereq Identifier
hi def link shsPrereqLazy shsPrereq

let b:current_syntax='sharness'
