# 08 — Subagents

> 📍 [README](../README.md) → [Estensibilita'](../README.md#estensibilita) → **08 Subagents**
> 🔧 Operational · 🟡 Intermediate

Subagent = AI assistant specializzato con context window proprio, system prompt custom, tool e permessi indipendenti. Quando Claude trova task matchato dalla `description`, delega.

## Cosa e' concettualmente

> I subagent sono **agent figli** spawnati dall'agent principale. Ognuno ha context window indipendente, tool subset, ev. modello diverso (Haiku per Explore = cheap+fast). Il main agent delega un task, riceve summary, continua. Pattern di "cognitive offloading": il main thread non si sporca con dettagli operativi.

**Modello mentale**: come `fork()` in un OS — processo figlio con stato isolato, comunicazione strutturata col padre via return value.

**Componente harness IMPACT**: Orchestration + Tool layer (ogni subagent e' un tool composito).

**Per il deep-dive**: [12 — Agent teams](./12-agent-teams.md) per il livello successivo (multi-agent persistenti) + [00b — Context engineering § Subagent Explore](./00b-context-engineering.md).

> "Each subagent runs in its own context window with a custom system prompt, specific tool access, and independent permissions." — [`/en/sub-agents`](https://code.claude.com/docs/en/sub-agents)

---

## 8.1 Dove vivono

| Scope | Path | Applies to |
|---|---|---|
| Enterprise | Managed settings | Tutti gli utenti dell'org |
| User | `~/.claude/agents/<name>.md` | Tutti i progetti |
| Project | `.claude/agents/<name>.md` | Progetto |
| Plugin | `<plugin>/agents/<name>.md` | Dove plugin abilitato |

---

## 8.2 Frontmatter completo

```yaml
---
name: code-reviewer            # opzionale, default = filename
description: Reviews code for quality and security
tools: Read, Grep, Glob        # opzionale, default = tutti
model: sonnet|opus|inherit     # opzionale
mcpServers: [github]           # opzionale (da v2.1.117 anche per main-thread agent)
skills: [api-docs]             # opzionale, preload skills nel system prompt
proactive: true                # auto-invoke se proattivo
hooks:                         # hook scoped al subagent
  PostToolUse:
    - matcher: Edit
      hooks:
        - type: command
          command: ".claude/hooks/format.sh"
---

You are an expert code reviewer focusing on...
```

---

## 8.3 Subagents built-in

| Nome | Funzione | Tool disponibili |
|---|---|---|
| `Explore` | Codebase exploration read-only | Glob, Grep, LS, Read, NotebookRead, WebFetch, TodoWrite, WebSearch (no Edit/Write) |
| `Plan` | Planning agent (read-only) | Stessi di Explore |
| `general-purpose` | Default, accesso completo | Tutti |

Custom: in `.claude/agents/*.md` o `~/.claude/agents/*.md` o plugin.

---

## 8.4 Spawn / interazione

### Da CLI
```bash
claude --agent code-reviewer
claude --agents '[{"name":"adhoc","tools":["Read","Bash"]}]'
claude agents                  # lista
```

### Dal main agent
Claude usa il tool **Agent** specificando `subagent_type`:
```json
{
  "subagent_type": "Explore",
  "prompt": "Trova tutti gli endpoint API nel monorepo",
  "description": "Endpoint search",
  "run_in_background": false
}
```

### Skill come subagent
Skill con `context: fork` + `agent: Explore` → il body della skill diventa task di un subagent (vedi [09 Skills](./09-skills.md)).

---

## 8.5 Forking di sessione

| Comando | Effetto |
|---|---|
| `claude --continue --fork-session` | Resume + branching senza perdere session originale |
| `claude --resume X --fork-session` | Stesso ma con session ID specifico |
| `CLAUDE_CODE_FORK_SUBAGENT=1` + `/fork` | Spawn come subagent |

Da v2.1.117: forked subagents su external builds (`CLAUDE_CODE_FORK_SUBAGENT=1`).

---

## 8.6 Persistent memory

Subagents possono mantenere auto-memory propria. Vedi [`/en/sub-agents#enable-persistent-memory`](https://code.claude.com/docs/en/sub-agents#enable-persistent-memory).

---

## 8.7 Subagent vs Agent Teams

|  | Subagents | Agent Teams |
|---|---|---|
| Context | Own, results back to caller | Own, fully independent |
| Communication | Solo to caller | Direct teammate-to-teammate (mailbox) |
| Coordination | Main agent | Shared task list + self-coord |
| Token cost | Lower (Explore/Plan: Haiku) | Higher (each = full instance) |
| Use case | Search, plan, review | Long collaborative project |

Approfondimento Agent Teams: [12](./12-agent-teams.md).

---

## 8.8 Esempi pratici

### A. Subagent "code-reviewer" project-scoped

`.claude/agents/code-reviewer.md`:
```yaml
---
name: code-reviewer
description: Review PR diff per security, correctness, style. Usalo dopo ogni implementazione importante.
tools: Read, Grep, Glob, Bash
model: sonnet
proactive: true
---

Sei un senior reviewer. Per ogni file modificato:
1. Identifica vulnerabilita' (OWASP top 10)
2. Verifica naming convention del progetto (vedi CLAUDE.md)
3. Cerca duplicazione di logica
4. Suggerisci semplificazioni

Output: lista bullet con file:linea + severita'.
```

### B. Subagent "research" parallelo

`.claude/agents/research.md`:
```yaml
---
name: research
description: Ricerca web + docs ufficiali per tema specifico
tools: WebSearch, WebFetch, Read
model: sonnet
---

Conduci una ricerca su <task>. Cita SEMPRE le fonti con link.
Restituisci un dossier markdown strutturato.
```

Spawn parallelo:
```
Spawn 4 research agents in parallel: docs ufficiali, post X, paper accademici, GitHub trending.
```

### C. Skill chaining via subagent

Tip Boris:
> "Yes, just ask claude to invoke skill 1, then skill 2, then skill 3, in natural language. Or ask it to use parallel subagents to invoke the skills in parallel. Then if you want, put that all in a skill." — [@bcherny](https://x.com/bcherny/status/2006170607092670691)

---

## 8.9 Tips operative

1. **Subagent Explore per ricerca codebase**: piu' veloce e cheap (Haiku) di main session. Restituisce summary, non output massivo.
2. **Subagent Plan per architettura**: read-only, propone piano implementativo.
3. **Subagent custom per review**: con `proactive: true` viene invocato senza chiedere.
4. **Tools restrittivi**: limita ogni subagent solo ai tool che servono. Riduce token e rischio.
5. **`context: fork` su skill** quando la skill richiede esplorazione lunga e non vuoi che inquini la conversation principale.
6. **Skills preload nel subagent**: usa `skills: [...]` nel frontmatter per avere domain knowledge gia' caricata.
7. **Parallel spawn** quando i task sono indipendenti: 1 messaggio con N tool call all'`Agent` tool.

---

## 8.10 Fonti

- Docs: [`/en/sub-agents`](https://code.claude.com/docs/en/sub-agents)
- Skill chaining tip: [@bcherny](https://x.com/bcherny/status/2006170607092670691)

---

← [07 Hooks](./07-hooks.md) · Successivo → [09 Skills](./09-skills.md)
