# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

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

## 2026-06-12

- **Usage attribution per-skill/agent/plugin** (v2.1.174, 12 giu): il dialog "Account & usage" mostra ora breakdowns granulari per skill, agent, plugin e server MCP, oltre a cache misses e long context — utile per analizzare i costi nei workflow agentic complessi. Fonte: [GitHub Releases v2.1.174](https://github.com/anthropics/claude-code/releases/tag/v2.1.174). Doc: [docs/08-subagents.md](./docs/08-subagents.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`enforceAvailableModels`** (v2.1.175, 12 giu): nuova opzione managed settings rende strict l'allowlist `availableModels` — il Default model e' ora vincolato dalla lista gestita e user/project settings non possono espandere i modelli consentiti dall'enterprise. Fonte: [GitHub Releases v2.1.175](https://github.com/anthropics/claude-code/releases/tag/v2.1.175). Doc: [docs/18-settings-auth.md](./docs/18-settings-auth.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-11

- **Sub-agenti annidati fino a 5 livelli** (v2.1.172, 10 giu): i sub-agenti possono ora lanciare a loro volta sub-agenti, con gerarchia profonda fino a 5 livelli — ogni livello riceve un context window fresco e restituisce solo un summary al padre. Abilita l'orchestrazione di task complessi senza saturare il context del main agent. Fonte: [GitHub Releases v2.1.172](https://github.com/anthropics/claude-code/releases/tag/v2.1.172). Doc: [docs/08-subagents.md](./docs/08-subagents.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-10

- **Claude Fable 5** (`claude-fable-5`, v2.1.170, 9 giu): primo modello Mythos-class di Anthropic disponibile pubblicamente — prestazioni superiori a qualsiasi modello precedentemente rilasciato al pubblico, ottimizzato per reasoning profondo e lavoro agentico di lunga durata. Context window 1M token, fino a 128k output per request, pricing $10/$50 per MTok (input/output), adaptive thinking sempre attivo. Disponibile su Claude API, Bedrock, Vertex AI, Foundry e Claude Code v2.1.170. Fonte: [GitHub Releases v2.1.170](https://github.com/anthropics/claude-code/releases/tag/v2.1.170) · [Anthropic docs](https://platform.claude.com/docs/en/about-claude/models/introducing-claude-fable-5-and-claude-mythos-5). Doc: [docs/05-fast-mode-1m-context.md](./docs/05-fast-mode-1m-context.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-09

- **Safe Mode** (`--safe-mode` / `CLAUDE_CODE_SAFE_MODE`, v2.1.169, 8 giu): nuovo flag di avvio disabilita tutte le customizzazioni (CLAUDE.md, plugin, skill, hook, MCP server) — pensato per troubleshooting isolato senza toccare la configurazione permanente. Fonte: [GitHub Releases v2.1.169](https://github.com/anthropics/claude-code/releases/tag/v2.1.169). Doc: [docs/04-modalita-permessi.md](./docs/04-modalita-permessi.md), [docs/18-settings-auth.md](./docs/18-settings-auth.md).
- **`/cd`** (v2.1.169, 8 giu): nuovo slash command sposta la sessione in una nuova working directory senza rompere il prompt cache — prima si doveva riavviare la sessione. Fonte: [GitHub Releases v2.1.169](https://github.com/anthropics/claude-code/releases/tag/v2.1.169). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md).
- **`disableBundledSkills`** (`CLAUDE_CODE_DISABLE_BUNDLED_SKILLS`, v2.1.169, 8 giu): nuovo setting nasconde le skill bundled e i comandi built-in dal modello — utile per ambienti enterprise che vogliono esporre solo le proprie skill custom. Fonte: [GitHub Releases v2.1.169](https://github.com/anthropics/claude-code/releases/tag/v2.1.169). Doc: [docs/09-skills.md](./docs/09-skills.md), [docs/18-settings-auth.md](./docs/18-settings-auth.md).

---

## 2026-06-08

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-07

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-06

- **`fallbackModel` setting** (v2.1.166, 6 giu): il campo `fallbackModel` in `settings.json` configura fino a 3 modelli di fallback provati in sequenza quando il primario e' sovraccarico o non disponibile; `--fallback-model` funziona ora anche nelle sessioni interattive (in precedenza solo in modalita' `-p`). Fonte: [GitHub Releases v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166). Doc: [docs/18-settings-auth.md](./docs/18-settings-auth.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Thinking Token Control** (v2.1.166, 6 giu): `MAX_THINKING_TOKENS=0`, `--thinking disabled` e il toggle per-modello disattivano il thinking su modelli che lo abilitano di default via Claude API — per output piu' rapidi o deterministici nei workflow API. Fonte: [GitHub Releases v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166). Doc: [docs/05-fast-mode-1m-context.md](./docs/05-fast-mode-1m-context.md), [docs/18-settings-auth.md](./docs/18-settings-auth.md).
- **Cross-session messaging hardening** (v2.1.166, 6 giu): i messaggi inoltrati via `SendMessage` da altre sessioni Claude non portano piu' l'autorita' dell'utente; i ricevitori rifiutano le richieste di permesso inoltrate e auto mode le blocca — rafforza la sicurezza nei workflow multi-agente con `SendMessage`. Fonte: [GitHub Releases v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166). Doc: [docs/08-subagents.md](./docs/08-subagents.md).

---

## 2026-06-05

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-04

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-03

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-06-02

- **Protezione file sensibili shell/build-tool** (v2.1.160, 2 giu): Claude Code mostra ora un prompt di conferma prima di scrivere su file di avvio shell (`.zshenv`, `.zlogin`, `.bash_login`, `~/.config/git/`) e file di configurazione build-tool (`.npmrc`, `.yarnrc*`, `bunfig.toml`, `.bazelrc`, `.pre-commit-config.yaml`, `.devcontainer/`) — il prompt appare anche in modalita' `acceptEdits`, prevenendo modifiche accidentali a configurazioni che concedono accesso all'esecuzione di codice. Fonte: [GitHub Releases v2.1.160](https://github.com/anthropics/claude-code/releases/tag/v2.1.160). Doc: [docs/04-modalita-permessi.md](./docs/04-modalita-permessi.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-06-01

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-31

- **Auto mode su Bedrock, Vertex e Foundry** (v2.1.158, 30 mag): la modalita' auto — il classifier che sostituisce le permission prompt con safety check automatici — diventa disponibile su AWS Bedrock, Google Vertex AI e Azure Foundry per Opus 4.7 e Opus 4.8; opt-in con `CLAUDE_CODE_ENABLE_AUTO_MODE=1`. Fonte: [GitHub Releases v2.1.158](https://github.com/anthropics/claude-code/releases/tag/v2.1.158). Doc: [docs/04-modalita-permessi.md](./docs/04-modalita-permessi.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-30

- **Plugin auto-loading** (v2.1.157, 29 mag): i plugin in `.claude/skills/<nome>/` vengono caricati automaticamente senza passare per il marketplace — niente piu' `/plugin install` per plugin locali e custom. Fonte: [GitHub Releases v2.1.157](https://github.com/anthropics/claude-code/releases/tag/v2.1.157). Doc: [docs/11-plugins-marketplace.md](./docs/11-plugins-marketplace.md), [docs/09-skills.md](./docs/09-skills.md).
- **`claude plugin init <name>`** (v2.1.157, 29 mag): nuovo comando CLI scaffolda un plugin in `.claude/skills/<nome>/` con struttura e manifest pronti — abbassa la barriera alla creazione di plugin locali senza configurazione manuale. Fonte: [GitHub Releases v2.1.157](https://github.com/anthropics/claude-code/releases/tag/v2.1.157). Doc: [docs/11-plugins-marketplace.md](./docs/11-plugins-marketplace.md).
- **Campo `agent` in `settings.json` per dispatch** (v2.1.157, 29 mag): il campo `agent` viene ora rispettato per le sessioni dispatch con override per sessione via `--agent <name>` — permette di fissare l'agente di default senza modificare ogni invocazione. Fonte: [GitHub Releases v2.1.157](https://github.com/anthropics/claude-code/releases/tag/v2.1.157). Doc: [docs/08-subagents.md](./docs/08-subagents.md), [docs/18-settings-auth.md](./docs/18-settings-auth.md).

---

## 2026-05-29

- **Opus 4.8** (v2.1.154, 28 mag): nuovo modello flagship disponibile in Claude Code come default per task `xhigh`; Fast Mode su Opus 4.8 gira a 2.5x la velocita' standard a 2x il costo base. Fonte: [GitHub Releases v2.1.154](https://github.com/anthropics/claude-code/releases/tag/v2.1.154). Doc: [docs/05-fast-mode-1m-context.md](./docs/05-fast-mode-1m-context.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`/workflows`** (v2.1.154, 28 mag): nuovo slash command per creare e orchestrare workflow dinamici con decine o centinaia di agenti background — descrivi il task, Claude genera il workflow ed esegue gli agenti in parallelo. Fonte: [GitHub Releases v2.1.154](https://github.com/anthropics/claude-code/releases/tag/v2.1.154). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/08-subagents.md](./docs/08-subagents.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`! <command>` in `claude agents`** (v2.1.154, 28 mag): digitare `! <comando>` in Agent View esegue il comando shell direttamente in una sessione background — equivalente a `claude --bg --exec '<comando>'` senza uscire dall'interfaccia di gestione sessioni. Fonte: [GitHub Releases v2.1.154](https://github.com/anthropics/claude-code/releases/tag/v2.1.154). Doc: [docs/08-subagents.md](./docs/08-subagents.md).

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
