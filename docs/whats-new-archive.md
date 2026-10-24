# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

## 2026-10-23

- **Agent Skills diventa uno standard open-governance**: Anthropic dona il formato Agent Skills — nome, logo, organizzazione GitHub e dominio [agentskills.io](https://agentskills.io) — alla **Agentic AI Foundation** (sotto Linux Foundation, co-fondata con Block e OpenAI), lo stesso percorso seguito da MCP a dicembre 2025. Oltre 70 piattaforme lo hanno adottato (ChatGPT, Cursor, GitHub Copilot, VS Code), per circa 1 milione di skill pubblicate e quasi 280 milioni di install. Fonte: [Anthropic](https://www.anthropic.com/news/donating-agent-skills-to-the-agentic-ai-foundation). Doc: [docs/09-skills.md](./09-skills.md), [docs/10-mcp.md](./10-mcp.md), [docs/23-glossario.md](./23-glossario.md), [docs/19-changelog.md](./19-changelog.md).

La release nella finestra (v2.1.309, 22 ott) resta sotto la soglia editoriale: fix di sandbox su macOS/Linux (script di shell startup che girava fuori dalla sandbox, protezione dei file di config MCP), `rm`/`rmdir` in bypass-permissions mode su desktop app/VS Code negati subito con un suggerimento di riscrittura, `claude ultrareview` che richiede ora workspace trust (`--trust-workspace` per gli script), `sed -i` passato al prompt Bash standard, oltre a fix su VS Code e sessioni cloud. Nessun nuovo slash command o tool primitivo nelle ultime 24 ore. Nessun post team rilevante individuato via web search (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog). Nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-22

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Le due release nella finestra (v2.1.307, 21 ott; v2.1.308, 22 ott) restano sotto la soglia editoriale: v2.1.307 aggiunge l'evento OpenTelemetry `claude_code.safety_event` (emesso per ogni tool call bloccata, confermata o rimandata da permessi, auto mode, hook o sandbox), un retry automatico (fino a due tentativi) sui tool call non parsabili prima di terminare il turno con errore, un timeout di 30 minuti di default per gli hook di checkout sui self-hosted runner (configurabile con `--checkout-hook-timeout-min`), l'estensione di Code Review con `@claude review stop` (oltre a `off`/`pause`) per terminare un abbonamento `@claude review always` su una PR, e il comando `/claude-api api-version`; v2.1.308 e' solo fix e miglioramenti di affidabilita' senza dettaglio ulteriore. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (l'unico post del 21 ottobre, sull'ingresso del fisico Christopher Stubbs nel Long-Term Benefit Trust, non riguarda Claude Code). Nessun nuovo slash command di rilievo, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-21

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Le due release nella finestra (v2.1.305, 20 ott; v2.1.306, 21 ott) restano sotto la soglia editoriale: v2.1.305 aggiunge il setting `sandbox.allowNestedUserNamespaces` per far creare user namespace a comandi Linux sandboxed (serve a Chromium e rootless podman, ma allenta anche le protezioni sui file della sandbox) e `CLAUDE_CODE_RETRY_WATCHDOG_USAGE_LIMIT_RECHECK_MS` per il retry mode non presidiato, oltre a decine di fix (tool search rifiutata da gateway/endpoint che rompeva ogni richiesta su Vertex/Bedrock, worktree in repository bare che partivano dal HEAD locale invece del branch di default, `/effort`/`/autocompact` ignorati con nomi modello che differiscono solo per maiuscole o tag `[1m]`); v2.1.306 e' solo due fix (falso "prompt is too long" con tanti tool MCP, `claude -p` che segnalava "Not logged in" in sessioni cloud). Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (l'unico post recente, il 18 ottobre sul fondo per il beneficio pubblico, non riguarda Claude Code). Nessun nuovo slash command di rilievo, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-20

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.304, 19 ott) resta sotto la soglia editoriale: `/auto-mode-setup`, wizard guidato per configurare auto mode (comando di setup per una feature di sistema gia' esistente, non un primitivo nuovo), e `/claude-api managed-agents-secure`, confronto in sola lettura tra le impostazioni di un Managed Agent e la guida di sicurezza Anthropic; il resto e' un avviso di utilizzo sul resume di conversazioni inattive (Pro/Max), estensioni API mod e 43 fix (tra cui `rm -r` su drive montati con lo stesso prompt di sicurezza di `rm -rf /Applications`, e un `--worktree` che in uscita non elimina piu' silenziosamente worktree/branch con commit non pushati). Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (l'unico post del 18 ottobre, sul fondo per il beneficio pubblico, non riguarda Claude Code). Nessun nuovo slash command di rilievo, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-19

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.303, 18 ott) resta sotto la soglia editoriale: solo bug fix e miglioramenti di affidabilita', senza dettaglio ulteriore nelle note di rilascio. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (l'unico post del 18 ottobre, sul fondo per il beneficio pubblico, non riguarda Claude Code). Nessun nuovo slash command, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-17

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Le due release nella finestra (v2.1.301, 15 ott; v2.1.302, 16 ott) restano sotto la soglia editoriale: v2.1.301 aggiunge `CLAUDE_CODE_RETRY_WATCHDOG_MAX_USAGE_LIMIT_WAIT_MS` per il retry mode non presidiato, il motion `%` in vim mode e nuovi attributi OpenTelemetry (`classifier_verdict`, `permission_mode`, `classifier_category`) sugli eventi `tool_decision`; v2.1.302 aggiunge `CLAUDE_CODE_AUTO_MODE_MODEL` per scegliere il modello del classificatore auto mode lato client, una riga "Idle compaction" in `/config`, un banner nelle sessioni cloud sul perche' una routine non e' partita, e porta i fork subagent — gia' default in terminale — a default anche su `claude -p`, Agent SDK, desktop app e VS Code (disattivabile con `CLAUDE_CODE_FORK_SUBAGENT=0`), oltre una quarantina di fix. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (i post del 14-15 ottobre — ufficio di Singapore, midterm USA, aggiornamento sui valutatori indipendenti — non riguardano Claude Code). Nessun nuovo slash command, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-15

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Le due release nella finestra (v2.1.299 e v2.1.300, entrambe 14 ott; nessuna release pubblica tra il 10 e il 13 ottobre) restano sotto la soglia editoriale: idle compaction per conversazioni ferme oltre 200K token (compattate dopo circa 54 minuti di inattivita', prima che la cache di un'ora scada — disattivabile con `"idleCompaction": false`), `CLAUDE_CODE_DISABLE_FILE_MENTIONS` per passare i path invece dei contenuti negli @-mention, `/effort` e `/fast` che impostano i default delle nuove sessioni, nuovi warning su `/usage`; v2.1.300 aggiunge solo API per i mod (`virtualText`, hook `prompt.change`, `$.ui.view({ agentId })`), attributi OpenTelemetry GenAI e l'estensione di `/advisor` (feature gia' esistente da v2.1.98) a Claude Platform su AWS, oltre un paio di centinaia di fix complessivi. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (i due post del 14 ottobre — ufficio di Singapore, preparazione midterm USA — non riguardano Claude Code). Nessun nuovo slash command, tool primitivo o post team rilevante: X non raggiungibile (DNS), ricerche web senza risultati pertinenti. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-10

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.296, 9 ott) resta sotto la soglia editoriale: `autoCompactWindow` per i subagent, `CLAUDE_CODE_WORKFLOW_SUBAGENT_MODEL`, backoff piu' lungo configurabile sugli errori 529, opzione `allow_large` sul Read tool, limite description tool MCP alzato a 4.096 caratteri, cache read di Sonnet 5.5 scesa a $0,10/MTok, oltre un centinaio di fix (hook `PreToolUse` managed, resume/subagent, prompt dei permessi PowerShell, redazione secret). Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (l'ultimo, Claude Haiku 5.5, e' del 7 ottobre e gia' coperto). Nessun nuovo slash command, tool primitivo o post team rilevante: X non raggiungibile (DNS) e ricerche web senza risultati pertinenti. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-09

- **`onFailure: "block"` per gli hook**: un hook `command`/`http` che non parte, va in timeout o esce con un codice inatteso bloccava l'azione in corso solo per caso (default "non-blocking"). Da v2.1.295 si puo' dichiarare esplicitamente `"onFailure": "block"` sull'hook perche' un suo fallimento equivalga a exit `2` — utile per regole di sicurezza non negoziabili dove il fail-open e' inaccettabile. Fonte: [GitHub Releases v2.1.295](https://github.com/anthropics/claude-code/releases/tag/v2.1.295). Doc: [docs/07-hooks.md](./07-hooks.md), [docs/19-changelog.md](./19-changelog.md).

Il resto della release v2.1.295 (8 ott, enorme: 120+ voci) resta sotto la soglia editoriale: Program Status Protocol (OSC 7501) per i terminali, header `request-id` sul gateway, cap tool search alzato a 16.384 caratteri, subagent limitati a 32 skill precaricate, decine di fix su MCP remoto, `claude -p`, vim mode e mod. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24 ore (i post Anthropic dell'8 ott — Usage Policy, scientific discovery, Cyber Mission — non riguardano Claude Code). Nessun nuovo slash command, tool primitivo o post team rilevante nelle ultime 24-48 ore. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-08

- **Claude Haiku 5.5**: Anthropic rilascia il nuovo modello Haiku di default (`claude-haiku-5-5`, v2.1.293) — 1M context, circa il 75% piu' economico di Haiku 4.5, prima Haiku con effort regolabile, pensata come sub-agent di coding affiancato a Opus 5.5/Sonnet 5.5. Completa la famiglia Claude 5.5. Fonte: [Anthropic](https://www.anthropic.com/claude-haiku-5-5) · [GitHub Releases v2.1.293](https://github.com/anthropics/claude-code/releases/tag/v2.1.293). Doc: [docs/05-fast-mode-1m-context.md](./05-fast-mode-1m-context.md), [docs/01-snapshot.md](./01-snapshot.md), [docs/19-changelog.md](./19-changelog.md).

Il resto delle release nella finestra (v2.1.292, 6 ott; v2.1.294, 8 ott) resta sotto la soglia editoriale: v2.1.292 aggiunge `claude plugin install --marketplace`, un parametro `effort` per lo strumento Agent e un fix di sicurezza su letture di file via rete UNC che bypassavano il prompt dei permessi; v2.1.294 corregge solo hook `prompt`/`agent` scritti come istruzioni che non bloccavano cio' che dovevano. Nessun nuovo slash command, tool primitivo o post team rilevante nelle ultime 24-48 ore. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-06

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Le uniche release nella finestra (v2.1.290, 5 ott; v2.1.291, 6 ott) restano sotto la soglia editoriale: v2.1.290 aggiunge estensioni dei plugin hook per i mod (`serverToolUses` nel risultato di `turn.step`, `agentId` nell'evento `tool.check` per distinguere i permessi dei subagent, `ceiling` per il livello di approvazione richiesto da un'organizzazione, tipi `ThemeKey`/`Color` per i pannelli), un pulsante Deny nella pagina di sign-in del gateway e il matching parziale del nome sessione per `claude attach`/`claude logs`, oltre un centinaio di fix (proxy/gateway, sessioni lunghe con molte immagini, subagent ripresi che perdono il prompt cache, WebFetch che troncava pagine oltre 100.000 caratteri, `/rewind`, scheduled task al resume, plan mode); v2.1.291 corregge due regressioni introdotte da 2.1.290 e 2.1.288. Nessun annuncio Anthropic blog dedicato specificamente a Claude Code nelle ultime 24-48 ore: l'annuncio del 5 ott su memory persistente per Claude Managed Agents riguarda la piattaforma Claude API/Console (`ant` CLI), non la CLI Claude Code; l'annuncio Barclays del 6 ott e' marketing privo di dettaglio tecnico. Nessun nuovo slash command, tool primitivo o post team rilevante nelle ultime 24-48 ore. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-05

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.289, 3 ott) resta sotto la soglia editoriale: estensioni dell'API mod per gli agenti teammate (`agent.spawn`, id agente unico tra gli hook event, stati idle/waiting in `$.agent.list()`), oltre una ventina di fix su plugin/mod (hot reload, pannelli, Box con border style ignoto, regioni che crescono senza altezza), sandbox auto-allow su variabili d'ambiente espanse nei comandi Bash e artifact pubblicati che si bloccavano su `<script>` non chiusi annidati. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24 ore; nessun nuovo slash command, tool primitivo o post team rilevante nelle ultime 24-48 ore. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-03

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.288, 2 ott) resta sotto la soglia editoriale: `$.ui.selection()` per i mod (legge il testo selezionato in fullscreen e la riga di trascrizione associata), `gh api` integrato nelle sessioni cloud senza GitHub CLI, Ctrl+F in Agent View per cercare sessioni per nome, flag `--max-findings <n>|all` per `/code-review`, recovery della bozza con Up dopo Ctrl+C, prompt di ri-autenticazione OAuth quando un server MCP richiede scope aggiuntivo a meta' tool call, oltre una dozzina di fix su resume/compacting, session titles/hook su Mantle o dietro gateway e chiamate MCP duplicate su risultati oltre 16 MB. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24 ore (l'unico post del 2 ott, sull'investimento da $100M per formare 10.000 ingegneri, non riguarda Claude Code); nessun nuovo slash command, tool primitivo o post team rilevante nelle ultime 24-48 ore. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-02

- **Claude Mods**: i plugin possono ora modificare il comportamento profondo di Claude Code con un *hooks module* JS/TypeScript — riscrivere prompt, disegnare pannelli/comandi in UI, sostituire feature built-in — un layer programmabile oltre gli hook JSON dichiarativi (che restano allow/deny/block). Bundlato il primo mod ufficiale **"You should know"**, side-agent opt-in che osserva la sessione e segnala cose che utente o Claude potrebbero perdere (`/plugin enable cc-plugin-you-should-know@builtin`). Fonte: [GitHub Releases v2.1.287](https://github.com/anthropics/claude-code/releases/tag/v2.1.287) · [code.claude.com/docs/en/plugins/mods/create](https://code.claude.com/docs/en/plugins/mods/create) · [@bcherny](https://x.com/bcherny/status/2105756563302723721) · [@ClaudeDevs](https://x.com/ClaudeDevs/status/2105721434807083061). Doc: [docs/11-plugins-marketplace.md](./11-plugins-marketplace.md), [docs/07-hooks.md](./07-hooks.md), [docs/19-changelog.md](./19-changelog.md).

Il resto della release v2.1.287 (filtro `n:<text>` in Agent View, URL prompt da server MCP sul protocollo 2025-11-25, oltre una dozzina di fix su Remote Control, fast mode remoto, notifiche hook e controlli modello Bedrock/Vertex) resta sotto la soglia editoriale. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24 ore; digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-01

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.286, 30 set) resta sotto la soglia editoriale: contatore "2 di 5" per i permission prompt in coda, supporto mouse per le righe "N more" delle liste in fullscreen, migliorata la commit guidance per eseguire una skill `verify` prima di committare, bookmark e question tracking per Claude Code in VS Code, oltre un centinaio di fix su resume/continue, errori API 400, sessioni cloud, spend meter, login macOS e Remote Control. Nessun annuncio Anthropic blog dedicato su Claude Code, nessun nuovo slash command o tool primitivo, nessun post team rilevante nelle ultime 24-48 ore. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-09-30

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.285, 29 set) resta sotto la soglia editoriale: `claude --desktop` per aprire la desktop app dalla CLI, `claude plugin configure` per gestire le opzioni di un plugin, il setting `allowedProviders` per limitare i provider API ammessi su una macchina, le env var `CLAUDE_CODE_DISABLE_WEB_FETCH` e `CLAUDE_CODE_NONSTREAMING_TIMEOUT_RETRIES`, oltre un centinaio di fix su plugin, MCP, Remote Control, VS Code e Artifact tool. Nessun annuncio Anthropic blog dedicato su Claude Code, nessun nuovo slash command o tool primitivo, nessun post team rilevante nelle ultime 24-48 ore.

---

## 2026-09-29

- **Claude Sonnet 5.5 diventa il nuovo modello Sonnet di default** (v2.1.284, 28 set): sostituisce Sonnet 5 sulla Claude API e in Claude Code, stesso pricing ($2/$10 per MTok, cache read $0.20/MTok), output oltre il 30% piu' veloce con meno token/tool call per task, salto da 10,3% a 70,6% su Terminal-Bench 4.0, cyber safeguard equivalenti a Opus 5 (prima volta su una Sonnet) e watermarking invisibile del testo. Fonte: [Anthropic](https://www.anthropic.com/claude-sonnet-5-5) · [GitHub Releases v2.1.284](https://github.com/anthropics/claude-code/releases/tag/v2.1.284). Doc: [docs/05-fast-mode-1m-context.md](./05-fast-mode-1m-context.md), [docs/01-snapshot.md](./01-snapshot.md), [docs/19-changelog.md](./19-changelog.md).
- **`/claude-api build-eval` e `/claude-api hillclimb`**: la skill ufficiale `claude-api` guadagna due workflow per costruire dentro il codebase una eval che rispecchia il lavoro reale in produzione e poi migliorare l'app (prompt, skill, tool, modello, effort) un cambiamento alla volta, verificando su un held-out set che il miglioramento non sia overfitting. Fonte: [Anthropic](https://claude.dev/blog/automating-eval-design-and-hillclimbing/) · [@ClaudeDevs](https://x.com/ClaudeDevs/status/2104676099083190435). Doc: [docs/09-skills.md](./09-skills.md), [docs/19-changelog.md](./19-changelog.md).

Il resto della release v2.1.284 resta sotto la soglia editoriale: risposta "si', ma richiedimelo di nuovo" al prompt di auto mode per letture fuori working directory, importi in dollari nella spend limit bar di `/usage`, `/mcp reconnect all`, oltre un centinaio di fix su stream di risposta, "Prompt is too long" e vim mode.

---

## 2026-09-27

- **Graceful wrap-up al limite delle 5 ore**: quando il limite di sessione interrompe un turno in corso, Claude Code cerca ora un punto di arresto pulito invece di tagliare a meta' un edit — usa una piccola quota fissa presa dal limite *settimanale* per finire la modifica, far passare i test e lasciare una nota su cosa resta da fare. Su Pro disponibile una volta a settimana, su Max e Team Premium a ogni limite raggiunto (quota permettendo). Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2103561342057943314). Doc: [docs/01-snapshot.md](./docs/01-snapshot.md), [docs/19-changelog.md](./docs/19-changelog.md).

Il resto della release v2.1.283 (25 set) resta sotto la soglia editoriale: `/doctor prompt-audit` per pattern di prompting datati in CLAUDE.md/skill/agent, `availableModelsMatch: "exact"` e `deniedModels` per bloccare modelli non elencati, header gateway `x-claude-code-prompt-id`, oltre 90 fix su MCP, plugin, vim mode e permessi. Nessun annuncio Anthropic blog dedicato su Claude Code, nessun nuovo slash command o tool primitivo nelle ultime 48 ore.

---

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
