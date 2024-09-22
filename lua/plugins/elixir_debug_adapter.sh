#!/bin/sh
# Launches the debug adapter. This script must be in the same directory as mix install launch script.

# readlink_f() {
# 	cd "$(dirname "$1")" >/dev/null || exit 1
# 	filename="$(basename "$1")"
# 	if [ -h "$filename" ]; then
# 		readlink_f "$(readlink "$filename")"
# 	else
# 		echo "Launching: $(pwd -P)/$filename"
# 	fi
# }

# readlink_f "$0"
#

cd "$HOME/.local/share/nvim/mason/packages/elixir-ls"

export ELS_MODE=debug_adapter
export MIX_ENV=prod
default_erl_opts="-kernel standard_io_encoding latin1 +sbwt none +sbwtdcpu none +sbwtdio none"

exec elixir $elixir_opts --erl "$default_erl_opts" "./launch.exs"
