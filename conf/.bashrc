# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

alias vi=vim

export PATH="~/bin:/opt/play-2.0.1:/opt/freeswitch/bin:$PATH"
