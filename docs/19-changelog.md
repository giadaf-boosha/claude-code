# 19 — Changelog completo Claude Code (feb 2025 → apr 2026)

> 📍 [README](../README.md) → [Riferimenti](../README.md#riferimenti) → **19 Changelog**
> 📚 Riferimento · 🟢 Beginner-friendly

Cronologia completa di Claude Code dalla research preview (24 febbraio 2025, v0.2.0) all'ultima versione (23 aprile 2026, v2.1.119+). 7 fasi storiche + tabella versione per versione + post-mortem aprile 2026.

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

---

## 19.8 Post-mortem qualita' (apr 2026)

> "Over the past month, some of you reported Claude Code's quality had slipped. We investigated, and published a post-mortem on the three issues we found. All are fixed in v2.1.116+ and we've reset usage limits for all subscribers." — [@ClaudeDevs](https://x.com/ClaudeDevs/status/2047371123185287223)

> "The issues stemmed from Claude Code and the Agent SDK harness, which also impacted Cowork since it runs on the SDK. The models themselves didn't regress, and the Claude API was not affected." — [@ClaudeDevs](https://x.com/ClaudeDevs/status/2047371124238062069)

Vedi anche [@bcherny](https://x.com/bcherny/status/2047375800945783056).

---

## 19.9 Tabella versione per versione (v0.2.0 → v2.1.119+)

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
| 24 apr 2026 | v2.1.120 | `claude ultrareview` non-interactive subcommand — [ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2047882231343878309) |

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
