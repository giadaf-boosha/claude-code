# 20 — Tips & best practices

> 📍 [README](../README.md) → [Riferimenti](../README.md#riferimenti) → **20 Tips & best practices**
> 📚 Riferimento · 🟡 Intermediate

Raccolta di pattern e tip operative dai post X del team Claude Code (Boris Cherny, Cat Wu, Noah Zweben, Thariq) e dalla community. Ogni tip cita la fonte.

## Cosa e' concettualmente

> I tips sono **harness pattern già validati** dal team che ha costruito Claude Code. Non sono opinioni: sono empiricismo da uso quotidiano (Boris ha aumentato output 200% interno, Anthropic ha generato 1M LOC con ~0 manual fix). Ogni tip mappa a uno o piu' componenti IMPACT.

**Modello mentale**: come "Effective Java" o "Clean Architecture" — cristallizzazione di pattern emersi nell'uso reale.

**Componente harness IMPACT**: trasversale (ogni tip e' un'ottimizzazione di uno o piu' componenti).

**Per il deep-dive**: [22 — Compound engineering](./22-compound-engineering.md) per come comporre i tips in pattern superiori.

---

## 20.1 Tips dal team Claude Code

### 1. Setup vanilla > customizzazione
> "My setup might be surprisingly vanilla! Claude Code works great out of the box, so I personally don't customize it much." — [@bcherny](https://x.com/bcherny/status/2007179832300581177)

Implica: prima di scrivere skill/hook custom, prova le feature built-in.

### 2. Full task context upfront
> "Give Claude Code your full task context upfront: goal, constraints, acceptance criteria in the first turn. This lets Claude Code do its best work." — [@_catwu](https://x.com/_catwu/status/2044808536790847693)

Pattern: nel primo prompt esplicita **goal + constraints + acceptance criteria + non-obiettivi**.

### 3. Hooks per routing permessi e nudge fine-turno
> "Set up hooks. Hooks are a way to deterministically hook into Claude's lifecycle. Use them to: Automatically route permission requests to Slack or Opus; Nudge Claude to keep going when it reaches the end of a turn..." — [@bcherny](https://x.com/bcherny/status/2021701059253874861)

Vedi [07 Hooks § esempi](./07-hooks.md#7.8-esempi-pratici).

### 4. Output style "Explanatory" o "Learning"
> "Enable the 'Explanatory' or 'Learning' output style in /config to have Claude explain the *why* behind its changes. Have Claude generate a visual HTML presentation explaining unfamiliar..." — [@bcherny](https://x.com/bcherny/status/2017742759218794768)

Tip: per imparare codice nuovo o stack sconosciuto, attiva l'output style "Explanatory".

### 5. Skill chaining
> "Yes, just ask claude to invoke skill 1, then skill 2, then skill 3, in natural language. Or ask it to use parallel subagents to invoke the skills in parallel." — [@bcherny](https://x.com/bcherny/status/2006170607092670691)

Pattern: chain in natural language, oppure subagent paralleli per indipendenti.

### 6. `/loop` + `/schedule` per maintenance
> "Two of the most powerful features in Claude Code: /loop and /schedule. Use these to schedule Claude to run automatically at a set interval, for up to a week at a time. I have a bunch of loops running locally: /loop 5m /babysit, to auto-address code review, auto-rebase, and..." — [@bcherny](https://x.com/bcherny/status/2038454341884154269)

### 7. Customizability fa la differenza
> "Reflecting on what engineers love about Claude Code, one thing that jumps out is its customizability: hooks, plugins, LSPs, MCPs, skills, effort, custom agents, status lines, output styles, etc. Every engineer uses their tools differently." — [@bcherny](https://x.com/bcherny/status/2021699851499798911)

### 8. Monitor tool + dev server
> "you'll need to explicitly prompt Claude Code to use it, but the Monitor Tool is super powerful. e.g. 'start my dev server and use the MonitorTool to observe for errors'" — [@trq212](https://x.com/trq212/status/2042335178388103559)

### 9. Plan mode prima di refactor grossi
> "New in Claude Code: Plan mode. Review implementation plans before making changes. Perfect for complex changes where you want to nail the approach before diving in." — [@_catwu](https://x.com/_catwu/status/1932857816131547453)

### 10. Opus per plan mode + Sonnet per execution
> "Claude Code has a new /model option: Opus for plan mode. This setting uses Claude Opus 4.1 for plan mode and Claude Sonnet 4 for all other work - getting the best of both models while maximizing your usage." — [@_catwu](https://x.com/_catwu/status/1955694117264261609)

---

## 20.2 Tips trasversali

### Ottimizzazione token / costo
- **`/compact` periodico** in sessioni lunghe: tieni il context sotto controllo
- **Subagent Explore** (Haiku) per ricerca: cheap e veloce
- **Tool restrittivi nei subagent**: solo quelli necessari
- **MCP tool search** per molti server: schemi caricati on-demand
- **Bare mode `--bare` in CI**: skip auto-discovery
- **1M context** quando serve, ma non sempre: paghi piu' input

### Controllo qualita'
- **`/ultrareview` pre-merge** per cambi sostanziali
- **`/security-review`** sulla diff prima di committare
- **Hooks PostToolUse** con linter/formatter automatici
- **`/fewer-permission-prompts`** per ridurre fatigue dopo qualche giorno

### Efficienza
- **Pattern "plan locally, execute remotely"**: CLI per pensiero, cloud per esecuzione
- **`/ultraplan` per design** + `/ultrareview` pre-merge + **Routines** per ricorrenze + **`/loop`** per check intra-sessione
- **Triggers GitHub > Schedule** (Pro plan): quota quotidiana solo sugli scheduled
- **Self-pacing `/loop`** (no interval): il modello decide quando ri-eseguire
- **Monitor tool > polling**: risparmia token e reagisce in tempo reale
- **Skill markdown-only > MCP custom** quando il task e' istruzionale

### Sicurezza
- **Sandbox sempre attiva**: macOS out of the box, Linux via bubblewrap
- **`--strict-mcp-config`** in CI per riproducibilita'
- **Boundary nel prompt** delle routine: `do not merge`, `do not modify > N files`, `dry run`
- **`/extra-usage` check** prima di lanciare ultrareview a pagamento
- **Read-only commands list custom** in plan/auto mode

### Affidabilita'
- **`/init` con `CLAUDE_CODE_NEW_INIT=1`** per CLAUDE.md ricco multi-fase
- **Auto-memory** lasciata accesa: Claude impara pattern progetto
- **Test con "Run now"** prima di mettere in schedule una routine
- **Idempotenza** del task in `/loop`
- **`tmux`/`screen`** per loop persistenti (la sessione muore col terminale)
- **`/compact` periodico** in sessioni `/loop` lunghe

### Output e formati
- **Output strutturato** in routine/loop: chiedi JSON per machine-readability
- **`--json-schema`** per structured outputs validati
- **`--output-format stream-json`** per pipeline real-time / dashboard

### Modelli
- **`/fast` per Opus 4.6** quando vuoi velocita' senza sacrificare qualita'
- **1M context su Max/Team/Enterprise e' automatico**: non serve flag
- **Auto mode > `--dangerously-skip-permissions`**: sicurezza con velocita' simile
- **Opus 4.7 + xhigh** per task di ragionamento complesso

---

## 20.3 Errori comuni da evitare

1. **Lasciar girare `/loop` senza idempotenza**: ogni iter rifara' tutto da capo
2. **`--dangerously-skip-permissions` come default**: usa auto mode
3. **CLAUDE.md gigante (1000+ righe)**: spezzalo con `@import`
4. **Auto-memory disabilitata**: perdi pattern progetto
5. **Skill troppo lunga (>5K token)**: budget cap, troncata in compaction
6. **MCP server non testato in CI**: usa `--strict-mcp-config`
7. **Hardcode API key in config**: usa `apiKeyHelper` o env
8. **Routine scheduled senza boundary**: blast radius alto
9. **Sandbox disabilitata in development senza motivo**: prompt fatigue
10. **Plan mode skippato per refactor cross-file**: bug a cascata

---

## 20.4 Pattern operativi (workflow)

### A. Feature nuova end-to-end

```
1. /plan describe feature + constraints + acceptance
2. (se complesso) /ultraplan → review browser
3. Implementa con auto mode o acceptEdits
4. /security-review sulla diff
5. /test (se hai skill custom) o /simplify per cleanup
6. /ultrareview pre-merge
7. PR
```

### B. Bug fix urgente

```
1. /plan: come riprodurlo + acceptance test
2. Implementa con default mode
3. Verifica manualmente
4. /review
5. Commit + push
```

### C. Refactor large-scale

```
1. /ultraplan → cloud
2. /batch <instruction> → 1 worktree+PR per modulo
3. /ultrareview su ognuno
4. Merge sequenziale
```

### D. Daily maintenance (Boris-style)

```
/loop 5m /babysit
```
Esegue maintenance prompt: review comments, auto-rebase, fixa CI failure.

### E. Triage da telefono (Remote Control)

```
1. CLI: /loop check CI on my PR
2. /remote-control name=triage
3. Apri claude.ai/code da telefono
4. Risposta dopo ogni iter, decidi mosse
5. Se serve fix in CLI, riprendi quando torni
```

---

## 20.6 Workflow operativi storici

Pattern consolidati dalla guida pre-feb 2026, ancora validi nel 2026 con i modelli attuali (Sonnet 4.7 / Opus 4.7). Sono workflow "end-to-end" che combinano i mattoni gia' visti (planning, worktree, sub-agent, hook) in flussi ripetibili.

### 20.6.1 Worktree end-to-end per feature parallele

Lo script `wt` automatizza la creazione di worktree dentro `.worktrees/` (gitignored) e l'avvio di Claude Code con permessi rilassati. Utile per portare in parallelo 3-5 feature/fix senza conflitti di file.

```bash
wt() {
    if [ -z "$1" ]; then
        echo "Uso: wt <branch> [base-branch]"
        return 1
    fi
    base_branch="${2:-main}"
    git_root=$(git rev-parse --show-toplevel) || return 1
    worktree_dir="$git_root/.worktrees"
    mkdir -p "$worktree_dir"
    grep -q "^\.worktrees$" "$git_root/.gitignore" 2>/dev/null \
      || echo ".worktrees" >> "$git_root/.gitignore"
    git worktree add "$worktree_dir/$1" "$base_branch" -b "$1"
    cd "$worktree_dir/$1"
}

cc() { claude --dangerously-skip-permissions; }

wtc() {
    git_root=$(git rev-parse --show-toplevel) || return 1
    git worktree prune
    rm -rf "$git_root/.worktrees"
    echo "Worktree puliti."
}
```

Flusso tipico:
1. `wt feature-infinite-scroll` per ogni feature
2. `cc` dentro ogni worktree (sandbox sicura: container, devcontainer o `--dangerously-skip-permissions` solo se isolato)
3. Lavoro parallelo su 3-5 feature; ogni Claude ha contesto e file system isolati
4. Merge / PR a feature completata
5. `wtc` per cleanup massivo a fine giornata

> Nota 2026: dalla v2.1.38+ esiste `claude --worktree` nativo (vedi [docs/19 § Fase 4](./19-changelog.md)). Lo script bash resta utile per setup massivo o pre-2.1.

### 20.6.2 "Friday refactor" — refactoring controllato a fine settimana

Pattern usato dal team Kora per pulire debito tecnico accumulato durante la settimana, senza bloccare le feature in corso.

```text
> trova l'utilizzo di API deprecate nella codebase
> suggerisci come fare refactoring di utils.js usando ES2024
> applica i cambiamenti mantenendo lo stesso comportamento
> esegui i test e correggi eventuali errori
```

Caratteristiche:
- Eseguito il venerdi' su un worktree dedicato (`wt friday-refactor`)
- Modello: Opus 4.7 in plan mode (Shift+Tab) per il piano, Sonnet 4.7 per esecuzione
- Checkpoint umano dopo il piano, prima dell'esecuzione (vedi [22 § R4](./22-compound-engineering.md))
- Output: PR singola con descrizione auto-generata (`/review` + `gh pr create`)

### 20.6.3 Bug investigation con timeline diff

Workflow per bug "comparsi N giorni fa" senza repro chiaro. Esempio storico Kora: form di feedback morto da 14 giorni.

```text
> 14 giorni fa qualcosa si e' rotto nel form feedback. Guarda il git log,
  cerca i cambiamenti nei controller rilevanti, e dimmi cosa e' successo.
```

Sequenza che Claude esegue autonomamente:
1. `git log --since="14 days ago"` sui path candidati
2. Grep nel codebase per simboli rilevanti (`feedback`, `submit`, controller)
3. Diff dei file modificati nel range temporale
4. Diagnosi causa-radice ("rimossa la riga che chiama `addUser`")
5. Fix + script di migrazione per recuperare i dati persi nel periodo (`/fix-issue` o PR diretta)

Il valore: zero context-switch per lo sviluppatore. L'investigazione che richiederebbe 30-60 min di `git blame` manuale viene chiusa in 2-3 minuti.

### 20.6.4 Claude come utility Unix (pipe-based)

Non interattivo, headless, idoneo a pre-commit hook e CI:

```bash
# Lint custom in package.json
"scripts": {
  "lint:claude": "claude -p 'sei un linter, segnala typo nei file modificati vs main'"
}

# Diagnosi build error
cat build-error.txt | claude -p 'spiega la causa principale' > diagnosis.txt

# Output JSON per pipeline
cat code.py | claude -p 'analizza per bug' --output-format json > analysis.json
```

Vedi anche [docs/16 § Headless mode](./16-headless-agent-sdk.md) per esempi piu' avanzati con `--output-format stream-json`.

### 20.6.5 Sub-agent chaining per pipeline qualita'

```text
> usa code-analyzer per trovare problemi di performance,
  poi passa l'output a optimizer per applicare i fix,
  infine usa code-reviewer per validare prima del commit
```

Tre sub-agent (vedi [docs/08](./08-subagents.md)) lavorano in serie con contesti isolati. Il main thread vede solo i riassunti, non i contesti pieni — risparmio token significativo su task lunghi.

---

## 20.7 Tip aggiuntive — operativita' quotidiana

Estratte dalla cheat sheet community [bhancockio/claude-code-cheat-sheet](https://github.com/bhancockio/claude-code-cheat-sheet), tradotte e adattate.

- **Hook "Stop" sonoro** per task lunghi: notifica audio quando Claude finisce. macOS:
  ```json
  { "hooks": { "Stop": [{ "hooks": [{ "type": "command",
    "command": "afplay /System/Library/Sounds/Pop.aiff" }] }] } }
  ```
  Windows: `powershell -c (New-Object Media.SoundPlayer 'C:\\Windows\\Media\\Windows Ding.wav').PlaySync()`. Linux: `paplay /usr/share/sounds/freedesktop/stereo/complete.oga`.
- **Hook PostToolUse "Lint after Edit"**: linter automatico solo sui file modificati.
  ```json
  { "hooks": { "PostToolUse": [{ "matcher": "Edit",
    "hooks": [{ "type": "command", "command": "npm run lint" }] }] } }
  ```
- **Hook PreToolUse "Bash validator"**: blocca comandi pericolosi (es. `rm -rf`, `curl | sh`) prima dell'esecuzione passando un validator Python che ritorna exit code 2. Pattern simmetrico al "file protection hook" di [docs/07](./07-hooks.md).
- **Drag & drop screenshot**: tieni premuto **Shift** mentre trascini un'immagine nel terminale — Claude Code la riconosce e la include nella conversazione (iTerm2, Warp, Terminal.app moderni).
- **`Esc Esc` (doppio tap)**: revert dell'ultima azione di Claude (alternativa rapida a `/rewind`, dalla v2.0+).
- **`Ctrl+T`**: apre il pannello Tasks/todos correnti senza interrompere il flusso.
- **`Ctrl+O`**: apre il pannello Thinking per vedere il ragionamento extended thinking in tempo reale.
- **Vim mode avanzato**: oltre a `i/a/o`, supportati `dw/de/db/dd/D` (delete), `cw/ce/cb/cc/C` (change), `.` (ripeti ultima azione). Attivazione globale: `claude config set -g vimMode true`. Visual mode `v`/`V` da v2.1.118.
- **Output style "Explanatory"** combinato con `Ctrl+O`: vedi sia il "perche'" stilistico sia il thinking grezzo — ottimo per onboarding su codebase nuove.
- **Custom keybindings VS Code/Cursor** per terminale: `Cmd+Shift+C` apre nuovo terminale come tab editor, `Cmd+Shift+R` rinomina, `Cmd+Shift+[ / ]` naviga tra terminali. Config in `keybindings.json`.

---

## 20.5 Risorse esterne

- Tips & tricks ufficiale: https://code.claude.com/docs/en/tips-and-tricks
- Awesome Claude Code: https://github.com/hesreallyhim/awesome-claude-code
- Plugin marketplace community: https://claudemarketplaces.com
- Awesome MCP servers: https://github.com/punkpeye/awesome-mcp-servers
- Boris's full thread tips: [@bcherny](https://x.com/bcherny/status/2017742741636321619)

---

← [19 Changelog](./19-changelog.md) · Torna al [README](../README.md)
