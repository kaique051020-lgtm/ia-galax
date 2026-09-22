# Galax AI Studio Plugin

Projeto original para Roblox Studio inspirado em ferramentas de criação assistida por IA. Ele cria GUIs por comandos em português, usa templates locais e foi preparado para receber um backend de IA no futuro.

> Não é uma cópia do ForgeGUI/ForgeUI e não inclui código ou assets proprietários.

## O que já funciona

- Painel dockável dentro do Roblox Studio.
- Comandos locais: `menu`, `loja`, `inventario`, `hud` e `limpar`.
- Criação automática no `StarterGui`.
- Temas neon, escuro, claro e medieval.
- Layout responsivo usando `Scale`.
- Geração de LocalScripts simples para botões.
- Modo de simulação de IA: interpreta frases como `crie uma loja neon roxa`.

## Estrutura

```text
src/
  Plugin.server.lua       -- ponto de entrada do plugin
  GuiBuilder.lua          -- cria objetos Roblox
  CommandParser.lua       -- interpreta comandos locais
  Templates.lua           -- layouts prontos
  Theme.lua               -- cores e estilo
  CodeGenerator.lua       -- scripts Luau básicos
  Security.lua            -- validação de respostas externas
rojo.project.json         -- projeto Rojo opcional
backend/
  README.md               -- contrato para conectar uma IA real
  server.example.js       -- servidor de exemplo (não usa chave real)
docs/
  INSTALACAO.md
  TRANSFORMAR-EM-PLUGIN.md
  COMANDOS.md
```

## Instalação rápida sem backend

1. Instale o Roblox Studio.
2. Abra um lugar de teste.
3. Siga `docs/TRANSFORMAR-EM-PLUGIN.md`.
4. No painel, digite `crie menu neon roxo` e clique em **Gerar**.

## Próximos passos

Para geração real por IA, implemente um backend separado conforme `backend/README.md`. Nunca coloque uma chave de OpenAI, Gemini ou outro provedor no plugin distribuído.

## Aviso de segurança

Revise todo script gerado antes de executar. O plugin não deve inserir `require` de IDs desconhecidos, código ofuscado, backdoors, loaders remotos ou comandos que apaguem o projeto.
