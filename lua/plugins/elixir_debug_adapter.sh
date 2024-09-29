#!/bin/sh

cd "$HOME/.local/share/nvim/mason/packages/elixir-ls"

export ELS_MODE=debug_adapter
export MIX_ENV=prod
default_erl_opts="-kernel standard_io_encoding latin1 +sbwt none +sbwtdcpu none +sbwtdio none"

exec elixir $elixir_opts --erl "$default_erl_opts" "./launch.exs"
