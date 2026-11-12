case $- in
  *i*) ;;
  *) return ;;
esac

# No Fedora isto pode vir de /etc/profile.d; no Ubuntu, carregue explicitamente.
if [[ -z ${BASH_COMPLETION_VERSINFO:-} ]]; then
  if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
  elif [[ -r /etc/bash_completion ]]; then
    source /etc/bash_completion
  fi
fi
if [[ -r "$HOME/.inputrc" ]]; then
  bind -f "$HOME/.inputrc"
fi
