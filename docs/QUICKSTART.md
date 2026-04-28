# Quick Start — primi 60 minuti con Claude Code

> 📍 [README](../README.md) → **Quick Start 60 min**
> 🚀 Workflow · 🟢 Beginner-friendly

> **Obiettivo**: in 60 minuti hai Claude Code installato, autenticato, una sessione attiva su un repo reale, un CLAUDE.md generato, una prima skill custom, un primo hook e un primo `/loop`. Da li' sei autonomo.

Pre-requisiti: macOS, Linux, Windows (con WSL2 o nativo) · Account Claude.ai (Pro o Max consigliato per fast mode + Opus 4.7) o Anthropic API key.

---

## Step 1 — Install (0-5 min)

### macOS / Linux / WSL
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Windows (PowerShell)
```powershell
irm https://claude.ai/install.ps1 | iex
```

### Alternative
```bash
brew install --cask claude-code        # macOS Homebrew
winget install Anthropic.ClaudeCode    # Windows WinGet
```

### Verifica
```bash
claude --version
# Atteso: 2.1.119+ o piu' recente
```

> Se manca: chiudi il terminale, riapri (per ricaricare PATH). Se ancora manca, vedi [02 § install](./02-cli-installazione.md).

---

## Step 2 — Authentication (5-15 min)

### Login con subscription (Pro/Max) — consigliato
```bash
claude auth login
```
Apre browser per OAuth. Pro: rate limit migliori, accesso modelli premium, no per-request cost (Max plan).

### Login con API key
```bash
export ANTHROPIC_API_KEY=sk-ant-...
```
Pro: pay-per-use chiaro, controllo granulare. Contro: nessuna subscription benefit.

### Verifica
```bash
claude auth status
# Atteso: account email + plan
```

> Vedi [18 § authentication precedence](./18-settings-auth.md#185-authentication) per OAuth, Bedrock, Vertex.

---

## Step 3 — Prima sessione (15-30 min)

```bash
cd /percorso/al/tuo/repo    # progetto reale, idealmente con git
claude
```

Ora sei nella sessione interattiva. Prova:

```
/help            # Lista comandi disponibili
/status          # Versione, modello, account
/cost            # Quanto stai consumando
```

### Genera il primo CLAUDE.md

```
/init
```

Claude scansiona il repo, identifica stack/convenzioni, propone un primo CLAUDE.md. Rivedi il file generato (`./CLAUDE.md`), aggiungi le tue regole non negoziabili.

> Per CLAUDE.md piu' ricco: `CLAUDE_CODE_NEW_INIT=1 claude /init` (flow multi-fase). Vedi [06 — CLAUDE.md & memory](./06-claude-md-memory.md).

### Prima conversazione di prova

```
Leggi il README di questo progetto e dimmi quali sono le 3 regole piu' importanti.
```

Claude legge, ragiona, risponde. **Se non capisce qualcosa, te lo dice** — non inventa (anti-hallucination).

> Nota: se vedi "Edit", "Bash" o "Write" tool che chiedono permessi, e' la modalita' default `ask`. Approvi una volta o aggiungi alle allow rules. Vedi [04 — Permessi](./04-modalita-permessi.md).

---

## Step 4 — Prima skill custom (30-40 min)

Crea una skill `release-notes` che genera changelog da git log.

```bash
mkdir -p .claude/skills/release-notes
```

Crea `.claude/skills/release-notes/SKILL.md`:

```yaml
---
name: release-notes
description: Genera release notes da git log dell'ultimo tag
allowed-tools: Bash(git *) Read Write
argument-hint: "[from-tag]"
---

# Release notes generator

Genera release notes leggibili da:
- Tag corrente: !`git describe --abbrev=0 --tags`
- Commit dall'ultimo tag: !`git log $(git describe --abbrev=0 --tags)..HEAD --oneline`

Format Markdown:

## $0..$1

### Features
[lista commit feat:]

### Fixes
[lista commit fix:]

Salva in `RELEASE_NOTES.md`.
```

Test in sessione:
```
/release-notes
```

> Skill = memoria eseguibile. Ne hai create centinaia? Vedi [09 — Skills](./09-skills.md). Marketplace community: [11](./11-plugins-marketplace.md).

---

## Step 5 — Primo hook (40-50 min)

Crea un hook che lancia il linter automaticamente dopo ogni edit.

Crea `.claude/settings.json`:

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [{
          "type": "command",
          "command": "npm run lint:fix 2>/dev/null || true",
          "timeout": 30
        }]
      }
    ]
  }
}
```

> Adatta `npm run lint:fix` al tuo stack (`black .`, `cargo fmt`, ecc).

Da ora ogni Edit lancia il linter — Claude vede l'errore e si autocorregge. **Verification feedback loop** (Boris tip 13: "+2-3x quality").

> Approfondimento: [07 — Hooks](./07-hooks.md). Pattern Authority: [04b § Layer 3](./04b-authority-model.md#layer-3-—-hooks-custom-logic).

---

## Step 6 — Primo `/loop` (50-60 min)

Il "babysit pattern" di Boris Cherny: loop di maintenance ogni 5 minuti.

```
/loop 5m /babysit
```

Senza prompt esplicito, Claude usa il maintenance prompt built-in:
- Continua lavoro non finito
- Risponde a comment PR (se aperto)
- Fixa CI failure
- Cleanup pass (bug hunt, simplification)

Per stop: `/loop --cancel` o premi `Esc`.

### `/compact` quando il context cresce

```
/compact
```

Comprime la conversation in summary, mantenendo cio' che serve. Ideale ogni 30-50 turn.

> Vedi [14 — `/loop` & Monitor](./14-loop-monitor.md), [14b — Agent loop ReAct](./14b-agent-loop-react.md).

---

## Hai finito i primi 60 minuti

Riassumendo:
1. ✅ CLI installato e autenticato
2. ✅ CLAUDE.md generato per il tuo progetto
3. ✅ Prima skill custom funzionante
4. ✅ Hook PostToolUse con linter automatico
5. ✅ `/loop` di maintenance attivo

**Costo stimato dei primi 60 minuti**: ~$0.50-1.00 con Sonnet 4.6 default (vedi `/cost` per il tuo dato esatto).

---

## Prossimi passi

Scegli un percorso in base al tuo profilo:

| Profilo | Continua con |
|---|---|
| Beginner / non-coder | [README-NAVIGATION § Percorso A](../README-NAVIGATION.md) (15 min altri) |
| Solo dev / Indie hacker | [21 § Indie hacker](./21-guide-target-user.md#2-solo-developer--indie-hacker) |
| Senior backend (con team) | [21 § Senior backend](./21-guide-target-user.md#3-senior-backend-developer-con-team) |
| Frontend / Full-stack | [21 § Frontend](./21-guide-target-user.md#4-frontend--full-stack-developer) |
| DevOps / SRE | [21 § DevOps](./21-guide-target-user.md#5-devops--sre) |
| Tech lead / Architect | [21 § Tech lead](./21-guide-target-user.md#6-tech-lead--architect) |
| AI/ML engineer | [21 § AI/ML](./21-guide-target-user.md#7-aiml-engineer) |
| Legacy stack maintainer | [21 § Legacy](./21-guide-target-user.md#8-legacy-stack-maintainer) |

E per il framework concettuale:
- [00 — Harness overview](./00-harness-overview.md) — capire COSA stai usando
- [00b — Context engineering](./00b-context-engineering.md) — perche' CLAUDE.md vince sui prompt

---

## Troubleshooting rapido

| Sintomo | Fix |
|---|---|
| `claude: command not found` | Riapri terminale (PATH); `which claude` |
| Autenticazione fallisce | `claude auth logout && claude auth login`; verifica firewall |
| Permission prompt fastidiosi | `/fewer-permission-prompts` (skill) o passa a sandbox + auto mode (vedi [04](./04-modalita-permessi.md)) |
| Token consumati troppo veloci | `/compact` periodico; subagent Explore per ricerca; `ENABLE_PROMPT_CACHING_1H=1` |
| Hook non si esegue | `/hooks` per verificare; `/doctor` per diagnostica |
| Skill custom non riconosciuta | `/skills` per lista; `/reload-plugins` per ricaricare |

> Diagnostica completa: `/doctor` con `f` per fix automatico.

---

## Esempi pronti per persona

Vuoi un setup gia' configurato per la tua persona? Vedi [examples/personas/](../examples/personas/) — 8 cartelle template `.claude/` con CLAUDE.md, settings, skill, hook esempio.

```bash
cp -r examples/personas/2-indie-hacker/.claude .   # adatta al tuo progetto
```

---

← Torna al [README](../README.md) · Vedi anche [README-NAVIGATION](../README-NAVIGATION.md)
