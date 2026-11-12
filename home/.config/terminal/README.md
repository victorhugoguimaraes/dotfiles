# Terminal One Dark

Ptyxis com fonte Adwaita Mono Medium 11 e paleta One Dark de alto contraste, combinando com o Neovim.
O Bash usa Starship com pasta, branch e alterações do Git, versão da linguagem
quando relevante e duração de comandos demorados. A seta fica vermelha quando
o comando anterior falha.

Abra uma nova aba para carregar o prompt, ou execute `source ~/.bashrc`.

## Arquivos selecionados para os dotfiles

- `.bashrc` e `.bash_profile`: inicialização do Bash.
- `.bashrc.d/90-appearance.sh`: integração do Starship e aliases `ll` e `la`.
- `.config/starship.toml`: aparência do prompt.
- `.config/terminal/apply-ptyxis.sh`: aplica as preferências do terminal.
- `.local/share/org.gnome.Ptyxis/palettes/one-dark-victor.palette`: cores.
- `.config/nvim/`: configuração do editor e lista de versões dos plugins.

Em outra máquina, instale Starship, copie a paleta e execute
`bash ~/.config/terminal/apply-ptyxis.sh`. O script detecta o perfil padrão
sem armazenar o identificador do perfil deste computador.

Dotfiles são arquivos de configuração, geralmente ocultos por começarem com
um ponto. Um repositório Git permite manter versões e reinstalar esse ambiente
em outra máquina. Um instalador pode criar links simbólicos dos arquivos do
repositório para seus locais corretos no diretório pessoal.

Senhas, tokens, credenciais do Codex, chaves SSH, históricos, caches e documentos
pessoais não entram nesse repositório. Os backups anteriores desta configuração
ficam em `~/.local/state/terminal/backups/` e também não precisam ser publicados.

O repositório local está em `~/dotfiles`.

Tab completa caminhos e percorre candidatos; Shift+Tab percorre no sentido
contrário. `source ~/.bashrc` aplica o prompt e o completamento na sessão atual.

Referência do prompt: <https://starship.rs/config/>.
