# Backend opcional

O plugin local foi feito para funcionar sem backend. Para adicionar uma IA real, crie um servidor separado que:

1. Receba o prompt do usuário.
2. Envie o prompt para o provedor de IA usando uma variável de ambiente.
3. Peça uma resposta JSON no schema permitido.
4. Valide o JSON no servidor.
5. Retorne apenas dados de GUI, nunca código executável arbitrário.

Nunca coloque `OPENAI_API_KEY`, `GEMINI_API_KEY` ou qualquer segredo em Luau/plugin. Plugins distribuídos podem ser inspecionados.

O plugin deverá chamar somente seu endpoint HTTPS e validar a resposta novamente com `Security.validateGeneratedText`/um validador equivalente. Para produção, adicione autenticação, rate limit, logs sem prompts sensíveis e limite de tamanho.
