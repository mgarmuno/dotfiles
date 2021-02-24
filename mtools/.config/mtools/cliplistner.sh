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

while ./clipnotify;
do
	SelectedText="$(xsel)"
	CopiedText="$(xsel -b)"
	if [[ $CopiedText == $SelectedText ]]; then
		~/dev/clipGo/clipGo add
	fi
done

