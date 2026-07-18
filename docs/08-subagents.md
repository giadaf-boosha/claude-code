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
claude agents                  # Agent View (lista + stato sessioni)
```

> **`agent` in `settings.json` per dispatch** (da v2.1.157): il campo `agent` in `.claude/settings.json` (o `~/.claude/settings.json`) viene ora rispettato anche per le sessioni dispatch — Claude usa l'agente configurato di default senza richiederlo esplicitamente a ogni invocazione. Override per singola sessione: `--agent <name>`.
>
> ```json
> { "agent": "code-reviewer" }
> ```

> **Agent View** (research preview, da v2.1.139): `claude agents` non mostra piu' solo una lista statica, ma apre una vista unificata di tutte le sessioni Claude Code — in esecuzione, bloccate in attesa di input, o completate. Navigabile da CLI, e' il modo nativo di gestire sessioni multiple in parallelo ("kind of like tmux built for CC" — [@trq212](https://x.com/trq212/status/2053979505346425179)).
>
> Da v2.1.145 il flag `--json` restituisce la stessa lista in JSON su stdout — utile per scripting, integrazione con tmux-resurrect, status bar custom e qualsiasi automazione che deve interrogare lo stato delle sessioni attive:
>
> ```bash
> claude agents --json          # array JSON di tutte le sessioni live
> claude agents --json | jq '.[] | select(.status=="waiting")'
> ```
>
> Il tab title mostra anche il count dei messaggi in attesa; gli span OTEL `claude_code.tool` includono ora `agent_id` e `parent_agent_id` per tracing gerarchico.
>
> **Sessioni pinnate** (da v2.1.147): `Ctrl+T` nella Agent View pinna una sessione. Le sessioni pinnate restano attive anche quando idle (non vengono terminate per inattivita') e si riavviano automaticamente per applicare gli aggiornamenti di Claude Code. Sotto pressione di memoria, vengono scaricate solo dopo le sessioni non pinnate. Utile per agent di lunga durata o sessioni di monitoring che non devono essere interrotte.
>
> **Esecuzione comandi in background** (da v2.1.154): digitare `! <comando>` in Agent View esegue il comando shell in una nuova sessione background senza uscire dall'interfaccia — equivalente CLI: `claude --bg --exec '<comando>'`.

<sub>Aggiornato 2026-05-29 via daily what's new. Fonte: [GitHub Releases v2.1.154](https://github.com/anthropics/claude-code/releases/tag/v2.1.154).</sub>

> **Cross-session messaging hardening** (da v2.1.166): i messaggi inoltrati via `SendMessage` da un'altra sessione Claude non portano piu' l'autorita' dell'utente. Le sessioni riceventi rifiutano le richieste di permesso inoltrate; in auto mode vengono bloccate direttamente. Questo significa che un agente che riceve un messaggio da un altro agente non puo' eseguire azioni che richiederebbero conferma utente, anche se l'agente mittente avrebbe quell'autorita'. Il comportamento era gia' documentato come best practice; ora e' applicato dall'harness. Fonte: [GitHub Releases v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166).

> **Sub-agenti annidati fino a 5 livelli** (da v2.1.172): un sub-agente puo' ora lanciare a sua volta altri sub-agenti, con profondita' massima di 5 livelli. Ogni livello ha il proprio context window isolato e restituisce solo un summary al livello padre — permette a task gerarchici complessi di suddividere ulteriormente il lavoro senza saturare il context dell'agente principale. Il limite di 5 livelli e' un punto di partenza configurabile (Boris Cherny ha esplicitamente richiesto feedback sulla soglia).
>
> ```
> main agent (L0)
>   └─ sub-agent A (L1)
>        └─ sub-agent B (L2)
>             └─ sub-agent C (L3, max L5)
> ```

<sub>Aggiornato 2026-06-11 via daily what's new. Fonte: [GitHub Releases v2.1.172](https://github.com/anthropics/claude-code/releases/tag/v2.1.172).</sub>

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
| `/fork` (alias `/branch`) | Da v2.1.212: copia l'intera conversazione in una **nuova sessione background**, con riga propria in `claude agents` — il thread principale resta libero |
| `/subtask <instruction>` | Da v2.1.212: spawna un subagent **dentro** la sessione corrente — e' il comportamento che `/fork` aveva prima di v2.1.212 |

Da v2.1.117: forked subagents su external builds (`CLAUDE_CODE_FORK_SUBAGENT=1`). Da v2.1.212 la distinzione e' esplicita nel nome del comando: `/fork` = nuova sessione indipendente, `/subtask` = subagent figlio nella sessione corrente. La stessa release ha introdotto tetti di sicurezza per-sessione (default, override via env var): fino a 200 chiamate WebSearch (`CLAUDE_CODE_MAX_WEB_SEARCHES_PER_SESSION`) e fino a 200 spawn di subagent (`CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION`), pensati per fermare loop di ricerca o delega fuori controllo.

<sub>Aggiornato 2026-07-18 via daily what's new. Fonte: [GitHub Releases v2.1.212](https://github.com/anthropics/claude-code/releases/tag/v2.1.212).</sub>

---

## 8.6 Persistent memory

Subagents possono mantenere auto-memory propria. Vedi [`/en/sub-agents#enable-persistent-memory`](https://code.claude.com/docs/en/sub-agents#enable-persistent-memory).

---

## 8.6b Usage attribution per subagent

Il comando `/usage` e il dialog "Account & usage" (VS Code) mostrano i token consumati con breakdowns granulari:

| Voce | Cosa include |
|---|---|
| Subagents | Token di ogni sotto-agente (per `subagent_type`) |
| Skills | Token consumati durante l'esecuzione di ogni skill |
| Plugins | Token delle skill/agenti iniettati da plugin |
| MCP servers | Tool call verso ogni MCP server |
| Cache misses | Prompt cache non servita (context ricalcolato) |
| Long context | Richieste oltre la soglia standard di context |

Utile per identificare quali agenti o skill costano di piu' in un workflow agentic complesso, prima di ottimizzare il modello, ridurre il contesto, o spostare task su Haiku.

<sub>Aggiornato 2026-06-12 via daily what's new. Fonte: [GitHub Releases v2.1.174](https://github.com/anthropics/claude-code/releases/tag/v2.1.174).</sub>

---

## 8.6c Background agents — auto-delivery (da v2.1.198)

Gli agenti background che lavorano in un git worktree possono ora chiudere il loop di delivery in modo completamente automatico: al termine dell'elaborazione, l'agente esegue commit, push e apre una draft PR senza intervento manuale.

**Come funziona**:
1. L'agente background riceve il task e opera in un worktree isolato
2. Al completamento, verifica se ci sono modifiche staged/committabili
3. Esegue commit con messaggio generato automaticamente
4. Push sul remote e apre una draft PR

**Configurazione**: abilitato di default per agenti background con `isolation: "worktree"` quando il progetto ha un remote git configurato. Per disabilitare: `"bgAutoDeliver": false` in `settings.json`.

**Quando usarlo**: task delegati (code review fix, refactor specifici, generazione test) dove vuoi trovare una PR pronta senza dover poi fare commit manualmente.

<sub>Aggiornato 2026-07-02 via daily what's new. Fonte: [GitHub Releases v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198).</sub>

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
8. **`/workflows` per orchestrazione massiva**: descrivi il task in linguaggio naturale, Claude genera e lancia un workflow con decine/centinaia di agenti background — nessuna definizione manuale dei subagent richiesta (da v2.1.154).

---

## 8.10 Fonti

- Docs: [`/en/sub-agents`](https://code.claude.com/docs/en/sub-agents)
- Skill chaining tip: [@bcherny](https://x.com/bcherny/status/2006170607092670691)

---

← [07 Hooks](./07-hooks.md) · Successivo → [09 Skills](./09-skills.md)
