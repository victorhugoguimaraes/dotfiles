# Ferramentas gerenciadas pelo Mason também disponíveis no terminal.
# O PATH existente tem prioridade, preservando versões por projeto.
case $- in
  *i*) ;;
  *) return ;;
esac
if [[ -d "$HOME/.local/share/nvim/mason/bin" ]]; then
  case ":$PATH:" in
    *":$HOME/.local/share/nvim/mason/bin:"*) ;;
    *) export PATH="$PATH:$HOME/.local/share/nvim/mason/bin" ;;
  esac
fi
