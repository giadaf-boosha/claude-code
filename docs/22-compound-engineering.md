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

## 22.7 Philosophy: vibe-to-agentic transition

Il compounding engineering nasce da un cambio di paradigma documentato dal team Every (Kieran Klaassen, Dan Shipper) nel corso del 2025: il passaggio dal **vibe coding** all'**agentic coding**.

### Vibe coding (era Cursor / Windsurf)

Caratteristiche del primo paradigma AI-assisted, dominante 2023-meta' 2025:
- Idea trasformata in codice attraverso un feedback loop **stretto** (umano-AI a ogni keystroke)
- Collaborazione real-time tipo "autocomplete potenziato": Cmd+K, accept/reject, shortcut continui
- Strumenti di riferimento: Cursor, Windsurf, GitHub Copilot
- Forte sull'**ideazione rapida**, debole sul **delivery sostenibile**: tendenza al "cancello tutto e ricomincio"

### Agentic coding (era Claude Code)

> "Coding with AI is more than just the coding part — utilizing it for research, for workflows, it should be used for everything." — Kieran Klaassen ([Every podcast, 2025](https://every.to/))

Caratteristiche:
- Si delega **una specifica intera** (non singola riga) a un agente capace
- Feedback loop **largo** ma piu' potente: l'umano fa review a checkpoint strategici, non a ogni token
- Possibilita' di orchestrare **piu' agenti in parallelo** (vedi 22.4 worktree, [docs/12 agent teams](./12-agent-teams.md))
- Strumento di riferimento: Claude Code (CLI minimalista, terminale, niente UI distrazionale)

> "We're now at a point where the agents are good enough that they can actually do everything, so we need to rethink again. It's a realization: oh, actually we can just give a task and it will do it." — Kieran Klaassen

### Il mindset shift in pratica

Stima del team Kora sulla distribuzione del lavoro reale di un engineer:

> "Most of the work is maybe coding, but maybe it's actually 20%. Maybe 80% of the work is figuring out what to do next."

Implicazioni operative:
- L'AI va usata per **ricerca** (codebase + web), **planning** (issue, ADR), **review** (security, perf), **migrazione**, **doc** — non solo per scrivere funzioni
- Ogni interazione ben strutturata diventa **template riusabile** (slash command, skill, sub-agent) → effetto compound
- L'investimento in setup (CLAUDE.md, skill, hook, comandi) ripaga in modo non lineare nel tempo

### Perche' Claude Code abilita la transizione

> "Claude just takes it one step further by simplifying it by a factor of 10. Cursor: Cmd+K, shortcuts, accept, reject. Claude Code: nothing except a text box — and it works because the underlying model is so much more capable now." — Natasha Mascarenhas (Every)

L'interfaccia minimale **non e' un limite**: e' un'affermazione. Quando il modello sottostante e' abbastanza capace, l'attrito UX si dissolve e resta solo l'intent dell'utente.

> Vedi anche: [00b — Context engineering](./00b-context-engineering.md), 22.1 (definizione operativa) e 22.8 per il case study Kora.

---

## 22.8 Case study: il team Kora di Every (Kieran Klaassen)

[Kora](https://www.korahq.com/) e' un assistente email AI sviluppato da Every (la media company di Dan Shipper). Il team di sviluppo conta **2 persone** — Kieran Klaassen e Nityesh Agarwal — ma produce, per loro stessa ammissione, **output paragonabile a un team di 15**.

> "Feels like there's 15 coding." — Kieran Klaassen ([Every podcast, 2025](https://every.to/))

Il caso e' rilevante perche' documenta un'applicazione **end-to-end** dei principi di compounding engineering, con metriche, workflow e fallimenti reali. Modelli usati: Claude Sonnet 4.5 → 4.7 e Opus 4.x via Claude Code.

### 22.8.1 Architettura del prodotto

Kora esegue:
- Connessione a Gmail via OAuth
- Archiviazione automatica di email non importanti
- Brief riassuntivo due volte al giorno
- Categorizzazione e prioritizzazione personalizzate per profilo di rischio utente

Stack: Rails 7.1 + Hotwire + Postgres + pgvector, deploy Render. Multi-LLM: diversi modelli per diversi step (riassunto, classificazione, embedding).

### 22.8.2 Workflow "Friday feedback bug" — root-cause + migration in minuti

Storia documentata da Kieran in podcast Every, 2025. Form di feedback in produzione che da 14 giorni non riceveva submit, ma nessun errore in Sentry.

Prompt iniziale (voice-to-text via Monologue):

```text
> 14 days ago something went wrong with feedback form, can you see what
  went wrong? Look at the git history.
```

Esecuzione autonoma di Claude Code:
1. `git log --since="14 days ago"` sui controller rilevanti
2. Identificazione del commit "incriminato": refactor che ha rimosso una chiamata `addUser`
3. Diagnosi: "We removed a piece of code that adds people"
4. Fix proposto + apertura PR via `gh pr create`
5. **Bonus non richiesto**: script di migrazione per recuperare i ~30 utenti "persi" nei 14 giorni — l'agente ha capito autonomamente che servisse

> "It didn't cost me any energy. It was as easy as me writing it down in GitHub to look at later — but I don't need to. I just ask it and it does it immediately." — Kieran Klaassen

Tempo totale: ~3 minuti vs ~45 minuti stimati per investigazione manuale.

### 22.8.3 Custom command template "/cc" per feature requests

Il team ha codificato il proprio workflow in un singolo slash command (`.claude/commands/cc.md`). Esempio reale di prompt vocale:

```text
> I want infinite scroll in Kora where if I am at the end of a brief
  it should load the next brief and it should go until every brief
  that's unread is read.
```

Steps automatici eseguiti dal comando:
1. **Inserimento nel feature template** (problem statement + solution vision)
2. **Research phase**: grounding nel codebase (Rails routes, controller, view)
3. **Best-practices research**: web search per pattern open-source di infinite scroll in Hotwire
4. **Plan presentation**: piano dettagliato con implementation steps + timeline
5. **Human-in-the-loop**: Kieran approva/corregge il piano (checkpoint critico)
6. **GitHub integration**: `gh issue create` con label, milestone, link a featurebase
7. (Opzionale) Implementazione in worktree separato

> "Most of the time it's right. Then I say 'yep sounds good.' And it creates the GitHub issue." — Kieran Klaassen

Template skeleton (semplificato):

```markdown
# /cc — Feature creation command

Sei un AI assistant che crea GitHub issue ben strutturate.

<feature_description>$ARGUMENTS</feature_description>

Steps (crea to-do, pensa ultra hard):
1. Research del repo: struttura, issue esistenti, CONTRIBUTING.md
2. Research best practices web per il pattern richiesto
3. Presenta un <plan> con architettura, file impattati, test strategy
4. Attendi approvazione umana
5. Genera <github_issue> con titolo, descrizione, criteri accettazione
6. Esegui `gh issue create` con label e milestone corretti
```

### 22.8.4 Multi-agent specialization

Kieran descrive il suo "tool portfolio" come un team di specialisti:

> "I'm thinking about it more like you're interviewing for a role and you find a developer to solve a certain problem. It's similar with coding agents."

Suddivisione 2025-2026 (modernizzata):

| Tool | Specializzazione |
|---|---|
| **Claude Code** (Sonnet/Opus 4.7) | Research, refactor, migrazioni, lavoro pesante in terminale |
| **Friday** | UI work (componenti, design system) |
| **Charlie** | Code review automatica su PR GitHub |
| **Cursor** | Editing puntuale "vibe-style" su file singoli |

L'idea-chiave: **non esiste un tool che fa tutto bene**, e cercarlo e' un anti-pattern. Compound = sapere quale agente per quale task.

### 22.8.5 Quality control: "fix problems at lowest value stage"

Natasha Mascarenhas cita "High Output Management" di Andy Grove (Intel CEO):

> "When we are using the workflow that Kieran just showed to create a very detailed GitHub issue, then it's very tempting to start another Claude Code to fix it immediately — but that's actually going to be a problem. There are chances that the plan wasn't the direction you wanted, and you want to catch that **before** you ask Claude to implement."

Checkpoint umani strategici:
1. **Plan review** prima dell'implementazione (10 sec di lettura, ore di lavoro evitate)
2. **Architecture validation** per scelte di direzione
3. **Taste & intuition**: l'umano nota cose che l'agente non flagga ("perche' qui un loop e non un job?")

> "There is still like a human touch of intuition. It's still a skill." — Natasha Mascarenhas

### 22.8.6 Risultati misurabili

- Output 2 persone ≈ 15 sviluppatori tradizionali (stima qualitativa team)
- 25 minuti di esecuzione autonoma continuativa di Claude Code (record interno tra Kieran e Natasha)
- Feature complete (es. infinite scroll) dall'idea al prod in **~1 ora** vs giorni
- iOS app vibe-coded in un weekend con Sonnet 4.5 in Claude Code ([Kieran su X](https://x.com/kieranklaassen))

### Fonti

- Every podcast / blog: [every.to](https://every.to/)
- Kieran Klaassen su X: [@kieranklaassen](https://x.com/kieranklaassen)
- Dan Shipper su X: [@danshipper](https://x.com/danshipper)
- Annuncio Sonnet 4.5 (drop-in usato da Kora): [@AnthropicAI](https://x.com/AnthropicAI)

---

## 22.9 Letture di approfondimento

- [00 — Harness overview](./00-harness-overview.md) — il livello sotto
- [00b — Context engineering](./00b-context-engineering.md) — il livello tra harness e compound
- [14b — Agent loop ReAct](./14b-agent-loop-react.md) — fondamento del loop
- [21 — Guide per target user](./21-guide-target-user.md) — compound per persona
- [@bcherny — tutti i tip thread](../posts/bcherny.md)
- [Dan Shipper, "Compounding Engineering"](https://every.to/) (citato da Boris)

---

← [21 Guide per target user](./21-guide-target-user.md) · Successivo → [23 Glossario](./23-glossario.md)
