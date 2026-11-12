# Configuração visual apenas para shells interativos.
case $- in
  *i*) ;;
  *) return ;;
esac

export EDITOR=nvim
export VISUAL=nvim
export BAT_THEME=OneHalfDark

alias ll='ls -lh --color=auto --group-directories-first'
alias la='ls -lah --color=auto --group-directories-first'

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi
