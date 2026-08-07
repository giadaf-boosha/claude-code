# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

## 2026-08-06

- **Rimosso `/ultraplan`** (v2.1.222, 4 ago): il planning in cloud lanciato ad aprile 2026 e' stato eliminato dal CLI senza sostituto dedicato — resta `/plan` locale o le routine (`/schedule`) per orchestrazione cloud. Fonte: [GitHub Releases v2.1.222](https://github.com/anthropics/claude-code/releases/tag/v2.1.222). Doc: [docs/15-ultraplan-ultrareview.md](./15-ultraplan-ultrareview.md), [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).
- **`/review` torna alias di `/code-review`** (v2.1.223, 6 ago): revisiona il diff corrente o una PR (`/code-review <level> <pr#>`), `/code-review ultra` per la deep review cloud — inverte la separazione single-pass introdotta a luglio (v2.1.202). Fonte: [GitHub Releases v2.1.223](https://github.com/anthropics/claude-code/releases/tag/v2.1.223). Doc: [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).
- **Focus view in VS Code** (v2.1.221, 4 ago): toggle `Ctrl+Alt+F` che nasconde l'attivita' dei tool dietro un riassunto per-turno espandibile, con indicatore live del tool in esecuzione. Fonte: [GitHub Releases v2.1.221](https://github.com/anthropics/claude-code/releases/tag/v2.1.221). Doc: [docs/17-ide-surface.md](./17-ide-surface.md), [docs/19-changelog.md](./19-changelog.md).

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

## 2026-07-04

- **Permission mode default → `manual`** (v2.1.200, 3 lug): il permission mode attivo all'avvio e' rinominato da `default` a `manual` in CLI, VS Code e JetBrains — comportamento invariato (solo letture auto-approvate), label piu' descrittiva. Contestualmente `AskUserQuestion` non auto-continua piu' dopo timeout idle; per riattivarla: `/config`. Fonte: [GitHub Releases v2.1.200](https://github.com/anthropics/claude-code/releases/tag/v2.1.200) · [@ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2073091434123591872). Doc: [docs/04-modalita-permessi.md](./docs/04-modalita-permessi.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-07-03

- **Stacked slash-skill invocations** (v2.1.199, 2 lug): `/skill-a /skill-b do XYZ` carica fino a 5 skill in cascata da un unico prompt — composizione skill senza configurazione aggiuntiva o modifica del frontmatter. Fonte: [GitHub Releases v2.1.199](https://github.com/anthropics/claude-code/releases/tag/v2.1.199). Doc: [docs/09-skills.md](./docs/09-skills.md), [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Artifacts su Pro e Max** (2 lug): Artifacts in Claude Code estesi a Pro e Max — le pagine web condivisibili da sessione ora disponibili per tutti i piani paid, non solo Team/Enterprise. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2072770790114914317). Doc: [docs/12-agent-teams.md](./docs/12-agent-teams.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-07-02

- **Claude in Chrome GA** (v2.1.198, 1 lug): accesso browser-native alle sessioni e agli agenti Claude Code senza installazione aggiuntiva — la Chrome extension diventa surface di prima classe con Agent View completa. Fonte: [GitHub Releases v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198) · [@ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2072425697629343845). Doc: [docs/17-ide-surface.md](./docs/17-ide-surface.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Background agents auto-delivery** (v2.1.198, 1 lug): gli agenti background al termine del lavoro in worktree eseguono automaticamente commit, push e aprono una draft PR — chiude il loop delivery senza intervento manuale. Fonte: [GitHub Releases v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198). Doc: [docs/08-subagents.md](./docs/08-subagents.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`/dataviz` skill built-in** (v2.1.198, 1 lug): nuovo skill bundled per progettazione grafici, chart e dashboard — include validatore tavolozza colori e linee guida accessibilita' per output coerenti in light e dark mode. Fonte: [GitHub Releases v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198). Doc: [docs/09-skills.md](./docs/09-skills.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-07-01

- **Claude Sonnet 5 — nuovo modello default** (v2.1.197, 30 giu): `claude-sonnet-5` sostituisce Sonnet 4.6 come modello di default in Claude Code per Free e Pro. Finestra di contesto nativa da 1M token, 128k output max. Pricing promozionale $2/$10 per MTok fino al 31 agosto (poi $3/$15). Performance: #3 su APEX-SWE (43.7% Pass@1). Aggiornare con `claude update`. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2072018504392601762). Doc: [docs/05-fast-mode-1m-context.md](./docs/05-fast-mode-1m-context.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-30

- **Modello default organizzativo** (v2.1.196, 29 giu): gli amministratori configurano il modello Claude di default per tutta l'organizzazione dalla console — in `/model` compare "Org default" o "Role default" quando nessun override personale e' attivo. Fonte: [GitHub Releases v2.1.196](https://github.com/anthropics/claude-code/releases/tag/v2.1.196). Doc: [docs/18-settings-auth.md](./docs/18-settings-auth.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Sicurezza MCP: auto-approvazione `.mcp.json`** (v2.1.196, 29 giu): `claude mcp list`/`get` non avvia piu' server da `.mcp.json` auto-approvato via settings committati — workspace non affidabili mostrano `⏠ Pending approval`. Fonte: [GitHub Releases v2.1.196](https://github.com/anthropics/claude-code/releases/tag/v2.1.196).

---

## 2026-06-29

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-28

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-27

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-26

- **Claude Tag** (beta, 25 giu): Claude Code diventa multiplayer — si integra in Slack come team member condiviso per Enterprise e Team plan. Chiunque nel canale puo' taggare @Claude, delegargli task e seguirne il lavoro in thread. Gira su Opus 4.8; la versione interna genera gia' il 65% del codice del product team Anthropic. Fonte: [@claudeai](https://x.com/claudeai/status/2069468694552461375) · [@ClaudeDevs](https://x.com/ClaudeDevs/status/2069468913264644419). Doc: [docs/12-agent-teams.md](./docs/12-agent-teams.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`autoMode.classifyAllShell`** (v2.1.193, 25 giu): nuova setting instrada TUTTI i comandi Bash/PowerShell attraverso il classificatore auto mode — non solo i pattern arbitrary-code-execution. Le denial reasons vengono ora scritte nel transcript, nel toast di blocco e nel tab "Recently denied" di `/permissions`. Fonte: [GitHub Releases v2.1.193](https://github.com/anthropics/claude-code/releases/tag/v2.1.193). Doc: [docs/04-modalita-permessi.md](./docs/04-modalita-permessi.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-25

- **`/rewind` post-`/clear`** (v2.1.191, 24 giu): `/rewind` recupera ora la conversazione anche da prima di un `/clear` — in precedenza il context azzerato era irrecuperabile nella sessione corrente. Rilasciato insieme a un miglioramento prestazioni streaming del ~37% via coalescing degli aggiornamenti testo a 100ms. Fonte: [GitHub Releases v2.1.191](https://github.com/anthropics/claude-code/releases/tag/v2.1.191). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/04-modalita-permessi.md](./docs/04-modalita-permessi.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-24

- **`sandbox.credentials`** (v2.1.187, 23 giu): nuova opzione sandbox blocca i comandi eseguiti in ambiente sandboxato dalla lettura di file di credenziali e variabili d'ambiente segrete — rafforza l'isolamento in deploy multi-tenant e pipeline CI/CD condivise. Configurabile in `settings.json`. Fonte: [GitHub Releases v2.1.187](https://github.com/anthropics/claude-code/releases/tag/v2.1.187). Doc: [docs/18-settings-auth.md](./docs/18-settings-auth.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-23

- **`claude mcp login/logout <name>`** (v2.1.186, 22 giu): nuovi comandi CLI per autenticare e deautenticare server MCP senza aprire il menu interattivo `/mcp`; `--no-browser` supporta flussi SSH headless. Fonte: [GitHub Releases v2.1.186](https://github.com/anthropics/claude-code/releases/tag/v2.1.186). Doc: [docs/10-mcp.md](./docs/10-mcp.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Bash `!` auto-response** (v2.1.186, 22 giu): i comandi `!<bash>` nel prompt triggherano ora una risposta automatica di Claude sull'output — prima era necessario esplicitare la richiesta. Disabilita con `"respondToBashCommands": false` in `settings.json`. Fonte: [GitHub Releases v2.1.186](https://github.com/anthropics/claude-code/releases/tag/v2.1.186). Doc: [docs/20-tips-best-practices.md](./docs/20-tips-best-practices.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-22

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-21

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-20

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-19

- **Artifacts in Claude Code** (beta, Team & Enterprise, 19 giu): Claude trasforma il lavoro di sessione in pagine web condivise — PR walkthrough, dashboard di progetto — aggiornate in tempo reale mentre la sessione continua. Condivisibili via link privato al team. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2067672094209675373) · [@claudeai](https://x.com/claudeai/status/2067671912038240487). Doc: [docs/12-agent-teams.md](./docs/12-agent-teams.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`/design-sync`** (19 giu): nuovo slash command per sync bidirezionale tra Claude Code e Claude Design — pull del design system nel repo per buildare su componenti reali, push del codice verso il canvas Design per continuare l'editing. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2067391951725629941). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Auto mode safety** (v2.1.183, 19 giu): auto mode blocca ora automaticamente comandi git distruttivi (`git reset --hard`, `git checkout -- .`, `git clean -fd`, `git stash drop`, `git commit --amend` non richiesto) e destroy di infra (`terraform destroy`, `pulumi destroy`, `cdk destroy`) quando non esplicitamente richiesti nel prompt corrente. Fonte: [GitHub Releases v2.1.183](https://github.com/anthropics/claude-code/releases/tag/v2.1.183). Doc: [docs/04-modalita-permessi.md](./docs/04-modalita-permessi.md), [docs/19-changelog.md](./docs/19-changelog.md).

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
