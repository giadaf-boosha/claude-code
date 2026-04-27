# 19 — Changelog feb → apr 2026

Changelog dettagliato Claude Code dal 15 febbraio 2026 al 23 aprile 2026 (v2.1.83 → v2.1.119+). Include link a release notes settimanali e annunci.

> Fonti master: [`/en/changelog`](https://code.claude.com/docs/en/changelog), [`/en/whats-new`](https://code.claude.com/docs/en/whats-new), [GitHub mirror](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md).

---

## 19.1 Roadmap settimanale

### Week 13 (March 23–27, 2026, v2.1.83–v2.1.85)

**Lancio Auto mode** (research preview): classifier model gestisce permission prompts; safe actions auto, risky bloccate.

- Computer use in Desktop app
- PR auto-fix on Web
- Transcript search con `/`
- Native PowerShell tool per Windows (rolling out, opt-in Linux/macOS via `pwsh`)
- Conditional `if` hooks (anatomia hook arricchita)

> https://code.claude.com/docs/en/whats-new/2026-w13

### Week 14 (March 30 – April 3, 2026, v2.1.86–v2.1.91)

**Lancio Computer use in CLI** (research preview): Claude apre app native, click UI, verifica.
**Lancio `/ultrareview`** (v2.1.86)

- `/powerup` interactive lessons
- Flicker-free alt-screen rendering
- Per-tool MCP result-size override fino 500K
- Plugin executables in Bash $PATH
- `/pr-comments` rimosso (v2.1.91)

> https://code.claude.com/docs/en/whats-new/2026-w14

### Week 15 (April 6–10, 2026, v2.1.92–v2.1.101)

**Lancio Ultraplan** (early preview, v2.1.91+)

- `/loop` self-paces senza interval (v2.1.72 era launch base, evoluzione w15)
- **Monitor tool** stream background events (v2.1.98)
- `/team-onboarding` packages setup as replayable guide
- `/autofix-pr` PR auto-fix dal terminale
- Auto-creazione cloud env per ultraplan first run (v2.1.101)
- `/vim` rimosso (v2.1.92), Vim mode via `/config`
- POSIX `which` fallback security fix

> https://code.claude.com/docs/en/whats-new/2026-w15

---

## 19.2 Release notes versione per versione

### v2.1.119 (23 apr 2026)
- `/config` settings persist con precedence project/local/policy
- `prUrlTemplate` per custom code-review URL
- `CLAUDE_CODE_HIDE_CWD` env
- `--from-pr` accepts GitLab MR/Bitbucket PR/GHE
- PowerShell auto-approvable
- PostToolUse hooks include `duration_ms`
- MCP server reconfiguration parallela

### v2.1.118 (23 apr 2026)
- **Vim visual mode** (`v`) + visual-line (`V`)
- `/usage` unifica `/cost` + `/stats`
- **Custom themes** in `~/.claude/themes/`
- **Hooks `mcp_tool` type**
- `DISABLE_UPDATES` env
- `--continue`/`--resume` finds `--add-dir` sessions
- `/color` syncs Remote Control

### v2.1.117 (22 apr 2026)
- Forked subagents su external builds (`CLAUDE_CODE_FORK_SUBAGENT=1`)
- Agent frontmatter `mcpServers` per main-thread agent sessions
- `/model` selections persist con project pins
- **Plugin dependencies auto-install**
- Managed-settings `blockedMarketplaces`/`strictKnownMarketplaces` enforced
- **Default effort `high` per Pro/Max su Opus 4.6 + Sonnet 4.6**
- Cleanup retention `~/.claude/tasks/`, `~/.claude/shell-snapshots/`, `~/.claude/backups/`

### v2.1.116 (20 apr 2026)
- **`/resume` 67% piu' veloce** (40MB+ sessions)
- Smoother fullscreen scrolling VS Code/Cursor/Windsurf
- Thinking spinner progress inline
- `/config` search
- `/doctor` apribile durante response
- `/reload-plugins` auto-install missing deps
- Bash hint rate-limit GitHub
- **Fix issue post-mortem qualita'** (vedi 19.3)

### v2.1.114 (18 apr 2026)
- Crash permission dialog agent teammate fix

### v2.1.113 (17 apr 2026)
- **CLI spawna native binary** (per-platform optional dep)
- `sandbox.network.deniedDomains`
- Fullscreen Shift+↑/↓ scroll viewport
- `Ctrl+A`/`Ctrl+E` start/end logical line multiline
- URL wrapping clickable con OSC 8 hyperlinks
- `/loop` Esc cancel pending wakeups
- `/extra-usage` from Remote Control

### v2.1.112 (16 apr 2026)
- Fix "claude-opus-4-7 temporarily unavailable" auto mode

### v2.1.111 (16 apr 2026)
- **Claude Opus 4.7 xhigh availability**
- **Auto mode per Max subscribers su Opus 4.7**
- **Effort level `xhigh`** (tra `high` e `max`)
- `/effort` interactive slider
- **"Auto (match terminal)" theme**
- `/fewer-permission-prompts` skill
- **`/ultrareview` general availability**
- Auto mode senza `--enable-auto-mode`
- PowerShell tool gradual rollout
- Read-only bash glob + `cd <project-dir> &&` no prompt
- CLI typo suggestion
- Plan files named (`fix-auth-race-snug-otter.md`)
- `/skills` sort by token
- `Ctrl+U` clear input buffer
- `Ctrl+L` redraw + clear
- Headless `plugin_errors` init event
- `OTEL_LOG_RAW_API_BODIES`

### v2.1.110 (15 apr 2026)
- `/tui` fullscreen flicker-free
- **Push notification tool Remote Control**
- `Ctrl+O` toggle normal/verbose
- `autoScrollEnabled`
- `Ctrl+G` external editor
- `/plugin` Installed tab favorite/attention top
- `/doctor` MCP multi-scope warning
- `--resume`/`--continue` resurrecting unexpired scheduled tasks
- `/context`, `/exit`, `/reload-plugins` su Remote Control
- Write tool IDE diff acceptance notify
- Bash max timeout enforcement
- SDK/headless `TRACEPARENT`/`TRACESTATE` distributed trace
- Session recap per `DISABLE_TELEMETRY` users

### v2.1.109 (15 apr 2026)
- Extended-thinking indicator rotating progress

### v2.1.108 (14 apr 2026)
- `ENABLE_PROMPT_CACHING_1H` opt-in 1h TTL
- `FORCE_PROMPT_CACHING_5M`
- **Session recap returning context** configurable `/recap`
- **Model built-in slash commands discovery via Skill tool**
- `/undo` alias `/rewind`
- `/model` mid-conversation switch warning
- `/resume` picker default current dir, Ctrl+A all projects
- Rate limits vs plan usage distinction
- Closest match suggestion unknown commands
- Ridotto memory footprint file reads

### v2.1.107 (14 apr 2026)
- Thinking hints sooner long ops

### v2.1.106 (13 apr 2026)
- `EnterWorktree` `path` param existing worktree
- **`PreCompact` hook support** (exit 2 / `decision: block`)
- **Plugin background monitor support** (`monitors` manifest)
- `/proactive` alias `/loop`
- Stalled API stream 5-min abort + non-streaming retry
- `/doctor` status icons + `f` Claude fix
- `/config` labels clarity
- **Skill description 250 → 1,536 chars cap**
- `WebFetch` strip CSS-heavy pages
- Stale agent worktree cleanup squash-merged PR
- MCP large-output truncation format-specific
- Token counts ≥1M display "1.5m"

### v2.1.101 (10 apr 2026)
- `/team-onboarding` teammate ramp-up guide
- OS CA cert store trust default (`CLAUDE_CODE_CERT_STORE=bundled` override)
- **`/ultraplan` remote-session auto-create default cloud env**
- Brief mode retry plain text
- Focus mode self-contained summaries
- Tool-not-available errors why/proceed
- Rate-limit retry limit/reset
- Refusal error API explanation
- `claude -p --resume <name>`
- Settings resilience unrecognized hook event
- Plugin force-enabled managed settings hook run
- `/plugin` `claude plugin update` marketplace warning
- Plan mode "Refine with Ultraplan" remote capability check
- Beta tracing `OTEL_LOG_USER_PROMPTS`/`TOOL_DETAILS`/`TOOL_CONTENT`
- SDK `query()` cleanup subprocess/temp

### v2.1.98 (9 apr 2026)
- **Lancio Monitor tool** ([@noahzweben](https://x.com/noahzweben/status/2042332268450963774))

### v2.1.91 (10 apr 2026)
- **Lancio `/ultraplan`** ([@trq212](https://x.com/trq212/status/2042671370186973589))
- `/pr-comments` rimosso

### v2.1.86 (30 mar 2026)
- **Lancio `/ultrareview`** ([@ClaudeDevs](https://x.com/ClaudeDevs/status/2046999435239133246))

### v2.1.85 (30 mar 2026)
- Computer use in CLI v2.1.85+

### v2.1.83 (24 mar 2026)
- **Lancio Auto mode** (research preview)
- Computer use in Desktop
- PowerShell tool nativo
- Conditional `if` hooks

### v2.1.36 (7 feb 2026)
- **Lancio Fast mode** Opus 4.6

### v2.1.32 (gen 2026)
- Agent Teams sperimentale (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`)

---

## 19.3 Post-mortem qualita' (apr 2026)

> "Over the past month, some of you reported Claude Code's quality had slipped. We investigated, and published a post-mortem on the three issues we found. All are fixed in v2.1.116+ and we've reset usage limits for all subscribers." — [@ClaudeDevs](https://x.com/ClaudeDevs/status/2047371123185287223)

> "The issues stemmed from Claude Code and the Agent SDK harness, which also impacted Cowork since it runs on the SDK. The models themselves didn't regress, and the Claude API was not affected." — [@ClaudeDevs](https://x.com/ClaudeDevs/status/2047371124238062069)

Vedi anche [@bcherny](https://x.com/bcherny/status/2047375800945783056).

---

## 19.4 Highlight cambiamenti chiave dal 15 feb 2026

1. **Auto mode** (w13, v2.1.83) — feature flagship research preview
2. **Computer use CLI + Desktop** (w13–w14)
3. **PowerShell tool nativo** (w13)
4. **`/ultrareview`** (w14, v2.1.86, GA v2.1.111)
5. **Ultraplan** (w15, v2.1.91)
6. **Monitor tool** (v2.1.98)
7. **`/loop` evoluzione self-pacing** (w15)
8. **Plugin background monitors** (v2.1.106)
9. **Hooks `mcp_tool` type + `PreCompact`** (v2.1.106, v2.1.118)
10. **Opus 4.7 + xhigh effort** (v2.1.111)
11. **Flicker-free fullscreen** (`/tui`, v2.1.110)
12. **Vim visual mode** (v2.1.118)
13. **`/team-onboarding` + `/autofix-pr`** (w15)
14. **Skill description cap 1,536 char** (v2.1.106)
15. **Routines** (research preview, web/desktop/CLI con `/schedule`, 14 apr 2026)

---

## 19.5 Aree non documentate pubblicamente (al 27 apr 2026)

- Plan mode standalone page (404 su `/en/plan-mode`) — coperto inline su `/en/permission-modes`
- Checkpoints via `/en/checkpoints` (404) — esiste come `/en/checkpointing`
- Monitor page standalone (404) — coperto in `/en/tools-reference#monitor-tool`
- Pricing dettagliato Opus 4.7 — non in docs

---

## 19.6 Risorse

- Index completo docs: https://code.claude.com/docs/llms.txt (117 documenti)
- Changelog versione per versione: https://code.claude.com/docs/en/changelog
- What's new weekly: https://code.claude.com/docs/en/whats-new/index
- GitHub mirror changelog: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Demo plugins marketplace: https://github.com/anthropics/claude-code/tree/main/plugins
- Sandbox runtime open source: https://github.com/anthropic-experimental/sandbox-runtime
- Agent SDK demos: https://github.com/anthropics/claude-agent-sdk-demos

---

← [18 Settings & Auth](./18-settings-auth.md) · Successivo → [20 Tips & best practices](./20-tips-best-practices.md)
