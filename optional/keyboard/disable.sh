#!/usr/bin/env bash
set -euo pipefail
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/keyboard-backup"
if [[ ! -d "$state_dir" ]]; then
  printf 'Este módulo ainda não foi ativado por este instalador. Nada foi alterado.\n'
  exit 0
fi
gsettings set org.gnome.desktop.input-sources sources "$(cat "$state_dir/sources")"
gsettings set org.gnome.desktop.input-sources xkb-options "$(cat "$state_dir/xkb-options")"
if [[ -f "$state_dir/compose-was-absent" ]]; then
  # Move o arquivo criado pelo módulo em vez de apagá-lo.
  if [[ -e "$HOME/.XCompose" || -L "$HOME/.XCompose" ]]; then
    mv -- "$HOME/.XCompose" "$state_dir/disabled-compose-$(date +%s)-$$"
  fi
else
  cp -a -- "$state_dir/XCompose" "$HOME/.XCompose"
fi
mv -- "$state_dir" "$state_dir-restored-$(date +%s)-$$"
printf 'Configuração anterior do teclado restaurada. Reabra os aplicativos.\n'
