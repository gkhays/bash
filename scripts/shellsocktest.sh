#!/bin/sh
if [ "$SHELL" = "/bin/bash" ]
then
	echo "You are using Bash"
	echo "$BASH_VERSION"
	env test='() { :; }; echo This version is vulnerable' bash -c 'echo ...'
fi
