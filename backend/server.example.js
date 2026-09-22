import express from "express";

const app = express();
app.use(express.json({ limit: "32kb" }));

const allowedKinds = new Set(["menu", "shop", "inventory", "hud"]);
const allowedThemes = new Set(["dark", "purple", "neon", "light", "medieval"]);

app.post("/generate", async (req, res) => {
  const prompt = typeof req.body?.prompt === "string" ? req.body.prompt.slice(0, 2000) : "";
  if (!prompt) return res.status(400).json({ error: "prompt obrigatório" });

  // TODO: chamar seu provedor de IA aqui, usando process.env.AI_API_KEY.
  // Exija JSON estruturado e valide antes de responder ao plugin.
  const result = { kind: "menu", theme: "dark", title: "MENU PRINCIPAL", elements: [] };
  if (!allowedKinds.has(result.kind) || !allowedThemes.has(result.theme)) {
    return res.status(422).json({ error: "resposta fora do schema" });
  }
  return res.json(result);
});

app.listen(process.env.PORT || 3000, () => console.log("Galax backend online"));
