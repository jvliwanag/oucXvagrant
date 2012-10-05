# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

alias vi=vim

export PATH="~/bin:/opt/play-2.0.3:/opt/freeswitch/bin:$PATH"

# Kerl R15B02 Activate
KERL_INSTALL="/home/vagrant/.kerl/installs/r15b02"

KERL_ACTIVATE="$KERL_INSTALL/activate"
if [ -f "$KERL_ACTIVATE" ]; then
	. "$KERL_ACTIVATE"
	export PATH
	export AGNER_BIN
	export REBAR_PLT_DIR
fi

