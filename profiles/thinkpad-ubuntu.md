# ThinkPad E14 Gen 2 — Ubuntu

Intel Core i5 de 11ª geração e 16 GB de RAM. O teclado personalizado do desktop
não é ativado neste perfil.

```bash
bash scripts/dependencies.sh
bash install.sh --apply --study --terminal
```

O primeiro comando apenas mostra os pacotes necessários. Para instalá-los,
execute `bash scripts/dependencies.sh --apply` na própria máquina.
Depois, abra o Neovim: o Mason instala os servidores de linguagem configurados.
É necessário Node.js e um Neovim compatível com os plugins; a configuração
atual do VimTeX exige Neovim 0.12.4 ou superior. Não presuma que o pacote
`neovim` do Ubuntu atende a essa versão.

O terminal do notebook pode ser GNOME Terminal em vez de Ptyxis. A integração
do Bash/Starship funciona nos dois. O módulo `--terminal` detecta os esquemas
disponíveis e aplica o tema no perfil padrão, com preferência pelo Ptyxis
se ambos estiverem instalados.
Se Adwaita Mono não existir, o script do tema usa a fonte Monospace.

Para a simulação, a documentação do UnBall2D pede Ubuntu e aceita
`UNBALL_BUILD_JOBS=2 ./scripts/instalar-ambiente.sh` para limitar o paralelismo.
Esse valor é uma opção conservadora para começar no notebook; ajuste conforme
o consumo medido. O clangd também usa dois trabalhadores de indexação.
Nenhum limite global de CPU, swap ou energia é alterado pelos dotfiles.
