# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

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

- **`/plugin list`** (v2.1.163, 4 giu): nuovo sottocomando elenca i plugin installati con filtri `--enabled` e `--disabled` — permette di vedere rapidamente lo stato dell'ecosistema plugin nella sessione corrente. Fonte: [GitHub Releases v2.1.163](https://github.com/anthropics/claude-code/releases/tag/v2.1.163). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/11-plugins-marketplace.md](./docs/11-plugins-marketplace.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Managed Settings: version enforcement** (v2.1.163, 4 giu): i campi `requiredMinimumVersion` e `requiredMaximumVersion` in `managed-settings.json` bloccano l'avvio di Claude Code se la versione installata e' fuori dal range — policy enterprise per garantire versioni stabili approvate. Fonte: [GitHub Releases v2.1.163](https://github.com/anthropics/claude-code/releases/tag/v2.1.163). Doc: [docs/18-settings-auth.md](./docs/18-settings-auth.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Stop/SubagentStop hook: `additionalContext`** (v2.1.163, 4 giu): i hook `Stop` e `SubagentStop` possono ora restituire `hookSpecificOutput.additionalContext` per iniettare feedback e continuare il turn senza che l'output venga marcato come errore hook. Fonte: [GitHub Releases v2.1.163](https://github.com/anthropics/claude-code/releases/tag/v2.1.163). Doc: [docs/07-hooks.md](./docs/07-hooks.md), [docs/19-changelog.md](./docs/19-changelog.md).

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

## 2026-05-28

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-27

- **`/reload-skills`** (v2.1.152, 27 mag): nuovo slash command built-in ricarica le directory skill nella sessione corrente senza riavvio — utile dopo installazione di nuovi plugin o aggiornamento di skill locali; i `SessionStart` hook possono restituire `reloadSkills: true` per lo stesso effetto via codice, e `sessionTitle` per impostare il titolo della sessione. Fonte: [GitHub Releases v2.1.152](https://github.com/anthropics/claude-code/releases/tag/v2.1.152). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/09-skills.md](./docs/09-skills.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`MessageDisplay` hook event** (v2.1.152, 27 mag): nuovo evento hook che intercetta i messaggi dell'assistente prima della visualizzazione — permette di trasformare il testo (redact, formatting, traduzione) o nasconderlo completamente. Fonte: [GitHub Releases v2.1.152](https://github.com/anthropics/claude-code/releases/tag/v2.1.152). Doc: [docs/07-hooks.md](./docs/07-hooks.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`/code-review --fix`** (v2.1.152, 27 mag): nuovo flag applica automaticamente i suggerimenti di review (refactoring, semplificazioni, efficienze) al working tree; `/simplify` torna come alias di `/code-review --fix`, chiudendo il ciclo iniziato con la rinomina in v2.1.146. Fonte: [GitHub Releases v2.1.152](https://github.com/anthropics/claude-code/releases/tag/v2.1.152). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`disallowed-tools` in frontmatter skill** (v2.1.152, 27 mag): le skill possono dichiarare nel frontmatter quali tool rimuovere dal modello durante la propria esecuzione — aumenta il focus del modello e riduce il rischio di uso accidentale di tool non pertinenti. Fonte: [GitHub Releases v2.1.152](https://github.com/anthropics/claude-code/releases/tag/v2.1.152). Doc: [docs/09-skills.md](./docs/09-skills.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-26

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-25

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-24

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-23

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-22

- **`/code-review --comment`** (v2.1.147, 21 mag): il flag `--comment` su `/code-review` pubblica i risultati della review come commenti inline direttamente su GitHub PR — chiude il loop tra analisi locale e feedback remoto senza uscire dal terminale. Fonte: [GitHub Releases v2.1.147](https://github.com/anthropics/claude-code/releases/tag/v2.1.147). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Sessioni background pinnate** (v2.1.147, 21 mag): le sessioni pinnate con `Ctrl+T` in `claude agents` restano attive anche quando idle e si riavviano automaticamente per applicare gli aggiornamenti di Claude Code — utile per agent di lunga durata che non devono essere interrotti da inattivita'. Fonte: [GitHub Releases v2.1.147](https://github.com/anthropics/claude-code/releases/tag/v2.1.147). Doc: [docs/08-subagents.md](./docs/08-subagents.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-21

- **`/code-review` (ex `/simplify`)** (v2.1.146, 21 mag): `/simplify` rinominato `/code-review` con parametro effort opzionale (es. `/code-review high`) — il nuovo nome riflette meglio l'azione (3 review agent paralleli + apply fix) e allinea il comando all'interfaccia `/effort`. Il vecchio nome non e' piu' valido. Fonte: [GitHub Releases v2.1.146](https://github.com/anthropics/claude-code/releases/tag/v2.1.146). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-20

- **`claude agents --json`** (v2.1.145, 19 mag): il flag `--json` su `claude agents` restituisce la lista delle sessioni live in formato JSON — abilita scripting, integrazione tmux-resurrect, status bar custom e automazioni che interrogano lo stato degli agenti attivi. Fonte: [GitHub Releases v2.1.145](https://github.com/anthropics/claude-code/releases/tag/v2.1.145). Doc: [docs/08-subagents.md](./docs/08-subagents.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`/resume` per sessioni background** (v2.1.144, 19 mag): `/resume` include ora le sessioni avviate via `claude --bg` o Agent View — appaiono nella lista con tag `bg`, chiudendo il gap tra sessioni interattive e background nella navigazione storica. Fonte: [GitHub Releases v2.1.144](https://github.com/anthropics/claude-code/releases/tag/v2.1.144). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`/plugin` pre-install preview** (v2.1.145, 19 mag): le tab Discover e Browse del marketplace mostrano comandi, agenti, skill, hook e server MCP/LSP forniti da un plugin prima dell'installazione — permette di valutare l'impatto senza committere. Fonte: [GitHub Releases v2.1.145](https://github.com/anthropics/claude-code/releases/tag/v2.1.145). Doc: [docs/11-plugins-marketplace.md](./docs/11-plugins-marketplace.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-19

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-18

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-17

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-16

- **Plugin dependency enforcement** (v2.1.143, 15 mag): `claude plugin disable` rifiuta la disabilitazione quando un altro plugin abilitato dipende dal target, mostrando un hint copy-pasteable con la catena completa da disabilitare; `claude plugin enable` forza l'abilitazione delle dipendenze transitive. Fonte: [GitHub Releases v2.1.143](https://github.com/anthropics/claude-code/releases/tag/v2.1.143). Doc: [docs/11-plugins-marketplace.md](./docs/11-plugins-marketplace.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`worktree.bgIsolation: "none"`** (v2.1.143, 15 mag): nuova opzione settings che permette alle sessioni background di editare la working copy direttamente senza `EnterWorktree` — per repository dove i worktree git non sono pratici (monorepo con submodule, toolchain non compatibili). Fonte: [GitHub Releases v2.1.143](https://github.com/anthropics/claude-code/releases/tag/v2.1.143). Doc: [docs/18-settings-auth.md](./docs/18-settings-auth.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-15

- **Fast Mode usa Opus 4.7 di default** (v2.1.142, 14 mag): Fast mode aggiorna il modello base da Opus 4.6 a Opus 4.7; chi vuole tornare a 4.6 usa `CLAUDE_CODE_OPUS_4_6_FAST_MODE_OVERRIDE=1`. Fonte: [GitHub Releases v2.1.142](https://github.com/anthropics/claude-code/releases/tag/v2.1.142). Doc: [docs/05-fast-mode-1m-context.md](./docs/05-fast-mode-1m-context.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Plugin SKILL.md root come skill** (v2.1.142, 14 mag): plugin con `SKILL.md` nella directory root vengono esposti automaticamente come skill, senza richiedere la struttura `skills/<name>/SKILL.md` — semplifica i plugin mono-skill. Fonte: [GitHub Releases v2.1.142](https://github.com/anthropics/claude-code/releases/tag/v2.1.142). Doc: [docs/09-skills.md](./docs/09-skills.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-14

- **Rewind "Summarize up to here"** (v2.1.141, 13 mag): il menu Rewind introduce l'opzione "Summarize up to here" che comprime il contesto accumulato mantenendo intatti i turni piu' recenti — utile per sessioni lunghe dove si vuole liberare context senza perdere il filo attivo. Fonte: [GitHub Releases v2.1.141](https://github.com/anthropics/claude-code/releases/tag/v2.1.141). Doc: [docs/00b-context-engineering.md](./docs/00b-context-engineering.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Crediti mensili dedicati per uso programmatico** (annuncio 13 mag, attivo dal 15 giu): i piani paid Claude ottengono un credito mensile dedicato per uso programmatico — copre `claude -p`, Claude Agent SDK, Claude Code GitHub Actions e app terze parti basate sull'Agent SDK. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2054610152817619388). Doc: [docs/16-headless-agent-sdk.md](./docs/16-headless-agent-sdk.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-13

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-12

- **Agent View** (`claude agents`, research preview, v2.1.139): lista unificata di tutte le sessioni Claude Code — in esecuzione, in attesa di input o completate — navigabile con un unico comando CLI. Fonte: [@trq212](https://x.com/trq212/status/2053979505346425179), [ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2053913638197416198). Doc: [docs/08-subagents.md](./docs/08-subagents.md), [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`/goal`** (v2.1.139): nuovo slash command che imposta una condizione di completamento; Claude esegue task su piu' turni fino al raggiungimento, con overlay live di tempo/turni/token. Funziona in modalita' interattiva, `-p` e Remote Control. Fonte: [ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2053913638197416198). Doc: [docs/03-slash-commands.md](./docs/03-slash-commands.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **Hook exec form + `continueOnBlock`** (v2.1.139): `args: string[]` esegue il comando hook direttamente senza shell (previene injection); `continueOnBlock` su PostToolUse permette al turno di proseguire anche dopo un rifiuto hook. Fonte: [GitHub Releases v2.1.139](https://github.com/anthropics/claude-code/releases). Doc: [docs/07-hooks.md](./docs/07-hooks.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-11

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-10

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-09

- **Plugin da `.zip` e URL** (v2.1.128–129): `--plugin-dir` accetta ora archivi `.zip` locali oltre alle directory; il nuovo flag `--plugin-url` scarica un plugin da URL per la sessione corrente — utile per testare plugin prima di pubblicarli su marketplace o distribuire plugin interni da uno store di artefatti. Fonte: [code.claude.com — Week 19](https://code.claude.com/docs/en/whats-new/2026-w19). Doc: [docs/11-plugins-marketplace.md](./docs/11-plugins-marketplace.md), [docs/19-changelog.md](./docs/19-changelog.md).
- **`autoMode.hard_deny`** (v2.1.134–136): nuova chiave `settings.autoMode.hard_deny` blocca azioni in auto mode in modo assoluto, indipendentemente da eccezioni "allow" configurate — per azioni che non devono mai essere eseguite automaticamente anche quando allow rules piu' ampie lo permetterebbero. Fonte: [code.claude.com — Week 19](https://code.claude.com/docs/en/whats-new/2026-w19). Doc: [docs/04-modalita-permessi.md](./docs/04-modalita-permessi.md), [docs/19-changelog.md](./docs/19-changelog.md).

---

## 2026-05-08

- **Hook input: `effort.level` + `$CLAUDE_EFFORT`** (v2.1.133): gli hook ricevono il livello di effort corrente nel JSON stdin (`effort.level`) e come variabile d'ambiente `$CLAUDE_EFFORT` — abilita logica condizionale nei hook in base all'effort (es. linting leggero a `low`, security scan completo a `xhigh`). Fonte: [GitHub Releases v2.1.133](https://github.com/anthropics/claude-code/releases). Doc: [07 Hooks](../docs/07-hooks.md), [19 Changelog](../docs/19-changelog.md).
- **`worktree.baseRef`** (v2.1.133): nuova opzione settings (`"fresh"` | `"head"`) controlla se i worktree generati dall'harness si diramano da `origin/<default>` (clean) o da `HEAD` locale. Fonte: [GitHub Releases v2.1.133](https://github.com/anthropics/claude-code/releases). Doc: [18 Settings & Auth](../docs/18-settings-auth.md), [19 Changelog](../docs/19-changelog.md).

---

## 2026-05-07

- **Limiti Claude Code raddoppiati** (annuncio 6 mag 2026, "Code with Claude" SF): Anthropic raddoppia i limiti di utilizzo a 5 ore per Pro, Max, Team e seat-based Enterprise; elimina i peak-hour limits per Pro e Max. L'accordo con SpaceX (Colossus 1, 300 MW+, 220K+ GPU NVIDIA) rende la capacita' aggiuntiva disponibile entro il mese. Fonte: [Anthropic blog](https://www.anthropic.com/news/higher-limits-spacex). Doc: [01-snapshot.md](./01-snapshot.md), [19-changelog.md](./19-changelog.md).

---

## 2026-05-06

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-05

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-04

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-03

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-02

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-05-01

- **`claude project purge`** (v2.1.126): nuovo subcomando elimina tutto lo stato di Claude Code per un progetto (trascrizioni, task, file history, config). Opzioni: `--dry-run`, `-i/--interactive`, `--all`. Fonte: [GitHub Releases](https://github.com/anthropics/claude-code/releases). Doc: [02 CLI](../docs/02-cli-installazione.md), [19 Changelog](../docs/19-changelog.md).
- **OAuth paste-in-terminal** (v2.1.126): `claude auth login` accetta ora il codice OAuth incollato in terminale quando il browser non raggiunge localhost — risolve login in ambienti WSL2, SSH, container. Fonte: [GitHub Releases](https://github.com/anthropics/claude-code/releases). Doc: [18 Settings & Auth](../docs/18-settings-auth.md), [19 Changelog](../docs/19-changelog.md).

---


## 2026-04-30

> Nessuna novita' significativa nelle ultime 24 ore.

---

## 2026-04-29

- **`${CLAUDE_EFFORT}` nelle skill** (v2.1.120): il contenuto delle skill puo' ora referenziare il livello di effort corrente tramite `${CLAUDE_EFFORT}` — abilita comportamenti adattativi (istruzioni diverse a `low` vs `xhigh`). Doc: [09 Skills](../docs/09-skills.md).
- **Windows: PowerShell senza Git Bash** (v2.1.120): Claude Code non richiede piu' Git Bash su Windows; quando assente, usa PowerShell come shell tool nativo. Doc: [02 CLI](../docs/02-cli-installazione.md).
- **`/resume` con PR URL** (v2.1.122): incollare un URL di PR (GitHub, GitHub Enterprise, GitLab, Bitbucket) in `/resume` trova automaticamente la sessione che ha creato quella PR. Doc: [03 Slash commands](../docs/03-slash-commands.md).

---

## 2026-04-28

- **PostToolUse output override universale** (v2.1.121): i PostToolUse hook possono ora sostituire l'output di qualsiasi tool tramite `hookSpecificOutput.updatedToolOutput`, non solo MCP — abilita trasformazioni inline prima che Claude legga il risultato. Doc: [07 Hooks](../docs/07-hooks.md).
- **MCP `alwaysLoad`** (v2.1.121): il campo `alwaysLoad: true` su un server MCP bypassa la tool-search deferral, rendendo tutti i tool del server sempre disponibili senza ricerca preventiva. Doc: [10 MCP](../docs/10-mcp.md).

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

← [README master](../README.md)
