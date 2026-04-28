# 13 — Routines (cloud automation)

> 📍 [README](../README.md) → [Cloud](../README.md#cloud) → **13 Routines**
> 🔧 Operational · 🟡 Intermediate

> "Put Claude Code on autopilot. Define routines that run on a schedule, trigger on API calls, or react to GitHub events."

## Cosa e' concettualmente

> Le routines sono l'**agent loop in cloud**: stesso pattern di `/loop` ma eseguito su infra Anthropic, senza laptop acceso. Tre trigger principali (schedule, API, GitHub event) coprono ogni caso di automazione 24/7. Sono il salto da "agent locale che gira finche' tieni aperta la sessione" a "agent cloud che lavora per te in autonomia".

**Modello mentale**: come cron + GitHub Actions + webhook handler in un solo prodotto, con LLM al posto dello script.

**Componente harness IMPACT**: Control flow (trigger-based) + Memory persistente cloud.

**Per il deep-dive**: [14 — `/loop` & Monitor](./14-loop-monitor.md) per il loop locale + [14b — Agent loop ReAct](./14b-agent-loop-react.md) per il pattern.

Lanciate **14 aprile 2026** in research preview. Eseguono su infrastruttura Anthropic, niente laptop acceso, niente sessione aperta.

> Fonti: [blog Anthropic](https://claude.com/blog/introducing-routines-in-claude-code), [`/en/routines`](https://code.claude.com/docs/en/routines), [`/en/web-scheduled-tasks`](https://code.claude.com/docs/en/web-scheduled-tasks). Annuncio: [@claudeai](https://x.com/claudeai/status/2044095086460309790).

---

## 13.1 Cosa cambia rispetto a `/loop` e Desktop scheduled

|  | **Routines (cloud)** | **Desktop scheduled** | **`/loop`** |
|---|---|---|---|
| Runs on | Anthropic cloud | Your machine | Your machine |
| Machine on | No | Yes | Yes |
| Open session | No | No | Yes |
| Restart persistent | Yes | Yes | Resume if unexpired |
| Local files | No (fresh clone) | Yes | Yes |
| MCP | Connectors per task | Config files + connectors | Inherits |
| Permission prompts | No (autonomo) | Configurable | Inherits |
| Min interval | 1 hour | 1 minute | 1 minute |

---

## 13.2 Componenti di una routine

- **Prompt**: il task in linguaggio naturale
- **Repos**: GitHub repository (fresh clone ad ogni run)
- **Connectors**: MCP server (Linear, Slack, Figma, Notion, ecc.)
- **Environment**: cloud env (network, env vars, setup script)
- **Triggers**: scheduled, API, GitHub event

---

## 13.3 Tipi di trigger

### 1. Scheduled
Preset: hourly / daily / weekdays / weekly. Custom cron via `/schedule update` (min 1 ora). Times locali → UTC. One-off: descrivi in natural language ("tomorrow at 9am, summarize PRs").

### 2. API
Per-routine endpoint con bearer token. POST con `text` field opzionale (freeform string, non parsed).

```bash
curl -X POST https://api.anthropic.com/v1/claude_code/routines/trig_01ABCDEF.../fire \
  -H "Authorization: Bearer sk-ant-oat01-xxxxx" \
  -H "anthropic-beta: experimental-cc-routine-2026-04-01" \
  -H "anthropic-version: 2023-06-01" \
  -d '{"text": "Sentry alert SEN-4521 fired"}'
```

Response:
```json
{
  "type": "...",
  "claude_code_session_id": "...",
  "claude_code_session_url": "..."
}
```

> Token shown once, generate da web only (CLI non puo'). Beta header obbligatorio.

### 3. GitHub
Install Claude GitHub App (≠ `/web-setup`). Eventi:
- `pull_request.opened/reopened/closed/edited/synchronize/...`
- `release.published`
- `push`
- `issues.opened`
- `check_runs`

Filtri sul payload: author, title, body, base/head branch, labels, is_draft, is_merged.
Operatori: `equals`, `contains`, `starts_with`, `is_one_of`, `regex` (matches entire field).

Ogni event = nuova session. Per-routine + per-account hourly caps.

---

## 13.4 Creation (web/desktop/CLI)

| Surface | Come |
|---|---|
| Web | https://claude.ai/code/routines → New routine |
| Desktop | Routines sidebar → New routine → Remote |
| CLI | `/schedule [description]`, es. `/schedule daily PR review at 9am`, `/schedule clean up flag in one week` |

> Da CLI: solo trigger **scheduled**. API e GitHub trigger via web.

### CLI subcommands
- `/schedule list`
- `/schedule update`
- `/schedule run <name>` (run now)
- `/web-setup` (GitHub access, NOT GitHub App — quello e' separato)

---

## 13.5 Permissions

Routines run **autonome**: niente permission prompt durante l'esecuzione. Allow unrestricted branch pushes per repo (default: solo branch `claude/*`).

Per limitare:
- Imposta scope read-only per la routine via prompt boundary
- Aggiungi `do not merge`, `do not modify > N files`, `dry run` nel prompt

---

## 13.6 Connectors

Tutti i connettori abilitati nell'account sono inclusi di default per la routine. Removable per ogni routine (es. una routine "Linear triage" puo' avere solo Linear, niente Slack).

> No tool restriction granular durante run.

---

## 13.7 Environments

Cloud env controlla:
- Network (whitelist domain)
- Env vars (es. `STAGING_API_TOKEN`)
- Setup script (es. `npm install`, `apt-get install ...`)

Custom env via web before routine creation.

---

## 13.8 Run management

| Azione | Come |
|---|---|
| Detail page | Click routine → repos, connectors, prompt, schedule, tokens, GitHub triggers, runs |
| **Run now** | Esecuzione immediata |
| Pause/Resume | Toggle |
| Edit | Pencil icon |
| Delete | Past sessions kept |

---

## 13.9 Usage limits

| Plan | Daily routine cap (scheduled trigger) |
|---|---|
| Pro | 5/giorno |
| Max | 15/giorno |
| Team / Enterprise | 25/giorno |

> Webhook/API trigger NON contano verso il cap. Use case: alert real-time, eventi PagerDuty, GitHub events.
> One-off (`Run now`) NON conta verso daily cap (ma si' verso usage subscription).

Extra usage abilitabile per overage.

---

## 13.10 Esempi pratici

### A. Triage backlog Linear notturno

Prompt:
```
Ogni notte alle 02:00 leggi top 5 bug in Linear progetto INGEST con label "p1".
Per ognuno, cerca PR aperte correlate, e se non esistono apri una **draft PR** con tentativo di fix.
NON merger. Tag @giada per review.
```

Trigger: Scheduled (daily 02:00).
Connectors: Linear, GitHub.

### B. Doc-drift detection

Prompt:
```
Confronta README.md con i comandi/flag definiti nel codice.
Se trovi divergenze, apri issue con label "docs" indicando file:linea.
```

Trigger: Scheduled (weekdays 09:00) o GitHub push.

### C. Alert triage da PagerDuty

Routine API trigger, lanciata da webhook PagerDuty:
```
Alert "$text" arrivato. Cerca run-book in docs/runbooks/, applica fix se sicuro,
altrimenti scrivi un primo commento di triage al PR.
```

Trigger: API.
Connectors: GitHub, Slack (per notifiche).

### D. Code review ogni PR aperta

Trigger: GitHub `pull_request.opened`, filter `is_draft=false`.
Prompt:
```
Review questa PR. Per ogni file:
- Verifica security (OWASP top 10)
- Controlla naming convention (vedi CLAUDE.md)
- Suggerisci semplificazioni
Posta findings come PR review comment.
```

### E. Porting libreria su molte repo

API trigger fired per ogni repo target:
```
Aggiorna questa repo da X v1 a X v2 seguendo migration guide @docs/v2-migration.md.
Testa con `npm test`. Apri draft PR.
```

---

## 13.11 Tips operative

1. **Quota**: usa **Webhook/API trigger** quando hai volume alto. Solo Scheduled conta verso il daily cap.
2. **"Run now" prima di schedule**: testa sempre la routine manualmente.
3. **Boundary nel prompt**: `do not merge`, `do not modify more than N files`, `dry run`. Riducono blast radius.
4. **Routine focalizzate su un task**: prompt complessi consumano molti token e fanno timeout.
5. **Output strutturato**: chiedi JSON / report markdown salvato in repo, cosi' il run e' verificabile.
6. **Combina con `/loop`**: scheduled in cloud per ricorrenze, `/loop` in sessione per intra-task.

---

## 13.12 Limitazioni e provider

- **Beta header obbligatorio**: `experimental-cc-routine-2026-04-01`
- **Solo Anthropic provider** (no Bedrock/Vertex/Foundry)
- **No ZDR organizations**
- **Web access plan necessario** (Pro, Max, Team, Enterprise — non API-only)

---

## 13.13 Annunci e copertura

- Annuncio ufficiale: [blog](https://claude.com/blog/introducing-routines-in-claude-code) · 14 apr 2026
- Tweet: [@claudeai](https://x.com/claudeai/status/2044095086460309790), [@noahzweben](https://x.com/noahzweben/status/2044093913376706655)
- Precursore "Scheduled cloud tasks": [@noahzweben](https://x.com/noahzweben/status/2035122989533163971)
- Cloud Auto-Fix PR (correlato): [@noahzweben](https://x.com/noahzweben/status/2037219115002405076)
- Coverage 9to5Mac: https://9to5mac.com/2026/04/14/anthropic-adds-repeatable-routines-feature-to-claude-code-heres-how-it-works/

---

← [12 Agent Teams](./12-agent-teams.md) · Successivo → [14 Loop & Monitor](./14-loop-monitor.md)
