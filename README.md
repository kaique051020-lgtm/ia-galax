# Galax AI Studio

Projeto original para Roblox Studio com foco em criar interfaces de jogo com IA local e arquitetura pronta para backend real.

Este projeto foi pensado como uma base melhorada e mais segura do que um gerador básico de templates: ele separa parsing, schema, geração visual, regras de segurança e integração futura com IA externa.

## Objetivo principal

Criar uma ferramenta original para Roblox Studio que:

- entende pedidos em português;
- converte prompts em um schema estruturado;
- monta GUIs com objetos Roblox;
- gera scripts básicos em Luau;
- permite conexão com backend de IA em um segundo passo;
- nunca executa código remoto ou chaves secretas dentro do plugin.

## Diferencial da arquitetura

A ideia não é apenas "escolher um template pronto". A arquitetura foi montada para ficar próxima do que uma IA real faria:

1. Prompt do usuário
2. Parser analisa intenção, estilo, plataforma e tipo de tela
3. Engine cria um schema de UI
4. Builder cria objetos reais no Roblox Studio
5. Generator produz código de apoio
6. Security valida tudo antes de aceitar
7. Backend externo pode substituir a camada local quando necessário

## Estrutura da base atual

```text
src/
  Plugin.server.lua
  GenerationEngine.lua
  GuiBuilder.lua
  CommandParser.lua
  Templates.lua
  Theme.lua
  CodeGenerator.lua
  Security.lua
backend/
  README.md
  server.example.js
docs/
  INSTALACAO.md
  TRANSFORMAR-EM-PLUGIN.md
  COMANDOS.md
README.md
rojo.project.json
```

## Como funciona agora

O plugin reconhece textos como:

- `crie um menu neon roxo`
- `faça uma loja medieval`
- `construa um inventário com 3 slots`
- `quero um hud futurista`
- `crie uma tela de login moderna`

Ele transforma isso em uma estrutura tipo:

```lua
{
  kind = "shop",
  theme = "purple",
  title = "LOJA",
  platform = "desktop",
  elements = {
    { type = "label", text = "Seus itens" },
    { type = "button", text = "Comprar" },
    { type = "button", text = "Sair" }
  }
}
```

E então cria a GUI real no `StarterGui`.

## Diferencial em relação a ferramentas simples

Este projeto foi desenhado para evoluir de modo original:

- parser inteligente de texto;
- schema normalizado;
- múltiplos tipos de UI;
- temas configuráveis;
- scripts via gerador seguro;
- integração pronta para backend externo.

## Próximo nível

A próxima etapa é substituir o motor local por um backend com IA real, mantendo `Security` e `SchemaValidator` como camada obrigatória.

Nunca exponha chaves de IA no plugin. Use um servidor separado, com autenticação, rate limit e validação de schema antes de devolver qualquer resposta ao Studio.
