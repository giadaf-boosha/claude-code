# 12 — Agent Teams (sperimentale, da v2.1.32)

> 📍 [README](../README.md) → [Estensibilita'](../README.md#estensibilita) → **12 Agent teams**
> 🔧 Operational · 🔴 Advanced

Coordina piu' istanze di Claude Code che lavorano insieme con shared task list e mailbox per messaging diretto.

## Cosa e' concettualmente

> Gli Agent Teams sono il livello superiore dei subagent: **agent persistenti, paralleli, comunicanti**. Ognuno e' una full Claude Code instance (full context, full tool, full settings) che pero' partecipa a una task list condivisa e puo' messaggiare gli altri via mailbox. E' l'orchestrazione multi-thread del harness.

**Modello mentale**: come microservizi — ogni servizio (teammate) ha boundary chiaro, comunica via API ben definita (mailbox + task list), il sistema emerge dalla coordinazione.

**Componente harness IMPACT**: Orchestration multi-thread (vs subagent single-thread).

**Per il deep-dive**: [22 — Compound engineering § Scaling](./22-compound-engineering.md#categoria-3-—-scaling-parallelizzazione--automazione).

> "Coordinate multiple Claude Code instances working together as a team" — [`/en/agent-teams`](https://code.claude.com/docs/en/agent-teams)

---

## 12.1 Enable

```json
{
  "env": { "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1" }
}
```

---

## 12.2 Avvio (natural language al lead)

```
Create an agent team to explore this CLI tool from different angles:
one teammate on UX, one on technical architecture, one playing devil's advocate.
```

Il lead crea il team via `TeamCreate`, spawna teammates via `Agent` tool con `team_name` + `name`, e coordina via task list.

---

> **2026-06-26 (auto-update)**: due fix v2.1.193 (25 giu) per background agents — **(1) Backgrounding spurious cancel**: risolto bug per cui spostare una sessione in background generava erroneamente il warning "N background tasks would be abandoned", bloccando l'operazione. **(2) Pinned agents re-prompt post-update**: gli agenti pinned non vengono piu' re-promptati automaticamente dopo ogni auto-update di Claude Code — comportamento che interrompeva sessioni longrunning. Fonte: [GitHub Releases v2.1.193](https://github.com/anthropics/claude-code/releases/tag/v2.1.193). Vedi anche README "What's new today" del giorno.

## 12.3 Componenti

| Componente | Funzione |
|---|---|
| **Team lead** | Sessione main, coordina, assegna task |
| **Teammates** | Claude Code instance separate, ognuno con context proprio |
| **Task list** | Shared, file locking per claim |
| **Mailbox** | Messaging direct teammate-to-teammate |

Storage:
```
~/.claude/teams/{team-name}/config.json   # team config (NON editare a mano)
~/.claude/tasks/{team-name}/              # task list condivisa
```

---

## 12.4 Display modes (`teammateMode` / `--teammate-mode`)

| Mode | Comportamento |
|---|---|
| `auto` (default) | tmux se gia' in tmux, in-process altrimenti |
| `in-process` | Shift+Down per cycle, type per messaggio diretto |
| `tmux` | Split panes (richiede tmux o iTerm2 + `it2` CLI) |

---

## 12.5 Workflow tipico

1. **Lead crea team** con `TeamCreate({team_name, description})`
2. **Lead crea task** con `TaskCreate({subject, description})`
3. **Lead spawna teammate** con `Agent({team_name, name, subagent_type, prompt})`
4. **Lead assegna task** con `TaskUpdate({taskId, owner: "name"})`
5. **Teammate lavora** sul task assegnato, comunica via SendMessage
6. **Teammate completa** con `TaskUpdate({taskId, status: "completed"})`
7. **Teammates idle automaticamente** dopo ogni turn — non vuol dire "fatto", ma "in attesa di input"
8. **Lead shutdown** con `SendMessage({to, message: {type: "shutdown_request"}})`

---

## 12.6 Task list (built-in)

### Tools
| Tool | Effetto |
|---|---|
| `TaskCreate` | Crea task pending |
| `TaskUpdate` | Cambia status / owner / addBlocks / addBlockedBy |
| `TaskList` | Vista corrente |
| `TaskGet` | Dettaglio task |
| `TaskStop` | Interrompe in_progress |
| `TaskOutput` | (deprecated) |

### Stati
- `pending` → `in_progress` → `completed`
- `deleted` per rimuovere

### Dependencies
- `addBlockedBy: ["1", "2"]` — questo task aspetta i task 1 e 2
- `addBlocks: ["3"]` — questo task blocca il task 3

### Note
- `TodoWrite` esiste solo in non-interactive mode + Agent SDK
- Tasks possono accumularsi nel tempo, fai cleanup periodico

---

## 12.7 Subagent definitions per teammate

Lo spawn referenzia un agent type esistente:
```
Spawn a teammate using the security-reviewer agent type to audit auth
```

- `tools` allowlist e `model` del frontmatter rispettati
- `skills`/`mcpServers` frontmatter **NON** caricati (teammate carica da settings come regular session)
- `permissions` set at spawn (modificabili dopo)

---

## 12.8 Plan approval per teammates (workflow)

1. Teammate lavora in plan mode read-only
2. Submit plan al lead via SendMessage
3. Lead approve o reject con feedback (`plan_approval_response`)
4. Loop fino approval
5. Implementation

```json
{ "type": "plan_approval_response", "request_id": "...", "approve": true }
```

---

## 12.9 Hooks per quality gates

`TeammateIdle`, `TaskCreated`, `TaskCompleted` come blocking hooks (exit 2 = block + feedback).

Esempio: hook che richiede review pass prima di marcare completed.

---

## 12.10 Confronto con Subagents

|  | Subagents | Agent Teams |
|---|---|---|
| Context | Own, results back to caller | Own, fully independent |
| Communication | Solo to caller | Direct teammate-to-teammate (mailbox) |
| Coordination | Main agent | Shared task list + self-coord |
| Token cost | Lower | Higher (each = full instance) |
| Use case ideal | Search, plan, review one-shot | Long collaborative project, parallel research |

---

## 12.11 Cleanup

```
Clean up the team
```
Lead controlla active teammates first, poi shutdown ordinato. La task list rimane (puoi consultarla dopo).

---

## 12.12 Limitations (sperimentale)

- No session resumption con in-process teammates
- Task status puo' laggare
- Shutdown lento (finish current request first)
- One team per session
- No nested teams
- Lead fixed (no promote/transfer)
- Permissions set at spawn
- Split panes NON in VS Code integrated terminal, Windows Terminal, Ghostty

---

## 12.13 Use case validi

1. **Ricerca multi-fonte parallela**: 4 teammate, 4 fonti diverse (docs, paper, X, repo).
2. **Code review distribuito**: 1 architecture, 1 security, 1 performance, 1 test.
3. **Refactor large-scale**: 1 lead orchestrator, N teammate ognuno su un modulo.
4. **Documentazione**: 1 teammate per ogni capitolo, lead consolida.
5. **Cross-stack**: 1 frontend + 1 backend + 1 DB + lead di sintesi.

> Pattern di fatto usato per generare questa stessa repo (4 teammate ricerca parallela, 1 lead di sintesi).

---

## 12.14 Annunci rilevanti

- Code Review (PR agents) (mar 2026): "A team of agents runs a deep review on every PR" — [@bcherny](https://x.com/bcherny/status/2031089411820228645), [@claudeai](https://x.com/claudeai/status/2031088171262554195). Vedi anche [15 Ultraplan/Ultrareview](./15-ultraplan-ultrareview.md).

---

← [11 Plugins & Marketplace](./11-plugins-marketplace.md) · Successivo → [13 Routines (cloud)](./13-routines-cloud.md)

## 12.15 Agent Teams vs Dynamic Workflows

Gli Agent Teams sono coordinamento **interattivo** multi-thread: un lead Claude coordina pochi teammate persistenti, con input umano possibile a meta'. Per orchestrazione **su larga scala e ripetibile** (decine-centinaia di subagent, piano codificato in uno script, fan-out parallelo) vedi [24 — Dynamic Workflows](./24-workflows.md). Regola pratica: progetto collaborativo esplorativo -> Teams; fan-out parallelo ripetibile (audit, migrazioni) -> Workflows.

---

## 12.16 Artifacts — pagine condivise da sessione (beta, Team & Enterprise)

Da giugno 2026, Claude Code introduce gli **Artifacts**: pagine web interattive generate direttamente da una sessione, condivisibili con il team via link privato. La pagina si aggiorna in tempo reale mentre la sessione continua a lavorare.

### Casi d'uso
- **PR walkthrough**: esposizione visuale dei cambi con commenti inline generati nella sessione
- **Dashboard di progetto**: stato live task, agenti attivi, metriche
- **Visualizzazioni di codice**: diagrammi, spiegazioni di architettura, animation preview
- **Data analysis**: tabelle, grafici, sintesi di dati analizzati nella sessione

### Come si attiva
Basta chiedere a Claude di trasformare il lavoro in una pagina condivisa:
```
Turn what we've built into a shared page for the team.
Create a PR walkthrough artifact for this session.
```
Claude genera il link privato. La pagina rimane sincronizzata con l'avanzamento della sessione finche' la sessione e' attiva.

### Disponibilita'
- **Beta**: Team ed Enterprise plan
- Non disponibile su Pro/Max/Free al lancio (19 giu 2026)

> Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2067672094209675373) · [@claudeai](https://x.com/claudeai/status/2067671912038240487).
> Boris Cherny: "They are a game changer for how I work with Claude." — [@bcherny](https://x.com/bcherny/status/2067700226669060207)

<sub>Aggiornato 2026-06-19 via daily what's new. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2067672094209675373).</sub>
