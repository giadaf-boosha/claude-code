# 24 — Dynamic Workflows (orchestrazione subagent su scala)

> Capitolo della guida Claude Code. Vedi [README](../README.md).

Un dynamic workflow e' uno **script JavaScript** che Claude scrive per il task che descrivi e che un runtime esegue **in background**, orchestrando da decine a centinaia di [subagent](./08-subagents.md) in parallelo mentre la sessione resta libera.

## Cosa e' concettualmente

> I workflow spostano il *piano* dentro il codice. Con subagent e skill l'orchestratore e' Claude turno per turno, e ogni risultato intermedio finisce nel suo context window. Con un workflow, il loop, il branching e i risultati intermedi vivono nello **script** (in variabili), quindi il context di Claude trattiene solo la risposta finale. E' il passaggio da "agent che coordina a voce" a "orchestrazione codificata, leggibile e ri-eseguibile".

**Modello mentale**: come un job di build/CI parallelo (es. una pipeline con fan-out di N worker) ma scritto al volo dall'LLM, dove ogni worker e' un subagent Claude invece di uno step bash.

**Componente harness IMPACT**: Orchestration (script-driven, deterministica) + Control flow esternalizzato dal context.

**Per il deep-dive**: [12 — Agent Teams](./12-agent-teams.md) (orchestrazione multi-thread interattiva) e [08 — Subagents](./08-subagents.md) (il primitivo "worker" che i workflow orchestrano).

Lanciati il **28 maggio 2026** con Opus 4.8, in **research preview**. Richiedono **Claude Code v2.1.154 o successivo**.

> Fonti: [`/en/workflows`](https://code.claude.com/docs/en/workflows), [blog Anthropic — Introducing dynamic workflows](https://claude.com/blog/introducing-dynamic-workflows-in-claude-code), [changelog v2.1.154](https://code.claude.com/docs/en/changelog).

> **2026-07-07 (auto-update)**: nuova setting "Dynamic workflow size" in `/config` (v2.1.202, 6 lug) regola quanto grandi Claude tende a fare i workflow (small/medium/large agent count) — linea guida advisory, non un cap imposto. Aggiunti anche attributi OTel `workflow.run_id`/`workflow.name` per ricostruire l'attivita' di un run dai dati di telemetria. Fonte: [GitHub Releases v2.1.202](https://github.com/anthropics/claude-code/releases/tag/v2.1.202). Vedi anche README "What's new today" del giorno.

---

## 24.1 Quando usare un workflow (vs subagent vs skill)

Subagent, skill e workflow possono tutti eseguire un task multi-step. La differenza e' **chi tiene il piano**.

|  | **Subagents** | **Skills** | **Workflows** |
|---|---|---|---|
| Cos'e' | Un worker che Claude spawna | Istruzioni che Claude segue | Uno script che il runtime esegue |
| Chi decide il prossimo step | Claude, turno per turno | Claude, seguendo il prompt | Lo script |
| Dove vivono i risultati intermedi | Context di Claude | Context di Claude | Variabili dello script |
| Cosa e' ripetibile | La definizione del worker | Le istruzioni | L'orchestrazione stessa |
| Scala | Pochi task delegati per turno | Idem subagent | Da decine a centinaia di agent per run |
| Interruzione | Riavvia il turno | Riavvia il turno | Resumable nella stessa sessione |

Usa un workflow quando: il task richiede **piu' agent di quanti una conversazione possa coordinare**, oppure quando vuoi l'orchestrazione **codificata come script** da rileggere e ri-eseguire. Casi tipici: bug sweep su tutta la codebase, migrazione di 500 file, una domanda di ricerca con fonti da cross-checkare l'una contro l'altra, un piano difficile da abbozzare da piu' angolazioni indipendenti prima di sceglierne una.

> Il valore non e' solo "piu' agent": un workflow puo' applicare un **pattern di qualita' ripetibile**, es. agent indipendenti che revisionano in modo adversarial i risultati l'uno dell'altro prima di riportarli, o un piano abbozzato da piu' angolazioni e poi pesato. Risultato piu' affidabile di un singolo passaggio.

---

## 24.2 Il workflow bundled: `/deep-research`

Claude Code include un workflow built-in per investigare una domanda su molte fonti.

| Comando | Cosa fa |
|---|---|
| `/deep-research <domanda>` | Fan-out di web search sulla domanda da piu' angolazioni, fetch e cross-check delle fonti, voto su ogni claim, e ritorna un report citato con i claim che non sopravvivono al cross-check gia' filtrati. Richiede il [WebSearch tool](https://code.claude.com/docs/en/tools-reference#websearch-tool-behavior) disponibile |

```text
/deep-research What changed in the Node.js permission model between v20 and v22?
```

Flusso: (1) lanci il comando; (2) Claude Code chiede se autorizzare il workflow → **Yes**; (3) il run parte in background — apri `/workflows`, seleziona il run con le frecce, Enter per la progress view (fasi con agent count, token totali, tempo trascorso); (4) a fine run il report citato atterra nella sessione.

> I workflow che salvi tu (vedi §24.5) diventano comandi `/<nome>` allo stesso modo e appaiono nell'autocomplete `/` accanto a quelli bundled.

---

## 24.3 Far scrivere un workflow a Claude

Due modi per far scrivere un workflow al volo:

### A. Keyword `workflow` nel prompt
Includi la parola `workflow` in un punto qualsiasi del prompt. Claude Code la evidenzia e Claude scrive uno script invece di lavorare turno per turno.

```text
Run a workflow to audit every API endpoint under src/routes/ for missing auth checks
```

- Se la keyword viene evidenziata per sbaglio: `alt+w` per ignorarla in questo prompt, oppure backspace col cursore subito dopo la parola.
- Per disattivarla del tutto: spegni **Workflow keyword trigger** in `/config`.

### B. `/effort ultracode` (Claude decide)
Ultracode combina effort `xhigh` con orchestrazione automatica dei workflow: Claude pianifica un workflow per ogni task sostanziale senza che tu lo chieda.

```text
/effort ultracode
```

Una singola richiesta puo' diventare piu' workflow in fila (uno per capire il codice, uno per la modifica, uno per verificarla). Vale per **ogni** task della sessione → piu' token e piu' tempo. Dura per la sessione corrente e si resetta a nuova sessione; torna indietro con `/effort high`. Disponibile solo su modelli che supportano effort `xhigh`.

---

## 24.4 Approvazione del piano prima del run

Nella CLI il prompt per-run mostra le fasi pianificate e queste opzioni:

- **Yes, run it**: avvia
- **Yes, and don't ask again for `<name>` in `<path>`**: avvia e salta il prompt per questo workflow in questo progetto
- **View raw script**: leggi lo script prima
- **No**: annulla

`Ctrl+G` apre lo script nell'editor; `Tab` consente di aggiustare il prompt prima del run.

Se vieni interpellato dipende dal [permission mode](./04-modalita-permessi.md):

| Permission mode | Quando ti viene chiesto |
|---|---|
| Default, accept edits | Ogni run, salvo "Yes, and don't ask again" per quel workflow nel progetto |
| Auto | Solo al primo lancio (consenso salvato nelle user settings). Saltato del tutto con ultracode |
| Bypass permissions, `claude -p`, Agent SDK | Mai. Il run parte subito |

> Importante: il permission mode controlla **solo** il prompt di lancio. I subagent spawnati dal workflow girano sempre in `acceptEdits` ed ereditano la tua [tool allowlist](https://code.claude.com/docs/en/settings#permission-settings), indipendentemente dalla modalita' di sessione. Le modifiche ai file sono auto-approvate. Shell command, web fetch e tool MCP non in allowlist possono comunque interromperti a meta' run — aggiungili all'allowlist prima di un run lungo.

---

## 24.5 Salvare un workflow per il riuso

Apri `/workflows`, seleziona il run, premi `s`. Nel dialog `Tab` alterna le due destinazioni:

- `.claude/workflows/` nel progetto: condiviso con chi clona il repo
- `~/.claude/workflows/` nella home: disponibile in ogni progetto, visibile solo a te

`Enter` per salvare. Il workflow gira come `/<nome>` nelle sessioni future. Se un workflow di progetto e uno personale hanno lo stesso nome, vince quello di **progetto**.

---

## 24.6 Come gira un workflow (runtime, limiti, costi)

Il runtime esegue lo script in un ambiente isolato, separato dalla conversazione. I risultati intermedi restano in variabili dello script invece di finire nel context di Claude. Il runtime traccia il risultato di ogni agent man mano → e' cio' che rende un run **resumable** nella stessa sessione.

### Vincoli del runtime

| Vincolo | Perche' |
|---|---|
| Nessun input utente a meta' run | Solo i permission prompt degli agent possono mettere in pausa. Per sign-off tra stage, esegui ogni stage come workflow separato |
| Nessun accesso diretto a filesystem/shell dal workflow stesso | Sono gli **agent** a leggere, scrivere ed eseguire comandi. Lo script coordina gli agent |
| Fino a **16 agent concorrenti** (meno su macchine con pochi core CPU) | Limita l'uso di risorse locali |
| **1.000 agent totali per run** | Previene loop runaway |

### Controllo della progress view (`/workflows`)

| Tasto | Azione |
|---|---|
| `↑` / `↓` | Seleziona fase o agent |
| `Enter` / `→` | Drill into fase, poi agent (prompt, tool call recenti, risultato) |
| `Esc` | Indietro di un livello |
| `j` / `k` | Scroll nel dettaglio agent |
| `p` | Pausa / resume del run |
| `x` | Stop dell'agent selezionato, o dell'intero workflow se il focus e' sul run |
| `r` | Restart dell'agent in esecuzione selezionato |
| `s` | Salva lo script del run come comando |

### Resume
Se fermi un run puoi riprenderlo: gli agent gia' completati ritornano i risultati cache-ati, gli altri girano live. Resume da `/workflows` selezionando e premendo `p`. **Funziona solo nella stessa sessione**: se esci da Claude Code mentre un workflow gira, la sessione successiva lo riavvia da zero.

### Costi
Un run spawna molti agent → puo' consumare molti piu' token della stessa cosa in conversazione. I run contano verso usage e rate limit del piano. Ogni agent usa il **modello della sessione** salvo che lo script instradi uno stage altrove. Per controllare il costo: controlla `/model` prima di un run grosso, e chiedi a Claude di usare un modello piu' piccolo per gli stage che non richiedono il top.

---

## 24.7 Disponibilita' e disattivazione

Disponibili in: CLI, Desktop app, IDE extensions, [non-interactive mode](./16-headless-agent-sdk.md) (`claude -p`), Agent SDK. Su tutti i piani a pagamento, con accesso API Anthropic, e su Amazon Bedrock, Google Cloud Vertex AI, Microsoft Foundry. **Su Pro** vanno attivati dalla riga *Dynamic workflows* in `/config`.

Per disattivarli (per te):
- Toggle *Dynamic workflows* off in `/config` (persiste)
- `"disableWorkflows": true` in `~/.claude/settings.json` (persiste)
- `CLAUDE_CODE_DISABLE_WORKFLOWS=1` (letto allo startup, vale ovunque)

Per tutta l'organizzazione: `"disableWorkflows": true` nelle [managed settings](https://code.claude.com/docs/en/server-managed-settings), o il toggle nella pagina [admin Claude Code](https://claude.ai/admin-settings/claude-code). Disattivati: i comandi bundled spariscono, la keyword `workflow` non triggera piu', `ultracode` esce dal menu `/effort`.

---

## 24.8 Esempi pratici

### A. Audit auth su tutti gli endpoint
```text
Run a workflow to audit every API endpoint under src/routes/ for missing auth checks.
For each endpoint report file:line and the missing guard.
```
Fan-out: un agent per gruppo di route, review adversarial dei findings, report consolidato.

### B. Migrazione large-scale
```text
Workflow: migrate all 500 files in src/ from the old logger API to the new one
following @docs/logger-v2-migration.md. Run the test suite per module and report failures.
```

### C. Piano da piu' angolazioni
```text
Workflow: draft an implementation plan for the new billing module from three independent
angles (data model, API surface, migration path), then weigh them and recommend one.
```

### D. Ricerca cross-checkata
```text
/deep-research Qual e' lo stato del supporto WebGPU nei browser mobile a giugno 2026?
```

---

## 24.9 Workflow vs Agent Teams (quando l'uno, quando l'altro)

|  | **Dynamic Workflows** | **Agent Teams** |
|---|---|---|
| Orchestrazione | Script deterministico scritto da Claude | Claude lead coordina interattivamente |
| Comunicazione tra agent | Via variabili dello script | Mailbox diretta teammate-to-teammate |
| Input umano a meta' | No (solo permission prompt) | Si', sessione interattiva |
| Scala | Decine-centinaia, fino a 1.000/run | Tipicamente pochi teammate persistenti |
| Ripetibilita' | Alta (salvi lo script come comando) | Bassa (sessione one-off) |
| Caso ideale | Fan-out parallelo ripetibile, audit, migrazioni | Progetto collaborativo lungo, ricerca esplorativa |

---

← [23 Glossario](./23-glossario.md) · Successivo → [25 /goal](./25-goal.md)
