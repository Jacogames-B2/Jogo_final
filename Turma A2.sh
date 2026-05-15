#!/bin/sh
printf '\033c\033]0;%s\a' Turma A2
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Turma A2.x86_64" "$@"
