# Comandos disponíveis

Digite no painel Galax AI:

- `crie um menu escuro`
- `crie uma loja neon roxa`
- `crie um inventário medieval`
- `crie um hud claro`
- `crie uma loja futurista`

O parser local identifica o tipo por palavras-chave. A integração com IA real poderá retornar um JSON normalizado, por exemplo:

```json
{
  "kind": "shop",
  "theme": "neon",
  "title": "LOJA FUTURISTA",
  "elements": [
    {"type": "button", "text": "Comprar"}
  ]
}
```

Não execute código arbitrário vindo da IA. Converta sempre o JSON em uma lista permitida de classes, propriedades e ações.
