case $- in
  *i*) ;;
  *) return ;;
esac

# Ctrl+C/V pertencem ao copiar/colar do emulador de terminal.
# Ctrl+G passa a enviar SIGINT para comandos no terminal em modo normal.
if [[ -t 0 ]]; then
  stty intr '^G' 2>/dev/null
fi
