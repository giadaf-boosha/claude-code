# 15 — Ultraplan & Ultrareview

Due feature lanciate in aprile 2026 (Week 14-15) che spostano **planning** e **review** in cloud, multi-agent. Pensate per task complessi dove vuoi affidabilita' alta.

---

## 15.1 `/ultraplan` (research preview, da v2.1.91)

> "Hands a planning task from your local CLI to a Claude Code on the web session running in plan mode."

Lanciato **Week 15** (6-10 aprile 2026). Sposta la fase di planning complessa dal terminale locale al cloud, dove Claude lavora con risorse maggiori e puoi rivedere/commentare il piano nel browser prima di eseguirlo.

### Requisiti
- Web account Claude Code attivo (`/web-setup`)
- Repo GitHub
- v2.1.91+
- **NON** disponibile su Bedrock/Vertex/Foundry

### Launch (3 modi)

1. `/ultraplan migrate auth from sessions to JWTs` (slash diretto)
2. Keyword `ultraplan` in normal prompt
3. Da local plan dialog: "No, refine with Ultraplan on Claude Code on the web"

> Confirmation dialog (skipped per il path 3). Remote Control si disconnette automaticamente (entrambi occupano `claude.ai/code`).

### Status indicators in CLI

| Indicator | Significato |
|---|---|
| `◇ ultraplan` | Drafting in cloud |
| `◇ ultraplan needs your input` | Clarifying question |
| `◆ ultraplan ready` | Review nel browser |

`/tasks` → entry ultraplan → session link, agent activity, **Stop ultraplan**.

### Browser review view

- Inline comments (highlight passage)
- Emoji reactions
- Outline sidebar
- Iterate finche' soddisfatto

### Execute (3 opzioni dal browser)

1. **Approve and start coding** (web): runa nella stessa cloud session, review diff via web, create PR
2. **Approve and teleport back to terminal**: web archivata; terminale dialog "Ultraplan approved":
   - **Implement here** (inject in current conversation)
   - **Start new session** (clear + plan as context, prints `claude --resume <id>` per ritornare)
   - **Cancel** (save plan to file, prints path)
3. (Implicit) **Cancel** dal browser

### Da v2.1.101: auto-creazione default cloud env
Se manca al primo uso, Claude Code crea un cloud env standard per la sessione web.

### Annuncio
- [@trq212](https://x.com/trq212/status/2042671370186973589): "New in Claude Code: /ultraplan. Claude builds an implementation plan for you on the web. You can read it and edit it, then run the plan on the web or back in your terminal. Available now in preview for all users with CC on the web enabled."

> Fonte: [`/en/ultraplan`](https://code.claude.com/docs/en/ultraplan).

---

## 15.2 `/ultrareview` (general availability da v2.1.111)

> "Run a deep, multi-agent code review in the cloud with /ultrareview to find and verify bugs before you merge."

Lanciato **Week 14** (v2.1.86, 30 mar 2026), GA con Opus 4.7 (v2.1.111, 16 apr 2026). Una flotta di agenti specialisti analizza la diff in parallelo. Ogni finding e' **riprodotto da un agente di verifica indipendente** prima di essere riportato in CLI: solo bug verificati, non rumore stilistico.

### `/review` vs `/ultrareview`

|  | `/review` | `/ultrareview` |
|---|---|---|
| Runs | Locally | Remote sandbox |
| Depth | Single-pass | Multi-agent fleet + verification |
| Duration | Seconds-minutes | 5-10 min |
| Cost | Plan usage | Free runs (3 Pro/Max → 5 mag 2026), poi $5-$20 extra usage |
| Best for | Iteration | Pre-merge confidence |

### Sintassi

```bash
/ultrareview              # diff branch corrente vs default + uncommitted/staged
/ultrareview 1234         # review GitHub PR (clone diretto, requires github.com remote)
```

Pre-launch dialog: scope (file/line count), free runs rimanenti, cost estimate.

### CLI subcommand non-interactive (v2.1.120)

```bash
claude ultrareview [target]                   # findings → stdout
claude ultrareview [target] --json            # raw output JSON
# Exit code: 0 ok, 1 fail
```

> Annuncio: [@ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2047882231343878309).

### Pricing

| Plan | Free runs | After |
|---|---|---|
| Pro | 3 free runs through May 5, 2026 | extra usage |
| Max | 3 free runs through May 5, 2026 | extra usage |
| Team / Enterprise | none | extra usage |

> 3 runs = one-time, no refresh, scadono **5 maggio 2026**. Extra usage **must be enabled** (organization). `/extra-usage` per check/change.

### Limiti

- Auth: claude.ai account (no API key only)
- **Solo user-invocable**: nessun subagent o routine puo' lanciarlo per te
- **NON** disponibile su Bedrock/Vertex/Foundry, ZDR organizations
- Tipica durata 5-10 min, fleet default 5 agent (provisioning ~90s)
- Sessione resta libera durante la review

### Run management

- `/tasks` per detail/stop
- Stop archivia, no partial findings
- Findings = notifica con file location + spiegazione

### Vantaggi

- **High signal**: ogni finding verificato indipendentemente (verification agent)
- **Broad coverage**: molti reviewer in parallelo (security, correctness, architecture, tests, performance, style)
- **No local resource**

### Annunci

- [@ClaudeDevs](https://x.com/ClaudeDevs/status/2046999435239133246): "/ultrareview"
- [@claudeai](https://x.com/claudeai/status/2044785266590622185): "the new /ultrareview command runs a dedicated review session that reads through your changes and flags what a careful reviewer would catch."

> Fonte: [`/en/ultrareview`](https://code.claude.com/docs/en/ultrareview).

---

## 15.3 Pattern combinato

Pattern "**plan locally, execute remotely**" che il team Claude Code usa internamente:

```
1. Conversazione locale: capisci il problema
2. /plan → review breve in CLI
3. /ultraplan → cloud session, piano dettagliato in browser, review iterativa
4. Approve + teleport back oppure execute remoto
5. Implementa
6. /ultrareview pre-merge → multi-agent verification cloud
7. Apri PR, /review per micro-feedback iterativo se serve
8. Merge
```

---

## 15.4 Code Review (PR agents) - feature correlata

Annunciata GA mar 2026 (oltre a `/ultrareview`):
- "When a PR opens, Claude dispatches a team of agents to hunt for bugs." — [@claudeai](https://x.com/claudeai/status/2031088171262554195)
- "A team of agents runs a deep review on every PR. We built it for ourselves first. Code output per Anthropic engineer is up 200% this year and reviews were the bottleneck." — [@bcherny](https://x.com/bcherny/status/2031089411820228645)

E' attivabile via Claude GitHub App per Team/Enterprise. Differenze:
- **Code Review (PR agents)**: automatico su PR open, runs sempre
- **`/ultrareview`**: on-demand, user-triggered, multi-agent piu' deep

---

## 15.5 Tips operative

1. **`/ultraplan` per refactor cross-file**: il browser review e' superiore a leggere markdown 800-righe nel terminale.
2. **`/ultrareview` solo pre-merge**: non per micro-feedback iterativo (per quello c'e' `/review`).
3. **`/extra-usage` check** prima di lanciare ultrareview a pagamento.
4. **Combina con `/plan` locale**: usa plan mode per scoping veloce, ultraplan se serve depth.
5. **Pattern routine + ultrareview**: una Routine GitHub-trigger puo' lanciare il subcommand `claude ultrareview` non-interactive su PR open.
6. **Repo grossa**: se troppo grossa per il bundle, push branch + open draft PR e usa PR mode (`/ultrareview <PR>`).

---

## 15.6 Quando NON usarli

- `/ultraplan`: task semplice (5 minuti), feature isolata, iterazione UI rapida.
- `/ultrareview`: PR triviale, change cosmetic, scarse risorse (paghi).

---

← [14 Loop & Monitor](./14-loop-monitor.md) · Successivo → [16 Headless & Agent SDK](./16-headless-agent-sdk.md)
