# Teclado opcional por computador

Somente a configuração que estava ativa foi incluída:

- Layout GNOME `us+intl` (US International).
- `.XCompose` personalizado, com acentos e cedilha.
- Nenhuma opção XKB adicional.

O instalador principal não ativa este módulo por padrão. No notebook, omita
`--keyboard`; no PC com o teclado externo, use essa opção se precisar reinstalar.
Essas preferências são da sessão do usuário, não uma detecção automática por USB.
O remapeamento antigo do Machinike não faz parte do repositório.

```bash
bash install.sh --apply --keyboard
# Para restaurar as preferências anteriores:
bash optional/keyboard/disable.sh
```

O módulo é para Linux/GNOME. Não configura o teclado do Windows.
