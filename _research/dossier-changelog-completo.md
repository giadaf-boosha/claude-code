# Dossier Changelog Completo Claude Code (feb 2025 → apr 2026)

> Documento di ricostruzione cronologica del ciclo di vita di Claude Code dalla research preview iniziale (24 feb 2025, v0.2.0) al rilascio di Auto mode/Ultraplan/Ultrareview (apr 2026, v2.1.119).
>
> **Periodo coperto in questo dossier**: feb 2025 → 22 mar 2026 (v0.2.x → v2.1.82).
> **Periodo gia' coperto in `docs/19-changelog.md`**: 23 mar 2026 → 23 apr 2026 (v2.1.83 → v2.1.119+, week 13–16).
>
> **Fonti master citate ricorrentemente**:
> - GitHub mirror ufficiale: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
> - Web changelog: https://code.claude.com/docs/en/changelog
> - Weekly recaps: https://code.claude.com/docs/en/whats-new
> - Anthropic news: https://www.anthropic.com/news
> - Vecchio dominio docs: https://docs.anthropic.com
> - Release notes Help Center: https://support.claude.com/en/articles/12138966-release-notes
> - Releases GitHub: https://github.com/anthropics/claude-code/releases

---

## 1. Cronologia per fase

### Fase 1 — Research preview (feb 2025 → mag 2025)

**Timeline**: 24 feb 2025 (v0.2.0) → 21 mag 2025 (v0.2.125, ultima preview).

**Versioni rilasciate** (selezione, ~125 patch nella serie 0.2.x):

| Data | Versione | Highlight |
|------|----------|-----------|
| 24 feb 2025 | v0.2.0 | Lancio research preview. CLI agentic con file editing, codebase scan, esecuzione bash. Annunciato con il blog "Introducing Claude 3.7 Sonnet". |
| 8 mar 2025 | v0.2.34 | Vim mode, custom slash commands. |
| 14 mar 2025 | v0.2.44 | Deep Reasoning / extended thinking mode. |
| 15 mar 2025 | v0.2.47 | Auto-compaction conversazioni. |
| 25 mar 2025 | v0.2.54 | Memory persistente con prefisso `#`, MCP SSE. |
| 20 apr 2025 | v0.2.75 | Concurrent queries, drag-drop immagini, @-mentions. |
| 25 apr 2025 | v0.2.82 | `--disallowedTools`, tool rinominati. |
| 1 mag 2025 | v0.2.93 | Sessioni: `--continue` e `--resume`. |
| 14 mag 2025 | v0.2.102 | Thinking mode migliorato. |
| 16 mag 2025 | v0.2.105 | Web search via fetch tool, comando `/status`. |
| 18 mag 2025 | v0.2.108 | Real-Time Steering durante thinking. |
| 20 mag 2025 | v0.2.117 | JSON output annidato; rinomina `DEBUG=true` → `ANTHROPIC_LOG`. |
| 21 mag 2025 | v0.2.125 | Bedrock ARN format. Ultima patch preview. |

**Feature flagship**:
- **Agentic CLI in terminale**: lettura/scrittura file, ricerca codice, esecuzione bash, git commit/push.
- **Memory `#` prefix** + `CLAUDE.md` per istruzioni persistenti progetto.
- **MCP SSE + thinking mode**: prima integrazione protocollo MCP e ragionamento esteso.
- **Auto-compaction**: conversazioni "infinite" senza esaurire context.

**Link**:
- Annuncio: https://www.anthropic.com/news/claude-3-7-sonnet (release Sonnet 3.7 + Claude Code preview)
- Wikipedia: https://en.wikipedia.org/wiki/Claude_(language_model)
- Versioning: https://developertoolkit.ai/en/claude-code/version-management/changelog/

---

### Fase 2 — GA + sub-agents (giu 2025 → ago 2025)

**Timeline**: 22 mag 2025 (v1.0.0 GA) → fine ago 2025 (v1.0.70+).

**Versioni rilasciate** (selezione):

| Data | Versione | Highlight |
|------|----------|-----------|
| 22 mag 2025 | v1.0.0 | **GA**: "graduated from preview to supported product". Disponibile con piani Pro/Max. |
| 4 giu 2025 | v1.0.10 | Markdown table rendering. |
| 9 giu 2025 | v1.0.17 | `--add-dir` per multi-directory. |
| 11 giu 2025 | v1.0.23 | Pacchetto npm ufficiale `@anthropic-ai/claude-code`. |
| 11 giu 2025 | — | **Lancio Plan mode** (annuncio Cat Wu su X). |
| 18 giu 2025 | v1.0.27 | SSE Support + OAuth 2.0 per MCP. |
| 25 giu 2025 | v1.0.24 | `/mcp` formatting. |
| 30 giu 2025 | v1.0.38 | **Sistema Hooks** introdotto. |
| 3 lug 2025 | v1.0.44 | `/export` transcript. |
| 7 lug 2025 | v1.0.48 | `PreCompact` hook. |
| 8 lug 2025 | v1.0.51 | **Native Windows** (no WSL), Bedrock support. |
| 16 lug 2025 | v1.0.54 | `UserPromptSubmit` hook, OAuth Windows. |
| 18 lug 2025 | v1.0.56 | Shift+Tab mode switching su Windows. |
| 20 lug 2025 | v1.0.58 | Lettura PDF. |
| 23 lug 2025 | v1.0.60 | **Sub-agents**: "create custom subagents for specialized tasks". |
| 26 lug 2025 | v1.0.62 | @-mention agenti custom. |
| 30 lug 2025 | v1.0.64 | Modello custom per agente. |
| 4 ago 2025 | v1.0.68 | Upgrade Opus 4.1. |
| 6 ago 2025 | v1.0.70 | @-mentions in slash commands. |
| ago 2025 | — | `/model` Opus per Plan mode (Opus 4.1 plan, Sonnet 4 lavoro) — annuncio Cat Wu. |

**Feature flagship**:
- **Plan mode** (giu 2025): review del piano prima di eseguire. Annuncio: https://x.com/_catwu/status/1932857816131547453, GA: https://x.com/_catwu/status/1932857819151413734. Approfondimento: https://lucumr.pocoo.org/2025/12/17/what-is-plan-mode/
- **Hooks system** (lug 2025): `PreToolUse`, `PostToolUse`, `UserPromptSubmit`, `PreCompact`.
- **Sub-agents** (23 lug 2025, v1.0.60): agenti specializzati con frontmatter, tool/model custom, @-mention.
- **Native Windows + Bedrock**: deployment enterprise.
- **/model Opus per plan**: https://x.com/_catwu/status/1955694117264261609

**Link**:
- npm package: https://www.npmjs.com/package/@anthropic-ai/claude-code
- Pro plan onboarding: https://x.com/_catwu/status/1930307574387363948

---

### Fase 3 — Claude Code 2.0 (set 2025 → nov 2025)

**Timeline**: 29 set 2025 (Sonnet 4.5 + Code 2.0) → 14 nov 2025 (Opus 4.5 + Desktop App, v2.0.51).

**Versioni rilasciate** (selezione):

| Data | Versione | Highlight |
|------|----------|-----------|
| 29 set 2025 | v2.0.0 | **Claude Code 2.0** + **Sonnet 4.5**. Checkpoints, VS Code extension nativa, parallel agents, hook expansion. |
| ott 2025 | v2.0.x | **Claude Code on the Web** launch (claude.ai/code). |
| nov 2025 | v2.0.4x | **Code Review beta** annunciata (poi promossa GA mar 2026). |
| 14 nov 2025 | v2.0.51 | **Opus 4.5** lancio + **Claude Desktop App**. |
| 20 nov 2025 | v2.0.55 | DNS proxy fix, fuzzy matching. |
| 22 nov 2025 | v2.0.56 | Terminal progress bar, secondary VS Code sidebar. |
| 24 nov 2025 | v2.0.57 | Plan Feedback, VS Code streaming. |
| 26 nov 2025 | v2.0.58 | Pro users access Opus 4.5. |
| 28 nov 2025 | v2.0.59 | `--agent` flag e `agent` setting. |

**Feature flagship**:
- **Checkpoints + rewind** (Esc Esc o `/rewind`): salva stato pre-modifica.
- **VS Code extension**: sidebar nativa con inline diff, sync real-time.
- **Parallel agents + Subagent maturation**.
- **Claude Code on the Web**: prima superficie cloud claude.ai/code.
- **Code Review beta** (nov 2025): team di agenti scansiona PR per bug.
- **Desktop App** (14 nov 2025): app nativa macOS/Windows.

**Link**:
- Sonnet 4.5: https://www.anthropic.com/news/claude-sonnet-4-5
- "Enabling Claude Code to work more autonomously": https://www.anthropic.com/news/enabling-claude-code-to-work-more-autonomously
- Opus 4.5: https://www.anthropic.com/news/claude-opus-4-5
- Code 2.0 deep dive: https://smartscope.blog/en/generative-ai/claude/claude-code-2-0-release/
- Sonnet 4.5 system prompt analysis: https://mikhail.io/2025/09/sonnet-4-5-system-prompt-changes/

---

### Fase 4 — 2.1 + Cowork + Web (dic 2025 → gen 2026)

**Timeline**: 3 dic 2025 (background agents, v2.0.60) → fine gen 2026 (v2.1.30+).

**Versioni rilasciate** (selezione):

| Data | Versione | Highlight |
|------|----------|-----------|
| 3 dic 2025 | v2.0.60 | **Background agents**, `/mcp enable` toggle. |
| 5 dic 2025 | v2.0.62 | `attribution` setting per commit. |
| 7 dic 2025 | v2.0.64 | Auto-compacting istantaneo, `/stats`. |
| 9 dic 2025 | v2.0.65 | Quick model switch `alt+p`, `CLAUDE_CODE_SHELL`. |
| 11 dic 2025 | v2.0.67 | Prompt suggestions, thinking di default. |
| dic 2025 | v2.1.0 | **Claude Code 2.1** (annuncio Boris Cherny). **Cowork** in Claude Desktop. **Claude Code for Slack**. |
| gen 2026 | v2.1.17 | Session forking. |
| 19 gen 2026 | v2.1.19 | **Skills** (`SKILL.md` in `.claude/skills/`). |
| 25 gen 2026 | v2.1.25 | Arrow-key history, sandbox improvements. |
| 26 gen 2026 | v2.1.29 | TeammateTool feature-flagged scoperto in binary (kieranklaassen). |

**Feature flagship**:
- **Cowork**: Claude Code agentico nella Claude Desktop app, runs in VM isolata, accesso file locali e MCP. Lanciato dic 2025, GA macOS/Windows successivamente.
- **Background agents + named sessions**: agenti che girano off-thread.
- **Claude Code for Slack**: tag `@claude-code` in qualsiasi thread.
- **Skills system** (gen 2026, v2.1.19): `.claude/skills/*/SKILL.md` per conoscenza domain-specific.
- **Session forking + .claude/rules/**.

**Link**:
- Boris Cherny annuncio 2.1: https://x.com/bcherny/status/2009072293826453669
- Claude Code Dec/Jan: https://www.vincirufus.com/en/posts/claude-code-december-january-updates/
- 2026 Q1 roundup: https://www.mindstudio.ai/blog/claude-code-q1-2026-update-roundup

---

### Fase 5 — Opus 4.6 + Fast mode + Security (feb 2026)

**Timeline**: 5 feb 2026 (v2.1.32, Opus 4.6) → 28 feb 2026 (v2.1.37+).

**Versioni rilasciate**:

| Data | Versione | Highlight |
|------|----------|-----------|
| 5 feb 2026 | v2.1.32 | **Claude Opus 4.6** + **Agent Teams preview** (sperimentale, dietro flag `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`). |
| 12 feb 2026 | v2.1.32–34 | Stabilizzazione Agent Teams. |
| 20–21 feb 2026 | v2.1.36 | **Fast mode** per Opus 4.6 (1M context). |
| feb 2026 | — | **Claude Code Security** annunciato. |
| 28 feb 2026 | v2.1.37 | Hardening pre-versioni 2.1.4x. |

**Feature flagship**:
- **Opus 4.6**: salto qualita' coding/reasoning. Annuncio: https://www.anthropic.com/news/claude-opus-4-6
- **Agent Teams**: team lead + teammate agents indipendenti, mailbox peer-to-peer, shared task list. Doc: https://code.claude.com/docs/en/agent-teams
- **Fast mode**: latenza ridotta + 1M token context.
- **Claude Code Security**: scansione vulnerabilita' integrata nel review.

**Link**:
- Opus 4.6: https://www.anthropic.com/news/claude-opus-4-6
- Agent Teams article: https://blog.imseankim.com/claude-code-team-mode-multi-agent-orchestration-march-2026/
- Q1 2026 guide: https://aimaker.substack.com/p/anthropic-claude-updates-q1-2026-guide
- Anthropic 2026 launches: https://fazal-sec.medium.com/anthropics-explosive-start-to-2026-everything-claude-has-launched-and-why-it-s-shaking-up-the-668788c2c9de

---

### Fase 6 — Remote + Code Review GA + Routines precursor (mar 2026, fino al 22)

**Timeline**: 1 mar 2026 (v2.1.38) → 22 mar 2026 (v2.1.82).

**Versioni rilasciate**:

| Data | Versione | Highlight |
|------|----------|-----------|
| 1–2 mar 2026 | v2.1.38–40 | Git worktrees, MCP enhancements. |
| 3–4 mar 2026 | v2.1.41–43 | Plugin tools `PluginCall`, agent access rules. |
| 5 mar 2026 | v2.1.44 | Ultra-thinking mode (`ultratlk`), `/sandbox`. |
| 6–7 mar 2026 | v2.1.45–46 | Tool `SendMessage`, `/mcp` upgrade. |
| 8–9 mar 2026 | v2.1.47–48 | Quick-fix commands, `PreCompact` hook. |
| 10–11 mar 2026 | v2.1.49–50 | Task management tools, deferred loading. |
| 17 mar 2026 | v2.1.76 | MCP elicitation, comando `/effort`. |
| 18 mar 2026 | v2.1.77 | Output 64K token, `/copy N`. |
| 19 mar 2026 | v2.1.78 | PowerShell tool preview, `StopFailure` hook. |
| 20 mar 2026 | v2.1.79 | **VS Code Remote Control** browser/mobile. |
| 21 mar 2026 | v2.1.80 | Rate limits in statusline, `--channels`. |
| 22 mar 2026 | v2.1.81–82 | `--bare` flag, channel servers. |

**Feature flagship**:
- **Remote Control GA-track**: connetti sessione Claude Code locale da claude.ai/code, app iOS, app Android. Sync layer, non cloud migration.
- **Code Review GA** (research preview beta Team/Enterprise): https://claude.com/blog/code-review, prezzo $15–25/review.
- **Computer Use** (Desktop): Claude apre app, click UI.
- **Routines precursor**: cron-like scheduling primi prototipi.
- **PowerShell native tool** (Windows preview).
- **Ultra-thinking** + `/effort` + 64K output tokens.

**Link**:
- Code Review blog: https://claude.com/blog/code-review
- Code Review docs: https://code.claude.com/docs/en/code-review
- VentureBeat Code Review: https://venturebeat.com/technology/anthropic-rolls-out-code-review-for-claude-code-as-it-sues-over-pentagon
- Remote Control: https://claudefa.st/blog/guide/development/remote-control-guide
- VentureBeat Remote: https://venturebeat.com/orchestration/anthropic-just-released-a-mobile-version-of-claude-code-called-remote
- Builder.io March recap: https://www.builder.io/blog/claude-code-updates

---

### Fase 7 — Auto mode + Ultraplan/Ultrareview + Routines GA (24 mar → apr 2026)

> Fase **gia' coperta in dettaglio** in `/Users/giadafranceschini/code/claude-code/docs/19-changelog.md` (v2.1.83 → v2.1.119+, week 13–16).

**Sintesi week-by-week**:

- **Week 13 (23–27 mar 2026, v2.1.83–85)**: lancio **Auto mode** (research preview, classifier per permission prompts). Computer use Desktop, PR auto-fix Web, transcript search `/`, native PowerShell, conditional `if` hooks. https://code.claude.com/docs/en/whats-new/2026-w13
- **Week 14 (30 mar – 3 apr 2026, v2.1.86–91)**: **Computer use CLI**. `/ultrareview` (v2.1.86), `/powerup` lessons, flicker-free, MCP result-size 500K, plugin executables in `$PATH`. Rimosso `/pr-comments`. https://code.claude.com/docs/en/whats-new/2026-w14
- **Week 15 (6–10 apr 2026, v2.1.92–101)**: **Ultraplan** (early preview). Monitor tool, `/loop` self-pace, `/team-onboarding`, `/autofix-pr`, auto-cloud-env, rimosso `/vim`. https://code.claude.com/docs/en/whats-new/2026-w15
- **Week 16 (13–23 apr 2026, v2.1.102–119)**: native CLI binary, Vim visual mode, custom themes, `/usage`, persistent `/config`, default effort `high` Pro/Max, plugin dependencies auto-install, `/resume` 67% piu' veloce, **Opus 4.7 `xhigh` effort** (v2.1.111).

---

## 2. Versione per versione (v0.2.0 → v2.1.82)

> Tabella compatta. Date approssimate per patch minori non documentate pubblicamente.

| Data | Versione | Feature principali | Link |
|------|----------|--------------------|------|
| 24 feb 2025 | v0.2.0 | Lancio research preview | https://www.anthropic.com/news/claude-3-7-sonnet |
| 8 mar 2025 | v0.2.34 | Vim mode, custom slash commands | GitHub CHANGELOG |
| 14 mar 2025 | v0.2.44 | Deep Reasoning mode | GitHub CHANGELOG |
| 15 mar 2025 | v0.2.47 | Auto-compaction | GitHub CHANGELOG |
| 25 mar 2025 | v0.2.54 | Memory `#`, MCP SSE | GitHub CHANGELOG |
| 20 apr 2025 | v0.2.75 | Concurrent queries, drag-drop, @-mentions | GitHub CHANGELOG |
| 25 apr 2025 | v0.2.82 | `--disallowedTools` | GitHub CHANGELOG |
| 1 mag 2025 | v0.2.93 | `--continue`, `--resume` | GitHub CHANGELOG |
| 14 mag 2025 | v0.2.102 | Thinking improvements | GitHub CHANGELOG |
| 16 mag 2025 | v0.2.105 | Web search fetch, `/status` | GitHub CHANGELOG |
| 18 mag 2025 | v0.2.108 | Real-Time Steering | GitHub CHANGELOG |
| 20 mag 2025 | v0.2.117 | Nested JSON output | GitHub CHANGELOG |
| 21 mag 2025 | v0.2.125 | Bedrock ARN | GitHub CHANGELOG |
| 22 mag 2025 | **v1.0.0** | **GA release** | https://x.com/_catwu/status/1930307574387363948 |
| 4 giu 2025 | v1.0.10 | Markdown tables | GitHub |
| 9 giu 2025 | v1.0.17 | `--add-dir` | GitHub |
| 11 giu 2025 | v1.0.23 | npm package, **Plan mode launch** | https://x.com/_catwu/status/1932857816131547453 |
| 18 giu 2025 | v1.0.27 | MCP SSE + OAuth 2.0 | GitHub |
| 25 giu 2025 | v1.0.24 | `/mcp` polish | GitHub |
| 30 giu 2025 | v1.0.38 | **Hooks** | https://code.claude.com/docs/en/hooks |
| 3 lug 2025 | v1.0.44 | `/export` | GitHub |
| 7 lug 2025 | v1.0.48 | `PreCompact` hook | GitHub |
| 8 lug 2025 | v1.0.51 | **Native Windows**, Bedrock | GitHub |
| 16 lug 2025 | v1.0.54 | `UserPromptSubmit` hook | GitHub |
| 18 lug 2025 | v1.0.56 | Shift+Tab Windows | GitHub |
| 20 lug 2025 | v1.0.58 | PDF support | GitHub |
| 23 lug 2025 | v1.0.60 | **Sub-agents** | https://code.claude.com/docs/en/sub-agents |
| 26 lug 2025 | v1.0.62 | @-mention agents | GitHub |
| 30 lug 2025 | v1.0.64 | Custom model per agent | GitHub |
| 4 ago 2025 | v1.0.68 | Opus 4.1 | GitHub |
| 6 ago 2025 | v1.0.70 | @-mentions slash | GitHub |
| ago 2025 | v1.0.7x | `/model` Opus per Plan mode | https://x.com/_catwu/status/1955694117264261609 |
| 29 set 2025 | **v2.0.0** | **Claude Code 2.0 + Sonnet 4.5** | https://www.anthropic.com/news/claude-sonnet-4-5 |
| ott 2025 | v2.0.1x | **Claude Code on the Web** | https://claude.ai/code |
| nov 2025 | v2.0.4x | **Code Review beta** | https://claude.com/blog/code-review |
| 14 nov 2025 | **v2.0.51** | **Opus 4.5 + Desktop App** | https://www.anthropic.com/news/claude-opus-4-5 |
| 20 nov 2025 | v2.0.55 | DNS proxy fix | GitHub |
| 22 nov 2025 | v2.0.56 | Terminal progress | GitHub |
| 24 nov 2025 | v2.0.57 | Plan Feedback | GitHub |
| 26 nov 2025 | v2.0.58 | Pro Opus 4.5 | GitHub |
| 28 nov 2025 | v2.0.59 | `--agent` flag | GitHub |
| 3 dic 2025 | v2.0.60 | Background agents | GitHub |
| 5 dic 2025 | v2.0.62 | `attribution` | GitHub |
| 7 dic 2025 | v2.0.64 | Instant auto-compact, `/stats` | GitHub |
| 9 dic 2025 | v2.0.65 | `alt+p` model switch | GitHub |
| 11 dic 2025 | v2.0.67 | Prompt suggestions | GitHub |
| dic 2025 | **v2.1.0** | **Claude Code 2.1 + Cowork + Slack** | https://x.com/bcherny/status/2009072293826453669 |
| 16–18 gen 2026 | v2.1.17 | Session forking | GitHub |
| 19 gen 2026 | v2.1.19 | **Skills (`SKILL.md`)** | https://code.claude.com/docs/en/skills |
| 25 gen 2026 | v2.1.25 | Arrow-key history | GitHub |
| 26 gen 2026 | v2.1.29 | TeammateTool flagged | https://deepakness.com/raw/claude-code-agent-teams/ |
| 5 feb 2026 | v2.1.32 | **Opus 4.6 + Agent Teams preview** | https://www.anthropic.com/news/claude-opus-4-6 |
| 20 feb 2026 | v2.1.36 | **Fast mode** | https://code.claude.com/docs/en/fast-mode |
| 28 feb 2026 | v2.1.37 | Hardening | GitHub |
| 1 mar 2026 | v2.1.38–40 | Worktrees | GitHub |
| 3 mar 2026 | v2.1.41–43 | `PluginCall`, agent access | GitHub |
| 5 mar 2026 | v2.1.44 | Ultra-thinking, `/sandbox` | GitHub |
| 6 mar 2026 | v2.1.45–46 | `SendMessage`, `/mcp` | GitHub |
| 8 mar 2026 | v2.1.47–48 | Quick-fix, `PreCompact` | GitHub |
| 10 mar 2026 | v2.1.49–50 | Task tools, deferred loading | GitHub |
| 17 mar 2026 | v2.1.76 | MCP elicitation, `/effort` | GitHub |
| 18 mar 2026 | v2.1.77 | 64K output, `/copy N` | GitHub |
| 19 mar 2026 | v2.1.78 | PowerShell preview, `StopFailure` | GitHub |
| 20 mar 2026 | v2.1.79 | **VS Code Remote Control** | https://venturebeat.com/orchestration/anthropic-just-released-a-mobile-version-of-claude-code-called-remote |
| 21 mar 2026 | v2.1.80 | Rate limits statusline | GitHub |
| 22 mar 2026 | v2.1.81–82 | `--bare`, channels | GitHub |

> Da v2.1.83 (24 mar 2026) in poi → vedi `docs/19-changelog.md`.

---

## 3. Note metodologiche

- Le date precise di patch minori sono ricostruite incrociando GitHub releases, claudelog.com release notes e developertoolkit.ai/version-management.
- I numeri di build tra v0.2.125 e v1.0.0 includono salti non documentati pubblicamente (tagging interno).
- Numerazioni "v2.0.4x" per Code Review beta indicano range approssimativo (release notes ufficiali non sempre allineate al GitHub mirror).
- Quando una feature compare in piu' versioni (es. Plan mode evoluzione), e' citata sotto la prima release stabile.

