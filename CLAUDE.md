# CLAUDE.md — CicloOuro (Turma B2)

## Visão Geral do Projeto

**CicloOuro** é um jogo de aventura narrativo point-and-click desenvolvido em Godot 4.6 com GDScript. O jogo se passa em Jacobina, uma cidade construída sobre minas de ouro abandonadas da empresa "Ciclo-Ouro". O protagonista, Elias Barreto, tem 48 horas para provar que a empresa perfurou ilegalmente e ameaça a estrutura da cidade.

**Gênero:** Aventura narrativa investigativa (point-and-click)  
**Estágio:** Início de desenvolvimento — pipeline de diálogo funcional, assets visuais ainda não criados  
**Idioma:** Português (Brasil)

---

## Estrutura de Diretórios

```
turma-b-2/
├── Artes/                        # Assets visuais (vazio — apenas placeholders)
│   ├── Animaçoes/
│   └── TileSets/
├── Cenas/                        # Cenas Godot (.tscn)
│   ├── cena_principal.tscn       # Cena de entrada — contém ObjetoClicavel instanciado
│   ├── Itens/                    # Objetos interativos reutilizáveis
│   │   ├── click.tscn            # Objeto clicável (dispara diálogo ao clicar)
│   │   ├── item_coletavel.tscn
│   │   └── transicao_de_sala.tscn
│   ├── Mapas/
│   │   └── mapa_1.tscn           # Primeira fase (mina)
│   └── Personagens/
│       └── player.tscn
├── Scripts/                      # GDScript
│   ├── Auxiliar/                 # Singletons e utilitários globais
│   │   ├── Global.gd             # Singleton global (placeholder)
│   │   ├── ItemData.gd           # Resource class para definição de itens
│   │   └── InventoryManager.gd
│   ├── Itens/
│   │   ├── click.gd              # Dispara diálogo em "inicio" de teste.dialogue
│   │   ├── item_coletavel.gd
│   │   └── transicao_de_sala.gd
│   ├── Mapas/
│   │   └── mapa_1.gd
│   ├── Personagens/
│   │   └── player.gd
│   └── cena_principal.gd
├── dialogos/                     # Todos os arquivos de diálogo e balloon UI
│   ├── balloon.tscn              # Balloon de diálogo do jogo (gerado pelo plugin)
│   ├── balloon.gd                # Script do balloon (customizável)
│   ├── dialogue_label.tscn       # Componente de texto animado
│   ├── example_balloon.tscn      # Referência — não usar diretamente
│   └── teste.dialogue            # Diálogo de teste com 5 títulos
├── addons/dialogue_manager/      # Plugin: Dialogue Manager v3.10.3 (Nathan Hoad)
├── dialog_manager/               # IGNORAR — cópia antiga Godot 3 (v1.19.2), não usada
├── Roteiro.txt                   # Roteiro narrativo completo (5 atos)
├── SUPERFÍCIE HUB Cidade.txt     # Mapa do mundo / estrutura de níveis
└── project.godot
```

---

## Engine e Configuração

- **Godot:** 4.6
- **Renderer:** GL Compatibility
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

### Configuração do Dialogue Manager

- **Balloon path:** `res://dialogos/balloon.tscn` (definido em `[dialogue_manager]` no `project.godot`)
- Isso significa que `DialogueManager.show_dialogue_balloon()` sempre instancia `dialogos/balloon.tscn`
- Para customizar o visual do balloon, editar `dialogos/balloon.gd` e `dialogos/balloon.tscn`

---

## Sistemas Implementados

### Diálogo (Dialogue Manager v3.10.3)

- Arquivos `.dialogue` ficam em `res://dialogos/`
- Títulos usam `~`, respostas usam `-`, jumps usam `=>`
- Variantes aleatórias: `[[opção1|opção2|opção3]]`
- Chamada em código: `DialogueManager.show_dialogue_balloon(load("res://dialogos/arquivo.dialogue"), "titulo")`
- Exemplo ativo: `Scripts/Itens/click.gd` → abre `teste.dialogue` no título `inicio`

**Estrutura de `teste.dialogue` (5 títulos):**
```
~ inicio       → pergunta com 3 respostas, texto aleatório
~ reacao_positiva
~ reacao_neutra
~ segredo      → usa "Narrador:" como segundo personagem
~ despedida    → texto aleatório, => END
```

### Inventário (`InventoryManager.gd`)
- 4 slots: `slots: Array = [null, null, null, null]`
- Signal: `inventario_atualizado`
- Método: `adicionar_item(item: ItemData) -> bool`

### Itens (`ItemData.gd`)
- Resource class: `nome`, `iconee` (Texture2D), `empilhavel` (bool), `max_stack` (int)

### Interação (click.gd / transicao_de_sala.gd)
- Objetos clicáveis: `Area2D` + sinal `input_event` + cheque `MOUSE_BUTTON_LEFT`
- `transicao_de_sala.gd`: troca cena via `get_tree().change_scene_to_file()`

### Player (`player.gd`)
- Extends `CharacterBody2D` — `SPEED = 300.0`, `JUMP_VELOCITY = -400.0`
- Movimento: setas; pulo: Espaço

---

## Padrões de Código

- Scripts espelham estrutura de `Cenas/` dentro de `Scripts/`
- Objetos interativos: `Area2D` + sinal `input_event`
- Novos itens: criar `.tres` Resource extendendo `ItemData`
- Novos diálogos: criar `.dialogue` em `res://dialogos/`, referenciar em `click.gd` ou similar
- O título de entrada do diálogo deve ser nomeado semanticamente (ex: `inicio`, `bar_abertura`) — não usar `start`

---

## Narrativa (Referência Rápida)

O roteiro completo está em `Roteiro.txt`. Estrutura dos 5 atos:

1. **Ato 1 — Bar da Codorna:** Elias é preso ao denunciar o perigo
2. **Ato 2 — Delegacia:** Polícia concede 48h e acesso à mina
3. **Ato 3 — Casa de Elias:** Tutorial — coleta suprimentos (lanterna, rádio, mapa, ferramentas)
4. **Ato 4 — Superfície:** Puzzles para desativar segurança e entrar na mina
5. **Ato 5 — Mina:** Exploração com horror atmosférico e descoberta do "Núcleo Profundo"

A estrutura do mundo está em `SUPERFÍCIE HUB Cidade.txt`.

---

## O que ainda não foi implementado

- Assets visuais (sprites, tilesets, animações) — `Artes/` está vazio
- Lógica de coleta de itens (`item_coletavel.gd` é placeholder)
- `Global.gd` e `cena_principal.gd` são placeholders vazios
- `mapa_1.gd` é placeholder vazio
- Sistema de puzzles
- Áudio/música
- Diálogos reais da narrativa (apenas `teste.dialogue` existe)
