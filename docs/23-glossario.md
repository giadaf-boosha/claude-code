# 23 — Glossario

> 📍 [README](../README.md) → [Riferimenti](../README.md#riferimenti) → **23 Glossario**
> 📚 Riferimento

Glossario alfabetico di 35+ termini che ricorrono nella guida. Per ogni termine: definizione concisa, sinonimi, capitoli dove appare, esempio d'uso, termini correlati.

---

## A

### Agent
**Definizione**: programma autonomo che combina un LLM con un harness per eseguire task. Formula: `Agent = LLM + Harness`.
**Sinonimi**: AI agent, autonomous agent, agentic system.
**Appare in**: [00](./00-harness-overview.md), [12](./12-agent-teams.md), [16](./16-headless-agent-sdk.md), [21](./21-guide-target-user.md).
**Esempio**: Claude Code e' un agent. Cursor e Codex sono agent.
**Correlati**: Harness, Subagent, Agent team.

### Agent loop
**Definizione**: ciclo `Reason → Act → Observe → Decide` che governa ogni turn dell'agent.
**Sinonimi**: ReAct loop, observation loop.
**Appare in**: [14b](./14b-agent-loop-react.md), [14](./14-loop-monitor.md).
**Esempio**: ogni `/loop 5m` esegue un'iterazione completa del loop.
**Correlati**: ReAct, `/loop`, Monitor tool.

### Agent team
**Definizione**: gruppo di Claude Code instances con mailbox e task list condivisa, coordinato da un team lead. Sperimentale (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`).
**Sinonimi**: Agent swarm.
**Appare in**: [12](./12-agent-teams.md).
**Esempio**: 1 lead + 4 researcher per dossier paralleli.
**Correlati**: Subagent, Mailbox, Task list.

### Agent SDK
**Definizione**: libreria Python/TypeScript che espone Claude Code come componente embeddabile. Renamed da Claude Code SDK.
**Appare in**: [16](./16-headless-agent-sdk.md).
**Esempio**: `query()` in Python o TypeScript per app custom.
**Correlati**: Headless mode, `--bare`.

### Authority
**Definizione**: pilastro IMPACT che dichiara cosa l'agent puo' fare. Stratificato in 4 layer in Claude Code.
**Appare in**: [04b](./04b-authority-model.md), [04](./04-modalita-permessi.md), [07](./07-hooks.md), [18](./18-settings-auth.md).
**Esempio**: `permissions.deny: ["Bash(rm *)"]`.
**Correlati**: Sandbox, Hooks, Permission rules, Managed settings.

### Auto mode
**Definizione**: modalita' permessi research preview (v2.1.83+) in cui un classifier model approva/blocca tool call senza chiedere all'utente.
**Sinonimi**: classifier-based permissions.
**Appare in**: [04](./04-modalita-permessi.md), [04b](./04b-authority-model.md).
**Esempio**: `claude --permission-mode auto`.
**Correlati**: `--dangerously-skip-permissions`, Sandbox.

### Auto-memory
**Definizione**: sistema che permette a Claude di scrivere learnings persistenti in `~/.claude/projects/<project>/memory/`. ON di default da v2.1.59+.
**Appare in**: [06](./06-claude-md-memory.md), [06b](./06b-memory-architecture.md), [00b](./00b-context-engineering.md).
**Esempio**: Claude scrive `MEMORY.md` con build commands del progetto, caricato ogni sessione.
**Correlati**: CLAUDE.md, `.claude/rules/`, Plans directory.

---

## C

### Checkpoint
**Definizione**: snapshot automatico filesystem + conversation pre-edit. Recoverable via `/rewind` o Esc Esc.
**Sinonimi**: rewind point.
**Appare in**: [04](./04-modalita-permessi.md) sez. 4.5, [06b](./06b-memory-architecture.md) Layer 4.
**Esempio**: Esc Esc → "Restore code and conversation" su prompt 5 turn fa.
**Correlati**: `/rewind`, `--fork-session`.

### CLAUDE.md
**Definizione**: file markdown con regole, convenzioni, contesto del progetto, caricato automaticamente in ogni sessione. Hierarchy a 4 livelli (managed > project > user > local).
**Appare in**: [06](./06-claude-md-memory.md), [06b](./06b-memory-architecture.md), [00b](./00b-context-engineering.md).
**Esempio**: `~/.claude/CLAUDE.md` con regole anti-hallucination personali.
**Correlati**: `.claude/rules/`, Auto-memory, `@import`.

### Compound engineering
**Definizione**: pratica di comporre pattern architetturali (caching + idempotenza + parallelizzazione + verification) sopra l'harness per moltiplicare la produttivita'.
**Sinonimi**: compounding engineering.
**Appare in**: [22](./22-compound-engineering.md).
**Esempio**: `/loop` + idempotency + Monitor + worktree paralleli + auto-memory.
**Correlati**: Harness, Context engineering.

### Context engineering
**Definizione**: disciplina di scegliere cosa l'LLM vede ad ogni turn (statico/dinamico/strutturato) e in che forma. Livello evolutivo dopo prompt engineering.
**Appare in**: [00b](./00b-context-engineering.md).
**Esempio**: `ENABLE_PROMPT_CACHING_1H=1`, `@import` modulari, MCP tool search.
**Correlati**: CLAUDE.md, Auto-memory, Prompt engineering.

### Context window
**Definizione**: numero massimo di token che l'LLM puo' processare in un turn. 1M token GA per Opus 4.6 e Sonnet 4.6 dal 13 mar 2026.
**Appare in**: [05](./05-fast-mode-1m-context.md).
**Esempio**: codebase intero in single request su Opus 4.6.
**Correlati**: Prompt caching, Compaction.

### Control flow
**Definizione**: pilastro IMPACT che governa come l'agent esegue il loop reason→act→observe. In Claude Code: `/loop`, Monitor tool, hooks lifecycle, auto mode.
**Appare in**: [00](./00-harness-overview.md), [14b](./14b-agent-loop-react.md), [07](./07-hooks.md).
**Correlati**: Agent loop, Hooks.

### Cowork
**Definizione**: surface non-coding di Claude Code (Desktop app) per task generali. GA su tutti i piani paid (apr 2026).
**Appare in**: [17](./17-ide-surface.md).
**Esempio**: brief mattutino, gestione email.
**Correlati**: Computer use, Desktop app.

---

## D

### Dry-run
**Definizione**: esecuzione simulata senza side-effect. Pattern di guardrail per Routines, batch operations, IaC apply.
**Appare in**: [13](./13-routines-cloud.md), [22](./22-compound-engineering.md).
**Esempio**: `/schedule daily at 09:00, do not merge, dry-run only`.
**Correlati**: Plan mode, Hooks PreToolUse.

---

## E

### `/effort`
**Definizione**: comando per impostare il livello di reasoning effort del modello: `low`, `medium`, `high`, `xhigh`, `max`. Slider interattivo da v2.1.111.
**Appare in**: [03](./03-slash-commands.md), [05](./05-fast-mode-1m-context.md).
**Esempio**: `/effort xhigh` per task di reasoning complesso su Opus 4.7.
**Correlati**: Opus 4.7, Adaptive thinking.

---

## F

### Fast mode
**Definizione**: routing su serving path piu' veloce (~2.5x) per Opus 4.6. Stesso modello, $30/$150 per MTok. NON disponibile su Opus 4.7.
**Appare in**: [05](./05-fast-mode-1m-context.md).
**Esempio**: `/fast` con Tab → icona fulmine.
**Correlati**: `/effort`, Extra usage.

---

## G

### Guardrail
**Definizione**: limite hard che l'agent non puo' aggirare. In Claude Code: sandbox OS-level, deny rules, hooks block, managed policies.
**Sinonimi**: hard limit, safety layer.
**Appare in**: [04b](./04b-authority-model.md), [22](./22-compound-engineering.md).
**Correlati**: Sandbox, Hooks, Authority.

---

## H

### Harness
**Definizione**: orchestration layer attorno a un LLM che lo trasforma in un agent (context, tool, memory, planning, authority, control flow). Concetto formalizzato da Mitchell Hashimoto, feb 2026.
**Sinonimi**: agent harness, agent scaffolding.
**Appare in**: [00](./00-harness-overview.md), [22](./22-compound-engineering.md).
**Esempio**: Claude Code IS un harness. Cursor, Codex, Aider sono altri harness.
**Correlati**: Agent, IMPACT, Context engineering.

### Hook
**Definizione**: script eseguito deterministicamente al lifecycle dell'agent (28+ eventi). Puo' bloccare o modificare un'azione.
**Sinonimi**: lifecycle hook.
**Appare in**: [07](./07-hooks.md), [04b](./04b-authority-model.md).
**Esempio**: `PreToolUse` su `Bash(rm *)` blocca rm pericolosi.
**Correlati**: Authority, PreToolUse, PostToolUse.

### Headless mode
**Definizione**: esecuzione di Claude Code senza UI interattiva, via `claude -p "..."`. Output text/json/stream-json. Ideale per CI.
**Sinonimi**: print mode, `-p` mode.
**Appare in**: [16](./16-headless-agent-sdk.md).
**Esempio**: `claude -p "Review PR" --bare --output-format json`.
**Correlati**: Agent SDK, `--bare`.

---

## I

### IMPACT
**Definizione**: framework con 5 pilastri di un harness completo: **I**ntent, **M**emory, **P**lanning, **A**uthority, **C**ontrol flow.
**Appare in**: [00](./00-harness-overview.md), tutti i `0Nb` capitoli.
**Esempio**: CLAUDE.md = Intent + Memory; sandbox = Authority; `/loop` = Control flow.
**Correlati**: Harness.

### Intent
**Definizione**: pilastro IMPACT che cattura goal + constraints + acceptance criteria. In CC: CLAUDE.md, prompt iniziale dettagliato, `/init`.
**Appare in**: [00](./00-harness-overview.md), [06](./06-claude-md-memory.md).
**Correlati**: CLAUDE.md, Plan mode.

---

## L

### `/loop`
**Definizione**: bundled skill che esegue ripetutamente un prompt o slash command su intervallo (cron) o self-paced (Claude decide cadenza).
**Sinonimi**: `/proactive` (alias).
**Appare in**: [14](./14-loop-monitor.md), [22](./22-compound-engineering.md).
**Esempio**: `/loop 5m /babysit` per maintenance.
**Correlati**: Monitor tool, Routines, Agent loop.

---

## M

### Managed settings
**Definizione**: policy enterprise distribuite via MDM/system, non override-abile dall'utente.
**Appare in**: [18](./18-settings-auth.md), [04b](./04b-authority-model.md).
**Esempio**: `/Library/Application Support/ClaudeCode/managed-settings.json`.
**Correlati**: Authority, Enterprise plan.

### MCP (Model Context Protocol)
**Definizione**: protocollo open per collegare LLM a tool esterni (DB, API, file, app). Donato a Linux Foundation dic 2025.
**Appare in**: [10](./10-mcp.md).
**Esempio**: server `playwright`, `github`, `slack`, `sentry`.
**Correlati**: Plugin, Tool layer.

### Memory
**Definizione**: pilastro IMPACT per stato persistente cross-turn / cross-session. In CC: CLAUDE.md, auto-memory, `.claude/rules/`, plans directory, checkpoints.
**Appare in**: [06](./06-claude-md-memory.md), [06b](./06b-memory-architecture.md), [00](./00-harness-overview.md).
**Correlati**: CLAUDE.md, Auto-memory, Plans directory.

### Monitor tool
**Definizione**: tool built-in (v2.1.98) che spawna processi background; ogni stdout line streamata come notifica all'agent. Push-based vs polling.
**Appare in**: [14](./14-loop-monitor.md), [14b](./14b-agent-loop-react.md).
**Esempio**: Monitor tool con `tail -f logs/error.log`.
**Correlati**: Agent loop, `/loop`, Observation.

---

## P

### Plan mode
**Definizione**: modalita' read-only in cui Claude esplora e produce un piano implementativo prima di modificare. Trigger: `Shift+Tab` o `/plan`.
**Appare in**: [04](./04-modalita-permessi.md) sez. 4.2, [15b](./15b-planning-strategy.md).
**Esempio**: `/plan migrate auth from sessions to JWTs`.
**Correlati**: Ultraplan, Planning, Opus.

### Planning
**Definizione**: pilastro IMPACT per design pre-esecuzione. Spettro: zero plan → plan mode → ultraplan → batch.
**Appare in**: [15b](./15b-planning-strategy.md), [00](./00-harness-overview.md).
**Correlati**: Plan mode, Ultraplan.

### Plugin
**Definizione**: pacchetto che bundla skills + agents + hooks + MCP server + LSP server + monitor + settings. Installabile da marketplace.
**Appare in**: [11](./11-plugins-marketplace.md).
**Esempio**: `/plugin install code-simplifier@official`.
**Correlati**: Skill, MCP, Marketplace.

### Prompt caching
**Definizione**: cache lato Anthropic dei prompt cached per 5 min (default) o 1 ora (`ENABLE_PROMPT_CACHING_1H=1`). Riduce costi ~90%.
**Appare in**: [00b](./00b-context-engineering.md), [22](./22-compound-engineering.md).
**Correlati**: Context engineering, CLAUDE.md.

---

## R

### ReAct
**Definizione**: pattern **Re**asoning + **Act**ing che interleava ragionamento e azione. Paper Yao et al. 2022 (arXiv:2210.03629).
**Appare in**: [14b](./14b-agent-loop-react.md).
**Correlati**: Agent loop, Chain-of-Thought.

### Routines
**Definizione**: automazioni cloud Claude Code con trigger schedule + API + GitHub event. Eseguite su infra Anthropic, no laptop. Lanciate 14 apr 2026.
**Appare in**: [13](./13-routines-cloud.md).
**Esempio**: routine notturna che triagia bug Linear e apre draft PR.
**Correlati**: `/schedule`, `/loop`.

---

## S

### Sandbox
**Definizione**: isolation OS-level (Seatbelt macOS, bubblewrap Linux) per Bash e child process. Filesystem rules + network rules.
**Appare in**: [04](./04-modalita-permessi.md) sez. 4.4, [04b](./04b-authority-model.md).
**Esempio**: `sandbox.network.deniedDomains: ["*.evil.com"]`.
**Correlati**: Authority, Guardrail.

### Skill
**Definizione**: file markdown con frontmatter YAML che estende Claude (custom command). Auto-attivabile da Claude o user-invocable.
**Sinonimi**: `SKILL.md`.
**Appare in**: [09](./09-skills.md).
**Esempio**: `.claude/skills/release-notes/SKILL.md`.
**Correlati**: Slash command, Plugin, Subagent.

### Subagent
**Definizione**: agent con context window proprio, system prompt custom, tool/permessi indipendenti. Built-in: Explore, Plan, general-purpose.
**Appare in**: [08](./08-subagents.md).
**Esempio**: `.claude/agents/code-reviewer.md`.
**Correlati**: Agent, Agent team.

---

## T

### Task list
**Definizione**: lista condivisa di task con dipendenze (`addBlockedBy`, `addBlocks`). Tools: TaskCreate, TaskUpdate, TaskList.
**Appare in**: [12](./12-agent-teams.md).
**Correlati**: Agent team.

---

## U

### `/ultraplan`
**Definizione**: comando che delega planning a una sessione Claude Code on the web in plan mode. Browser review iterativa.
**Appare in**: [15](./15-ultraplan-ultrareview.md), [15b](./15b-planning-strategy.md).
**Esempio**: `/ultraplan migrate auth from sessions to JWTs`.
**Correlati**: Plan mode, Cloud session.

### `/ultrareview`
**Definizione**: code review multi-agent in cloud su branch o PR. Ogni finding verificato da agent indipendente.
**Appare in**: [15](./15-ultraplan-ultrareview.md).
**Esempio**: `/ultrareview 1234` per review PR GitHub.
**Correlati**: Code Review, Authority.

---

## Indice IMPACT

Per ogni componente IMPACT, capitoli rilevanti:

| Pilastro | Capitoli |
|---|---|
| **Intent** | [00](./00-harness-overview.md), [06](./06-claude-md-memory.md), [15b](./15b-planning-strategy.md) |
| **Memory** | [06](./06-claude-md-memory.md), [06b](./06b-memory-architecture.md), [00b](./00b-context-engineering.md) |
| **Planning** | [15](./15-ultraplan-ultrareview.md), [15b](./15b-planning-strategy.md), [04](./04-modalita-permessi.md) sez. plan mode |
| **Authority** | [04](./04-modalita-permessi.md), [04b](./04b-authority-model.md), [07](./07-hooks.md), [18](./18-settings-auth.md) |
| **Control flow** | [14](./14-loop-monitor.md), [14b](./14b-agent-loop-react.md), [07](./07-hooks.md) |

---

## Riferimenti aggregati

- Paper ReAct: https://arxiv.org/abs/2210.03629
- Hashimoto agent harness: https://mitchellh.com/writing/agent-harnesses
- Docs ufficiali: https://code.claude.com/docs/
- MCP spec: https://modelcontextprotocol.io
- Anthropic news: https://www.anthropic.com/news

---

← [22 Compound engineering](./22-compound-engineering.md) · Torna al [README](../README.md)
