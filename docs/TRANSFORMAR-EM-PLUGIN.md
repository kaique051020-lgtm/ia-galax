# Transformando em plugin

## Método recomendado: Rojo

1. Instale o [Rojo](https://rojo.space/).
2. No terminal, entre na pasta do projeto.
3. Execute `rojo serve`.
4. No Roblox Studio, instale o plugin do Rojo e conecte ao projeto.
5. O `Plugin.server.lua` aparecerá em `ServerScriptService` durante o desenvolvimento.
6. Teste os comandos no painel **Galax AI**.
7. Quando terminar, gere um arquivo `.rbxm`/plugin pela ferramenta de build do Rojo ou copie a árvore para um plugin local.

## Método manual

1. No Roblox Studio, abra **Plugins > New Plugin** ou crie um plugin local.
2. Crie um Script principal chamado `GalaxAIPlugin`.
3. Cole o conteúdo de `src/Plugin.server.lua` nele.
4. Dentro do script, crie uma Folder chamada `GalaxModules`.
5. Para cada arquivo de `src/`, crie um `ModuleScript` com o mesmo nome e cole seu conteúdo.
6. Verifique se `GuiBuilder`, `CommandParser`, `Templates`, `Theme`, `CodeGenerator` e `Security` são filhos de `GalaxModules`.
7. Salve o plugin e reabra o Studio.

## Observações

- O código cria a GUI em `StarterGui`, não no jogo publicado automaticamente.
- O primeiro protótipo funciona sem internet e sem API.
- Em uma versão distribuída, não use chaves secretas dentro de Scripts do plugin.
- Faça backup do lugar antes de testar geradores externos.
