# CLAUDE.md — CicloOuro (Turma B2)

## Visão Geral do Projeto

**CicloOuro** é um jogo de aventura narrativo point-and-click desenvolvido em Godot 4.6 com GDScript. O jogo se passa em Jacobina, uma cidade construída sobre minas de ouro abandonadas da empresa "Ciclo-Ouro". O protagonista, Elias Barreto, tem 48 horas para provar que a empresa perfurou ilegalmente e ameaça a estrutura da cidade.

**Gênero:** Aventura narrativa investigativa (point-and-click)  
**Estágio:** Desenvolvimento ativo — pipeline de diálogo funcional, inventário com drag-and-drop, sistema de porta com chave  
**Idioma:** Português (Brasil)

---

## Estrutura de Diretórios

```
novo-projeto-de-jogo/
├── Artes/                          # Assets visuais (maioria vazia)
│   └── Captura de tela de 2026-04-22 14-30-34.png  # Fundo usado no Parallax2D
├── Cenas/
│   ├── cena_principal.tscn         # Cena de entrada (apenas ObjetoClicavel por hora)
│   ├── cena_inicial.tscn           # Cena inicial vazia (CanvasLayer placeholder)
│   ├── Item/                       # ← Pasta ativa de desenvolvimento (singular)
│   │   ├── click.tscn              # Objeto clicável → dispara diálogo
│   │   ├── item_coletavel.tscn     # Item coletável (click → adiciona ao inventário)
│   │   ├── porta.tscn              # Porta (StaticBody2D) — abre com chave
│   │   ├── Parallax2D.tscn         # Cena de jogo com parallax, câmera e transições
│   │   ├── transicao_de_sala.tscn  # Gatilho de troca de cena (entrada direita)
│   │   ├── transicao_de_sala_2.tscn # Gatilho de troca de cena (saída esquerda)
│   │   └── item/                   # Recursos de itens (.tres)
│   │       ├── chave.tres          # Chave (id="Chave") — abre portas
│   │       ├── Pedra.tres          # Pedra (id="Pedra")
│   │       ├── Madeira.tres        # Madeira (id="Madeira")
│   │       └── Machado.tres        # Machado (id="Machado") — resultado de fusão
│   ├── Itens/                      # Pasta legada (plural) — duplicatas, usar Item/
│   │   ├── click.tscn
│   │   ├── item_coletavel.tscn
│   │   ├── Parallax2D.tscn
│   │   ├── transicao_de_sala.tscn
│   │   └── item/                  # Pedra.tres, Madeira.tres, Machado.tres (sem chave)
│   ├── Mapas/
│   │   └── mapa_1.tscn             # Primeira fase (TileMapLayer placeholder)
│   ├── Personagens/                # Vazio (player.tscn não existe ainda)
│   ├── teste/
│   │   └── node_2d.tscn            # Cena de teste: diálogo + inventário + porta
│   └── ui/
│       ├── inventario.tscn         # UI do inventário (Panel 4 slots, drag-and-drop)
│       └── canvas_layer.tscn       # CanvasLayer contendo o inventário
├── Scripts/
│   ├── cena_principal.gd           # Placeholder vazio
│   ├── static_body_2d.gd           # Porta placeholder (usa feijao_com_farinha bool)
│   ├── Auxiliar/
│   │   ├── Global.gd               # Singleton global (placeholder vazio)
│   │   ├── ItemData.gd             # Resource class para definição de itens
│   │   ├── InventoryManager.gd     # Inventário singleton alternativo (fusão de itens)
│   │   └── game_manager.gd         # GameManager (score/win — não conectado ao jogo)
│   ├── Itens/
│   │   ├── click.gd                # Dispara DialogueManager.show_dialogue_balloon()
│   │   ├── item_coletavel.gd       # Click → inventario.adicionar_item(item_data)
│   │   ├── static_body_2d.gd       # Script da porta — verifica chave no inventário
│   │   └── transicao_de_sala.gd    # Troca de cena ao clicar
│   ├── Mapas/
│   │   ├── mapa_1.gd               # Placeholder vazio
│   │   └── parallax_2d.gd          # Parallax2D com câmera e change_offset()
│   └── Ui/
│       ├── inventario.gd           # class_name Inventory — Panel com 4 slots
│       └── slot_1.gd               # Slot individual: drag-and-drop, botão direito solta
├── dialogos/
│   ├── balloon.tscn                # Balloon de diálogo (gerado pelo plugin)
│   ├── balloon.gd                  # Script do balloon (customizável)
│   ├── dialogue_label.tscn         # Componente de texto animado
│   ├── example_balloon.tscn        # Referência — não usar diretamente
│   ├── teste.dialogue              # Diálogo simples (5 títulos, teste básico)
│   ├── teste1.dialogue             # Diálogo completo Ato 1 — Bar da Codorna
│   └── teste2.dialogue             # Diálogo completo Ato 1 — versão alternativa
├── addons/dialogue_manager/        # Plugin: Dialogue Manager v3.10.3 (Nathan Hoad)
├── dialog_manager/                 # IGNORAR — cópia Godot 3 (v1.19.2), não usada
├── Roteiro.txt                     # Roteiro narrativo completo (5 atos)
├── SUPERFÍCIE HUB Cidade.txt       # Mapa do mundo / estrutura de níveis
└── project.godot
```

---

## Engine e Configuração

- **Godot:** 4.6
- **Renderer:** Forward Plus (declarado em `config/features` no project.godot)
- **Physics:** Jolt Physics
- **Cena principal:** `res://Cenas/cena_principal.tscn`
- **Plugin ativo:** `res://addons/dialogue_manager/plugin.cfg`

### Autoloads (Singletons)

| Nome | Arquivo |
|---|---|
| `Global` | `Scripts/Auxiliar/Global.gd` |
| `ItemData` | `Scripts/Auxiliar/ItemData.gd` |
| `DialogueManager` | `addons/dialogue_manager/dialogue_manager.gd` |
| `InventoryManager` | `Scripts/Auxiliar/InventoryManager.gd` |

> **Nota:** Os autoloads precisam estar registrados pelo editor Godot (Project → Project Settings → Autoload). O `project.godot` no repositório pode não refletir os autoloads se editado fora do editor.

### Configuração do Dialogue Manager

- **Balloon path:** `res://dialogos/balloon.tscn` (definido em `[dialogue_manager]` no `project.godot`)
- `DialogueManager.show_dialogue_balloon(resource, "titulo")` instancia `dialogos/balloon.tscn`
- Para customizar o visual, editar `dialogos/balloon.gd` e `dialogos/balloon.tscn`

---

## Sistemas Implementados

### Diálogo (Dialogue Manager v3.10.3)

- Arquivos `.dialogue` ficam em `res://dialogos/`
- Títulos usam `~`, respostas usam `-`, jumps usam `=>`
- Variantes aleatórias: `[[opção1|opção2|opção3]]`
- Chamada em código: `DialogueManager.show_dialogue_balloon(load("res://dialogos/arquivo.dialogue"), "titulo")`
- `click.gd` dispara o diálogo ao clicar no `Area2D`; `dialogue_file` e `dialogue_title` são exportados e configuráveis no editor

**Arquivos de diálogo:**
- `teste.dialogue` — diálogo básico de teste (5 títulos, 3 respostas)
- `teste1.dialogue` — Ato 1 completo: Bar da Codorna, 3 finais possíveis
- `teste2.dialogue` — variante do Ato 1 com formatação diferente

### Inventário (scene-based, `Scripts/Ui/`)

O inventário ativo usa a cena `Cenas/ui/inventario.tscn` e é passado por referência de nó (não via singleton).

- **`inventario.gd`** (`class_name Inventory extends Panel`) — 4 slots em GridContainer
  - `@export var slots: Array[Panel]` — preenchido na cena
  - `adicionar_item(item: ItemData) -> bool` — adiciona no primeiro slot livre
  - `_notification` — detecta drag-begin/end, restaura ícone se drop falhar
- **`slot_1.gd`** (`extends Panel`) — cada slot individual
  - `@export var item: ItemData` — item atual no slot
  - `update_ui()` — sincroniza ícone e tooltip
  - `_get_drag_data` / `_can_drop_data` / `_drop_data` — drag-and-drop entre slots
  - `_gui_input` — **botão direito** remove o item do slot

> **Atenção:** O `InventoryManager.gd` (singleton) é um sistema alternativo com lógica de fusão de itens. Não é usado pelo pipeline principal da cena de teste.

### Itens (`ItemData.gd`)

Resource class com campos:
- `id: String` — identificador único (ex: `"Chave"`, `"Pedra"`)
- `nome: String` — nome exibido no tooltip
- `iconee: Texture2D` — ícone no inventário
- `empilhavel: bool` / `max_stack: int` — para futuras stacks

Recursos existentes em `Cenas/Item/item/`: `chave.tres`, `Pedra.tres`, `Madeira.tres`, `Machado.tres`

### Sistema de Porta com Chave

- **`Cenas/Item/porta.tscn`** — `StaticBody2D` com `CollisionShape2D`
- **`Scripts/Itens/static_body_2d.gd`** — script da porta:
  - `@export var inventario: Inventory` — referência ao nó de inventário
  - `@export var id_chave: String = "Chave"` — id do item que abre a porta
  - Ao clicar: verifica se algum slot tem `item.id == id_chave`
  - Se encontrar: remove o item do slot, desativa colisão, esconde a porta
  - Se não encontrar: loga mensagem no console

### Interação (click.gd / transicao_de_sala.gd)

- **`click.gd`**: `Area2D` com `_on_input_event` → `DialogueManager.show_dialogue_balloon()`
  - Exports: `dialogue_file` (path do .dialogue) e `dialogue_title` (título inicial)
- **`transicao_de_sala.gd`**: `Area2D` que chama `get_tree().change_scene_to_file()` ao clicar
- **`item_coletavel.gd`**: virtual `_input_event` → `inventario.adicionar_item(item_data)` + `queue_free()`

### Parallax2D (`Cenas/Item/Parallax2D.tscn`)

Cena de jogo completa com fundo estático (screenshot placeholder), câmera com smoothing e transições de sala em ambos os lados. Usar como base para fases jogáveis.

---

## Cena de Teste (`Cenas/teste/node_2d.tscn`)

Cena abrangente para testar todos os sistemas:

| Elemento | Posição | Função |
|---|---|---|
| NPC (click.tscn) | ~(130, 215) | Clique → inicia `teste1.dialogue` |
| Item Pedra | ~(360, 215) | Clique → adiciona Pedra ao inventário |
| Item Chave | ~(540, 215) | Clique → adiciona Chave ao inventário |
| Porta | ~(675, 230) | Clique com Chave no inventário → abre |
| Inventário | fundo da cena | 4 slots, drag-and-drop, botão direito solta |

**Controles na cena de teste:**
- Clique esquerdo em item → coleta
- Clique esquerdo no NPC → inicia diálogo
- Clique esquerdo na porta → tenta abrir (precisa da chave)
- Arrastar slot → troca de posição com outro slot
- Botão direito no slot → descarta item

---

## Padrões de Código

- Scripts espelham estrutura de `Cenas/` dentro de `Scripts/`
- Pasta ativa é `Cenas/Item/` (singular) — ignorar `Cenas/Itens/` (plural, legada)
- Objetos interativos: `Area2D` ou `StaticBody2D` + sinal `input_event`
- Novos itens: criar `.tres` em `Cenas/Item/item/` extendendo `ItemData`
- Novos diálogos: criar `.dialogue` em `res://dialogos/`
- Título de entrada do diálogo: nomeado semanticamente (ex: `inicio`, `bar_abertura`) — não usar `start`
- Inventário na cena: usar `Cenas/ui/inventario.tscn` instanciado diretamente; passar ref via NodePath para itens/porta

---

## Narrativa (Referência Rápida)

O roteiro completo está em `Roteiro.txt`. Estrutura dos 5 atos:

1. **Ato 1 — Bar da Codorna:** Elias é preso ao denunciar o perigo
2. **Ato 2 — Delegacia:** Polícia concede 48h e acesso à mina
3. **Ato 3 — Casa de Elias:** Tutorial — coleta suprimentos (lanterna, rádio, mapa, ferramentas)
4. **Ato 4 — Superfície:** Puzzles para desativar segurança e entrar na mina
5. **Ato 5 — Mina:** Exploração com horror atmosférico e descoberta do "Núcleo Profundo"

`teste1.dialogue` contém o diálogo do Ato 1 com 3 finais (mina / desiste / baratas atômicas).

A estrutura do mundo está em `SUPERFÍCIE HUB Cidade.txt`.

---

## O que ainda não foi implementado

- Assets visuais (sprites dos personagens, tilesets, animações) — `Artes/` praticamente vazio
- `Global.gd`, `cena_principal.gd`, `mapa_1.gd` são placeholders vazios
- Sistema de puzzles
- Áudio/música
- Diálogos reais da narrativa nas cenas do jogo (apenas `teste.dialogue`, `teste1.dialogue` e `teste2.dialogue`)
- Player com movimentação (não há `player.tscn` — `Cenas/Personagens/` vazio)
- Fusão de itens via UI (lógica existe em `InventoryManager.gd` mas não está conectada)
- Sistema de saves
- Transições de tela (fade in/out)
