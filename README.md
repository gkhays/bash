bash
====

Some bash scripts I use. Updated to include a quick test for CVE-2014-6271 (Shellshock).

<pre lang="bash"><code>
#!/bin/sh
if [ "$SHELL" = "/bin/bash" ]
then
	echo "You are using Bash"
	echo "$BASH_VERSION"
	env test='() { :; }; echo This version is vulnerable' bash -c 'echo ...'
fi
</code></pre>

I added a Wiki article that describes the settings I use for terminal colors. See the following:

https://github.com/gkhays/bash/wiki/Setting-Terminal-and-Shell-Environment-Colors

Or just navigate to Wiki, above.
