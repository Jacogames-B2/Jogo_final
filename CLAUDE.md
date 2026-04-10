# CLAUDE.md — CicloOuro (Turma B2)

## Visão Geral do Projeto

**CicloOuro** é um jogo de aventura narrativo point-and-click desenvolvido em Godot 4.6 com GDScript. O jogo se passa em Jacobina, uma cidade construída sobre minas de ouro abandonadas da empresa "Ciclo-Ouro". O protagonista, Elias Barreto, tem 48 horas para provar que a empresa perfurou ilegalmente e ameaça a estrutura da cidade.

**Gênero:** Aventura narrativa investigativa (point-and-click)  
**Estágio:** Início de desenvolvimento (mecânicas básicas implementadas, assets visuais ainda não criados)  
**Idioma:** Português (Brasil)

---

## Estrutura de Diretórios

```
turma-b-2/
├── Artes/                    # Assets visuais (vazio — apenas placeholders)
│   ├── Animaçoes/
│   └── TileSets/
├── Cenas/                    # Cenas Godot (.tscn)
│   ├── cena_principal.tscn   # Cena de entrada do jogo
│   ├── Itens/                # Objetos interativos reutilizáveis
│   │   ├── click.tscn        # Objeto clicável (dispara diálogo)
│   │   ├── item_coletavel.tscn
│   │   └── transicao_de_sala.tscn
│   ├── Mapas/
│   │   └── mapa_1.tscn       # Primeira fase (mina)
│   └── Personagens/
│       └── player.tscn
├── Scripts/                  # GDScript
│   ├── Auxiliar/             # Singletons e utilitários globais
│   │   ├── Global.gd         # Singleton global (placeholder)
│   │   ├── ItemData.gd       # Resource class para definição de itens
│   │   └── InventoryManager.gd
│   ├── Itens/
│   │   ├── click.gd
│   │   ├── item_coletavel.gd
│   │   └── transicao_de_sala.gd
│   ├── Mapas/
│   │   └── mapa_1.gd
│   ├── Personagens/
│   │   └── player.gd
│   └── cena_principal.gd
├── dialogos/                 # Arquivos .dialogue (Dialogue Manager)
│   └── teste.dialogue
├── addons/dialogue_manager/  # Plugin: Dialogue Manager v3.10.3
├── Roteiro.txt               # Roteiro narrativo completo (5 atos)
├── SUPERFÍCIE HUB Cidade.txt # Mapa do mundo / estrutura de níveis
└── project.godot
```

---

## Engine e Configuração

- **Godot:** 4.6
- **Renderer:** GL Compatibility
- **Physics:** Jolt Physics
- **Autoloads (Singletons):**
  - `Global` → `Scripts/Auxiliar/Global.gd`
  - `ItemData` → `Scripts/Auxiliar/ItemData.gd`
  - `DialogueManager` → `addons/dialogue_manager/dialogue_manager.gd`
  - `InventoryManager` → `Scripts/Auxiliar/InventoryManager.gd`
- **Cena principal configurada:** `res://Cenas/cena_principal.tscn`

---

## Sistemas Implementados

### Inventário (`InventoryManager.gd`)
- 4 slots: `slots: Array = [null, null, null, null]`
- Signal: `inventario_atualizado`
- Método: `adicionar_item(item: ItemData) -> bool`

### Itens (`ItemData.gd`)
- Resource class com: `nome`, `iconee` (Texture2D), `empilhavel` (bool), `max_stack` (int)

### Diálogo (Dialogue Manager v3.10.3)
- Plugin por Nathan Hoad
- Arquivos `.dialogue` ficam em `res://dialogos/`
- Chamada: `DialogueManager.show_dialogue_balloon(dialogue_file, "start")`
- Exemplo de uso: `Scripts/Itens/click.gd`

### Interação (click.gd / transicao_de_sala.gd)
- Objetos clicáveis usam `Area2D` + sinal `input_event`
- Click esquerdo dispara diálogo ou troca de cena
- `transicao_de_sala.gd`: troca cena via `get_tree().change_scene_to_file()`

### Player (`player.gd`)
- Extends `CharacterBody2D`
- `SPEED = 300.0`, `JUMP_VELOCITY = -400.0`
- Movimento: setas esquerda/direita; pulo: Espaço
- Contém `AnimatedSprite2D`, `CollisionShape2D`, `Camera2D`

---

## Narrativa (Referência Rápida)

O roteiro completo está em `Roteiro.txt`. Estrutura dos 5 atos:

1. **Ato 1 — Bar da Codorna:** Elias é preso ao denunciar o perigo
2. **Ato 2 — Delegacia:** Polícia concede 48h e acesso à mina
3. **Ato 3 — Casa de Elias:** Tutorial — coleta suprimentos (lanterna, rádio, mapa, ferramentas)
4. **Ato 4 — Superfície:** Puzzles para desativar segurança e entrar na mina
5. **Ato 5 — Mina:** Exploração com elementos de horror atmosférico e descoberta do "Núcleo Profundo"

A estrutura do mundo (Superfície, subníveis da mina) está em `SUPERFÍCIE HUB Cidade.txt`.

---

## Padrões de Código

- Scripts de cenas ficam em `Scripts/` espelhando a estrutura de `Cenas/`
- Objetos interativos (Area2D) usam sinal `input_event` para detectar clique esquerdo (`MOUSE_BUTTON_LEFT`)
- Novos tipos de item: criar como `Resource` estendendo `ItemData`
- Singletons autoloaded são acessados pelo nome (ex: `InventoryManager.adicionar_item(...)`)
- Diálogos novos: adicionar `.dialogue` em `res://dialogos/` e referenciar via `click.gd` ou similar

---

## O que ainda não foi implementado

- Assets visuais (sprites, tilesets, animações) — `Artes/` está vazio
- Lógica de coleta de itens (`item_coletavel.gd` é placeholder)
- `Global.gd` e `cena_principal.gd` são placeholders vazios
- `mapa_1.gd` é placeholder vazio
- Sistema de puzzles
- Áudio/música
- Diálogos reais da narrativa (apenas `teste.dialogue` existe)
