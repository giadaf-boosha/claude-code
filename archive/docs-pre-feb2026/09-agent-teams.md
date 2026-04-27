# Claude Code Agent Teams: Guida Completa

> Data: 15/02/26

## Link di riferimento

- [Claude Code Docs - Orchestrate teams](https://docs.claude.com)
- [VibeCodeCamp](https://jumpspace.com)

## Cos'è e come funziona

Agent Teams è un sistema che permette di avviare 3-5 sessioni Claude Code parallele, ciascuna con il proprio context window, che collaborano su un progetto comune. A differenza dei subagent tradizionali (che eseguono un task e restituiscono un riassunto al "chiamante"), qui gli agenti possono comunicarsi tra loro direttamente, condividere una task list, e coordinarsi in modo autonomo.

### Architettura

L'architettura si compone di quattro elementi fondamentali:

- **Team Lead**: la sessione principale di Claude Code che crea il team, assegna i compiti e sintetizza i risultati
- **Teammates**: istanze separate di Claude Code, ognuna con il proprio contesto, che lavorano in parallelo
- **Task List**: lista condivisa di work item che i teammate possono reclamare e completare
- **Mailbox**: sistema di messaggistica che permette la comunicazione diretta tra agenti

### Filesystem

| Risorsa | Path |
|---------|------|
| Team config | `~/.claude/teams/{team-name}/config.json` |
| Task list | `~/.claude/tasks/{team-name}/` |
| Inbox messaggi | `~/.claude/teams/<team_id>/inbox/` |
| Settings globali | `~/.claude/settings.json` |

## Come attivarlo

**Step 1** — Aggiornare Claude Code all'ultima versione.

**Step 2** — Abilitare il feature flag:

```bash
code ~/.claude/settings.json
```

Aggiungi:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

**Step 3** — Riavvia il terminale e avvia una nuova sessione Claude Code. Basta descrivere nel prompt che vuoi creare un agent team e Claude lo farà automaticamente.

## Il ciclo di vita interno

Il blog di VibeCodeCamp ha fatto reverse engineering della sequenza operativa:

1. **TeamCreate** — crea la struttura del team (cartella `.claude/teams/`). A questo punto il team esiste ma non ha ancora agenti assegnati.
2. **TaskCreate** — crea i singoli task come file JSON, ciascuno con ID, descrizione, stato (`pending`/`in_progress`/`complete`), owner e dipendenze tra task.
3. **Task tool (potenziato)** — è lo stesso strumento dei subagent, ma con nuovi parametri `name` e `team_name` che attivano la modalità Agent Teams.
4. **taskUpdate** — ogni agente lo usa per reclamare task, aggiornare lo stato, segnalare completamento.
5. **sendMessage** — il cuore della differenza rispetto ai subagent: supporta messaggi diretti (agente → agente) e broadcast (agente → tutti). I messaggi vengono scritti nelle inbox e iniettati nella conversation history del destinatario come `<teammate-message>`.

Lo shutdown segue un protocollo collaborativo: il lead invia una `shutdown_request`, il teammate risponde con `shutdown_response` per confermare, e un hook `postToolCall` termina la sessione.

## Differenze chiave rispetto ai Subagent

| Aspetto | Subagent | Agent Teams |
|---------|----------|-------------|
| Contesto | Proprio context, risultati tornano come riassunto | Proprio context, completamente indipendente |
| Comunicazione | Solo verso il "padre" (unidirezionale) | Tra tutti i teammate (bidirezionale) |
| Coordinamento | Gestito interamente dall'agente principale | Task list condivisa con auto-coordinamento |
| Ideale per | Task focalizzati dove serve solo il risultato | Lavoro complesso che richiede discussione e collaborazione |
| Costo token | Più basso | Significativamente più alto |

**Regola pratica**: usa i subagent quando hai bisogno di "lavoratori veloci" che restituiscono un output. Usa Agent Teams quando gli agenti devono confrontarsi, sfidarsi a vicenda e coordinarsi autonomamente.

## Modalità di visualizzazione

### In-process (default)

Tutti i teammate girano nello stesso terminale. Navigazione:
- `Shift+Up/Down` per navigare tra i teammate
- `Enter` per vedere la sessione
- `Escape` per interrompere il turno corrente

### Split panes

Ogni teammate ha il proprio pannello. Richiede tmux o iTerm2 (con Python API abilitata).

```bash
claude --teammate-mode tmux
```

Per iTerm2: Settings → General → Magic → Enable Python API, poi installare la CLI `it2`.

## Navigazione e interazione (tastiera)

| Comando | Azione |
|---------|--------|
| `Shift+Up` / `Shift+Down` | Navigare tra i teammate (in-process mode) |
| `Enter` | Visualizzare la sessione di un teammate selezionato |
| `Escape` | Interrompere il turno corrente di un teammate |
| `Ctrl+T` | Toggle della task list |
| `Shift+Tab` | Attivare/disattivare il delegate mode (lead solo coordinamento) |

## Configurazione e avvio

Forzare la modalità in-process per una singola sessione:

```bash
claude --teammate-mode in-process
```

Impostare la modalità teammate di default in `settings.json`:

```json
{
  "teammateMode": "in-process"
}
```

Il valore default è `"auto"`, che usa split panes se sei già in una sessione tmux, altrimenti in-process.

## Prompt di esempio per il lead

### Creare un team generico

```
I'm designing a CLI tool that helps developers track TODO comments across
their codebase. Create an agent team to explore this from different angles:
one teammate on UX, one on technical architecture, one playing devil's advocate.
```

### Specificare numero di teammate e modello

```
Create a team with 4 teammates to refactor these modules in parallel.
Use Sonnet for each teammate.
```

### Richiedere approvazione del piano prima dell'implementazione

```
Spawn an architect teammate to refactor the authentication module.
Require plan approval before they make any changes.
```

### Code review parallela

```
Create an agent team to review PR #142. Spawn three reviewers:
- One focused on security implications
- One checking performance impact
- One validating test coverage
Have them each review and report findings.
```

### Debug con ipotesi concorrenti

```
Users report the app exits after one message instead of staying connected.
Spawn 5 agent teammates to investigate different hypotheses. Have them talk to
each other to try to disprove each other's theories, like a scientific
debate. Update the findings doc with whatever consensus emerges.
```

### Dare contesto specifico a un teammate

```
Spawn a security reviewer teammate with the prompt: "Review the authentication
module at src/auth/ for security vulnerabilities. Focus on token handling, session
management, and input validation. The app uses JWT tokens stored in httpOnly
cookies. Report any issues with severity ratings."
```

### Forzare il lead ad aspettare i teammate

```
Wait for your teammates to complete their tasks before proceeding
```

### Shutdown e cleanup

```
Ask the researcher teammate to shut down
```

```
Clean up the team
```

## Gestione sessioni tmux (troubleshooting)

```bash
# Verificare che tmux sia installato
which tmux

# Elencare le sessioni tmux attive
tmux ls

# Terminare una sessione tmux orfana
tmux kill-session -t <session-name>
```

## Hook disponibili per quality gates

| Hook | Quando scatta | Comportamento con exit code 2 |
|------|--------------|-------------------------------|
| `TeammateIdle` | Quando un teammate sta per andare idle | Invia feedback e mantiene il teammate attivo |
| `TaskCompleted` | Quando un task viene marcato completo | Impedisce il completamento e invia feedback |

## Tool interni (dal reverse engineering di VibeCodeCamp)

| Tool | Funzione |
|------|----------|
| `TeamCreate` | Crea la struttura del team in `.claude/teams/` |
| `TaskCreate` | Crea singoli task come JSON con ID, stato, owner, dipendenze |
| `Task` (potenziato) | Avvia agenti; con parametri `name` e `team_name` attiva la modalità team |
| `taskUpdate` | Permette agli agenti di reclamare task e aggiornare lo stato |
| `sendMessage` | Messaggi diretti (agent→agent) o broadcast (agent→tutti) |
| `taskList` / `getTask` | Consultare la lista task condivisa |
| `shutdown_request` / `shutdown_response` | Protocollo di shutdown collaborativo tra lead e teammate |

## Casi d'uso e esempi pratici

### 1. Code Review parallela (il più immediato)

Ogni reviewer applica un filtro diverso allo stesso PR. Il lead sintetizza alla fine.

### 2. Debug con ipotesi concorrenti (il più potente)

Questo è il caso dove Agent Teams brillano di più. Un singolo agente tende a trovare una spiegazione plausibile e fermarsi. Più agenti che si sfidano attivamente producono diagnosi molto più affidabili.

### 3. Esplorazione progettuale multi-prospettiva

Un teammate su UX, uno su architettura tecnica, uno come devil's advocate.

### 4. Sviluppo parallelo di moduli indipendenti

Fondamentale: ogni teammate deve lavorare su file diversi per evitare conflitti di sovrascrittura.

## Best practice per l'uso ottimale

- **Dai contesto sufficiente nel prompt di spawn** — i teammate caricano CLAUDE.md e la configurazione del progetto, ma NON ereditano la storia della conversazione del lead
- **Dimensiona i task correttamente** — troppo piccoli e l'overhead di coordinamento supera il beneficio; troppo grandi e i teammate lavorano troppo a lungo senza checkpoint. L'ideale sono 5-6 task per teammate
- **Usa il delegate mode** (`Shift+Tab`) quando vuoi che il lead si limiti a orchestrare senza implementare direttamente
- **Richiedi l'approvazione del piano** per task rischiosi
- **Usa gli hooks per quality gates**: `TeammateIdle` e `TaskCompleted` permettono di iniettare feedback automatico
- **Monitora attivamente** — non lasciare il team incustodito troppo a lungo. Controlla i progressi, reindirizza approcci che non funzionano, sintetizza i risultati man mano

## Limitazioni attuali

Essendo ancora sperimentale, ci sono vincoli importanti:

- Non c'è session resumption per i teammate in-process
- Lo stato dei task può andare fuori sync
- Un solo team per sessione
- Niente team annidati
- Il lead non può essere cambiato
- Lo split-pane non funziona nel terminale integrato di VS Code né su Windows Terminal
