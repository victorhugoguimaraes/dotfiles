#!/usr/bin/env bash
set -u
printf 'Ferramentas disponíveis (este comando não instala nada):\n'
export PATH="$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin:$PATH"
for tool in git nvim node codex starship latexmk pdflatex evince gcc g++ cmake gdb python3 podman cargo rustc rustfmt clangd rust-analyzer pyright-langserver vtsls aiken texlab marksman; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  OK       %-10s %s\n' "$tool" "$(command -v "$tool")"
  else
    printf '  AUSENTE  %s\n' "$tool"
  fi
done
if command -v nvim >/dev/null 2>&1; then
  nvim --version | head -1
  printf 'Esta configuração do VimTeX exige Neovim >= 0.12.4.\n'
fi
