#!/usr/bin/env bash
set -euo pipefail

# Usa o perfil padrão da máquina, sem fixar UUIDs pessoais no arquivo.
profile_uuid=$(gsettings get org.gnome.Ptyxis default-profile-uuid)
profile_uuid=${profile_uuid//\'/}
if [[ ! "$profile_uuid" =~ ^[a-zA-Z0-9-]+$ ]]; then
  printf 'Não foi possível identificar o perfil padrão do Ptyxis.\n' >&2
  exit 1
fi
profile_schema="org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$profile_uuid/"

gsettings set org.gnome.Ptyxis interface-style dark
gsettings set org.gnome.Ptyxis use-system-font false
font_name='Monospace Medium 11'
if [[ "$(fc-match -f '%{family}' 'Adwaita Mono')" == 'Adwaita Mono' ]]; then
  font_name='Adwaita Mono Medium 11'
fi
gsettings set org.gnome.Ptyxis font-name "$font_name"
gsettings set org.gnome.Ptyxis disable-padding false
gsettings set org.gnome.Ptyxis audible-bell false
gsettings set "$profile_schema" palette one-dark-victor
gsettings set "$profile_schema" opacity 1.0
gsettings set "$profile_schema" cell-height-scale 1.08
gsettings set org.gnome.Ptyxis.Shortcuts copy-clipboard '<Control>c'
gsettings set org.gnome.Ptyxis.Shortcuts paste-clipboard '<Control>v'
