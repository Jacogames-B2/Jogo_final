# CicloOuro

Jogo de aventura narrativo point-and-click desenvolvido em **Godot 4.6** com GDScript.

---

## Enredo

Jacobina, Brasil. Uma cidade construída sobre minas de ouro abandonadas da empresa **Ciclo-Ouro**.

**Elias Barreto** descobriu que a empresa perfurou ilegalmente muito além do permitido — os túneis se ramificam por quilômetros sob a cidade, sem registro. A estrutura está cedendo. Ninguém acredita nele.

Após ser detido por causar pânico num bar, a polícia lhe dá uma chance improvável:

> *"48 horas. A segurança da mina vai estar desligada. Se você tá tão certo… vai lá e prova."*

Você tem 48 horas para entrar na mina, encontrar as evidências e sair — se conseguir.

---

## Tecnologia

| | |
|---|---|
| Engine | Godot 4.6 |
| Linguagem | GDScript |
| Renderer | Forward Plus |
| Physics | Jolt Physics |
| Diálogo | [Dialogue Manager v3.10.3](https://github.com/nathanhoad/godot_dialogue_manager) (Nathan Hoad) |

---

## Como Abrir o Projeto

1. Instale o **Godot 4.6** (versão estável)
2. Abra o Godot e selecione **Import**
3. Navegue até a pasta do projeto e selecione `project.godot`
4. Na primeira abertura, confirme a reimportação de assets
5. Verifique em **Project → Project Settings → Autoload** que os seguintes singletons estão registrados:
   - `Global` → `Scripts/Auxiliar/Global.gd`
   - `DialogueManager` → `addons/dialogue_manager/dialogue_manager.gd`
   - `InventoryManager` → `Scripts/Auxiliar/InventoryManager.gd`
6. Pressione **F5** para rodar, ou abra `Cenas/teste/node_2d.tscn` para a cena de teste

---

## Cena de Teste

Para testar todos os sistemas implementados, abra e execute `Cenas/teste/node_2d.tscn`.

### O que testar

| Sistema | Como testar |
|---|---|
| **Diálogo** | Clique no NPC (ícone Godot) — inicia a conversa do Bar da Codorna com escolhas |
| **Coletar item** | Clique na **Pedra** ou na **Chave** — aparecem no inventário |
| **Inventário** | Arraste slots para reordenar itens |
| **Soltar item** | Botão direito do mouse em um slot ocupado |
| **Porta com chave** | Com a Chave no inventário, clique na Porta — ela some e a passagem abre |

### Controles

| Ação | Controle |
|---|---|
| Coletar item | Clique esquerdo no item |
| Falar com NPC | Clique esquerdo no NPC |
| Avançar diálogo | Clique esquerdo no balloon / Enter |
| Escolher resposta | Clique na opção |
| Reordenar inventário | Arrastar slot para outro slot |
| Descartar item | Botão direito no slot |
| Usar chave na porta | Clique esquerdo na porta (chave deve estar no inventário) |

---

## Sistemas Implementados

### Diálogo
- Baseado no Dialogue Manager v3.10.3
- Suporte a múltiplos personagens, ramificações, variantes aleatórias
- Arquivo `dialogos/teste1.dialogue` contém o Ato 1 completo (3 finais possíveis)
- Qualquer objeto `Area2D` com `click.gd` pode disparar um diálogo

### Inventário
- 4 slots em grade
- Drag-and-drop para reordenar itens
- Botão direito para descartar
- Cursor personalizado (mão aberta/fechada)
- Tooltip com nome do item ao passar o mouse

### Coleta de Itens
- Itens no mundo são `Area2D` com `item_coletavel.gd`
- Clicar no item o adiciona ao primeiro slot livre do inventário
- Item some do mundo após coleta

### Sistema de Porta
- Porta é `StaticBody2D` com `static_body_2d.gd`
- Ao clicar: verifica se o inventário contém item com `id = "Chave"`
- Com a chave: item é consumido, colisão desativada, porta some
- Sem a chave: mensagem no console ("Porta trancada")

---

## Estrutura Narrativa

O jogo é dividido em 5 atos (ver `Roteiro.txt` para detalhes):

```
Ato 1 — Bar da Codorna   → Elias é detido
Ato 2 — Delegacia        → 48 horas concedidas
Ato 3 — Casa de Elias    → Tutorial de inventário
Ato 4 — Superfície       → Puzzle para acessar a mina
Ato 5 — Mina             → Exploração, horror e revelação
```

Mapa do mundo em `SUPERFÍCIE HUB Cidade.txt`.

---

## Estado do Desenvolvimento

- [x] Pipeline de diálogo funcional
- [x] Inventário com drag-and-drop
- [x] Coleta de itens por clique
- [x] Sistema de porta com chave
- [x] Cena de teste integrada
- [ ] Assets visuais (sprites, tilesets, animações)
- [ ] Player com movimentação
- [ ] Diálogos de todas as cenas
- [ ] Áudio e música
- [ ] Sistema de puzzles
- [ ] Saves / persistência

---

## Licença

Projeto acadêmico — Turma B2.
