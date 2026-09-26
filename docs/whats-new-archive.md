# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

## 2026-09-25

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Le uniche release CLI nella finestra (v2.1.281, 23 set; v2.1.282, 24 set) restano sotto la soglia editoriale: solo settings enterprise/gateway (`assume_role` e `guardrail` su Bedrock, `telemetry.resource_attributes`, `"attribution": false` per nascondere le righe di attribuzione commit/PR), `maxProseWidth` per limitare la larghezza del testo nei terminali wide, e un ampio giro di fix su sessioni, resume, vim mode e prompt cache. I due post del blog Anthropic del 22 e 24 settembre su Opus 5.5 (pricing dei task, ottimizzazione per sessioni di coding lunghe) approfondiscono un modello gia' coperto il 23 settembre, senza annunciare feature nuove. Nessun nuovo slash command, tool o annuncio di sistema nelle ultime 24-48 ore.

---

## 2026-09-23

- **Claude Opus 5.5 diventa il nuovo modello Opus di default in Claude Code** (v2.1.280, 22 set): prima uscita della famiglia Claude 5.5, performa al livello di Fable 5.1 sulla gran parte dei task, con output oltre il 30% piu' veloce e un costo di esercizio il 40% piu' basso di Opus 5 — 1M di context, pricing $4/$20 per MTok e cache read a $0.20/MTok (-60%). Contestualmente, su **Pro e Team Standard il modello di default passa da Sonnet a Opus**, allineandosi a Max/Premium/Enterprise. Fonte: [Anthropic](https://www.anthropic.com/claude-opus-5-5) · [GitHub Releases v2.1.280](https://github.com/anthropics/claude-code/releases/tag/v2.1.280). Doc: [docs/05-fast-mode-1m-context.md](./05-fast-mode-1m-context.md), [docs/01-snapshot.md](./01-snapshot.md), [docs/19-changelog.md](./19-changelog.md).

Il resto della release v2.1.280 (supporto mouse esteso a piu' liste in fullscreen, `CLAUDE_CODE_MAX_MCP_DESCRIPTION_LENGTH` per il cap sulla lunghezza delle description dei tool MCP, oltre un centinaio di fix su auto mode, dialog, MCP, subagent e sessioni Remote/cloud) resta sotto la soglia editoriale. Nessun annuncio Anthropic blog dedicato specificamente a Claude Code oltre al lancio del modello (qui incluso per l'impatto diretto sul default CLI), ne' altri post team rilevanti nelle ultime 24-48 ore.

---

## 2026-09-20

- **Supporto nativo ad AGENTS.md** (v2.1.277, 18 set): nei progetti senza CLAUDE.md, Claude Code legge ora automaticamente **AGENTS.md** — lo standard cross-tool gia' usato in decine di migliaia di repo condivisi tra piu' agenti AI (Codex, Cursor e altri) — eliminando il workaround manuale via `@AGENTS.md` che serviva finora. Il file di istruzioni preferito resta configurabile da "Project instructions" in `/config`; non ancora disponibile su Bedrock, Vertex e Foundry. Fonte: [GitHub Releases v2.1.277](https://github.com/anthropics/claude-code/releases/tag/v2.1.277). Doc: [docs/06-claude-md-memory.md](./06-claude-md-memory.md), [docs/19-changelog.md](./19-changelog.md).

Il resto delle release v2.1.276/278 (18-19 set: fix di una regressione 400 su gateway/proxy introdotta da v2.1.275, e il passaggio di default al classificatore auto mode lato server per utenti Claude API/Enterprise/Bedrock/Vertex/Foundry/gateway — non piu' fatturato per l'overhead di classificazione) resta sotto la soglia editoriale. Nessun annuncio Anthropic blog dedicato su Claude Code e nessun post team rilevante (oltre a quanto gia' coperto il 18 set) nelle ultime 24-48 ore.

---

## 2026-09-18

- **Projects redesign: da cartella a conversazione** (beta, 17 set): Anthropic rilascia una nuova esperienza "Projects" in Claude Code — non piu' una cartella con dentro una chat, ma una conversazione persistente in cui Claude fa da coordinatore, delega il lavoro a thread paralleli con memoria condivisa e una libreria comune di file/artifact, e assembla il risultato finale; si puo' guidare l'avanzamento anche da telefono, e il lavoro continua dopo che chiudi il laptop. Beta da oggi per un gruppo selezionato di utenti Pro/Max che usano sessioni cloud e non hanno ancora progetti su web/desktop, rollout esteso nei prossimi giorni e poi a Team/Enterprise. Fonte: [Anthropic blog](https://claude.com/blog/projects-redesigned). Doc: [docs/12-agent-teams.md](./12-agent-teams.md), [docs/13-routines-cloud.md](./13-routines-cloud.md), [docs/19-changelog.md](./19-changelog.md).
- **Sync skill/plugin da claude.ai al terminale** (v2.1.275, 17 set): le skill e i plugin abilitati sull'account claude.ai si sincronizzano ora automaticamente nelle sessioni CLI loggate con lo stesso account, con opt-out per-progetto via `syncClaudeAiSkills: false` / `syncClaudeAiPlugins: false` — riduce la deriva tra cosa hai abilitato sul web e cosa gira in terminale. Fonte: [GitHub Releases v2.1.275](https://github.com/anthropics/claude-code/releases/tag/v2.1.275). Doc: [docs/09-skills.md](./09-skills.md), [docs/11-plugins-marketplace.md](./11-plugins-marketplace.md), [docs/19-changelog.md](./19-changelog.md).

Il resto delle release v2.1.270-274 (12-17 set: fast mode esteso alle sessioni Remote, `allowed_domains` per-comando su Bash/PowerShell/Monitor in auto mode con sandboxing, fork di sessioni Remote Control in locale, diagnostica `/mcp` su disconnessione, avviso di memoria critica, fix vari) resta sotto la soglia editoriale. Nota fonti: `code.claude.com/docs/en/changelog` e la pagina GitHub Releases hanno risposto 503 per l'intera finestra di ricerca; i dettagli versione per versione sono ricostruiti incrociando piu' aggregatori indipendenti (changelog mirror community, digest di terze parti), l'annuncio Projects e' invece confermato direttamente dal blog Anthropic e da piu' testate tech indipendenti.

---

## 2026-09-12

- **`claude plugin eval`** (v2.1.269, 11 set): nuovo comando CLI che esegue la suite di eval di un plugin contro Claude Code e restituisce un risultato riproducibile con punteggio, in formato JSON e HTML — porta un framework di test formale agli autori di plugin/skill. Fonte: [GitHub Releases v2.1.269](https://github.com/anthropics/claude-code/releases/tag/v2.1.269). Doc: [docs/11-plugins-marketplace.md](./11-plugins-marketplace.md), [docs/19-changelog.md](./19-changelog.md).
- **Limiti settimanali: +25% permanente dal 14 set, ma e' un calo del 17% rispetto al bonus attuale**: Anthropic sostituisce il bonus temporaneo del +50% (in vigore da mesi) con un aumento permanente del +25% sui limiti settimanali standard di Pro, Max, Team e Enterprise a seat — per chi sta usando il bonus oggi la capacita' netta scende del 17% dal 14 settembre. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2093742321473065266). Doc: [docs/01-snapshot.md](./01-snapshot.md), [docs/19-changelog.md](./19-changelog.md).

Il resto delle release v2.1.265-269 (8-11 set: gateway pricing/`gatewayInternalNetworks`, `maxEffortLevel`, `/output-style` cross-surface, agent map e dialog hook/permessi in VS Code, `CLAUDE_CODE_WORKFLOW_MAX_CONCURRENT_AGENTS`, fix su WebFetch timeout e sessioni cloud) resta sotto la soglia editoriale. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24 ore; digest ufficiale settimanale ancora fermo alla Week 34 (17-21 ago).

---

## 2026-09-05

- **Computer use in background** in Claude Cowork e Claude Code (2 set): Claude clicca, digita e apre app sul desktop senza prendere il controllo dello schermo, cosi' l'utente continua a lavorare su altro nel frattempo; dentro Cowork la priorita' resta ai connector nativi (Gmail, Drive, Microsoft 365, Slack) e al browser, il controllo diretto dello schermo interviene solo come ultima risorsa. Solo macOS, piani Pro e Max, toggle manuale in Settings → General → Desktop app (off di default). Fonte: [@claudeai](https://x.com/claudeai/status/2095226833293685100). Doc: [docs/17-ide-surface.md](./17-ide-surface.md), [docs/19-changelog.md](./19-changelog.md).
- **`/skill-doctor`** (v2.1.261, 4 set): nuovo comando diagnostico che individua le skill caricate ma mai invocate e il loro costo di context, per ripulire il setup senza doverlo fare a occhio. Fonte: [GitHub Releases v2.1.261](https://github.com/anthropics/claude-code/releases/tag/v2.1.261). Doc: [docs/09-skills.md](./09-skills.md), [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).

Il resto delle release v2.1.259/260/261 (2-4 set: `managedMcpServers` per MCP gestiti da org, `--permission-prompts none` per host headless unattended, diff panel fullscreen via `/diff`, settings `bashOutputMaxChars`/`taskOutputMaxChars`, fix su prompt cache e Remote Control) resta sotto la soglia editoriale. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24 ore.

---

## 2026-09-02

- **Claude Fable 5.1 diventa il modello Fable di default** (v2.1.257, 1 set): stesso pricing di Fable 5 ($10/$50 per MTok) ma cache read tagliate del 75% ($0.25/MTok); arriva piu' lontano in task lunghi prima di richiedere input, segnala meglio quando e' bloccato, stile di scrittura piu' naturale. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2094851229734277228) · [GitHub Releases v2.1.257](https://github.com/anthropics/claude-code/releases/tag/v2.1.257). Doc: [docs/05-fast-mode-1m-context.md](./05-fast-mode-1m-context.md), [docs/19-changelog.md](./19-changelog.md).
- **Regola "Containment Escape" in auto mode** (v2.1.257, 1 set): auto mode non auto-approva piu' fetch di credenziali da metadata cloud, tentativi di egress evasion o cross-tenant reach, a meno che l'ambiente non li dichiari espliciti come attesi. Fonte: [GitHub Releases v2.1.257](https://github.com/anthropics/claude-code/releases/tag/v2.1.257). Doc: [docs/04-modalita-permessi.md](./04-modalita-permessi.md), [docs/19-changelog.md](./19-changelog.md).

Il resto delle release v2.1.252/257/258 (25-1 set: fix estesi su Remote Control, VS Code, sandbox e permessi, `CLAUDE_CODE_SUBAGENT_MODEL_FORCE`, settings `timeZone`/`timeFormat`) resta sotto la soglia editoriale. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24 ore.

---

## 2026-08-29

- **Hook `PreModelSwitch`/`PostModelSwitch`** (v2.1.251, 28 ago): due nuovi eventi hook bloccano, confermano o annotano un cambio di modello a runtime (fallback auto mode, `/model`, switch programmatico); i `SessionStart` di tipo resume ricevono ora anche staleness della sessione e stima del costo di re-cache. Fonte: [GitHub Releases v2.1.251](https://github.com/anthropics/claude-code/releases/tag/v2.1.251). Doc: [docs/07-hooks.md](./07-hooks.md), [docs/19-changelog.md](./19-changelog.md).

Il resto della release v2.1.251 (streaming live dei tool call subagent verso Remote Control, spend limit bar in `/usage`, metriche prompt-cache per-sessione in `/cost`, ampi fix di sicurezza sui tool file) resta sotto la soglia editoriale. Nessun annuncio Anthropic dedicato su Claude Code nelle ultime 24 ore.

---

## 2026-08-28

> Nessuna novita' significativa nelle ultime 24 ore. Le release piu' recenti (v2.1.247, v2.1.248, v2.1.250, 26-28 ago) restano sotto la soglia editoriale: tool `SendFeedback` per bozze di feedback da `/feedback`, `/claude-api cost-optimize` per profilare la spesa API, nuovo flag `--restricted` per sessioni lock-down (rimuove i tool che eseguono comandi/codice e `WebFetch`, rifiuta `bypassPermissions`, ignora i settings utente/progetto), cross-session messaging esteso a Bedrock/Vertex/Foundry, fix di sicurezza (`/ultrareview` non carica piu' file tipo `.env`/`.tfvars`/backup di credenziali). Nessun annuncio Anthropic rilevante su Claude Code nelle ultime 24 ore.

---

## 2026-08-26

> Nessuna novita' significativa nelle ultime 24 ore. Il digest ufficiale settimanale resta fermo alla Week 34 (17-21 ago, gia' coperta: `/design`, output style "Concise", device card Remote Control, `ANTHROPIC_DEFAULT_MODEL`). Le release piu' recenti (v2.1.243, v2.1.245, v2.1.246, 24-25 ago) restano sotto la soglia editoriale: settings minori (tab classificatore auto mode in `/permissions`, breakdown loop in `/usage`, `modelPicker`, TTL prompt cache configurabile) e fix (crash glibc 2.44 su Linux, rallentamenti transcript). Nessun annuncio Anthropic rilevante nelle ultime 24 ore.

---

## 2026-08-24

> Nessuna novita' significativa nelle ultime 24 ore. Le release piu' recenti (v2.1.235-v2.1.241, 18-23 ago) restano sotto la soglia editoriale: solo settings minori (output style built-in "Concise", env var `ANTHROPIC_DEFAULT_MODEL`, `spellcheck` opzionale, `keybindingFlavor`, shutdown graduale per self-hosted runner), fix di affidabilita' e sicurezza. Nessun annuncio Anthropic rilevante nelle ultime 24 ore.

---

## 2026-08-18

> Nessuna novita' significativa nelle ultime 24 ore. Le uniche release (v2.1.233 e v2.1.234, 14-17 ago) contengono solo fix, hardening di sicurezza e feature minori (badge merge request GitLab, auto-continuazione sessione al reset dei limiti d'uso, keybinding di selezione), sotto la soglia editoriale.

---

## 2026-08-14

- **Cross-session messaging: mention diretto con `@`** (v2.1.232, 13 ago): digitare `@nome-sessione` nel prompt basta a raggiungere un'altra sessione Claude Code — Claude usa `SendMessage` in automatico, senza bisogno di invocare esplicitamente il tool; se il nome e' univoco tra le sessioni vive, il messaggio parte subito senza conferma. Nomi duplicati sulla stessa macchina ricevono ora una variante automatica `nome-parola-parola`. Fonte: [GitHub Releases v2.1.232](https://github.com/anthropics/claude-code/releases/tag/v2.1.232). Doc: [docs/17-ide-surface.md](./17-ide-surface.md), [docs/19-changelog.md](./19-changelog.md).
- **Subagent forking di default** (v2.1.232, 13 ago): i subagent `subagent_type: "fork"` ereditano ora conversazione e prompt cache completi dalla sessione padre; gli agent non-teammate spawnati in sessioni interattive girano di default in background invece che in foreground. Fonte: [GitHub Releases v2.1.232](https://github.com/anthropics/claude-code/releases/tag/v2.1.232). Doc: [docs/08-subagents.md](./08-subagents.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-08-12

> Nessuna novita' significativa nelle ultime 24 ore. Le uniche release (v2.1.227 e v2.1.228, 10-11 ago) contengono solo bug fix e hardening, sotto la soglia editoriale.

---

## 2026-08-11

> Nessuna novita' significativa nelle ultime 24 ore. L'unica release (v2.1.227, 10 ago) contiene solo bug fix e rifiniture minori di UI, sotto la soglia editoriale.

---

## 2026-08-10

- **Auto mode diventa default per Pro, Max e Team** (annuncio 9 ago, effettivo dal 14 ago): le nuove sessioni su questi piani partiranno in auto mode invece che in `manual` — il classifier ha bloccato l'89% delle azioni pericolose nei test interni contro il 13,6% della revisione manuale (1.053 tester paganti). Enterprise, API e i provider cloud (Bedrock, Vertex, Foundry) restano opt-in per ora. Fonte: [Anthropic blog](https://claude.com/blog/auto-mode-default-in-claude-code) · [@ClaudeDevs](https://x.com/ClaudeDevs/status/2085794862608318627) · [docs ufficiale](https://code.claude.com/docs/en/auto-mode-config). Doc: [docs/04-modalita-permessi.md](./04-modalita-permessi.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-08-08

- **Ambienti self-hosted per Claude Code** (v2.1.224, 7 ago): beta pubblica di `claude self-hosted-runner` — le sessioni web/mobile/desktop possono girare sull'infrastruttura del team (fixed o on-demand) invece che su quella cloud Anthropic, per Team ed Enterprise. Fonte: [GitHub Releases v2.1.224](https://github.com/anthropics/claude-code/releases/tag/v2.1.224) · [Anthropic blog](https://claude.com/blog/run-claude-code-sessions-on-your-own-compute). Doc: [docs/13-routines-cloud.md](./13-routines-cloud.md), [docs/19-changelog.md](./19-changelog.md).
- **Cross-session messaging (`SendMessage` + `ListAgents`)** (v2.1.224, 7 ago): le sessioni Claude Code indipendenti possono ora scambiarsi messaggi tra loro — sulla stessa macchina via socket locale, su macchine diverse o sul web tramite Remote Control (solo risposta cross-machine). Fonte: [GitHub Releases v2.1.224](https://github.com/anthropics/claude-code/releases/tag/v2.1.224) · [docs ufficiale](https://code.claude.com/docs/en/cross-session-messaging). Doc: [docs/17-ide-surface.md](./17-ide-surface.md), [docs/08-subagents.md](./08-subagents.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-08-06

- **Rimosso `/ultraplan`** (v2.1.222, 4 ago): il planning in cloud lanciato ad aprile 2026 e' stato eliminato dal CLI senza sostituto dedicato — resta `/plan` locale o le routine (`/schedule`) per orchestrazione cloud. Fonte: [GitHub Releases v2.1.222](https://github.com/anthropics/claude-code/releases/tag/v2.1.222). Doc: [docs/15-ultraplan-ultrareview.md](./docs/15-ultraplan-ultrareview.md), [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`/review` torna alias di `/code-review`** (v2.1.223, 6 ago): revisiona il diff corrente o una PR (`/code-review <level> <pr#>`), `/code-review ultra` per la deep review cloud — inverte la separazione single-pass introdotta a luglio (v2.1.202). Fonte: [GitHub Releases v2.1.223](https://github.com/anthropics/claude-code/releases/tag/v2.1.223). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Focus view in VS Code** (v2.1.221, 4 ago): toggle `Ctrl+Alt+F` che nasconde l'attivita' dei tool dietro un riassunto per-turno espandibile, con indicatore live del tool in esecuzione. Fonte: [GitHub Releases v2.1.221](https://github.com/anthropics/claude-code/releases/tag/v2.1.221). Doc: [docs/17-ide-surface.md](./docs/17-ide-surface.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-08-03

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-08-02

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-08-01

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-07-29

- **Spec MCP 2026-07-28**: il Model Context Protocol passa a un core stateless (niente piu' `Mcp-Session-Id`, ogni request puo' essere gestita da qualsiasi istanza server), con OAuth/OIDC rafforzati ed extension versionate per Apps e Tasks — il maggior aggiornamento del protocollo dal lancio. Supporto in rollout sui prodotti Claude, incluso Claude Code. Fonte: [Anthropic blog](https://claude.com/blog/bringing-mcp-2026-07-28-to-claude) · [@ClaudeDevs](https://x.com/ClaudeDevs/status/2082164248697069935). Doc: [docs/10-mcp.md](./10-mcp.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-07-28

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-07-26

- **Claude Opus 5** (v2.1.219, 24 lug): nuovo modello Opus, si avvicina a Fable 5 su molti benchmark a meta' del prezzo (stesso pricing di Opus 4.8, $5/$25 per MTok standard). Diventa il modello premium di default su Max e il piu' forte disponibile su Pro; effort toggle low/medium/high per bilanciare costo e capacita', 1M context nativo, modello meno "prompt-injectable" ad oggi. Sostituisce Opus 4.7 in fast mode (`/fast` ora copre Opus 5 e Opus 4.8). Fonte: [Anthropic news](https://www.anthropic.com/news/claude-opus-5) · [GitHub Releases v2.1.219](https://github.com/anthropics/claude-code/releases/tag/v2.1.219). Doc: [docs/01-snapshot.md](./01-snapshot.md), [docs/05-fast-mode-1m-context.md](./05-fast-mode-1m-context.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-07-19

- **`/verify` e `/code-review` non piu' auto-invocate** (v2.1.215, 19 lug): Claude non lancia piu' di propria iniziativa le skill `/verify` e `/code-review` a fine task — vanno invocate esplicitamente quando servono. Riduce le review "a sorpresa" non richieste dall'utente. Fonte: [GitHub Releases v2.1.215](https://github.com/anthropics/claude-code/releases/tag/v2.1.215). Doc: [docs/09-skills.md](./09-skills.md), [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-07-18

- **`/fork` → sessione background + `/subtask`** (v2.1.212, 17 lug): `/fork` non spawna piu' un subagent in-sessione ma copia l'intera conversazione in una nuova sessione background (riga separata in `claude agents`), lasciando libero il thread principale; il vecchio comportamento (subagent dentro la sessione corrente) e' ora `/subtask`. Stessa release: tetti di sicurezza default (200 WebSearch, 200 subagent spawn per sessione) e `/resume` con picker delle sessioni passate, incluse quelle cancellate. Fonte: [GitHub Releases v2.1.212](https://github.com/anthropics/claude-code/releases/tag/v2.1.212). Doc: [docs/08-subagents.md](./08-subagents.md), [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).
- **Tool `EndConversation`** (v2.1.214, 18 lug): nuovo tool primitivo che permette a Claude di terminare autonomamente una conversazione con utenti fortemente abusivi o tentativi di jailbreak, affiancandosi a Monitor e AskUserQuestion nella cassetta degli attrezzi built-in dell'agent loop. Fonte: [GitHub Releases v2.1.214](https://github.com/anthropics/claude-code/releases/tag/v2.1.214). Doc: [docs/16-headless-agent-sdk.md](./16-headless-agent-sdk.md), [docs/04-modalita-permessi.md](./04-modalita-permessi.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-07-13

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-07-12

- **Browser in-app su Desktop**: Claude Code su Desktop apre un browser integrato, sandboxato, con cui Claude legge documentazione, design e siti esterni, clicca ed interagisce come gia' fa coi dev server locali — sessioni persistenti opzionali, permessi per-sito (Allow once / Always / Deny). Scorciatoia `Ctrl+Shift+B` (Windows) / `Cmd+Shift+B` (macOS). Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2075635283211772279). Doc: [docs/17-ide-surface.md](./17-ide-surface.md), [docs/19-changelog.md](./19-changelog.md).
- **`/checkup`** (v2.1.205, 8 lug): nuovo alias di `/doctor` che diventa un vero setup checkup — diagnostica e propone fix per skill/MCP/plugin inutilizzati (in base al costo di context), deduplica `CLAUDE.md` locali contro le versioni committate e segnala hook lenti; riporta i risultati e chiede conferma prima di modificare nulla. Fonte: [GitHub Releases v2.1.205](https://github.com/anthropics/claude-code/releases/tag/v2.1.205). Doc: [docs/03-slash-commands.md](./03-slash-commands.md), [docs/02-cli-installazione.md](./02-cli-installazione.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-07-08

- **Dynamic workflow size** in `/config` (v2.1.202, 6 lug): linea guida small/medium/large su quanti agent Claude tende a usare quando scrive un [dynamic workflow](./24-workflows.md) — indicativa, non un tetto imposto dal runtime. Stessa release: attributi OpenTelemetry `workflow.run_id`/`workflow.name` per ricostruire l'attivita' di un run, e `/review <PR>` torna a single-pass veloce (multi-agent resta su `/code-review <level> <PR#>`). Fonte: [GitHub Releases v2.1.202](https://github.com/anthropics/claude-code/releases/tag/v2.1.202). Doc: [docs/24-workflows.md](./24-workflows.md), [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-07-06

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-07-05

> Nessuna novita' significativa nelle ultime 24 ore.

---

## Come consultare la storia completa

```bash
# Tutte le entry "What's new today" mai pubblicate
git log --all --oneline --grep="what's new" -- README.md

# Diff di una giornata specifica
git log --all --grep="what's new YYYY-MM-DD" -p -- README.md
```

---

## Riferimenti

- [Automazione daily](../automations/daily-whats-new/) — README, prompt, setup
- [docs/19 — Changelog completo](./19-changelog.md) — versione per versione
- [docs/13 — Routines cloud](./13-routines-cloud.md) — come funziona la routine

---

← [README master](../README.md)
