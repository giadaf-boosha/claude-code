# 22 — Compound engineering

> 📍 [README](../README.md) → [Concetti foundation](../README.md#concetti-foundation) → **22 Compound engineering**
> 📘 Concettuale · 🔴 Advanced

> **Tesi del capitolo**: "compound engineering" e' il livello di pratica successivo a context engineering: comporre **pattern architetturali** sopra l'harness — caching + idempotenza + parallelizzazione + verification — per ottenere risultati che il singolo prompt o la singola feature non potrebbero. E' qui che la curva di apprendimento si appiattisce: non impari piu' "come si usa X", impari "come X si compone con Y per risolvere classe di problemi Z".

---

## 22.1 Da prompt a compound

| Livello | Cosa fai | Esempio |
|---|---|---|
| 1. Prompt engineering | Scrivi prompt | "Sei esperto Python con 20 anni..." |
| 2. Context engineering | Strutturi cosa LLM vede | CLAUDE.md, RAG, MCP tool search |
| 3. Harness engineering | Costruisci agent con tool/memory/guardrail | Claude Code, custom SDK |
| 4. **Compound engineering** | Componi pattern sopra harness | `/loop` + idempotenza + Monitor + auto-memory + verification |

> Termine attribuito a Dan Shipper (Every) e adottato dal team Claude Code (Boris cita "Compounding Engineering" — vedi [@bcherny](https://x.com/bcherny/status/2007179842928947333)).

---

## 22.2 Le 3 categorie di compound pattern

```mermaid
flowchart LR
    subgraph "Optimization"
        O1[Prompt caching 1h]
        O2[Subagent Explore Haiku]
        O3[CLAUDE.md vs prompt repeats]
        O4[MCP tool search on-demand]
    end
    subgraph "Resilience"
        R1[/loop + idempotency]
        R2[Monitor + push events]
        R3[Hooks PreToolUse safety]
        R4[Checkpoints + /rewind]
        R5[Verification feedback loop]
    end
    subgraph "Scaling"
        S1[git worktree parallel]
        S2[/batch fan-out]
        S3[Subagent specialization]
        S4[Agent teams + mailbox]
        S5[Routines cloud 24/7]
    end
```

### Categoria 1 — Optimization (token + latenza)

#### O1. Prompt caching 1h TTL
```bash
ENABLE_PROMPT_CACHING_1H=1 claude
```
Riduce costi ~90% sui turn successivi. Sopra una soglia di token, Anthropic cache il context per 1 ora.
> Vedi [Thariq, "Lessons: Prompt Caching Is Everything"](https://x.com/trq212/status/2024574133011673516).

#### O2. Subagent Explore (Haiku) per ricerca
Search massiccio su codebase → delega a subagent Haiku, che ritorna **summary** nel main thread (Sonnet/Opus). 5-10x cheaper.

```
"Spawn an Explore subagent to find all REST endpoints
and return list of file:line"
```

#### O3. CLAUDE.md vs prompt repeats
Ogni regola ripetuta in N prompt → 1 regola in CLAUDE.md (cached).
Pattern: regole non negoziabili in `.claude/CLAUDE.md`, contesto specifico nel prompt.

#### O4. MCP tool search on-demand
Server MCP con 50 tool → solo schema dei tool **rilevanti** caricati per il task corrente. Riduce token startup di server pesanti (`playwright`, `github`).

### Categoria 2 — Resilience (recovery + safety)

#### R1. `/loop` + idempotenza
Loop maintenance che gira ogni 5 min DEVE essere idempotente:
- Re-run su PR gia' aggiornata = no-op
- Re-run su CI gia' verde = no-op
- State check prima di Act

```
/loop 5m /babysit
```
Boris pattern. Vedi [@bcherny](https://x.com/bcherny/status/2038454341884154269).

#### R2. Monitor tool + push events
Sostituisce polling con interrupt push-based. Esempio: `tail -f logs/error.log` con Monitor → notifica Claude solo quando emerge un errore. Token saving + reattivita'.

```
"Use Monitor tool with `tail -f logs/error.log | grep ERROR`"
```

#### R3. Hooks PreToolUse safety
Hook deterministico che blocca azioni pericolose **prima** che l'LLM le esegua. Non puo' essere aggirato.

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "if": "Bash(rm -rf *)",
        "command": ".claude/hooks/block-rm.sh"
      }]
    }]
  }
}
```

#### R4. Checkpoints + `/rewind`
Ogni edit auto-snapshot. Esc Esc per rollback chirurgico. Combinato con git per cambi rilevanti.

#### R5. Verification feedback loop (Boris tip 13)
> "Give Claude a way to verify its work. If Claude has that feedback loop, it will 2-3x the quality of the final result."

In pratica: dopo ogni implement, Claude esegue `npm test` o `claude /security-review` e itera fino a verde. Vedi [@bcherny](https://x.com/bcherny/status/2007179861115511237).

### Categoria 3 — Scaling (parallelizzazione + automazione)

#### S1. Git worktree parallel
Boris tip 1 e 10:
> "Spin up 3-5 git worktrees at once, each running its own Claude session. Top tip from the team."

```bash
claude --worktree feature-a
claude --worktree feature-b
claude --worktree fix-bug-x
```
Vedi [@bcherny](https://x.com/bcherny/status/2017742743125299476).

#### S2. `/batch` fan-out
Massive code migration → `/batch` distribuisce a centinaia di worktree agents in parallelo.

```
/batch convert all callbacks to async/await across 200 files
```
Vedi [@bcherny](https://x.com/bcherny/status/2038454355469484142).

#### S3. Subagent specialization
Subagent custom dedicati a workflow ricorrenti. Boris ha `code-simplifier`, `verify-app`, ecc. Vedi [@bcherny](https://x.com/bcherny/status/2007179850139000872).

```yaml
# .claude/agents/code-simplifier.md
---
name: code-simplifier
description: Riduce ridondanza dopo ogni modifica significativa
tools: Read, Edit, Grep
proactive: true
---
```

#### S4. Agent teams + mailbox
Per task collaborativi cross-context: team lead + N teammates con mailbox e task list condivisa. Useful per ricerca multi-fonte parallela. Vedi [12 — Agent teams](./12-agent-teams.md).

#### S5. Routines cloud 24/7
Compound pattern definitivo: prompt + repos + connectors + trigger (schedule/API/GitHub event), eseguito da Anthropic cloud senza laptop acceso.

```
/schedule daily at 09:00, triage Linear bugs and open draft PRs
```
Vedi [13 — Routines cloud](./13-routines-cloud.md).

---

## 22.3 Compound moltiplicativo

Il punto di "compound" e' che i pattern **si moltiplicano**:

```
Esempio reale (workflow Boris):
  /loop 5m /babysit            (R1: loop maintenance)
+ Monitor on dev server         (R2: push events)
+ Hook block force-push        (R3: safety)
+ git worktree per feature     (S1: scaling)
+ Subagent code-simplifier     (S3: specialization)
+ Routines weekly dep update   (S5: 24/7)
+ CLAUDE.md project rules      (O3: caching)

Risultato: workflow che si auto-mantiene, scala parallelo,
e produce 2-3x output con 1/N intervento manuale.
```

L'output non e' la somma ma il **prodotto** delle ottimizzazioni.

---

## 22.4 Pattern team Anthropic interno (compound stack)

Da post X di Boris (vedi [posts/bcherny.md](../posts/bcherny.md)):

| Compound element | Implementazione team CC |
|---|---|
| **Skill condivise in repo** | `BigQuery` skill, `code-simplifier` skill (open source) |
| **MCP shared in `.mcp.json`** | Slack MCP, Sentry MCP, BigQuery via bq CLI |
| **Settings.json in git** | Configurazione team-wide checked in |
| **`@claude` su PR** | Hook GitHub Action per aggiornare CLAUDE.md collaborativamente |
| **Worktree paralleli** | 3-5 simultanei per dev |
| **`/loop` maintenance** | `/babysit` ogni 5 min |
| **Subagent ricorrenti** | `code-simplifier`, `verify-app` |

> "Code output per Anthropic engineer is up 200% this year and reviews were the bottleneck." — [@bcherny](https://x.com/bcherny/status/2031089411820228645)

200% = compound effect.

---

## 22.5 Anti-pattern di compound

| Anti-pattern | Sintomo | Fix |
|---|---|---|
| Compound senza idempotenza | `/loop` rifa' tutto da capo | R1: state check + idempotency |
| Tutti i pattern attivi sempre | Token explosion, context pollution | Selettivita': abilita per task |
| Compound senza observability | Bug silenti in 5 layer | Hook logging, transcript, auto-memory |
| Copy-paste pattern dal blog senza verify | Claim non verificati ("+919%") | Misura nel tuo contesto |
| Subagent specialization eccessiva | 20 subagent custom, debug nightmare | Max 3-5 subagent ricorrenti |
| Routines senza boundary nel prompt | Blast radius alto | `do not merge`, `dry run`, `max N file` |

---

## 22.6 Compound engineering vs over-engineering

Compound engineering **paga** quando:
- Iterazione fitta sullo stesso task type
- Team > 1 persona (compound shareable)
- Production con compliance
- Scala (>50 PR/settimana)

Compound **e' over-engineering** quando:
- Prototipo throw-away
- Solo dev, 5 task al mese
- POC esplorativo
- Vuoi chiarezza, non ottimizzazione

---

## 22.7 Letture di approfondimento

- [00 — Harness overview](./00-harness-overview.md) — il livello sotto
- [00b — Context engineering](./00b-context-engineering.md) — il livello tra harness e compound
- [14b — Agent loop ReAct](./14b-agent-loop-react.md) — fondamento del loop
- [21 — Guide per target user](./21-guide-target-user.md) — compound per persona
- [@bcherny — tutti i tip thread](../posts/bcherny.md)
- [Dan Shipper, "Compounding Engineering"](https://every.to/) (citato da Boris)

---

← [21 Guide per target user](./21-guide-target-user.md) · Successivo → [23 Glossario](./23-glossario.md)
