#!/usr/bin/env bash
set -euo pipefail
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/keyboard-backup"
command -v gsettings >/dev/null
# Guarda a configuração anterior somente na primeira ativação.
if [[ ! -d "$state_dir" ]]; then
  mkdir -p -- "$state_dir"
  gsettings get org.gnome.desktop.input-sources sources > "$state_dir/sources"
  gsettings get org.gnome.desktop.input-sources xkb-options > "$state_dir/xkb-options"
  if [[ -e "$HOME/.XCompose" || -L "$HOME/.XCompose" ]]; then
    cp -a -- "$HOME/.XCompose" "$state_dir/XCompose"
  else
    touch "$state_dir/compose-was-absent"
  fi
fi
if [[ -L "$HOME/.XCompose" ]]; then
  printf 'O .XCompose atual é um link; preserve-o manualmente antes de ativar este módulo.\n' >&2
  exit 1
fi
cp -- "$module_dir/XCompose" "$HOME/.XCompose"
gsettings set org.gnome.desktop.input-sources sources "$(cat "$module_dir/sources.gvariant")"
gsettings set org.gnome.desktop.input-sources xkb-options "$(cat "$module_dir/xkb-options.gvariant")"
printf 'Teclado ativo. Reabra os aplicativos para recarregar a composição.\n'
