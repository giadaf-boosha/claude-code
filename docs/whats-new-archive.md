# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

## 2026-07-19

- **`/verify` e `/code-review` non piu' auto-invocate** (v2.1.215, 19 lug): Claude non lancia piu' di propria iniziativa le skill `/verify` e `/code-review` a fine task — vanno invocate esplicitamente quando servono. Riduce le review "a sorpresa" non richieste dall'utente. Fonte: [GitHub Releases v2.1.215](https://github.com/anthropics/claude-code/releases/tag/v2.1.215). Doc: [docs/09-skills.md](./09-skills.md), [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-07-18

- **`/fork` → sessione background + `/subtask`** (v2.1.212, 17 lug): `/fork` non spawna piu' un subagent in-sessione ma copia l'intera conversazione in una nuova sessione background (riga separata in `claude agents`), lasciando libero il thread principale; il vecchio comportamento (subagent dentro la sessione corrente) e' ora `/subtask`. Stessa release: tetti di sicurezza default (200 WebSearch, 200 subagent spawn per sessione) e `/resume` con picker delle sessioni passate, incluse quelle cancellate. Fonte: [GitHub Releases v2.1.212](https://github.com/anthropics/claude-code/releases/tag/v2.1.212). Doc: [docs/08-subagents.md](./08-subagents.md), [docs/03-slash-commands.md](./03-slash-commands.md), [docs/19-changelog.md](./19-changelog.md).
- **Tool `EndConversation`** (v2.1.214, 18 lug): nuovo tool primitivo che permette a Claude di terminare autonomamente una conversazione con utenti fortemente abusivi o tentativi di jailbreak, affiancandosi a Monitor e AskUserQuestion nella cassetta degli attrezzi built-in dell'agent loop. Fonte: [GitHub Releases v2.1.214](https://github.com/anthropics/claude-code/releases/tag/v2.1.214). Doc: [docs/16-headless-agent-sdk.md](./16-headless-agent-sdk.md), [docs/04-modalita-permessi.md](./04-modalita-permessi.md), [docs/19-changelog.md](./19-changelog.md).

---

## 2026-07-14

> Nessuna novita' significativa nelle ultime 24 ore.

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

## 2026-06-18

- **`/config key=value`** (v2.1.181, 17 giu): la sintassi `/config key=value` imposta qualsiasi setting direttamente dal prompt senza modificare `settings.json` — es. `/config thinking=false` disabilita il thinking per la sessione corrente. Funziona in modalita' interattiva, con `-p` e in Remote Control. Fonte: [GitHub Releases v2.1.181](https://github.com/anthropics/claude-code/releases/tag/v2.1.181). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/18-settings-auth.md](./docs/18-settings-auth.md).
- **`CLAUDE_CLIENT_PRESENCE_FILE`** (v2.1.181, 17 giu): nuova env var punta a un marker file per silenziare le push notification mobile mentre si e' alla macchina — utile per chi usa Claude Code sia da desktop che da mobile. Fonte: [GitHub Releases v2.1.181](https://github.com/anthropics/claude-code/releases/tag/v2.1.181). Doc: [docs/18-settings-auth.md](./docs/18-settings-auth.md).

---

## 2026-06-17

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-16

- **`Tool(param:value)` nelle permission rules** (v2.1.178, 15 giu): le regole `allow`/`deny` in `settings.json` supportano ora la sintassi `Tool(param:value)` per filtrare in base ai parametri del tool — ad esempio `Agent(model:opus)` in `deny` blocca qualsiasi sub-agente che usa Opus, con supporto wildcard `*`. Fonte: [GitHub Releases v2.1.178](https://github.com/anthropics/claude-code/releases/tag/v2.1.178). Doc: [docs/18-settings-auth.md](./docs/18-settings-auth.md#183-permission-rule-syntax), [docs/19-changelog.md](./docs/19-changelog.md).
- **Nested `.claude/` directory precedence** (v2.1.178, 15 giu): skill, agenti, workflow e output-style nella directory `.claude/` piu' vicina alla working directory ora prevalgono su quelli di livello superiore; in caso di clash di nome, la skill annidata e' disponibile come `<dir>:<name>` — entrambe restano accessibili. I workflow salvati a livello progetto puntano ora alla `.claude/workflows/` piu' vicina. Fonte: [GitHub Releases v2.1.178](https://github.com/anthropics/claude-code/releases/tag/v2.1.178). Doc: [docs/09-skills.md](./docs/09-skills.md#96-auto-discovery-e-nested), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-15

- **Credito programmazione attivo da oggi** (15 giu 2026): i crediti mensili dedicati per uso programmatico entrano in vigore — `claude -p`, Agent SDK, GitHub Actions e app terze parti basate sull'SDK escono dal pool interattivo e attingono a un budget separato ($20 Pro · $100 Max 5x/Team per seat · $200 Max 20x/Enterprise per seat). Il credito va reclamato, si azzera con il ciclo di fatturazione e non e' cumulabile. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2054610152817619388). Doc: [docs/16-headless-agent-sdk.md](./docs/16-headless-agent-sdk.md#crediti-mensili-per-uso-programmatico-attivi-dal-15-giu-2026).

---

## 2026-06-14

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-13

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
