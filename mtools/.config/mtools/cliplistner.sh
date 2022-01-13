#!/bin/bash

# title: copy_without_linebreaks
# author: Glutanimate (github.com/glutanimate)
# modifier: Siddharth (github.com/SidMan2001)
# license: MIT license

# Parses currently selected text and removes 
# newlines

# requires:
# xsel
# https://github.com/cdown/clipnotify

if pidof -o %PPID -x "clipnotify">/dev/null; then
	exit 1
fi

LastSelected=""

while ~/.config/mtools/clipnotify;
do
	CopiedText="$(xsel -b)"
	echo $LastSelected
	echo $CopiedText
	if [[ $CopiedText != $LastSelected ]]; then
		LastSelected=$CopiedText
		~/go/bin/clipGo add
	fi
done

