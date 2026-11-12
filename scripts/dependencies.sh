#!/usr/bin/env bash
set -euo pipefail
apply=false
case "${1:---dry-run}" in
  --apply) apply=true ;;
  --dry-run) ;;
  *) printf 'Uso: bash scripts/dependencies.sh [--dry-run | --apply]\n' >&2; exit 1 ;;
esac
source /etc/os-release
case "$ID" in
  ubuntu|debian)
    packages=(git bash-completion curl ca-certificates unzip tar build-essential cmake pkg-config python3 python3-venv python3-pip gdb latexmk texlive-latex-recommended texlive-latex-extra texlive-lang-portuguese evince fontconfig)
    command=(sudo apt-get install -y "${packages[@]}") ;;
  fedora)
    packages=(git bash-completion curl ca-certificates unzip tar gcc gcc-c++ make cmake pkgconf-pkg-config python3 python3-pip gdb rust cargo rust-src rustfmt clippy latexmk texlive-collection-latexrecommended texlive-collection-latexextra texlive-collection-langportuguese evince fontconfig)
    command=(sudo dnf install -y "${packages[@]}") ;;
  *) printf 'Distribuição ainda não suportada: %s\n' "$ID" >&2; exit 1 ;;
esac
printf 'Pacotes de base para %s:\n' "$ID"
printf '%q ' "${command[@]}"; printf '\n'
printf 'Neovim >= 0.12.4, Node.js, Rust/Cargo, Starship e Codex são verificados separadamente pelo doctor.\n'
printf 'As dependências e versões do simulador continuam sob responsabilidade do instalador do UnBall2D.\n'
if "$apply"; then
  "${command[@]}"
else
  printf 'Simulação: nenhum pacote foi instalado.\n'
fi
