# 19 — Changelog completo Claude Code (feb 2025 → apr 2026)

> 📍 [README](../README.md) → [Riferimenti](../README.md#riferimenti) → **19 Changelog**
> 📚 Riferimento · 🟢 Beginner-friendly

Cronologia completa di Claude Code dalla research preview (24 febbraio 2025, v0.2.0) all'ultima versione (23 giugno 2026, v2.1.187). 7 fasi storiche + tabella versione per versione + post-mortem aprile 2026.

## Cosa e' concettualmente

> Il changelog non e' solo elenco di feature: e' la **traiettoria evolutiva dell'harness**. Si vede come Claude Code sia partito come CLI agentic (research preview), abbia aggiunto Plan mode (Planning), poi Hooks (Authority), poi Sub-agents (Orchestration), poi Skills (Memory eseguibile), poi Routines (Control flow cloud). Ogni release amplifica un componente IMPACT.

**Modello mentale**: come la storia di Linux — ogni patch aggiunge un pezzo del sistema operativo. Qui ogni release aggiunge un pezzo dell'agent harness.

**Componente harness IMPACT**: traccia evolutiva di tutti i pilastri.

**Per il deep-dive**: [00 — Harness overview](./00-harness-overview.md) per leggere il changelog in chiave IMPACT.

> Fonti master: [GitHub CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md), [`/en/changelog`](https://code.claude.com/docs/en/changelog), [`/en/whats-new`](https://code.claude.com/docs/en/whats-new), [Anthropic news](https://www.anthropic.com/news), [Help Center release notes](https://support.claude.com/en/articles/12138966-release-notes), [GitHub Releases](https://github.com/anthropics/claude-code/releases).

---

## 19.1 Fase 1 — Research preview (feb 2025 → mag 2025)

**Timeline**: 24 feb 2025 (v0.2.0) → 21 mag 2025 (v0.2.125, ultima preview).

### Versioni rilasciate (selezione, ~125 patch nella serie 0.2.x)

| Data | Versione | Highlight |
|---|---|---|
| 24 feb 2025 | v0.2.0 | **Lancio research preview**. CLI agentic con file editing, codebase scan, esecuzione bash. Annunciato col blog "Introducing Claude 3.7 Sonnet". |
| 8 mar 2025 | v0.2.34 | Vim mode, custom slash commands |
| 14 mar 2025 | v0.2.44 | Deep Reasoning / extended thinking mode |
| 15 mar 2025 | v0.2.47 | Auto-compaction conversazioni |
| 25 mar 2025 | v0.2.54 | Memory persistente con prefisso `#`, MCP SSE |
| 20 apr 2025 | v0.2.75 | Concurrent queries, drag-drop immagini, @-mentions |
| 25 apr 2025 | v0.2.82 | `--disallowedTools`, tool rinominati |
| 1 mag 2025 | v0.2.93 | Sessioni: `--continue` e `--resume` |
| 14 mag 2025 | v0.2.102 | Thinking mode migliorato |
| 16 mag 2025 | v0.2.105 | Web search via fetch tool, comando `/status` |
| 18 mag 2025 | v0.2.108 | Real-Time Steering durante thinking |
| 20 mag 2025 | v0.2.117 | JSON output annidato; rinomina `DEBUG=true` → `ANTHROPIC_LOG` |
| 21 mag 2025 | v0.2.125 | Bedrock ARN format. Ultima patch preview |

### Feature flagship della fase
- **Agentic CLI in terminale**: lettura/scrittura file, ricerca codice, esecuzione bash, git commit/push
- **Memory `#` prefix** + `CLAUDE.md` per istruzioni persistenti progetto
- **MCP SSE + thinking mode**: prima integrazione MCP e ragionamento esteso
- **Auto-compaction**: conversazioni "infinite" senza esaurire context

### Link
- Annuncio launch: https://www.anthropic.com/news/claude-3-7-sonnet
- Anniversario primo anno: [@swyx](https://x.com/swyx/status/2026462001933988094) — "Feb 24 2025 was the launch"

---

## 19.2 Fase 2 — GA + sub-agents (giu 2025 → ago 2025)

**Timeline**: 22 mag 2025 (v1.0.0 GA) → fine ago 2025 (v1.0.70+).

### Versioni rilasciate (selezione)

| Data | Versione | Highlight |
|---|---|---|
| 22 mag 2025 | **v1.0.0** | **GA release** — graduated from preview. Disponibile con piani Pro/Max |
| 4 giu 2025 | v1.0.10 | Markdown table rendering |
| 9 giu 2025 | v1.0.17 | `--add-dir` per multi-directory |
| 11 giu 2025 | v1.0.23 | Pacchetto npm ufficiale `@anthropic-ai/claude-code` |
| 11 giu 2025 | — | **Lancio Plan mode** (annuncio Cat Wu su X) |
| 18 giu 2025 | v1.0.27 | SSE Support + OAuth 2.0 per MCP |
| 25 giu 2025 | v1.0.24 | `/mcp` formatting |
| 30 giu 2025 | v1.0.38 | **Sistema Hooks** introdotto |
| 3 lug 2025 | v1.0.44 | `/export` transcript |
| 7 lug 2025 | v1.0.48 | `PreCompact` hook |
| 8 lug 2025 | v1.0.51 | **Native Windows** (no WSL), Bedrock support |
| 16 lug 2025 | v1.0.54 | `UserPromptSubmit` hook, OAuth Windows |
| 18 lug 2025 | v1.0.56 | Shift+Tab mode switching su Windows |
| 20 lug 2025 | v1.0.58 | Lettura PDF |
| 23 lug 2025 | v1.0.60 | **Sub-agents**: "create custom subagents for specialized tasks" |
| 26 lug 2025 | v1.0.62 | @-mention agenti custom |
| 30 lug 2025 | v1.0.64 | Modello custom per agente |
| 4 ago 2025 | v1.0.68 | Upgrade Opus 4.1 |
| 6 ago 2025 | v1.0.70 | @-mentions in slash commands |
| ago 2025 | — | `/model` Opus per Plan mode (Opus 4.1 plan, Sonnet 4 lavoro) |

### Feature flagship della fase
- **Plan mode** (giu 2025): review del piano prima di eseguire — [@_catwu](https://x.com/_catwu/status/1932857816131547453), GA: [@_catwu](https://x.com/_catwu/status/1932857819151413734)
- **Hooks system** (lug 2025): `PreToolUse`, `PostToolUse`, `UserPromptSubmit`, `PreCompact`
- **Sub-agents** (23 lug 2025, v1.0.60): agenti specializzati con frontmatter, tool/model custom
- **Native Windows + Bedrock**: deployment enterprise
- **`/model` Opus per plan**: [@_catwu](https://x.com/_catwu/status/1955694117264261609)

### Link
- npm package: https://www.npmjs.com/package/@anthropic-ai/claude-code
- Plan mode deep dive: https://lucumr.pocoo.org/2025/12/17/what-is-plan-mode/

---

## 19.3 Fase 3 — Claude Code 2.0 (set 2025 → nov 2025)

**Timeline**: 29 set 2025 (Sonnet 4.5 + Code 2.0) → 14 nov 2025 (Opus 4.5 + Desktop App, v2.0.51).

### Versioni rilasciate (selezione)

| Data | Versione | Highlight |
|---|---|---|
| 29 set 2025 | **v2.0.0** | **Claude Code 2.0 + Sonnet 4.5**. Checkpoints, VS Code extension nativa, parallel agents, hook expansion |
| ott 2025 | v2.0.x | **Claude Code on the Web** launch (claude.ai/code) |
| nov 2025 | v2.0.4x | **Code Review beta** (Team/Enterprise) |
| 14 nov 2025 | **v2.0.51** | **Opus 4.5 lancio + Claude Desktop App** |
| 20 nov 2025 | v2.0.55 | DNS proxy fix, fuzzy matching |
| 22 nov 2025 | v2.0.56 | Terminal progress bar, secondary VS Code sidebar |
| 24 nov 2025 | v2.0.57 | Plan Feedback, VS Code streaming |
| 26 nov 2025 | v2.0.58 | Pro users access Opus 4.5 |
| 28 nov 2025 | v2.0.59 | `--agent` flag e `agent` setting |

### Feature flagship della fase
- **Checkpoints + rewind** (Esc Esc o `/rewind`): salva stato pre-modifica
- **VS Code extension** GA: sidebar nativa con inline diff, sync real-time. Annuncio @claudeai (RT [@_catwu](https://x.com/claudeai/status/2013704053226717347))
- **Parallel agents + Subagent maturation**
- **Claude Code on the Web** (ott 2025) — [@_catwu](https://x.com/_catwu/status/1980338889958257106)
- **Code Review beta** (nov 2025): team di agenti scansiona PR per bug — [@claudeai](https://x.com/claudeai/status/1998109172634902629)
- **Desktop App** (14 nov 2025): app nativa macOS/Windows

### Storico — Annuncio Claude Code 2.0 + Sonnet 4.5 (29 set 2025)

> Anthropic annuncia Sonnet 4.5 come "the best coding model in the world", con guadagni sostanziali su reasoning e math. Drop-in replacement per Sonnet 4 allo stesso prezzo (cit. Alex Albert).

**Benchmark riportati al lancio** (selezione):

| Benchmark | Sonnet 4.5 | Opus 4.1 | Sonnet 4 | GPT-5 |
|---|---|---|---|---|
| Agentic coding (self-hosted) | 82.0% | 79.4% | 77.2% | 72.8% |
| Agentic reasoning (coding) | 80.2% | 46.5% | 34.4% | 43.8% |
| Computer use (OSWorld) | 96.0% | 71.5% | 49.6% | 96.7% |
| High school math (competition) | 100% | 78.0% | 70.5% | 99.6% |
| Financial analysis (Finance Agent) | 55.3% | 50.9% | 44.6% | 40.9% |

**Novita' lanciate insieme a CC 2.0**:
- **`/rewind`**: rollback instantaneo dei cambi codice — citazione Ian Nuttall ("Model messes up? No biggie, just rewind it back")
- **Checkpoints**: snapshot automatico pre-edit
- **VS Code extension nativa**: sidebar con inline diff
- **Context editing** + 1M context API (Cognition/Devin team consigliava di capparlo a 200K per evitare "anxiety-driven shortcuts")
- **Parallel agents + subagent maturation**

> Nota: Sonnet 4.5 e Opus 4.1 sono superati da Sonnet 4.6 / Opus 4.6 / Opus 4.7 (apr 2026). I benchmark sopra sono storici al 29 set 2025. Per i modelli correnti vedi [05 — Fast mode + 1M context](./05-fast-mode-1m-context.md).

### Link
- Sonnet 4.5: https://www.anthropic.com/news/claude-sonnet-4-5
- "Enabling Claude Code to work more autonomously": https://www.anthropic.com/news/enabling-claude-code-to-work-more-autonomously
- Opus 4.5: https://www.anthropic.com/news/claude-opus-4-5
- Code 2.0 deep dive: https://smartscope.blog/en/generative-ai/claude/claude-code-2-0-release/

---

## 19.4 Fase 4 — 2.1 + Cowork + Web (dic 2025 → gen 2026)

**Timeline**: 3 dic 2025 (background agents, v2.0.60) → fine gen 2026 (v2.1.30+).

### Versioni rilasciate (selezione)

| Data | Versione | Highlight |
|---|---|---|
| 3 dic 2025 | v2.0.60 | **Background agents**, `/mcp enable` toggle |
| 5 dic 2025 | v2.0.62 | `attribution` setting per commit |
| 7 dic 2025 | v2.0.64 | Auto-compacting istantaneo, `/stats` |
| 9 dic 2025 | v2.0.65 | Quick model switch `alt+p`, `CLAUDE_CODE_SHELL` |
| 11 dic 2025 | v2.0.67 | Prompt suggestions, thinking di default |
| dic 2025 | **v2.1.0** | **Claude Code 2.1** (annuncio Boris Cherny). **Cowork** in Claude Desktop. **Claude Code for Slack** |
| gen 2026 | v2.1.17 | Session forking |
| 19 gen 2026 | v2.1.19 | **Skills** (`SKILL.md` in `.claude/skills/`) |
| 25 gen 2026 | v2.1.25 | Arrow-key history, sandbox improvements |
| 26 gen 2026 | v2.1.29 | TeammateTool feature-flagged scoperto in binary |

### Feature flagship della fase
- **Cowork** (dic 2025): Claude Code agentico nella Claude Desktop app, runs in VM isolata, accesso file locali e MCP — [@claudeai](https://x.com/claudeai/status/2010805682434666759)
- **Background agents + named sessions**: agenti che girano off-thread
- **Claude Code for Slack**: tag `@claude-code` in qualsiasi thread
- **Skills system** (gen 2026, v2.1.19): `.claude/skills/*/SKILL.md` per conoscenza domain-specific
- **Session forking + .claude/rules/**

### Link
- Boris Cherny annuncio 2.1: [@bcherny](https://x.com/bcherny/status/2009072293826453669)
- Cowork roadmap CC: [@swyx](https://x.com/swyx/status/2016258918297829719) — "CC started as humble CLI side project; today forms basis for Claude Cowork"
- Q1 2026 roundup: https://www.mindstudio.ai/blog/claude-code-q1-2026-update-roundup

---

## 19.5 Fase 5 — Opus 4.6 + Fast mode + Security (feb 2026)

**Timeline**: 5 feb 2026 (v2.1.32, Opus 4.6) → 28 feb 2026 (v2.1.37+).

### Versioni rilasciate

| Data | Versione | Highlight |
|---|---|---|
| 5 feb 2026 | v2.1.32 | **Claude Opus 4.6 + Agent Teams preview** (sperimentale, dietro flag `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`) |
| 7 feb 2026 | v2.1.36 | **Fast mode** Opus 4.6 (1M context) |
| feb 2026 | — | **Claude Code Security** annunciato |
| feb 2026 | v2.1.37 | Hardening pre-versioni 2.1.4x |
| 19 feb 2026 | v2.1.39 | 5 CLI + 1 prompt change ([ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2021362954864648607)) |
| feb 2026 | — | **Sonnet 4.6** in CC + free tier upgraded a Sonnet 4.6 — [@claudeai](https://x.com/claudeai/status/2023817132581208353), [@claudeai](https://x.com/claudeai/status/2023817147303292948) |
| feb 2026 | — | **Built-in git worktree support** (`claude --worktree`) — [@bcherny](https://x.com/bcherny/status/2025007393290272904) |

### Feature flagship della fase
- **Opus 4.6**: salto qualita' coding/reasoning — annuncio: https://www.anthropic.com/news/claude-opus-4-6
- **Agent Teams** (sperimentale): team lead + teammate agents indipendenti, mailbox peer-to-peer, shared task list — [@bcherny](https://x.com/bcherny/status/2019472394696683904)
- **Fast mode** Opus 4.6 (2.5x latenza ridotta) — [@claudeai](https://x.com/claudeai/status/2020207322124132504), [@bcherny](https://x.com/bcherny/status/2020223254297031110)
- **Claude Code Security**: scansione vulnerabilita' integrata — [@claudeai](https://x.com/claudeai/status/2024907535145468326)
- **Sonnet 4.6 1M context** in beta
- **Async hooks** (`async: true`) — [@bcherny](https://x.com/bcherny/status/2015524460481388760)
- **Built-in worktree CLI** + subagent worktree per migrazioni cross-modulo
- **Hackathon Opus 4.6 ($100K)** — [@claudeai](https://x.com/claudeai/status/2019833113418035237)

### Link
- Opus 4.6: https://www.anthropic.com/news/claude-opus-4-6
- Q1 2026 guide: https://aimaker.substack.com/p/anthropic-claude-updates-q1-2026-guide

---

## 19.6 Fase 6 — Remote + Code Review GA + Routines precursor (mar 2026, fino al 22)

**Timeline**: 1 mar 2026 (v2.1.38) → 22 mar 2026 (v2.1.82).

### Versioni rilasciate

| Data | Versione | Highlight |
|---|---|---|
| 1–2 mar 2026 | v2.1.38–40 | Git worktrees, MCP enhancements |
| 3–4 mar 2026 | v2.1.41–43 | Plugin tools `PluginCall`, agent access rules |
| 5 mar 2026 | v2.1.44 | Ultra-thinking mode (`ultratlk`), `/sandbox` |
| 6–7 mar 2026 | v2.1.45–46 | Tool `SendMessage`, `/mcp` upgrade |
| 8–9 mar 2026 | v2.1.47–48 | Quick-fix commands, `PreCompact` hook |
| 10–11 mar 2026 | v2.1.49–50 | Task management tools, deferred loading |
| 17 mar 2026 | v2.1.76 | MCP elicitation, comando `/effort` |
| 18 mar 2026 | v2.1.77 | Output 64K token, `/copy N` |
| 19 mar 2026 | v2.1.78 | PowerShell tool preview, `StopFailure` hook |
| 20 mar 2026 | v2.1.79 | **VS Code Remote Control** + memory tightening (system prompt) — [ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2034402575634612594) |
| 21 mar 2026 | v2.1.80 | Rate limits in statusline, `--channels`. Memory tightening 2 — [ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2034759402796818648) |
| 22 mar 2026 | v2.1.81–82 | `--bare` flag, channel servers |

### Feature flagship della fase
- **Remote Control GA-track**: connetti sessione locale da claude.ai/code, app iOS, app Android — [@noahzweben](https://x.com/noahzweben/status/2026371260805271615), [@_catwu](https://x.com/_catwu/status/2026421789476401182). Pro rollout: [@noahzweben](https://x.com/i/status/2027460961884639663)
- **Code Review GA** (research preview Team/Enterprise): https://claude.com/blog/code-review — [@bcherny](https://x.com/bcherny/status/2031089411820228645), [@claudeai](https://x.com/claudeai/status/2031088171262554195)
- **Computer use Desktop**: Claude apre app, click UI — [@claudeai](https://x.com/claudeai/status/2036195789601374705)
- **Computer use Windows** — [@claudeai](https://x.com/claudeai/status/2039836891508261106)
- **Cowork scheduled tasks** — [@claudeai](https://x.com/claudeai/status/2026720870631354429)
- **Cowork Projects** — [@claudeai](https://x.com/claudeai/status/2035025492617961704)
- **Routines precursor**: cron-like scheduling primi prototipi — [@noahzweben](https://x.com/noahzweben/status/2035122989533163971)
- **Cloud Auto-Fix PR** — [@noahzweben](https://x.com/noahzweben/status/2037219115002405076)
- **PowerShell native tool** (Windows preview)
- **`/btw` side-chain** — [@trq212](https://x.com/trq212/status/2031506296697131352)
- **`/simplify` e `/batch`** — [@bcherny](https://x.com/bcherny/status/2027534984534544489)
- **Ultra-thinking** + `/effort` + 64K output tokens
- **Hidden features thread** — [@bcherny](https://x.com/bcherny/status/2038454336355999749)
- **Code with Claude conf** SF/London/Tokyo — [@claudeai](https://x.com/claudeai/status/2034308517964956051)

### Link
- Code Review blog: https://claude.com/blog/code-review
- Remote Control: https://claudefa.st/blog/guide/development/remote-control-guide
- Routines precursor coverage: https://venturebeat.com/orchestration/anthropic-just-released-a-mobile-version-of-claude-code-called-remote
- Builder.io March recap: https://www.builder.io/blog/claude-code-updates

---

## 19.7 Fase 7 — Auto mode + Ultraplan/Ultrareview + Routines GA (24 mar → apr 2026)

**Timeline**: 24 mar 2026 (v2.1.83) → 23 apr 2026 (v2.1.119+).

### Week 13 (March 23–27, 2026, v2.1.83–v2.1.85)

**Lancio Auto mode** (research preview): classifier model gestisce permission prompts; safe actions auto, risky bloccate.

- Computer use in Desktop app
- PR auto-fix on Web
- Transcript search con `/`
- Native PowerShell tool per Windows
- Conditional `if` hooks

> https://code.claude.com/docs/en/whats-new/2026-w13

### Week 14 (March 30 – April 3, 2026, v2.1.86–v2.1.91)

**Lancio Computer use in CLI** (research preview).
**Lancio `/ultrareview`** (v2.1.86).

- `/powerup` interactive lessons
- Flicker-free alt-screen rendering
- Per-tool MCP result-size override fino 500K
- Plugin executables in Bash $PATH
- `/pr-comments` rimosso (v2.1.91)

> https://code.claude.com/docs/en/whats-new/2026-w14

### Week 15 (April 6–10, 2026, v2.1.92–v2.1.101)

**Lancio Ultraplan** (early preview, v2.1.91+).

- `/loop` self-paces senza interval
- **Monitor tool** stream background events (v2.1.98) — [@noahzweben](https://x.com/noahzweben/status/2042332268450963774), [@alistaiir](https://x.com/alistaiir/status/2042345049980362819)
- `/team-onboarding` packages setup as replayable guide
- `/autofix-pr` PR auto-fix dal terminale
- Auto-creazione cloud env per ultraplan first run (v2.1.101)
- `/vim` rimosso (v2.1.92), Vim mode via `/config`
- POSIX `which` fallback security fix

> https://code.claude.com/docs/en/whats-new/2026-w15

### Week 16 (April 13–17, 2026, v2.1.102–v2.1.110)

**Lancio Routines** GA in research preview (14 apr 2026) — [@claudeai](https://x.com/claudeai/status/2044095086460309790), [blog](https://claude.com/blog/introducing-routines-in-claude-code).

- Desktop redesign multi-session — [@claudeai](https://x.com/claudeai/status/2044131493966909862)
- `/ultrareview + auto mode esteso a Max` — [@claudeai](https://x.com/claudeai/status/2044785266590622185)
- `EnterWorktree` `path` param
- **`PreCompact` hook** support (v2.1.106)
- **Plugin background monitor support** (`monitors` manifest)
- `/proactive` alias `/loop`
- **Skill description 250 → 1,536 chars cap**
- `WebFetch` strip CSS-heavy pages
- Token counts ≥1M display "1.5m"
- `/tui` fullscreen flicker-free (v2.1.110)
- **Push notification tool Remote Control**
- SDK `TRACEPARENT`/`TRACESTATE` distributed trace

### Week 16+ (April 16–23, 2026, v2.1.111–v2.1.119)

**Opus 4.7 + xhigh effort** (v2.1.111, 16 apr 2026) — [@bcherny](https://x.com/bcherny/status/2044802532388774313), [@bcherny](https://x.com/bcherny/status/2044847856872546639).
**`/ultrareview` general availability** (v2.1.111).

- Effort level `xhigh` (tra `high` e `max`)
- `/effort` interactive slider
- Auto mode disponibile su Opus 4.7 per Max
- `/fewer-permission-prompts` skill
- **`/resume` 67% piu' veloce** (v2.1.116, 40MB+ sessions)
- **Fix issue post-mortem qualita'** (v2.1.116, vedi 19.8)
- `sandbox.network.deniedDomains` (v2.1.113)
- **CLI spawna native binary** (v2.1.113)
- `/loop` Esc cancel pending wakeups (v2.1.113)
- **Plugin dependencies auto-install** (v2.1.117)
- Forked subagents su external builds (v2.1.117)
- **Default effort `high` per Pro/Max** su Opus 4.6 + Sonnet 4.6 (v2.1.117)
- **Vim visual mode** (`v`) + visual-line (`V`) (v2.1.118)
- `/usage` unifica `/cost` + `/stats` (v2.1.118)
- **Custom themes** in `~/.claude/themes/` (v2.1.118)
- **Hooks `mcp_tool` type** (v2.1.118)
- `prUrlTemplate` per custom code-review URL (v2.1.119)
- `CLAUDE_CODE_HIDE_CWD` env (v2.1.119)
- `--from-pr` accepts GitLab MR/Bitbucket PR/GHE (v2.1.119)
- PostToolUse hooks include `duration_ms` (v2.1.119)
- **`claude ultrareview [target]`** non-interactive subcommand per CI/script (v2.1.120) — [ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2047882231343878309)
- **`${CLAUDE_EFFORT}` nelle skill** (v2.1.120): le skill possono referenziare il livello di effort corrente nel proprio contenuto con `${CLAUDE_EFFORT}`
- **Windows: PowerShell senza Git Bash** (v2.1.120): quando Git for Windows non e' installato, Claude Code usa PowerShell come shell tool nativo
- **`alwaysLoad` MCP config** (v2.1.121): bypassa tool-search deferral per server specifici — tutti i tool sempre disponibili all'avvio
- **PostToolUse output override universale** (v2.1.121): `hookSpecificOutput.updatedToolOutput` funziona su tutti i tool, non solo MCP
- `claude plugin prune` (v2.1.121): rimuove dipendenze orfane dei plugin
- MCP server auto-retry 3x su errori transienti (v2.1.121)
- **`/resume` con PR URL** (v2.1.122): incollare URL di PR (GitHub, GitHub Enterprise, GitLab, Bitbucket) trova la sessione che ha creato quel PR
- `ANTHROPIC_BEDROCK_SERVICE_TIER` env (v2.1.122): seleziona tier Bedrock (`default`, `flex`, `priority`)
- Fix OAuth auth retry loop con `CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1` (v2.1.123)
- **`claude project purge [path]`** (v2.1.126, 1 mag 2026): elimina tutto lo stato di Claude Code per un progetto — trascrizioni, task, file history, config. Opzioni: `--dry-run`, `-y/--yes`, `-i/--interactive`, `--all`
- **OAuth paste-in-terminal** (v2.1.126): `claude auth login` accetta codice OAuth incollato nel terminale — risolve login in WSL2, SSH, container
- **`CLAUDE_CODE_SESSION_ID`** (v2.1.132, 6 mag 2026): env var passata all'ambiente dei subprocess Bash — permette a hook e script di correlare l'esecuzione alla sessione Claude Code corrente
- **`CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN=1`** (v2.1.132): opt-out dal renderer fullscreen; mantiene lo scrollback nativo del terminale
- **Hook input `effort.level` + `$CLAUDE_EFFORT`** (v2.1.133, 7 mag 2026): ogni hook riceve il livello di effort corrente nel JSON stdin (`effort.level`) e come variabile d'ambiente `$CLAUDE_EFFORT` — abilita logica hook condizionale in base all'effort
- **`worktree.baseRef`** (v2.1.133): nuova opzione settings (`"fresh"` | `"head"`) che controlla il branch di partenza dei worktree generati dall'harness; `"fresh"` (default) dirama da `origin/<default>`, `"head"` da HEAD locale
- **`autoMode.hard_deny`** (v2.1.134–136, 8 mag 2026): nuove regole di blocco assoluto per auto mode — azioni matching vengono bloccate incondizionatamente indipendentemente da eccezioni "allow" configurate. Vedi [04 Permessi](./04-modalita-permessi.md).
- **Agent View** (`claude agents`, research preview, v2.1.139, 11 mag 2026): vista unificata di tutte le sessioni Claude Code — in esecuzione, bloccate su input, o completate. Primo passo verso session management nativo multi-istanza. [@trq212](https://x.com/trq212/status/2053979505346425179).
- **`/goal [condition]`** (v2.1.139): nuovo slash command che imposta una condizione di completamento; Claude lavora su piu' turni fino al raggiungimento con overlay live tempo/turni/token. Funziona in modalita' interattiva, `-p` e Remote Control. [ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2053913638197416198).
- **Hook exec form `args: string[]`** (v2.1.139): il handler `command` accetta ora `args: string[]` per eseguire il processo direttamente senza shell intermediaria — previene injection, migliora sicurezza hook.
- **Hook `continueOnBlock`** (v2.1.139): nuova proprieta' su hook PostToolUse — il turno prosegue anche se l'hook ritorna `block`, utile per validazioni non critiche non bloccanti.

### 6 maggio 2026 — "Code with Claude" SF: raddoppio limiti

Alla conferenza "Code with Claude" di San Francisco (6 maggio 2026), Anthropic annuncia l'accordo con SpaceX per l'accesso al data center Colossus 1 (Memphis, TN) con oltre 300 MW di capacita' e 220.000+ GPU NVIDIA. Effetto immediato su Claude Code:

- **Limiti 5-ore raddoppiati** per Pro, Max, Team e seat-based Enterprise
- **Peak-hour limits rimossi** per Pro e Max
- **Rate limits API Opus** aumentati considerevolmente (pay-per-token)

Fonte: [Anthropic blog](https://www.anthropic.com/news/higher-limits-spacex), [CNBC](https://www.cnbc.com/2026/05/06/anthropic-spacex-data-center-capacity.html).

---

## 19.8 Post-mortem qualita' (apr 2026)

> "Over the past month, some of you reported Claude Code's quality had slipped. We investigated, and published a post-mortem on the three issues we found. All are fixed in v2.1.116+ and we've reset usage limits for all subscribers." — [@ClaudeDevs](https://x.com/ClaudeDevs/status/2047371123185287223)

> "The issues stemmed from Claude Code and the Agent SDK harness, which also impacted Cowork since it runs on the SDK. The models themselves didn't regress, and the Claude API was not affected." — [@ClaudeDevs](https://x.com/ClaudeDevs/status/2047371124238062069)

Vedi anche [@bcherny](https://x.com/bcherny/status/2047375800945783056).

---

## 19.9 Tabella versione per versione (v0.2.0 → v2.1.159)

| Data | Versione | Feature principali |
|---|---|---|
| 24 feb 2025 | v0.2.0 | **Lancio research preview** |
| 8 mar 2025 | v0.2.34 | Vim mode, custom slash commands |
| 14 mar 2025 | v0.2.44 | Deep Reasoning mode |
| 15 mar 2025 | v0.2.47 | Auto-compaction |
| 25 mar 2025 | v0.2.54 | Memory `#`, MCP SSE |
| 20 apr 2025 | v0.2.75 | Concurrent queries, drag-drop, @-mentions |
| 25 apr 2025 | v0.2.82 | `--disallowedTools` |
| 1 mag 2025 | v0.2.93 | `--continue`, `--resume` |
| 14 mag 2025 | v0.2.102 | Thinking improvements |
| 16 mag 2025 | v0.2.105 | Web search fetch, `/status` |
| 18 mag 2025 | v0.2.108 | Real-Time Steering |
| 20 mag 2025 | v0.2.117 | Nested JSON output |
| 21 mag 2025 | v0.2.125 | Bedrock ARN |
| 22 mag 2025 | **v1.0.0** | **GA release** |
| 4 giu 2025 | v1.0.10 | Markdown tables |
| 9 giu 2025 | v1.0.17 | `--add-dir` |
| 11 giu 2025 | v1.0.23 | npm package, **Plan mode launch** |
| 18 giu 2025 | v1.0.27 | MCP SSE + OAuth 2.0 |
| 30 giu 2025 | v1.0.38 | **Hooks** |
| 3 lug 2025 | v1.0.44 | `/export` |
| 7 lug 2025 | v1.0.48 | `PreCompact` hook |
| 8 lug 2025 | v1.0.51 | **Native Windows**, Bedrock |
| 16 lug 2025 | v1.0.54 | `UserPromptSubmit` hook |
| 18 lug 2025 | v1.0.56 | Shift+Tab Windows |
| 20 lug 2025 | v1.0.58 | PDF support |
| 23 lug 2025 | v1.0.60 | **Sub-agents** |
| 26 lug 2025 | v1.0.62 | @-mention agents |
| 30 lug 2025 | v1.0.64 | Custom model per agent |
| 4 ago 2025 | v1.0.68 | Opus 4.1 |
| 6 ago 2025 | v1.0.70 | @-mentions slash |
| ago 2025 | v1.0.7x | `/model` Opus per Plan mode |
| 29 set 2025 | **v2.0.0** | **Claude Code 2.0 + Sonnet 4.5** |
| ott 2025 | v2.0.1x | **Claude Code on the Web** |
| nov 2025 | v2.0.4x | **Code Review beta** |
| 14 nov 2025 | **v2.0.51** | **Opus 4.5 + Desktop App** |
| 20 nov 2025 | v2.0.55 | DNS proxy fix |
| 22 nov 2025 | v2.0.56 | Terminal progress |
| 24 nov 2025 | v2.0.57 | Plan Feedback |
| 26 nov 2025 | v2.0.58 | Pro Opus 4.5 |
| 28 nov 2025 | v2.0.59 | `--agent` flag |
| 3 dic 2025 | v2.0.60 | Background agents |
| 5 dic 2025 | v2.0.62 | `attribution` |
| 7 dic 2025 | v2.0.64 | Instant auto-compact, `/stats` |
| 9 dic 2025 | v2.0.65 | `alt+p` model switch |
| 11 dic 2025 | v2.0.67 | Prompt suggestions |
| dic 2025 | **v2.1.0** | **Claude Code 2.1 + Cowork + Slack** |
| 16–18 gen 2026 | v2.1.17 | Session forking |
| 19 gen 2026 | v2.1.19 | **Skills (`SKILL.md`)** |
| 25 gen 2026 | v2.1.25 | Arrow-key history |
| 26 gen 2026 | v2.1.29 | TeammateTool flagged |
| 5 feb 2026 | v2.1.32 | **Opus 4.6 + Agent Teams preview** |
| 7 feb 2026 | v2.1.36 | **Fast mode** |
| feb 2026 | v2.1.37 | Hardening |
| 19 feb 2026 | v2.1.39 | 5 CLI + 1 prompt change |
| feb 2026 | v2.1.4x | Sonnet 4.6 in CC, built-in worktree |
| 1 mar 2026 | v2.1.38–40 | Worktrees |
| 5 mar 2026 | v2.1.44 | Ultra-thinking, `/sandbox` |
| 17 mar 2026 | v2.1.76 | MCP elicitation, `/effort` |
| 18 mar 2026 | v2.1.77 | 64K output, `/copy N` |
| 19 mar 2026 | v2.1.78 | PowerShell preview, `StopFailure` |
| 20 mar 2026 | v2.1.79 | **VS Code Remote Control**, memory tightening |
| 21 mar 2026 | v2.1.80 | Rate limits statusline |
| 22 mar 2026 | v2.1.81–82 | `--bare`, channels |
| 24 mar 2026 | v2.1.83 | **Auto mode launch** |
| 30 mar 2026 | v2.1.86 | **`/ultrareview` launch** |
| 9 apr 2026 | v2.1.98 | **Monitor tool** |
| 10 apr 2026 | v2.1.91 | **`/ultraplan` launch** |
| 14 apr 2026 | v2.1.106 | **Routines GA** + PreCompact + plugin monitors |
| 15 apr 2026 | v2.1.110 | `/tui` flicker-free, push notifications |
| 16 apr 2026 | v2.1.111 | **Opus 4.7 + xhigh effort + `/ultrareview` GA** |
| 20 apr 2026 | v2.1.116 | `/resume` 67% piu' veloce, fix post-mortem |
| 22 apr 2026 | v2.1.117 | Plugin deps auto-install, default effort high |
| 23 apr 2026 | v2.1.118 | Vim visual mode, custom themes, `mcp_tool` hooks |
| 23 apr 2026 | v2.1.119 | `/config` persist, `prUrlTemplate`, `CLAUDE_CODE_HIDE_CWD` |
| 24 apr 2026 | v2.1.120 | `claude ultrareview` non-interactive subcommand, `${CLAUDE_EFFORT}` nelle skill, PowerShell senza Git Bash |
| 28 apr 2026 | v2.1.121 | `alwaysLoad` MCP config, PostToolUse output override universale, `claude plugin prune`, MCP auto-retry 3x |
| 28 apr 2026 | v2.1.122 | **`/resume` con PR URL**, `ANTHROPIC_BEDROCK_SERVICE_TIER`, fix `/branch` con timeline riavvolte |
| 29 apr 2026 | v2.1.123 | Fix OAuth auth retry loop con `CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1` |
| 1 mag 2026 | v2.1.126 | **`claude project purge`**, OAuth paste-in-terminal, model picker gateway |
| 2–3 mag 2026 | v2.1.127–128 | `/color` random, tool count in `/mcp`, archive support `--plugin-dir`, subagent summary improvements |
| 3 mag 2026 | v2.1.129 | `--plugin-url <url>` flag, `CLAUDE_CODE_FORCE_SYNC_OUTPUT=1`, auto-update Homebrew/WinGet, gateway model discovery opt-in |
| 6 mag 2026 | v2.1.131 | Fix VS Code extension Windows (hardcoded build path); fix Mantle auth (header `x-api-key`) |
| 6 mag 2026 | v2.1.132 | `CLAUDE_CODE_SESSION_ID` in Bash subprocess env, `CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN=1`, "Pasting..." hint clipboard, SIGINT graceful shutdown |
| 6 mag 2026 | — | **Raddoppio limiti Claude Code**: limiti 5-ore 2x per Pro/Max/Team/Enterprise; rimossi peak-hour limits Pro e Max; aumento rate limits API Opus. Accordo Anthropic-SpaceX (Colossus 1, 300 MW+). [Anthropic blog](https://www.anthropic.com/news/higher-limits-spacex) |
| 7 mag 2026 | v2.1.133 | **Hook input `effort.level` + `$CLAUDE_EFFORT`**; `worktree.baseRef` (`fresh`\|`head`); `sandbox.bwrapPath`/`socatPath`; `parentSettingsBehavior` managed |
| 8 mag 2026 | v2.1.134–136 | `autoMode.hard_deny` (blocco assoluto in auto mode); fix OAuth parallel sessions (401 race); fix MCP OAuth refresh token race |
| 11 mag 2026 | v2.1.139 | **Agent View** (`claude agents`, research preview); **`/goal`** command (completamento multi-turno con overlay); **`/scroll-speed`** per regolare la velocita' di scroll del transcript; hook `args: string[]` exec form (no-shell); hook `continueOnBlock` PostToolUse; `CLAUDE_PROJECT_DIR` per MCP stdio; Remote MCP reconnect retry GA |
| 13 mag 2026 | v2.1.141 | **Rewind "Summarize up to here"**: comprime il context accumulato mantenendo intatti i turni recenti; `claude agents --cwd <path>` filtra session list per directory; `terminalSequence` field negli hook JSON; `CLAUDE_CODE_PLUGIN_PREFER_HTTPS` per clone plugin via HTTPS; `ANTHROPIC_WORKSPACE_ID` per workload identity federation; `/feedback` include ultime 24h/7gg; spinner amber dopo 10s thinking; plugin menu keyboard shortcuts |
| 13 mag 2026 | — | **Crediti mensili per uso programmatico** (attivi dal 15 giu 2026): i piani paid Claude ottengono un credito mensile dedicato per `claude -p`, Agent SDK, Claude Code GitHub Actions e app terze parti basate sull'Agent SDK. [@ClaudeDevs](https://x.com/ClaudeDevs/status/2054610152817619388) |
| 14 mag 2026 | v2.1.142 | **Fast mode → Opus 4.7 di default** (era Opus 4.6); override via `CLAUDE_CODE_OPUS_4_6_FAST_MODE_OVERRIDE=1`. **Plugin SKILL.md root come skill**: plugin con `SKILL.md` a livello root esposto automaticamente come skill. Nuovi flag `--add-dir/--settings/--mcp-config/--plugin-dir/--permission-mode/--model/--effort` per `claude agents`. LSP server visibili in `/plugin details`. |
| 15 mag 2026 | v2.1.143 | **Plugin dependency enforcement**: `claude plugin disable` rifiuta se un plugin dipendente e' attivo (hint copy-pasteable); `claude plugin enable` forza dipendenze transitive. **`worktree.bgIsolation: "none"`**: sessioni background editano la working copy direttamente senza `EnterWorktree`. Sessioni background preservano modello ed effort dopo idle; `/bg` preserva `--mcp-config/--settings/--add-dir/--plugin-dir/--fallback-model`. PowerShell: `-ExecutionPolicy Bypass` di default (opt-out via env var). |
| 19 mag 2026 | v2.1.144 | **`/usage-credits`**: nuovo comando che mostra i crediti mensili per uso programmatico (`claude -p`, Agent SDK, GitHub Actions). **`/resume` sessioni background**: `/resume` include ora le sessioni avviate via `claude --bg` o Agent View (tag `bg` nella lista). **`/model` per-session**: cambia modello solo per la sessione corrente; `d` per impostare il default per le nuove sessioni. MCP `tools/list` paginato: ritorna tutte le pagine, non solo la prima. Elapsed duration nelle notifiche di completamento background. `/plugin` browse/discover mostra data ultimo aggiornamento. |
| 19 mag 2026 | v2.1.145 | **`claude agents --json`**: output JSON della lista sessioni live per scripting, tmux-resurrect, status bar. **`/plugin` pre-install preview**: tab Discover/Browse mostrano comandi, agenti, skill, hook, server MCP/LSP prima dell'installazione. `agent_id` e `parent_agent_id` negli span OTEL `claude_code.tool`. Status line JSON include info GitHub repo e PR. Mouse hover/click su slash command e @-mention in fullscreen. Hook Stop/SubagentStop include `background_tasks` e `session_crons`. |
| 21 mag 2026 | v2.1.146 | **`/simplify` → `/code-review`**: command rinominato con parametro effort opzionale (es. `/code-review high`); il vecchio nome non e' piu' valido. Auto mode non sopprime piu' `AskUserQuestion` quando esplicitamente richiesto da utente o skill. |
| 21 mag 2026 | v2.1.147 | **`/code-review --comment`**: nuovo flag pubblica i risultati come commenti inline sulla PR GitHub corrente. **Sessioni background pinnate** (`Ctrl+T` in Agent View): restano attive idle, si riavviano automaticamente per applicare update CC, vengono scaricate per ultime sotto pressione di memoria. Auto-updater con retry su errori di rete e reporting dettagliato. Diff rendering migliorato per file grandi. |
| 22 mag 2026 | v2.1.148 | Fix: Bash tool restituiva exit code 127 su ogni comando per alcuni utenti (regressione da v2.1.147). |
| 22 mag 2026 | v2.1.149 | `/usage` breakdown per categoria (skills, subagent, plugin, MCP server); `/diff` detail view scrollable con tastiera; `allowAllClaudeAiMcps` setting per Enterprise MCP cloud |
| 27 mag 2026 | **v2.1.152** | **`/reload-skills`** built-in; **`MessageDisplay` hook event** (trasforma/nasconde messaggi assistente); `/code-review --fix` applica review al working tree + alias `/simplify`; `disallowed-tools` in frontmatter skill; `--fallback-model` auto-switch; SessionStart hook: `reloadSkills` e `sessionTitle` |
| 28 mag 2026 | v2.1.153 | Stabilizzazione: `skipLfs` per plugin GitHub/git; `/doctor` mostra ultimo risultato update; fix stateful MCP servers reconnect-looping (regressione v2.1.147); fix memory usage su resume sessioni |
| 28 mag 2026 | **v2.1.154** | **Opus 4.8** (modello premium) come default per effort `xhigh`, con `xhigh` che diventa il nuovo `high`; **Dynamic Workflows** in research preview via **`/workflows`** per orchestrare decine/centinaia di agenti background (vedi [./24-workflows.md](./24-workflows.md)); **`! <command>`** in Agent View per eseguire comandi in sessione background; Fast Mode su Opus 4.8 (2x rate per 2.5x velocita'); lean system prompt default per Opus 4.8; `/effort` slider rinominato "Faster"/"Smarter"; `CLAUDE_CODE_SESSION_ID` in stdio MCP subprocess |
| 29 mag 2026 | v2.1.156 | Fix: thinking blocks Opus 4.8 venivano modificati causando errori API |
| 29 mag 2026 | **v2.1.157** | **Plugin auto-loading** da `.claude/skills/`: plugin locali caricati senza marketplace. **`claude plugin init <name>`**: scaffolding plugin in `.claude/skills/`. **`agent` in `settings.json` per dispatch** con override `--agent <name>`. Autocomplete `/plugin`. EnterWorktree multi-switch. Telemetria `tool_parameters` con `OTEL_LOG_TOOL_DETAILS=1`. |
| 30 mag 2026 | v2.1.158 | **Auto mode su Bedrock, Vertex e Foundry**: disponibile per Opus 4.7 e Opus 4.8 su AWS Bedrock, Google Vertex AI e Azure Foundry; opt-in con `CLAUDE_CODE_ENABLE_AUTO_MODE=1`. |
| 31 mag 2026 | **v2.1.159** | Stabilizzazione post-Opus 4.8: fix rendering thinking blocks in Fast Mode; affinamento Dynamic Workflows (`/workflows`) in research preview; correzioni minori auto mode su Bedrock/Vertex/Foundry. |
| 2 giu 2026 | **v2.1.160** | **Protezione file sensibili in `acceptEdits`**: prompt di conferma esplicita prima di scrivere su file di avvio shell (`.zshenv`, `.zlogin`, `.bash_login`, `~/.config/git/`) e file di configurazione build-tool (`.npmrc`, `.yarnrc*`, `bunfig.toml`, `.bazelrc`, `.pre-commit-config.yaml`, `.devcontainer/`). Ottimizzazione read-before-edit: `Edit` dopo `grep`/`egrep`/`fgrep` su singolo file non richiede `Read` separata. Keyword trigger Dynamic Workflows rinominata da `workflow` a `ultracode`. Auto Mode: ridotto reasoning su azioni routine per abbassare latenza classifier. Fix WSL copy-on-select (PowerShell interop), IME CJK positioning, sessioni background che perdevano chat history al ripristino. Rimosso `CLAUDE_CODE_OPUS_4_6_FAST_MODE_OVERRIDE`. |
| 2 giu 2026 | v2.1.161 | OTEL: `OTEL_RESOURCE_ATTRIBUTES` inclusi come labels su metric datapoints. `claude agents` mostra `done/total` per work fanned-out. `/mcp` collassa connettori claude.ai non utilizzati. Parallel tool calls: Bash fallito non cancella piu' gli altri. Fix `forceLoginOrgUUID`/`forceLoginMethod` con provider third-party. Fix `/usage-credits` per admin Team/Enterprise. Fix subagent frontmatter MCP servers che ignoravano `--strict-mcp-config`. Fix background subagent output che corrompeva stdout. |
| 3 giu 2026 | v2.1.162 | `claude agents --json` aggiunge campo `waitingFor` per mostrare su cosa e' bloccata una sessione. `/effort` conferma quando il livello scelto persistera' come default. Click su slash command in autocomplete riempie il prompt invece di eseguire immediatamente. Remote Control appare come pill persistente nel footer. macOS: background agents appaiono come "Claude Code" in Privacy & Security e mantengono i permessi dopo aggiornamenti. Fix WebFetch rules per domini preapprovati. Fix permission rules Windows con backslash/case-variant. Fix LSP `workspaceSymbol`. Fix startup silenzioso con config directory read-only. Fix Bash interrupt (Esc) ignorato all'inizio di un turn. |
| 4 giu 2026 | **v2.1.163** | **`/plugin list [--enabled\|--disabled]`**: nuovo sottocomando elenca plugin installati, filtrando per stato. **Managed Settings version enforcement**: `requiredMinimumVersion` e `requiredMaximumVersion` in `managed-settings.json` bloccano l'avvio se fuori range — policy enterprise per versioni approvate. **Stop/SubagentStop `additionalContext`**: questi hook possono ora restituire `hookSpecificOutput.additionalContext` per iniettare feedback e continuare il turn senza etichetta di errore. Aggiunta sintassi `\$` per letterali `$` prima di cifre in command body delle skill. "c to copy" in `/btw` copia la risposta in markdown preservando la formattazione. Fix: sessioni background non perdono piu' task in background dopo un aggiornamento; fix terminal misalignment e hang su uscita da agent view; fix bash failure sotto bazel/EDR; fix org-managed permission rules durante startup. |
| 5 giu 2026 | v2.1.165 | Bug fixes e miglioramenti di affidabilita'. |
| 6 giu 2026 | **v2.1.166** | **`fallbackModel` setting**: configura fino a 3 modelli di fallback provati in sequenza quando il primario e' sovraccarico o non disponibile; `--fallback-model` funziona ora anche in sessioni interattive. **Thinking Token Control**: `MAX_THINKING_TOKENS=0`, `--thinking disabled` e toggle per-modello disabilitano il thinking su modelli che lo attivano di default via Claude API (provider third-party invariati). **Cross-session messaging hardening**: messaggi inoltrati via `SendMessage` non portano piu' l'autorita' dell'utente — sessioni riceventi rifiutano richieste di permesso inoltrate, auto mode le blocca. `claude update` annuncia versione target prima del download. `claude agents` filtra sessioni per URL. Fix: remote sessions bloccate dopo disruption backend; orphaned `claude --bg-pty-host` a 100% CPU su macOS; background agents crash-loop "No conversation found"; flickering JetBrains 2026.1+; Shift+non-ASCII scartati su terminali Kitty; PowerShell validation hang su Windows; voice mode richiedeva `/login` dopo toggle `/voice`. |
| 6 giu 2026 | v2.1.167 | Bug fixes e miglioramenti di affidabilita'. |
| 8 giu 2026 | **v2.1.169** | **Safe Mode** (`--safe-mode` / `CLAUDE_CODE_SAFE_MODE`): avvia CC con tutte le customizzazioni disabilitate (CLAUDE.md, plugin, skill, hook, MCP) per troubleshooting isolato. **`/cd <path>`**: sposta la sessione in una nuova working directory senza rompere il prompt cache. **`disableBundledSkills`** (`CLAUDE_CODE_DISABLE_BUNDLED_SKILLS`): nasconde skill bundled e comandi built-in dal modello. `claude agents --json` include ora anche sessioni blocked/dispatched; aggiunto `--all` flag e campi `id`/`state`. Fix: policy MCP enterprise non applicate su reconnect; stall UI 30-50ms macOS; lentezza `claude -p` su Windows; Remote Control stuck su reconnect; popup Git Credential Manager Windows; footer hints assenti con statusline custom; permission prompt stale su reattach remoto. |

| 9 giu 2026 | **v2.1.170** | **Claude Fable 5** (`claude-fable-5`): primo modello Mythos-class disponibile pubblicamente — prestazioni superiori a Opus 4.8, ottimizzato per reasoning profondo e agentico long-horizon. Context window 1M token, 128k output max, $10/$50 per MTok, adaptive thinking sempre attivo. Disponibile su Claude API, Bedrock, Vertex AI, Foundry. |
| 10 giu 2026 | **v2.1.172** | **Sub-agenti annidati fino a 5 livelli**: un sub-agente puo' ora lanciare propri sub-agenti, con gerarchia fino a depth 5; ogni livello ha context window isolato e restituisce solo summary al padre. Plugin marketplace search bar. Bedrock region da `~/.aws` config. |
| 11 giu 2026 | v2.1.173 | Fix: normalizzazione nomi modelli Fable 5 con suffix `[1m]`; rimosso warning spurio "sandbox dependencies missing" su Windows. |
| 12 giu 2026 | v2.1.174 | **Usage attribution nel dialog Account & usage**: breakdowns granulari per skill, agent, plugin e server MCP; cache misses; long context. Fix `/model` picker che nascondeva la famiglia del Default model; fix Bedrock GovCloud prefix (`us-gov` anziche' `global`); fix background sessions che ereditavano variabili provider da altre sessioni. `wheelScrollAccelerationEnabled` setting per disabilitare l'accelerazione scroll in fullscreen. |
| 12 giu 2026 | **v2.1.175** | **`enforceAvailableModels`** (managed setting): se attivo, l'allowlist `availableModels` vincola anche il Default model e user/project settings non possono espandere la lista gestita — governance enterprise strict sul modello consentito. |
| 12 giu 2026 | v2.1.176 | **Session titles in conversation language**: i titoli delle sessioni vengono generati nella lingua della conversazione (configurabile via setting `language`). **`footerLinksRegexes`** setting: link badge regex-matched nel footer row, configurabile via user o managed settings. **Bedrock credential caching**: credenziali da `awsCredentialExport` cachate fino alla loro `Expiration` (prima 1h fissa). Auto mode fallback al miglior modello Opus disponibile quando il modello configurato non e' raggiungibile. |
| 13 giu 2026 | v2.1.177 | Aggiornamento CHANGELOG.md e feed.xml (maintenance). |
| 15 giu 2026 | — | **Credito programmatico attivo**: il budget mensile dedicato per `claude -p`, Agent SDK, GitHub Actions e app terze parti entra in vigore per tutti i piani paid. Vedi [16.5](./16-headless-agent-sdk.md#crediti-mensili-per-uso-programmatico-attivi-dal-15-giu-2026). |
| 15 giu 2026 | **v2.1.178** | **`Tool(param:value)` in permission rules**: sintassi per filtrare per parametro del tool — es. `Agent(model:opus)` in `deny` blocca sub-agenti Opus; wildcard `*` supportato. **Nested `.claude/` directory precedence**: skill/agenti/workflow/output-style nella `.claude/` piu' vicina alla working directory prevalgono; clash di nome risolti con prefisso `<dir>:<name>`. Auto mode: subagent spawns valutati dal classifier prima del lancio. `/doctor` rinnovato (layout flat, icone status, nomi comando evidenziati). |
| 17 giu 2026 | **v2.1.181** | **`/config key=value`**: imposta qualsiasi setting direttamente dal prompt senza modificare files (es. `/config thinking=false`) — funziona in interactive, `-p`, Remote Control. **`CLAUDE_CLIENT_PRESENCE_FILE`** (env var): sopprime push notification mobile finche' il file marker esiste. `sandbox.allowAppleEvents` opt-in per Apple Events su macOS. Streaming paragrafi lunghi riga-per-riga. Auto-retry su drop connessione mid-thinking. Subagent panel: idle auto-hide 30s, cap 5 righe con scroll hints. MCP OAuth page allineata allo stile CC. URL in fullscreen: richiede Cmd+click (macOS)/Ctrl+click. Bun runtime 1.4. |
| 19 giu 2026 | **v2.1.183** | **Artifacts** (beta Team/Enterprise): pagine web interattive generate da sessione, condivisibili via link privato al team — PR walkthrough, dashboard di progetto, visualizzazioni codice — aggiornate in tempo reale. **`/design-sync [pull\|push]`**: sync bidirezionale Claude Code ↔ Claude Design (pull design system nel repo, push codice verso canvas Design). **Auto mode safety**: blocco automatico comandi distruttivi non richiesti (`git reset --hard`, `git checkout -- .`, `git clean -fd`, `git stash drop`, `git commit --amend`, `terraform/pulumi/cdk destroy`). **`/config --help`**: lista tutti gli shorthand disponibili. **`attribution.sessionUrl`**: omette link sessione claude.ai da commit e PR (web/Remote Control). Rimosso "setup issues" dallo startup — usa `/doctor`. |
| 20 giu 2026 | v2.1.185 | Stream-stall hint rinominato "Waiting for API response · will retry in …" (era "No response from API…"); soglia silenziosa da 10s a 20s. |
| 22 giu 2026 | **v2.1.186** | **`claude mcp login <name>` / `claude mcp logout <name>`**: autenticazione server MCP da CLI senza menu interattivo `/mcp`; `--no-browser` per flussi SSH headless. **Bash `!` auto-response**: comandi `!<bash>` triggherano risposta automatica di Claude sull'output (`"respondToBashCommands": false` per comportamento precedente). Skills section nella tab Installed di `/plugin`. Workflow status filter (`f` in `/workflows`). `teammateMode: "iterm2"`. 18+ bug fix (streaming post-sleep, sub-agent scroll, Chrome tab isolation, `Agent(type)` deny rules, strikethrough rendering). |
| 23 giu 2026 | v2.1.187 | **`sandbox.credentials`**: blocca comandi sandboxati dalla lettura di file di credenziali e variabili d'ambiente segrete — isolamento multi-tenant. Restrizioni modello organizzazione visibili nel model picker e via `--model`/`/model`/`ANTHROPIC_MODEL`. Mouse click in menu fullscreen (permission prompts, `/model`, `/config`). Navigazione ←/→ in `/btw`. `CLAUDE_CODE_MCP_TOOL_IDLE_TIMEOUT` per timeout tool MCP remoti configurabile. Bug fix: `--resume` su run senza model turn; `agent({schema})` StructuredOutput loop; Remote Control lag ridotto ~2.7s; mojibake CJK su terminali paste-per-byte. |
| 24 giu 2026 | v2.1.190 | Bug fix e miglioramenti di affidabilita'. |
| 24 giu 2026 | **v2.1.191** | **`/rewind` post-`/clear`**: `/rewind` recupera ora la conversazione da prima dell'esecuzione di `/clear` — il context azzerato torna selezionabile nel menu Esc Esc. Prestazioni streaming +~37% via coalescing aggiornamenti testo a 100ms; riduzione memory growth su sessioni lunghe. MCP: capability discovery (`tools/list` etc.) ritenta errori transienti con backoff; OAuth discovery/token retry su errori transienti; headless salta popup browser; HTTP 404 mostra URL e punta a config MCP. Vim mode: history search (`NORMAL /`) aggiunge hint per slash command. Fix: matchers CSV negli hook (es. `"Bash,PowerShell"`) non si silenziavano; approvazione denial in `/permissions` non persisteva. |
| 25 giu 2026 | **v2.1.193** | **`autoMode.classifyAllShell`**: instrada TUTTI i comandi Bash/PowerShell attraverso il classificatore auto-mode (non solo pattern "arbitrary-code-execution"). **OTEL `claude_code.assistant_response`**: nuovo evento con testo risposta modello, redatto default, attivabile con `OTEL_LOG_ASSISTANT_RESPONSES=true`. **Autocomplete path bash mode**: completamenti live percorsi file con `!`. **MCP auth startup warning**: avviso visivo all'avvio quando un server MCP richiede autenticazione. **Background shell memory reaping**: auto-release memoria processi inattivi (disabilita con `CLAUDE_CODE_DISABLE_BG_SHELL_PRESSURE_REAP=1`). Fix: `headersHelper` MCP reconnect automatico su 401/403; backgrounding non genera piu' falso warning "N background tasks would be abandoned"; agenti pinned non vengono re-promptati dopo auto-update; agent panel mostra ora i sibling agents; `/model` e UI client-data non mostrano piu' stato stale dopo `/login`; migliorato plugin auto-rename con marketplace rename maps; migliorato messaggio `/add-dir`. |

<sub>Aggiornato 2026-06-26 via daily what's new. Fonte: [GitHub Releases v2.1.193](https://github.com/anthropics/claude-code/releases/tag/v2.1.193).</sub>

---

## 19.10 Note metodologiche

- Le date precise di patch minori sono ricostruite incrociando GitHub releases, claudelog.com, developertoolkit.ai
- Tra v0.2.125 e v1.0.0 ci sono salti di build interni non pubblici
- Numerazioni "v2.0.4x" sono range approssimativi (release notes non sempre allineate al GitHub mirror)
- Quando una feature compare in piu' versioni (es. Plan mode evoluzione), e' citata sotto la prima release stabile
- Range di patch (es. v2.1.41–43) sono accorpati quando le feature sono incrementali

---

## 19.11 Risorse

- Index completo docs: https://code.claude.com/docs/llms.txt (117 documenti)
- Changelog versione per versione: https://code.claude.com/docs/en/changelog
- What's new weekly: https://code.claude.com/docs/en/whats-new/index
- GitHub mirror changelog: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Demo plugins marketplace: https://github.com/anthropics/claude-code/tree/main/plugins
- Sandbox runtime open source: https://github.com/anthropic-experimental/sandbox-runtime
- Agent SDK demos: https://github.com/anthropics/claude-agent-sdk-demos
- Help Center release notes: https://support.claude.com/en/articles/12138966-release-notes

---

← [18 Settings & Auth](./18-settings-auth.md) · Successivo → [20 Tips & best practices](./20-tips-best-practices.md)
