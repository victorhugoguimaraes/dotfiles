# Neovim

Minha configuração do Neovim para programar, escrever em LaTeX e fazer anotações.
Uso LazyVim com tema One Dark e o Codex em um terminal lateral.

Tem suporte a C, C++, Rust, Python, TypeScript e Aiken. O LaTeX recompila ao
salvar e abre o PDF no Evince. O Markdown tem visualização no editor e preview
no navegador.

## Atalhos

Pressione no modo normal. `Espaço` é a tecla líder.

| Atalho | Ação |
| --- | --- |
| `Espaço a c` | Abrir ou ocultar o Codex |
| `Espaço l c` | Iniciar ou parar a compilação LaTeX |
| `Espaço l v` | Abrir o PDF |
| `Espaço l e` | Ver erros de compilação |
| `Espaço m p` | Abrir ou parar o preview Markdown |
| `gd` / `K` | Ir à definição / consultar documentação |

## Instalação

Faz parte dos meus [dotfiles](https://github.com/victorhugoguimaraes/dotfiles).
Os comandos de instalação estão no README principal.

Precisa de Neovim 0.12.4 ou superior e Node.js. Para LaTeX, use uma distribuição
TeX, `latexmk` e Evince. Para a IA, instale o Codex CLI e entre na sua conta.
