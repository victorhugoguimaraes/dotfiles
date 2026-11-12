#!/usr/bin/env bash
set -euo pipefail
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
apply=false
keyboard=false
study=false
terminal=false
for arg in "$@"; do
  case "$arg" in
    --apply) apply=true ;;
    --dry-run) apply=false ;;
    --keyboard) keyboard=true ;;
    --study) study=true ;;
    --terminal) terminal=true ;;
    --help)
      printf 'Uso: bash install.sh [--dry-run | --apply] [--terminal] [--keyboard] [--study]\n'
      printf 'Sem --apply, apenas mostra as alterações. Teclado e perfil da IA são opcionais.\n'
      exit 0 ;;
    *) printf 'Opção desconhecida: %s\n' "$arg" >&2; exit 1 ;;
  esac
done
backup_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups/$(date +%Y%m%d-%H%M%S)-$$"
link_file() {
  local source=$1 target=$2 relative=$3
  printf '%s -> %s\n' "$target" "$source"
  "$apply" || return 0
  if [[ -L "$target" && "$(readlink -f -- "$target")" == "$source" ]]; then return 0; fi
  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p -- "$backup_dir/$(dirname -- "$relative")"
    mv -- "$target" "$backup_dir/$relative"
  fi
  mkdir -p -- "$(dirname -- "$target")"
  ln -s -- "$source" "$target"
}
while IFS= read -r relative; do
  [[ -n "$relative" && "$relative" != \#* ]] || continue
  link_file "$repo_dir/home/$relative" "$HOME/$relative" "$relative"
done < "$repo_dir/manifest.txt"
if "$study"; then
  link_file "$repo_dir/optional/study/AGENTS.md" "${CODEX_HOME:-$HOME/.codex}/AGENTS.md" '.codex/AGENTS.md'
fi
if "$terminal"; then
  printf 'Aplicar aparência no perfil padrão do Ptyxis ou GNOME Terminal.\n'
  if "$apply"; then
    mkdir -p -- "$backup_dir"
    dconf dump /org/gnome/Ptyxis/ > "$backup_dir/ptyxis.dconf"
    dconf dump /org/gnome/terminal/legacy/ > "$backup_dir/gnome-terminal.dconf"
    bash "$HOME/.config/terminal/apply-terminal.sh"
  fi
fi
if "$keyboard"; then
  printf 'Ativar teclado US International + XCompose personalizado.\n'
  if "$apply"; then bash "$repo_dir/optional/keyboard/enable.sh"; fi
fi
if "$apply"; then
  printf 'Configuração aplicada. Backups: %s\n' "$backup_dir"
else
  printf '\nSimulação: nenhum arquivo ou preferência foi alterado. Use --apply para instalar.\n'
fi
