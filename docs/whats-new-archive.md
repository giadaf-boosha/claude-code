# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

## 2026-11-12

> Nessuna novita' significativa nelle ultime 48 ore. Prossimo aggiornamento domani 07:00.

Nessuna nuova release CLI nella finestra: l'ultima resta v2.1.322 (10 nov), gia' coperta nell'aggiornamento precedente — nessuna versione successiva su GitHub Releases, tag o changelog ufficiale, e il digest settimanale ufficiale e' ancora fermo alla Week 37 (7-11 set). Nessun annuncio Anthropic blog dedicato su Claude Code nella finestra (gli unici post, 9-10 novembre, riguardano Claude Fable 5.2/Mythos 5.2 in generale e il roadshow per l'IPO, non una feature della CLI). Nessun post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti e datati alla finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato nella finestra.

---

## 2026-11-10

> Aggiornamento con 1 voce editoriale.

- **Claude Fable 5.2** diventa il nuovo modello Fable di default in Claude Code, sostituendo Fable 5.1: stesso context window da 1M token, pricing piu' basso ($8/$40 per MTok contro $10/$50, cache read a $0.20/MTok). Fonte: [GitHub Releases v2.1.321](https://github.com/anthropics/claude-code/releases/tag/v2.1.321). Doc: [docs/05-fast-mode-1m-context.md](./05-fast-mode-1m-context.md), [docs/19-changelog.md](./19-changelog.md).

Il resto della finestra resta sotto la soglia editoriale: v2.1.321 (9 nov) aggiunge anche `--settings <file>` per `claude remote-control` e fix di sicurezza su MCP OAuth/sandbox/`cp`-`mv`, mentre v2.1.322 (10 nov) porta solo il fast mode su Vertex AI (regioni global/us/eu) — nessun nuovo slash command o tool primitivo. Nessun annuncio Anthropic blog dedicato su Claude Code nella finestra (l'unico post, 9 novembre, annuncia Claude Fable 5.2/Mythos 5.2 in generale, non una feature della CLI). Nessun post team rilevante: x.com irraggiungibile dalla rete della sessione (DNS), ricerche web sostitutive sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-11-08

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Nessuna nuova release CLI nella finestra: l'ultima resta v2.1.319 (6 nov), gia' coperta ieri — nessuna versione successiva su GitHub Releases, tags o changelog ufficiale. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (gli ultimi post, 4-5 novembre, riguardano Personal Finance in Claude, controlli di sicurezza per Claude Enterprise e nuovi partner del Marketplace — non la CLI). Nessun post team rilevante: x.com irraggiungibile dalla rete della sessione (DNS), ricerche web sostitutive sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-11-07

> Aggiornamento con 3 voci editoriali.

- **Task MCP in background**: una tool call MCP eseguita come task si sposta ora in background, il risultato arriva a Claude quando finisce invece di bloccare il turno (nuova feature di sistema MCP). Fonte: [GitHub Releases v2.1.319](https://github.com/anthropics/claude-code/releases/tag/v2.1.319). Doc: [docs/10-mcp.md](./10-mcp.md), [docs/19-changelog.md](./19-changelog.md).
- **`/claude-api latency-optimize`**: nuovo sotto-comando della skill `/claude-api` che individua dove il codice che chiama la Claude API fa attendere l'utente e testa settaggi piu' rapidi contro il tuo eval. Fonte: [GitHub Releases v2.1.319](https://github.com/anthropics/claude-code/releases/tag/v2.1.319). Doc: [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).
- **`/loop` e Monitor, comportamento cambiato**: un loop self-paced termina ora da solo a fine turno se non richiama `ScheduleWakeup` (prima restava agganciato finche' non arrivava cancel/Esc; `CLAUDE_CODE_LOOP_KEEPALIVE=1` per il vecchio comportamento), e il watch WebSocket di Monitor segue sempre la regola Bash sottostante, anche in bypass o auto mode. Fonte: [GitHub Releases v2.1.319](https://github.com/anthropics/claude-code/releases/tag/v2.1.319). Doc: [docs/14-loop-monitor.md](./14-loop-monitor.md).

---

## 2026-11-06

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Una nuova versione (v2.1.319) e' stata pubblicata su npm nella notte tra il 5 e il 6 novembre, ma il changelog ufficiale (GitHub CHANGELOG.md, `code.claude.com/docs/en/changelog`) non si e' ancora sincronizzato al momento di questo aggiornamento — l'ultima voce verificabile resta v2.1.318 (4 nov, gia' coperta), quindi nessun dettaglio di contenuto e' al momento confermabile; verra' valutata nell'aggiornamento di domani una volta disponibile. I due articoli Anthropic del 5 novembre nella finestra (beta "Personal Finance in Claude" e nuovi controlli di sicurezza/amministrazione per Claude Enterprise) riguardano i prodotti Claude apps/Enterprise, non la CLI Claude Code, sotto soglia. Nessun post team rilevante: x.com irraggiungibile dalla rete della sessione (DNS), ricerche web sostitutive sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-11-04

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.318, 4 nov) resta sotto la soglia editoriale: l'estensione IDE non si installa/aggiorna piu' se Claude Code parte da un terminale IDE (usare `/ide` da terminale esterno), i subagent in background spostano i comandi shell in background dopo 3 minuti su tutti i provider per non far scadere la prompt cache, `assume_role` sugli upstream `mantle` del gateway Claude apps e un avviso quando un login claude.ai salvato sta per scadere, oltre a 47 fix (tra cui `--continue` che perdeva la conversazione precedente dopo retry su tool call malformate, regressione di 2.1.314) — nessun nuovo slash command, tool primitivo o feature di sistema. L'unico articolo Anthropic nella finestra (4 nov, nuovi partner nel Claude Marketplace per sicurezza/dev infra/marketing/produttivita') non riguarda la CLI Claude Code, sotto soglia. Nessun post team rilevante: x.com irraggiungibile dalla rete della sessione (DNS), ricerche web sostitutive sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-11-03

> Nessuna novita' significativa nelle ultime 24-48 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.317, 3 nov) resta sotto la soglia editoriale: aggiunge un avviso in `/schedule` quando una nuova attivita' cloud usa connettori MCP non richiesti in precedenza, un controllo di conferma prima che un tool web o shell invii l'email dell'account, `onFailure: "block"` per gli hook dell'Agent SDK, nuove metriche OpenTelemetry e un report dei costi nell'API admin del gateway Claude apps, oltre a `CLAUDE_CODE_DISABLE_NESTED_SESSION_ID` e al fix di `claude -p` che ora esce con errore invece di proseguire silenziosamente a disco pieno — nessun nuovo slash command, tool primitivo o feature di sistema. Nessun annuncio Anthropic blog dedicato su Claude Code nella finestra (gli ultimi post, 26-28 ottobre, riguardano AI for Science, sviluppo farmaci e la partnership GSA). Nessun post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-11-01

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Nessuna nuova release CLI nella finestra: l'ultima resta v2.1.316 (31 ott), gia' coperta ieri — nessuna versione successiva su GitHub Releases, tags o changelog ufficiale. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (i post recenti — AI for Science, sviluppo farmaci, partnership GSA, deposito S-1 per l'IPO — non riguardano la CLI). Nessun nuovo slash command, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-31

> Nessuna novita' significativa nelle ultime 24-48 ore. Prossimo aggiornamento domani 07:00.

Le release nella finestra (v2.1.314, 30 ott; v2.1.316, 31 ott) restano sotto la soglia editoriale: v2.1.314 aggiunge `permissions.blockWritesOutsideWorkingDirectories` (Write/Edit/NotebookEdit rifiutano sempre i path fuori dalle working directory, in ogni modalita' di permesso), idle compaction anche in VS Code e nel tab Code della desktop app (estensione di una feature gia' in terminale da v2.1.299), una lista `groups` per limitare un upstream del gateway Claude apps a determinati gruppi IdP, oltre a 81 fix (tra cui `claude -p` che usciva con codice 0 senza output in caso di errore di avvio, e un bug TLS con certificati radice rinnovati cross-signed); v2.1.316 aggiunge `CLAUDE_CODE_DISABLE_ULTRATHINK` e `CLAUDE_CODE_SUBAGENT_EFFORT`, budget di gruppo aggregati (`pooled_budget`) e `managed.policy_mode: "layered"` per il gateway, e annuncia la **deprecazione del fast mode per Opus 4.8** dal 30 ottobre (rimosso il 30 novembre 2026, poi errore invece di fallback — da migrare a Opus 5.5), oltre a fix su comandi shell lasciati in esecuzione dopo l'uscita su macOS/Linux e alias `sonnet`/`opus`/`haiku` che su Vertex/Bedrock andavano in errore a meta' sessione invece di passare a un modello piu' vecchio. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore. Nessun nuovo slash command, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-29

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.312, 27 ott) resta sotto la soglia editoriale: aggiunge `oidc.user_id_claim` per identificare gli utenti tramite un claim diverso da `sub` (es. `oid` di Microsoft Entra ID), il click-to-send sul prompt accodato in fullscreen, un effort level nel model picker delle routine cloud e un editor Bash con syntax highlighting per lo script di setup degli ambienti cloud, oltre a una lunga serie di fix (CLAUDE.md/rules file molto grandi che Claude sovrascriveva leggendone solo l'inizio, skill per-directory non trovate dopo un `cd` Bash dentro un repo git, prima risposta mancante al resume di una sessione terminale, un comando con nome non valido che bloccava il caricamento di tutti gli altri comandi, Read che falliva su pagine PDF durante il cleanup dei file di sessione) e la rimozione dell'evento OpenTelemetry `claude_code.safety_event`. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (i post del 27-28 ottobre riguardano AI for Science, sviluppo farmaci, la partnership con la GSA, nuove funzioni report/sondaggi/budget per Claude Enterprise e un case study IDC/Quanta — nessuno introduce feature tecniche per la CLI). Nessun nuovo slash command, tool primitivo o post team rilevante: x.com irraggiungibile dalla rete della sessione (DNS), ricerche web sostitutive sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-27

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.311, 26 ott) resta sotto la soglia editoriale: aggiunge `--hold-idle-file` e `--max-hold-min` per `self-hosted-runner` (mantiene una sessione idle mentre l'host segnala processi lasciati in esecuzione) e un tip per l'output style Explanatory, oltre a una lunga serie di fix (freeze all'avvio con un item di lista molto lungo in CLAUDE.md, Write/Edit che si bloccavano fino a 5 secondi modificando migliaia di righe, hook `SubagentStop` che scattavano circa due volte al minuto invece che una sola a fine lavoro, sessioni standard-context che si fermavano con errore "Usage credits required for 1M context" sopra 200K token invece di compattare, worktree isolati di subagent rimossi mentre un loro sotto-subagent in background ci lavorava ancora) e miglioramenti minori (rimozione del suffisso `[1m]` dai nomi modello dove non ha effetto, sintassi colorata nei code block della risposta in VS Code, vista Skills nelle analytics di Claude Tag). Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (l'unico post del 26 ottobre, il deposito S-1 per l'IPO, e' notizia societaria/finanziaria, non un annuncio prodotto su Claude Code). Nessun nuovo slash command, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-26

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Nessuna nuova release CLI nella finestra: l'ultima resta v2.1.310 (23 ott), gia' coperta nei giorni scorsi. Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (l'ultimo rilevante resta la donazione di Agent Skills alla Agentic AI Foundation del 22 ottobre, gia' coperta). Nessun nuovo slash command, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-25

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

Nessuna nuova release CLI nella finestra: l'ultima resta v2.1.310 (23 ott), gia' coperta ieri. Due articoli sul blog Anthropic del 23 ottobre restano fuori soglia perche' non riguardano la CLI Claude Code: l'unificazione di chat e Cowork per i piani Enterprise (estensione business di una feature gia' in GA da aprile) e le misure di sicurezza di **Claude Duet**, nuovo agente consumer separato che riusa il classificatore di auto mode di Claude Code come building block ma non e' una sua feature. Nessun nuovo slash command, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

## 2026-10-24

> Nessuna novita' significativa nelle ultime 24 ore. Prossimo aggiornamento domani 07:00.

L'unica release nella finestra (v2.1.310, 23 ott) resta sotto la soglia editoriale: estende il Monitor tool e i monitor dei plugin anche a Bedrock, Vertex e Foundry e ai setup con telemetria/traffico non essenziale disattivati (bloccando anche li' gli sleep in foreground troppo lunghi, feature gia' coperta in [docs/14-loop-monitor.md](./docs/14-loop-monitor.md)), aggiunge permessi Enterprise per ruoli custom su Cloud sessions e Remote Control e un pulsante per caricare da file lo script di setup di un cloud environment, oltre a una quarantina di fix (retry automatico su gateway che rifiutano il beta `effort-2025-11-24` o messaggi di sistema a meta' conversazione, cleanup in background che non cancella piu' file recenti con `cleanupPeriodDays` molto alto, hook Windows che non bypassano piu' i permessi quando Git Bash manca, fix su VS Code, Claude Tag e Code Review admin). Nessun annuncio Anthropic blog dedicato su Claude Code nelle ultime 24-48 ore (l'unico post rilevante, sulla donazione di Agent Skills alla Agentic AI Foundation, e' del 22 ottobre e gia' coperto ieri). Nessun nuovo slash command, tool primitivo o post team rilevante: ricerche web sugli account del team (bcherny, catwu, noahzweben, trq212, claudeai, ClaudeDevs, alistaiir, ClaudeCodeLog) senza risultati pertinenti nella finestra; nessun articolo tecnico con tutorial riproducibile rilevante trovato. Digest settimanale ufficiale ancora fermo alla Week 37 (7-11 set).

---

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
