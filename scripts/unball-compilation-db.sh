#!/usr/bin/env bash
set -euo pipefail
project_dir="${1:-$PWD}"
build_dir="$project_dir/build/estrategia"
if [[ ! -f "$build_dir/CMakeCache.txt" ]]; then
  printf 'Primeiro prepare o UnBall2D com o instalador do próprio projeto.\n' >&2
  exit 1
fi
# Usa o cache existente para preservar as versões, bibliotecas e flags locais.
cmake -S "$project_dir" -B "$build_dir" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
if [[ ! -e "$project_dir/.clangd" && ! -L "$project_dir/.clangd" ]]; then
  printf 'CompileFlags:\n  CompilationDatabase: build/estrategia\n' > "$project_dir/.clangd"
  printf 'Criado .clangd local para localizar o banco de compilação.\n'
fi
printf 'Banco de compilação disponível em %s/compile_commands.json\n' "$build_dir"
printf 'Configurações .clangd existentes foram preservadas.\n'
