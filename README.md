# Ambiente de estudo e desenvolvimento

Configuração pessoal de Bash, Ptyxis, Starship e Neovim para Engenharia de
Computação, anotações em Markdown, LaTeX e uso do Codex no terminal lateral.
Inclui a configuração de alto contraste do terminal.

No Bash, **Tab** completa caminhos e percorre as sugestões; **Shift+Tab** volta.
Para aplicar mudanças na sessão atual, execute `source ~/.bashrc`.

O terminal usa **Ctrl+C para copiar**, **Ctrl+V para colar** e **Ctrl+G para
interromper comandos**. O módulo interativo do Bash configura `stty intr ^G`;
os atalhos de copiar/colar são aplicados com `--terminal` no Ptyxis ou GNOME
Terminal. Neovim e outros aplicativos em modo raw mantêm seus atalhos internos.

## Instalação por computador

O padrão é uma simulação; não altera arquivos nem instala pacotes:

```bash
bash install.sh
bash scripts/doctor.sh
```

Para instalar os arquivos selecionados, criando links simbólicos e backups:

```bash
bash install.sh --apply --terminal
```

Mantenha esta pasta no disco: os links apontam para ela. Arquivos anteriores
ficam em `~/.local/state/dotfiles/backups/`.
As preferências do Ptyxis ou GNOME Terminal são aplicadas com `--terminal`.
O script não modifica inicialização, partições ou configurações do Windows.
O suporte automatizado atual é Linux/Bash; Windows/WSL precisa de um módulo
próprio conforme o uso real no notebook.

## Opções independentes

| Opção | Uso |
| --- | --- |
| `--terminal` | Aplicar cores e fonte no Ptyxis ou GNOME Terminal |
| `--keyboard` | Ativar US International e o XCompose personalizado |
| `--study` | Aplicar preferências de estudo no Codex |

No notebook, omita `--keyboard`. A opção nunca é ativada automaticamente.
Veja [o módulo de teclado](optional/keyboard/README.md) para desfazer a ativação.
O perfil de estudo é opcional e não inclui credenciais nem escolhe um modelo.
O Codex carrega o arquivo de instruções em uma nova sessão; veja a
[documentação oficial](https://learn.chatgpt.com/docs/agent-configuration/agents-md).

## Estudo e UnBall

O [perfil do ThinkPad Ubuntu](profiles/thinkpad-ubuntu.md) documenta o notebook
sem o teclado opcional. `scripts/dependencies.sh` detecta Fedora ou Ubuntu e
mostra os pacotes de base; só instala com `--apply`.

O Neovim configura clangd (C/C++), rust-analyzer, Pyright (Python), vtsls
(TypeScript/JavaScript), Aiken, Texlab e Marksman. O Mason gerencia esses
servidores no diretório do usuário. Eles iniciam por tipo de arquivo;
as ferramentas de compilação de cada projeto continuam independentes.
`gd` abre a definição, `K` mostra documentação, Espaço `ca` mostra ações e
Espaço `cr` renomeia símbolos. O completamento manual já configurado é preservado.

Para Aiken, o editor executa `aiken lsp`. Respeite a versão exigida pelo
`aiken.toml` do projeto e confira a versão instalada com `aiken --version`.
A configuração do editor não substitui testes de validadores ou revisão
do contrato. Veja a [documentação do Aiken](https://aiken-lang.org/installation-instructions).

Em uma instalação UnBall2D já preparada, execute:

```bash
bash scripts/unball-compilation-db.sh /caminho/do/UnBall2D
```

Isso gera `build/estrategia/compile_commands.json` reutilizando o cache do
CMake e cria um `.clangd` local se nenhum existir. O banco informa ao clangd
os includes e flags reais do projeto.
Não copie esse arquivo entre os computadores: seus caminhos são locais.
Se necessário, aponte um `.clangd` local para ele:

```yaml
CompileFlags:
  CompilationDatabase: build/estrategia
```

O ambiente preserva os comandos e as dependências do projeto. O módulo de IA
orienta explicações com exemplos, unidades, hipóteses e experimentos
reproduzíveis. A instalação de ferramentas específicas da competição deve
seguir a documentação do projeto, sem transformar seus dados em dotfiles.

O diagnóstico lista ferramentas de C/C++, Python, LaTeX e contêineres, sem
instalar pacotes automaticamente. Código dos projetos, pesos, logs, datasets,
resultados de partidas e documentos acadêmicos ficam em seus repositórios
ou pastas próprios.

## Conteúdo do repositório

Esta pasta contém somente configurações selecionadas em `manifest.txt`, o
módulo opcional de teclado e instruções de estudo. Autenticação do Codex,
chaves SSH, histórico, cookies, bancos de dados e caches foram excluídos.
Depois de novas alterações no sistema, atualize as cópias aqui ou use o
instalador para passar a editar diretamente os arquivos por links simbólicos.
