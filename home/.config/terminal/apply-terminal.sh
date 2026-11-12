#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
schemas=$(gsettings list-schemas)
if [[ "$schemas" == *org.gnome.Ptyxis* ]]; then
  exec bash "$script_dir/apply-ptyxis.sh"
fi
if [[ "$schemas" != *org.gnome.Terminal.ProfilesList* ]]; then
  printf 'Tema automático disponível para Ptyxis ou GNOME Terminal.\n' >&2
  exit 1
fi
python3 - <<'PY'
from pathlib import Path
import configparser, subprocess
palette = configparser.ConfigParser()
palette.read(Path.home()/'.local/share/org.gnome.Ptyxis/palettes/one-dark-victor.palette')
colors=palette['Palette']
def get(*args): return subprocess.check_output(['gsettings','get',*args],text=True).strip()
def set_value(key,value): subprocess.run(['gsettings','set',schema,key,value],check=True)
uuid=get('org.gnome.Terminal.ProfilesList','default').strip("'")
schema=f'org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:{uuid}/'
font=subprocess.check_output(['fc-match','-f','%{family}','Adwaita Mono'],text=True)
set_value('use-theme-colors','false')
set_value('foreground-color',colors['Foreground'])
set_value('background-color',colors['Background'])
set_value('palette',repr([colors[f'Color{i}'] for i in range(16)]))
set_value('use-system-font','false')
set_value('font','Adwaita Mono Medium 11' if font=='Adwaita Mono' else 'Monospace Medium 11')
subprocess.run(['gsettings','set','org.gnome.Terminal.Legacy.Keybindings','copy','<Primary>c'],check=True)
subprocess.run(['gsettings','set','org.gnome.Terminal.Legacy.Keybindings','paste','<Primary>v'],check=True)
print('Tema de alto contraste aplicado ao perfil padrão do GNOME Terminal.')
PY
