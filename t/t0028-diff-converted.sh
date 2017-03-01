#!/bin/sh
#
# Copyright (c) 2017 Mike Crowe
#
# These tests ensure that files changing line endings in the presence
# of .gitattributes to indicate that line endings should be ignored
# don't cause 'git diff' or 'git diff --quiet' to think that they have
# been changed.

test_description='git diff with files that require CRLF conversion'

. ./test-lib.sh

test_expect_success setup '
	echo "* text=auto" >.gitattributes &&
	printf "Hello\r\nWorld\r\n" >crlf.txt &&
	git add .gitattributes crlf.txt &&
	git commit -m "initial"
'

test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
	printf "Hello\r\nWorld\n" >crlf.txt &&
	git status &&
	git diff --quiet
'

test_done
