# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

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
