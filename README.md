# CicloOuro (Godot)

Jogo point-and-click de investigação ambientado em uma operação de mina abandonada na cidade de Jacobina. O jogador explora o local, encontra pistas e monta a verdade por trás do fechamento.

## Sistema de Arquivos

```
├─ Artes/                # Assets organizados por categoria
│  ├─ Itens/
│  ├─ Personagens/
│  └─ TileSet/
├─ Cenas/                # Scenes (.tscn)
│  ├─ Itens/
│  ├─ Mapas/
│  └─ Personagens/
├─ Scripts/              # Scripts GDScript (.gd)
│  ├─ Aux/
│  ├─ Itens/
│  ├─ Mapas/
│  └─ Personagens/
├─ project.godot         # Configuração do projeto
├─ icon.svg              # Ícone do projeto
└─ icon.svg.import       # Metadados de importação do Godot
```

## Como Rodar

1. Abra o Godot e clique em `Import`.
2. Selecione a pasta do projeto e escolha o arquivo `project.godot`.
3. Abra a cena principal em `Cenas/cena_principal.tscn`.
4. Pressione `F5` para rodar o projeto.

## Próximos Passos

1. Definir o loop principal (explorar, coletar pistas, resolver enigmas).
2. Montar cenas adicionais (entrada da mina, galeria, sala de controle).
3. Implementar interações de clique e uma UI de inventário/registro de pistas.
4. Adicionar áudio ambiente e efeitos visuais para o clima de mistério.
5. Criar um vertical slice curto e playtestar ritmo e clareza.
