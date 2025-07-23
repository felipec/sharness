#!/bin/sh

exec "${SHELL_PATH:-/bin/sh}" "$(dirname "$0")"/../example/simple.t "$@"
