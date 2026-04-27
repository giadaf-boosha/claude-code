# Dossier — Documentazione ufficiale Claude Code (aprile 2026)

> Ricerca strutturata sulla documentazione ufficiale `code.claude.com/docs/` aggiornata al **27 aprile 2026**.
> Obiettivo: fornire una base completa per riscrivere la repo `giadaf-boosha/claude-code` (ferma al 15 febbraio 2026), integrando ogni novità intercorsa.
> Italiano per le spiegazioni, inglese per i nomi tecnici. Ogni sezione cita la fonte ufficiale.

---

## 1. Snapshot prodotto — aprile 2026

### Versioni e modelli
- **Versione CLI corrente** (al 23 aprile 2026): `v2.1.119` (range coperto in questo dossier: `2.1.83` → `2.1.119`).
- **Modello di default**: `claude-sonnet-4-6`. Effort di default `high` per Pro/Max su Opus 4.6 e Sonnet 4.6 (da `v2.1.117`).
- **Modello premium**: `claude-opus-4-7` con effort `xhigh` disponibile su Max plan (da `v2.1.111`).
- **Effort levels** (dipendono dal modello): `low`, `medium`, `high`, `xhigh`, `max`.
- **Fast mode**: configurazione 2.5x più veloce di **Opus 4.6** (non disponibile su 4.7). Pricing $30/$150 per MTok (Fonte: `/en/fast-mode`).

### Modalità di accesso
| Surface | URL/comando | Note |
|---|---|---|
| Terminal CLI | `claude` | Native install raccomandato; auto-update in background |
| Desktop app | macOS / Windows / Windows ARM64 | claude.com/download |
| VS Code / Cursor | `vscode:extension/anthropic.claude-code` | Inline diff, plan review, @-mentions |
| JetBrains | Plugin marketplace | IntelliJ, PyCharm, WebStorm, ecc. |
| Web | claude.ai/code | Cloud sessions, repo cloning |
| Slack | `/install-slack-app` | Mention `@Claude` per task |
| Mobile | Claude iOS app + Remote Control | Android via mobile web |
| GitHub Actions / GitLab CI/CD | `/install-github-app` | PR review, issue triage |

### Provider supportati
Anthropic (default), **Amazon Bedrock** (`CLAUDE_CODE_USE_BEDROCK=1`), **Google Vertex AI** (`CLAUDE_CODE_USE_VERTEX=1`), **Microsoft Foundry** (`CLAUDE_CODE_USE_FOUNDRY=1`).

> Fonti: `/en/overview`, `/en/quickstart`, `/en/fast-mode`, `/en/changelog`.

---

## 2. CLI: install, comandi, flag

### Install
```bash
# macOS / Linux / WSL
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex

# Windows CMD
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd

# Homebrew (canale stabile)
brew install --cask claude-code
brew install --cask claude-code@latest   # canale latest

# WinGet
winget install Anthropic.ClaudeCode

# Linux: apt, dnf, apk supportati
```

Native install: **auto-update in background**. Homebrew/WinGet richiedono upgrade manuale.

### Comandi CLI principali

| Comando | Descrizione |
|---|---|
| `claude` | Sessione interattiva |
| `claude "query"` | Sessione interattiva con prompt iniziale |
| `claude -p "query"` | Print/headless mode (SDK), poi exit |
| `claude -c` / `--continue` | Continua l'ultima conversazione nella cwd |
| `claude -r "<id-or-name>"` / `--resume` | Riprende sessione per ID o nome |
| `claude update` | Aggiorna alla versione più recente |
| `claude install [version\|stable\|latest]` | Installa o reinstalla binary |
| `claude auth login [--email\|--sso\|--console]` | Login |
| `claude auth logout` | Logout |
| `claude auth status [--text]` | Stato auth (JSON di default) |
| `claude agents` | Lista subagent configurati |
| `claude auto-mode defaults` / `config` | Mostra regole classifier auto mode |
| `claude mcp` | Configura server MCP |
| `claude plugin` (alias `plugins`) | Gestione plugin |
| `claude remote-control` | Avvia server Remote Control |
| `claude setup-token` | Genera OAuth token (1 anno) per CI |

### Flag CLI rilevanti (selezione completa al 2.1.119)

Sezione dossier — vedi `/en/cli-reference` per la tabella completa. Highlight:

- `--add-dir <path>...` — directory aggiuntive (file access, NON config)
- `--agent <name>` / `--agents '<json>'` — agent per la sessione / definizione dinamica
- `--allow-dangerously-skip-permissions` — aggiunge `bypassPermissions` al ciclo Shift+Tab
- `--allowedTools "Bash,Edit,Read"` — pre-approve tools
- `--append-system-prompt[-file]` / `--system-prompt[-file]` — quattro flag dedicati al system prompt
- `--bare` — modalità minimale per CI/SDK (skippa auto-discovery, sarà default per `-p`)
- `--betas` — beta headers (API key only)
- `--channels` — research preview, ascolto eventi Channels MCP
- `--chrome` / `--no-chrome` — Chrome browser integration
- `--debug "api,hooks"` / `--debug-file <path>` — debug mode con filtri categoria
- `--dangerously-skip-permissions` — equivalente a `--permission-mode bypassPermissions`
- `--disable-slash-commands` — disabilita skills/commands per la sessione
- `--effort low|medium|high|xhigh|max` — effort level (session-only)
- `--exclude-dynamic-system-prompt-sections` — migliora cache hit cross-machine
- `--fallback-model sonnet` — fallback se modello principale è overloaded (print only)
- `--fork-session` — con `--resume`/`--continue` crea nuovo session ID
- `--from-pr <num\|url>` — riprende sessione collegata a PR (GitHub, GitLab MR, Bitbucket, GHE)
- `--ide` — connect automatico IDE all'avvio
- `--init` / `--init-only` / `--maintenance` — esegue hook di lifecycle
- `--include-hook-events` / `--include-partial-messages` — stream-json output extra
- `--input-format` / `--output-format text|json|stream-json`
- `--json-schema '<schema>'` — structured outputs validati (print only)
- `--max-budget-usd 5.00` / `--max-turns N` — limiti
- `--mcp-config <file-or-json>` / `--strict-mcp-config`
- `--model claude-sonnet-4-6` — alias `sonnet`/`opus` o full ID
- `--name`, `-n "feature-x"` — nome sessione (per `/resume`)
- `--no-session-persistence` — non salva sessioni (print only)
- `--permission-mode default|acceptEdits|plan|auto|dontAsk|bypassPermissions`
- `--permission-prompt-tool <mcp-tool>` — gestore prompt non-interactive
- `--plugin-dir <path>` — load plugin locale (ripetibile)
- `--print`, `-p` — non-interactive
- `--remote "<task>"` — crea web session su claude.ai
- `--remote-control "<name>"` (alias `--rc`) / `--remote-control-session-name-prefix`
- `--replay-user-messages` — re-emit user messages (stream-json)
- `--resume`, `-r` / `--session-id <uuid>`
- `--setting-sources user,project,local` / `--settings <file-or-json>`
- `--teleport` — pull web session in terminale
- `--teammate-mode auto|in-process|tmux` — display mode agent teams
- `--tmux[=classic]` — crea tmux session per worktree
- `--tools "Bash,Edit,Read"` / `""` / `"default"` — restringe built-in tools
- `--verbose` / `--version`, `-v`
- `--worktree`, `-w [name]` — worktree isolato in `<repo>/.claude/worktrees/<name>`

> Fonte primaria: https://code.claude.com/docs/en/cli-reference

---

## 3. Slash commands — lista completa built-in e bundled skills (al 2.1.119)

Type `/` per vederli filtrati per la tua sessione. Convenzione: **[Skill]** = bundled skill (prompt-based, può essere invocato da Claude in autonomia); altri = built-in CLI.

| Comando | Tipo | Funzione |
|---|---|---|
| `/add-dir <path>` | built-in | Aggiunge working directory file-access |
| `/agents` | built-in | Gestione [subagents](/en/sub-agents) |
| `/autofix-pr [prompt]` | built-in | Spawn web session che watcha la PR e pusha fix su CI failure / review comment (richiede `gh`) |
| `/batch <instruction>` | **Skill** | Refactor large-scale: 5-30 unit, 1 worktree+PR per agente |
| `/branch [name]` (alias `/fork`) | built-in | Branch della conversazione |
| `/btw <question>` | built-in | Side question senza inquinare la conversation |
| `/chrome` | built-in | Configura [Claude in Chrome](/en/chrome) |
| `/claude-api [migrate\|managed-agents-onboard]` | **Skill** | Reference Claude API + tool migration |
| `/clear` (alias `/reset`, `/new`) | built-in | Nuova conversation, pregresso resta in `/resume` |
| `/color [color\|default]` | built-in | Colore prompt bar (sync claude.ai con Remote Control) |
| `/compact [instructions]` | built-in | Comprime context |
| `/config` (alias `/settings`) | built-in | UI settings |
| `/context` | built-in | Visualizza uso context window |
| `/copy [N]` | built-in | Copia ultima risposta (o N-esima); `w` per write to file |
| `/cost` (alias `/usage`, `/stats`) | built-in | Costi e utilizzo |
| `/debug [description]` | **Skill** | Debug logging mid-session |
| `/desktop` (alias `/app`) | built-in | Continua su Desktop app (macOS/Windows) |
| `/diff` | built-in | Diff viewer interattivo (uncommitted + per-turn) |
| `/doctor` | built-in | Diagnostica install + `f` per fix automatico |
| `/effort [level\|auto]` | built-in | Imposta effort, slider interattivo, applica subito |
| `/exit` (alias `/quit`) | built-in | Esci CLI |
| `/export [filename]` | built-in | Esporta conversation come testo |
| `/extra-usage` | built-in | Configura extra usage |
| `/fast [on\|off]` | built-in | Toggle [fast mode](/en/fast-mode) (Opus 4.6) |
| `/feedback [report]` (alias `/bug`) | built-in | Submit feedback |
| `/fewer-permission-prompts` | **Skill** | Scansiona transcript e crea allowlist read-only |
| `/focus` | built-in | Focus view (solo ultimo prompt + risposta), fullscreen only |
| `/heapdump` | built-in | Heap snapshot per troubleshooting memoria |
| `/help` | built-in | Help comandi |
| `/hooks` | built-in | View hook configurations (read-only browser) |
| `/ide` | built-in | Manage integrazioni IDE |
| `/init` | built-in | Genera CLAUDE.md (con `CLAUDE_CODE_NEW_INIT=1` flow interattivo multi-fase) |
| `/insights` | built-in | Report analytics sessioni |
| `/install-github-app` | built-in | Setup [GitHub Actions](/en/github-actions) |
| `/install-slack-app` | built-in | Setup Slack OAuth |
| `/keybindings` | built-in | Apre/crea config keybindings |
| `/login` / `/logout` | built-in | Auth |
| `/loop [interval] [prompt]` (alias `/proactive`) | **Skill** | Re-run prompt: con interval (cron), senza interval (Claude self-paces), senza prompt (maintenance prompt o `loop.md`) |
| `/mcp` | built-in | Manage MCP server + OAuth |
| `/memory` | built-in | Edita CLAUDE.md, toggle auto-memory |
| `/mobile` (alias `/ios`, `/android`) | built-in | QR code app mobile |
| `/model [model]` | built-in | Cambia modello, slider effort |
| `/passes` | built-in | Free week to friends (se eligible) |
| `/permissions` (alias `/allowed-tools`) | built-in | Manage allow/ask/deny rules |
| `/plan [description]` | built-in | Entra in plan mode (con task opzionale) |
| `/plugin` | built-in | Gestione [plugins](/en/plugins) |
| `/powerup` | built-in | Lessons interattive con demo animati |
| `/privacy-settings` | built-in | Privacy (Pro/Max only) |
| `/recap` | built-in | One-line summary on demand |
| `/release-notes` | built-in | Changelog interattivo |
| `/reload-plugins` | built-in | Reload plugins live (no restart) |
| `/remote-control` (alias `/rc`) | built-in | Espone sessione a [Remote Control](/en/remote-control) |
| `/remote-env` | built-in | Configura env remote per `--remote` |
| `/rename [name]` | built-in | Rinomina sessione |
| `/resume [session]` (alias `/continue`) | built-in | Riprende sessione |
| `/review [PR]` | built-in | Code review locale (cf. `/ultrareview` per cloud) |
| `/rewind` (alias `/checkpoint`, `/undo`) | built-in | Checkpoint rewind |
| `/sandbox` | built-in | Toggle [sandbox mode](/en/sandboxing) |
| `/schedule [description]` (alias `/routines`) | built-in | Gestione [routines](/en/routines) |
| `/security-review` | built-in | Analizza diff per security issues |
| `/setup-bedrock` / `/setup-vertex` | built-in | Wizard provider |
| `/simplify [focus]` | **Skill** | 3 review agent paralleli + apply fix |
| `/skills` | built-in | Lista skills, `t` per sort by token |
| `/status` | built-in | Settings → Status (version, model, account) |
| `/statusline` | built-in | Configura status line |
| `/stickers` | built-in | Order stickers |
| `/tasks` (alias `/bashes`) | built-in | Background tasks (incluse cron, ultraplan, ultrareview) |
| `/team-onboarding` | built-in | Genera onboarding guide da usage history |
| `/teleport` (alias `/tp`) | built-in | Pull web session nel terminale |
| `/terminal-setup` | built-in | Keybindings shell (VS Code/Cursor/Windsurf/Alacritty/Zed) |
| `/theme` | built-in | Color theme + custom themes da `~/.claude/themes/` |
| `/tui [default\|fullscreen]` | built-in | Renderer TUI (fullscreen flicker-free da v2.1.110) |
| `/ultraplan <prompt>` | built-in | Plan in cloud, review browser, execute remote o local |
| `/ultrareview [PR]` | built-in | Multi-agent cloud code review (3 free runs Pro/Max → 5 mag 2026) |
| `/upgrade` | built-in | Upgrade plan |
| `/usage` | built-in | Cost + plan usage + activity |
| `/voice [hold\|tap\|off]` | built-in | Voice dictation (Claude.ai account) |
| `/web-setup` | built-in | Connect GitHub a [Claude Code on the web](/en/claude-code-on-the-web) |

**Rimossi**:
- `/vim` — rimosso in v2.1.92, sostituito da `/config` → Editor mode (Vim ora con visual mode `v` e visual-line `V` da v2.1.118)
- `/pr-comments` — rimosso in v2.1.91 (chiedere a Claude direttamente)

**MCP prompts**: `/mcp__<server>__<prompt>` discovery dinamico dai server connessi.

> Fonte: https://code.claude.com/docs/en/commands

---

## 4. Hooks — 28 eventi supportati

### Eventi (tabella completa)
| Evento | Quando fire | Bloccabile? |
|---|---|---|
| `SessionStart` | Inizio/resume | No |
| `SessionEnd` | Termine | No |
| `UserPromptSubmit` | Prompt prima di processing | Sì |
| `UserPromptExpansion` | Slash command expanded | Sì |
| `PreToolUse` | Prima di tool call | Sì |
| `PermissionRequest` | Permission dialog | Sì |
| `PermissionDenied` | Auto mode classifier nega | No |
| `PostToolUse` | Tool success | No |
| `PostToolUseFailure` | Tool fail | No |
| `PostToolBatch` | Fine batch parallelo | Sì |
| `Stop` | Claude termina turn | Sì |
| `StopFailure` | Turn ends per API error | No |
| `Notification` | Notifica Claude Code | No |
| `SubagentStart` / `SubagentStop` | Subagent spawn/finish | Stop=Sì |
| `TaskCreated` / `TaskCompleted` | Task list events | Sì |
| `TeammateIdle` | Teammate sta per idle | Sì |
| `InstructionsLoaded` | CLAUDE.md / rules caricati | No |
| `ConfigChange` | Config file cambia | Sì |
| `CwdChanged` | cwd cambia | No |
| `FileChanged` | File watched cambia | No |
| `WorktreeCreate` / `WorktreeRemove` | Worktree events | Create=Sì |
| `PreCompact` (da v2.1.106) / `PostCompact` | Compaction | Pre=Sì |
| `Elicitation` / `ElicitationResult` | MCP server input request | Sì |

### Anatomia (settings.json)
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "if": "Bash(rm *)",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-rm.sh",
            "timeout": 600,
            "statusMessage": "Validating...",
            "shell": "bash"
          }
        ]
      }
    ]
  }
}
```

### Tipi di handler
1. `command` — shell, input via stdin JSON, output via stdout/exit code
2. `http` — POST con JSON body, header configurabili (`allowedEnvVars` per secret)
3. `mcp_tool` (da v2.1.118) — chiama tool MCP server, output come command
4. `prompt` — single-turn al model con yes/no
5. `agent` — spawna subagent (Read, Grep, Glob), restituisce decision JSON

### Matcher
- `*`, `""` o omesso → match all
- Solo `[A-Za-z0-9_|]` → exact o list (`Bash`, `Edit|Write`)
- Altri caratteri → JS regex (`^Notebook`, `mcp__memory__.*`)

### Exit codes
- `0` + JSON → process decision
- `2` → blocking, stderr → Claude
- altro → non-blocking, stderr → log

### Output JSON tipici
```json
// PreToolUse
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow|deny|ask|defer",
    "permissionDecisionReason": "...",
    "updatedInput": { "field": "modified" },
    "additionalContext": "..."
  }
}

// Top-level (UserPromptSubmit, PostToolUse, Stop)
{
  "decision": "block",
  "reason": "...",
  "additionalContext": "..."
}
```

### Scope
```
~/.claude/settings.json          → user-wide
.claude/settings.json            → project (git-shared)
.claude/settings.local.json      → project (gitignore)
<plugin>/hooks/hooks.json        → plugin hooks
Skill/Agent frontmatter `hooks:` → component-scoped
```

> Fonte: https://code.claude.com/docs/en/hooks (con regole `if`, conditional, da v2.1.83).

---

## 5. Subagents

### Definizione
Subagent = AI assistant specializzato con context window proprio, system prompt custom, tool e permessi indipendenti. Quando Claude trova task matchato dalla `description`, delega.

> "Each subagent runs in its own context window with a custom system prompt, specific tool access, and independent permissions." — `/en/sub-agents`

### Dove vivono
| Scope | Path | Applies to |
|---|---|---|
| Enterprise | Managed settings | Tutti gli utenti org |
| User | `~/.claude/agents/<name>.md` | Tutti i progetti |
| Project | `.claude/agents/<name>.md` | Progetto |
| Plugin | `<plugin>/agents/<name>.md` | Dove plugin abilitato |

### Frontmatter
```yaml
---
name: code-reviewer        # opzionale, default = filename
description: Reviews code for quality and security
tools: Read, Grep, Glob   # opzionale, default = tutti
model: sonnet|opus|inherit # opzionale
mcpServers: [github]       # opzionale
skills: [api-docs]         # opzionale, preload skills
proactive: true            # auto-invoke se proattivo
hooks: { ... }             # hook scoped al subagent
---

You are an expert code reviewer focusing on...
```

### Built-in subagents
- `Explore` — codebase exploration read-only
- `Plan` — planning agent
- `general-purpose` — default

### Spawn / interazione
- `--agent <name>` o `--agents '<json>'` da CLI
- Tool `Agent` con `subagent_type` da Claude
- `claude agents` per lista
- Skills con `context: fork` + `agent: Explore` runano in subagent

### Forking
- `--fork-session` con resume
- `claude --continue --fork-session` per branching senza perdere session originale
- `CLAUDE_CODE_FORK_SUBAGENT=1` abilita `/fork` come spawn subagent

### Persistent memory subagents
Subagents possono mantenere auto-memory propria — vedi `/en/sub-agents#enable-persistent-memory`.

> Fonte: https://code.claude.com/docs/en/sub-agents

---

## 6. Skills

### Definizione
Skills = Markdown con YAML frontmatter che estendono Claude. Compatibile con [Agent Skills open standard](https://agentskills.io). Custom commands e skills sono **fusi**: un file in `.claude/commands/deploy.md` e uno in `.claude/skills/deploy/SKILL.md` creano entrambi `/deploy`.

### Bundled skills (sempre disponibili)
`/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api`, `/fewer-permission-prompts`.

### Path / scope
| Location | Path | Applies to |
|---|---|---|
| Enterprise | Managed settings | Tutti utenti org |
| User | `~/.claude/skills/<name>/SKILL.md` | Tutti progetti |
| Project | `.claude/skills/<name>/SKILL.md` | Progetto |
| Plugin | `<plugin>/skills/<name>/SKILL.md` | Plugin enabled |

Plugin skills usano namespace `plugin-name:skill-name`. Override: enterprise > personal > project. Plugin separato.

### Frontmatter completo
```yaml
---
name: my-skill                      # max 64 chars, [a-z0-9-]
description: When/what (key text)   # raccomandato; cap 1,536 char per entry
when_to_use: trigger phrases        # opzionale, appended a description
argument-hint: "[issue-number]"     # autocomplete hint
arguments: [issue, branch]          # named positional args (string or list)
disable-model-invocation: false     # se true, solo user invoke
user-invocable: true                # se false, solo Claude invoke
allowed-tools: "Bash(git *) Read"   # pre-approved tools (list o string)
model: sonnet|opus|inherit          # override modello
effort: low|medium|high|xhigh|max   # override effort
context: fork                       # esegue in subagent
agent: Explore                      # tipo subagent quando context: fork
hooks: { PreToolUse: [...] }        # hook scoped al skill
paths: ["src/api/**/*.ts"]          # auto-attivazione path-specific
shell: bash|powershell              # shell per !`...` blocks
---

# Skill content (Markdown)

Use `$ARGUMENTS`, `$ARGUMENTS[0]` / `$0`, `$1`, `$name` per substitution.
`${CLAUDE_SESSION_ID}`, `${CLAUDE_SKILL_DIR}` disponibili.

## Dynamic context injection
Inline: !`gh pr diff`
Multi-line block:
```!
node --version
npm --version
```
```

### Lifecycle del content
- Quando invocato, `SKILL.md` rendered diventa singolo messaggio nella conversation.
- Auto-compaction: re-attaches most recent invocation di ogni skill (5K token cap each, 25K token total budget).
- Per skill di grandi dimensioni dopo molte invocations, considera re-invoke dopo compact.

### Allowed-tools
Pre-approva tool senza prompt. Non restringe (per restringere usa permission deny rules).

### Auto-discovery nested
Lavorando in `packages/frontend/`, anche `packages/frontend/.claude/skills/` viene caricato (monorepo support).

### Live change detection
Aggiungere/modificare/rimuovere skill in `~/.claude/skills/`, project `.claude/skills/`, o `--add-dir` directory: effetto immediato senza restart.

### Subagent + skills
- Skill con `context: fork` + `agent: Explore` → skill body diventa task del subagent
- Subagent con `skills:` field → preload skill content nel system prompt

### Disabilitare shell execution
`disableSkillShellExecution: true` in settings (utile in managed settings).

### Restrict access
- `Skill` deny rule in `/permissions`
- `Skill(name)` exact / `Skill(name *)` prefix
- `disable-model-invocation: true`

### Char budget
`SLASH_COMMAND_TOOL_CHAR_BUDGET` env var (default: 1% context window, fallback 8000 char).

> Fonte: https://code.claude.com/docs/en/skills

---

## 7. MCP — Model Context Protocol

### Configurazione
```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

### Transports
- **stdio** — comando locale
- **http** / **sse** — remoto (URL)

### Comandi
- `claude mcp add` — aggiunge server
- `claude mcp serve` — gestione
- `/mcp` — UI gestione + OAuth
- `--mcp-config <file-or-json>` (ripetibile) / `--strict-mcp-config`

### Scopes
`enabledMcpjsonServers`, `disabledMcpjsonServers`, `enableAllProjectMcpServers`, `allowedMcpServers`, `deniedMcpServers`, `allowManagedMcpServersOnly`.

### MCP Registry
Anthropic mantiene un registry pubblico (`api.anthropic.com/mcp-registry/v0/servers`). Server "commercial" includono GitHub, GitLab, Atlassian, Slack, Notion, Figma, Vercel, Sentry, Linear, Asana, Firebase, Supabase, ecc.

### Tool search (scale)
Per molti tool, usa **MCP tool search** (`/en/mcp#scale-with-mcp-tool-search`) — schemi caricati on-demand via `ToolSearch`.

### MCP prompts come comandi
Server possono esporre prompts → `/mcp__<server>__<prompt>`.

### Channels (research preview)
MCP server possono pushare eventi nella sessione attiva via `/en/channels` (notifications real-time invece di polling).

> Fonte: https://code.claude.com/docs/en/mcp

---

## 8. Plugins & Marketplace

### Struttura plugin
```
my-plugin/
├── .claude-plugin/
│   └── plugin.json     # manifest (name, description, version, author)
├── skills/<name>/SKILL.md
├── commands/*.md       # legacy, ora skills/
├── agents/<name>.md
├── hooks/hooks.json
├── .mcp.json           # MCP servers
├── .lsp.json           # LSP servers (code intelligence)
├── monitors/monitors.json   # background monitors (da v2.1.106)
├── bin/                # executable aggiunti a $PATH
└── settings.json       # default settings (agent, subagentStatusLine)
```

### Manifest
```json
{
  "name": "my-plugin",
  "description": "...",
  "version": "1.0.0",
  "author": { "name": "..." },
  "homepage": "...",
  "repository": "...",
  "license": "MIT"
}
```

### Marketplace ufficiale
- **`claude-plugins-official`** — auto-disponibile
- Browse: https://claude.com/plugins
- Submit: https://claude.ai/settings/plugins/submit / https://platform.claude.com/plugins/submit

### Categorie marketplace ufficiale
1. **Code intelligence (LSP)**: `clangd-lsp`, `csharp-lsp`, `gopls-lsp`, `jdtls-lsp`, `kotlin-lsp`, `lua-lsp`, `php-lsp`, `pyright-lsp`, `rust-analyzer-lsp`, `swift-lsp`, `typescript-lsp` — danno automatic diagnostics + code navigation.
2. **External integrations**: `github`, `gitlab`, `atlassian`, `asana`, `linear`, `notion`, `figma`, `vercel`, `firebase`, `supabase`, `slack`, `sentry`.
3. **Development workflows**: `commit-commands`, `pr-review-toolkit`, `agent-sdk-dev`, `plugin-dev`.
4. **Output styles**: `explanatory-output-style`, `learning-output-style`.

### Comandi plugin
```bash
/plugin marketplace add anthropics/claude-code
/plugin marketplace add https://gitlab.com/org/plugins.git#v1.0.0
/plugin marketplace add ./local-marketplace
/plugin marketplace list / update <name> / remove <name>

/plugin install plugin-name@marketplace-name
/plugin enable / disable / uninstall plugin-name@marketplace-name
/plugin                  # UI tabbed: Discover, Installed, Marketplaces, Errors

claude plugin install formatter@your-org --scope project
/reload-plugins          # apply senza restart
```

### Scopes installazione
- **User** (default) — tutti progetti
- **Project** — collaborators (in `.claude/settings.json`)
- **Local** — only you, this repo
- **Managed** — admin via managed settings

### Auto-update marketplaces
Toggle per marketplace via UI. Official: enabled di default. Third-party: disabled di default.
- `DISABLE_AUTOUPDATER=1` — disabilita Claude Code + plugins
- `FORCE_AUTOUPDATE_PLUGINS=1` — keep plugin auto-update con `DISABLE_AUTOUPDATER=1`

### Team marketplaces
```json
{
  "extraKnownMarketplaces": {
    "my-team-tools": {
      "source": { "source": "github", "repo": "your-org/claude-plugins" }
    }
  }
}
```

### Managed restrictions
- `strictKnownMarketplaces: [...]` — solo questi
- `blockedMarketplaces: [...]` — block esplicito
- `allowManagedMcpServersOnly`, `pluginTrustMessage`

### Versioning
Se `version` omesso, commit SHA viene usato (ogni commit = nuova versione). Set explicit `version` per controllo update.

> Fonti: https://code.claude.com/docs/en/plugins , https://code.claude.com/docs/en/discover-plugins , `/en/plugin-marketplaces` , `/en/plugins-reference`.

---

## 9. Memory: CLAUDE.md hierarchy + auto-memory

### Due sistemi complementari

|  | CLAUDE.md | Auto-memory |
|---|---|---|
| Chi scrive | Tu | Claude |
| Contenuto | Instructions, rules | Learnings, patterns |
| Scope | Project/user/org | Per working tree (git-derived) |
| Loaded | Ogni sessione | First 200 lines / 25KB di MEMORY.md |
| Per | Coding standards, architecture | Build commands, debugging insights |

### Locations CLAUDE.md (precedence: locale → globale)
| Scope | Path | Shared with |
|---|---|---|
| Managed policy | `/Library/Application Support/ClaudeCode/CLAUDE.md` (macOS) / `/etc/claude-code/CLAUDE.md` (Linux/WSL) / `C:\Program Files\ClaudeCode\CLAUDE.md` (Windows) | Tutti utenti |
| Project | `./CLAUDE.md` o `./.claude/CLAUDE.md` | Team via VCS |
| User | `~/.claude/CLAUDE.md` | Te, ovunque |
| Local | `./CLAUDE.local.md` (gitignore) | Te, repo |

Tutti i discovered files sono **concatenati** (non override). `/init` per autogenerare. `CLAUDE_CODE_NEW_INIT=1` flow interattivo multi-fase.

### Imports
```markdown
@README.md
@docs/git-instructions.md
@~/.claude/my-project-instructions.md
```
Max 5 hops. Approval dialog la prima volta.

### AGENTS.md interop
Claude Code legge **CLAUDE.md** non AGENTS.md. Workaround:
```markdown
@AGENTS.md

## Claude Code
Use plan mode for changes under `src/billing/`.
```

### `.claude/rules/`
File `.md` con frontmatter `paths:` per rule path-specific:
```yaml
---
paths:
  - "src/api/**/*.ts"
  - "tests/**/*.test.ts"
---
# API rules
- Validate input
- Use standard error format
```
- Senza `paths`: load unconditional
- Symlinks supportati per share cross-project
- User-level: `~/.claude/rules/`

### Path resolution per CLAUDE.md
- Walk up directory tree dalla cwd
- Discovery di subdirectory CLAUDE.md when reading files in those dirs
- Block-level `<!-- HTML comments -->` strippati prima di context injection
- `claudeMdExcludes: ["**/monorepo/CLAUDE.md"]` per skip
- `--add-dir` + `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` carica anche da additional dirs

### Auto-memory
- Richiede v2.1.59+
- Default: ON, toggle via `/memory` o `autoMemoryEnabled: false` o env `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`
- Storage: `~/.claude/projects/<project>/memory/`
  - `MEMORY.md` (entry index, first 200 lines / 25KB caricati ogni sessione)
  - Topic files (es. `debugging.md`) lazy-loaded on demand
- `autoMemoryDirectory` redirect (settable da policy/local/user, NON da project)
- Project derivato da git repo (worktrees condividono memory)
- Plain markdown, edit/delete a piacere
- Subagents possono avere auto-memory proprio (`/en/sub-agents#enable-persistent-memory`)

### Compaction & memory
Project-root CLAUDE.md sopravvive `/compact` (re-iniettato). Nested CLAUDE.md ricaricano on next file read in subdir.

> Fonte: https://code.claude.com/docs/en/memory

---

## 10. Plan mode, Auto mode, Sandbox, Fast mode, Checkpoints

### Permission modes (cycle Shift+Tab: default → acceptEdits → plan)
| Mode | Run senza prompt | Use case |
|---|---|---|
| `default` | Solo reads | Sensitive work |
| `acceptEdits` | Reads + file edits + filesystem cmd (mkdir, touch, mv, cp, rm, rmdir, sed) entro working dir | Iterazione |
| `plan` | Solo reads | Esplora prima di modificare |
| `auto` | Tutto + classifier | Long task (richiede Max/Team/Enterprise/API + Anthropic provider + Sonnet 4.6 / Opus 4.6 / 4.7) |
| `dontAsk` | Solo pre-approved tools + read-only Bash | CI |
| `bypassPermissions` | Tutto eccetto protected paths | Container/VM isolated |

**Protected paths** (mai auto-approved):
- Directories: `.git`, `.vscode`, `.idea`, `.husky`, `.claude` (eccetto `.claude/commands`, `.claude/agents`, `.claude/skills`, `.claude/worktrees`)
- Files: `.gitconfig`, `.gitmodules`, `.bashrc`, `.zshrc`, `.profile`, `.ripgreprc`, `.mcp.json`, `.claude.json`

### Plan mode
Enter: `Shift+Tab`, `/plan [task]`, `--permission-mode plan`. Quando Claude finisce piano: opzioni include "Refine with Ultraplan" (browser review).

### Auto mode (research preview, da v2.1.83)
- Classifier separato review actions
- Boundaries dichiarate in conversation respectate (ma non rules permanenti)
- Block dopo 3 consecutivi / 20 totali → fallback prompts
- `claude auto-mode defaults` per vedere regole
- `autoMode.environment` per trusted infrastructure custom (`/en/auto-mode-config`)
- Disable: `disableAutoMode: "disable"` in managed settings

### Sandbox (`/sandbox`)
- macOS: Seatbelt (out of the box)
- Linux/WSL2: bubblewrap + socat (`apt-get install bubblewrap socat`). WSL1 NON supportato.
- Modes: **auto-allow** (sandboxed cmd auto-approved) / **regular** (standard prompt flow)
- Filesystem isolation: `sandbox.filesystem.allowWrite/denyWrite/allowRead/denyRead` (paths merge across scopes)
- Network isolation: proxy + `allowedDomains` / `deniedDomains`
- `sandbox.failIfUnavailable: true` per managed deployments
- `allowUnixSockets`, `allowMachLookup`, `allowLocalBinding`, `httpProxyPort`, `socksProxyPort`
- Open source: `npx @anthropic-ai/sandbox-runtime <command>`
- Escape hatch: `dangerouslyDisableSandbox` parametro permission-flow (disabilitabile con `allowUnsandboxedCommands: false`)

### Fast mode (research preview, da v2.1.36)
- Toggle: `/fast` con Tab, o `fastMode: true` settings
- 2.5x più veloce, **same Opus 4.6 quality**, **NON disponibile su Opus 4.7**
- Pricing: $30 input / $150 output MTok (flat su 1M context)
- Bills sempre come **extra usage** (anche con plan rimanente)
- Requirements: Anthropic API only (NO Bedrock/Vertex/Foundry); extra usage abilitato; Team/Enterprise admin enable
- `fastModePerSessionOptIn: true` reset a OFF ogni sessione
- `CLAUDE_CODE_DISABLE_FAST_MODE=1` disable totale
- Rate-limit fallback automatico a standard Opus 4.6 (icon `↯` grigia in cooldown)

### Checkpointing
Tracking automatico edits Claude. **NON** traccia bash file mods (`rm`, `mv`, `cp`).

`/rewind` (alias `/checkpoint`, `/undo`) o **Esc Esc**: menu scrollable con prompts della sessione.

Opzioni per ogni messaggio:
- **Restore code and conversation**
- **Restore conversation** (mantiene code)
- **Restore code** (mantiene conversation)
- **Summarize from here** (compatta da quel punto in avanti, simile a `/compact` targeted)
- **Never mind**

Persiste cross-session (cleanup default 30 giorni, configurable). Non sostituisce git.

> Fonti: `/en/permission-modes`, `/en/auto-mode-config`, `/en/sandboxing`, `/en/fast-mode`, `/en/checkpointing`.

---

## 11. Headless / Agent SDK

### CLI Headless (`-p`)
```bash
claude -p "Find and fix the bug" --allowedTools "Read,Edit,Bash"
```

Output formats: `text` (default), `json`, `stream-json` (NDJSON real-time).

**Bare mode** (`--bare`): skip auto-discovery (hooks, skills, plugins, MCP, auto memory, CLAUDE.md). Will be default for `-p`. Requires `ANTHROPIC_API_KEY` o `apiKeyHelper` (NON legge `CLAUDE_CODE_OAUTH_TOKEN` né keychain).

Stream events:
- `system/init` (with `plugins`, `plugin_errors`)
- `system/api_retry` (with `attempt`, `max_retries`, `retry_delay_ms`, `error_status`, `error`)
- `system/plugin_install` (sotto `CLAUDE_CODE_SYNC_PLUGIN_INSTALL`)
- `stream_event` (text deltas)

Structured outputs: `--output-format json --json-schema '<schema>'` → `structured_output` field.

Auto-approve: `--allowedTools` o `--permission-mode acceptEdits|dontAsk|bypassPermissions`.

### Agent SDK (Python + TypeScript)
> "Build production AI agents with Claude Code as a library" — `/en/agent-sdk/overview`

Renamed da Claude Code SDK. Migration guide: `/en/agent-sdk/migration-guide`.

Install:
```bash
npm install @anthropic-ai/claude-agent-sdk   # TypeScript
pip install claude-agent-sdk                  # Python
```

TypeScript SDK bundles native binary as optional dependency (no separate install needed).

Esempio TypeScript:
```typescript
import { query } from "@anthropic-ai/claude-agent-sdk";

for await (const message of query({
  prompt: "Find and fix the bug in auth.ts",
  options: { allowedTools: ["Read", "Edit", "Bash"] }
})) {
  console.log(message);
}
```

Esempio Python:
```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

async def main():
    async for message in query(
        prompt="Find and fix the bug in auth.py",
        options=ClaudeAgentOptions(allowed_tools=["Read", "Edit", "Bash"]),
    ):
        print(message)

asyncio.run(main())
```

**Capabilities** (dalla overview tabbed):
- **Built-in tools**: Read, Write, Edit, Bash, Monitor, Glob, Grep, WebSearch, WebFetch, AskUserQuestion
- **Hooks**: callback functions (PreToolUse, PostToolUse, Stop, SessionStart/End, UserPromptSubmit, ecc.)
- **Subagents**: `agents:` option + Agent tool
- **MCP**: `mcpServers:` option, full registry
- **Permissions**: `allowedTools`, `permissionMode`
- **Sessions**: capture session_id, `resume` per continuare con full context

**Claude Code features filesystem-based**: caricati da `.claude/` cwd + `~/.claude/`:
- Skills (`.claude/skills/*/SKILL.md`)
- Slash commands (`.claude/commands/*.md`)
- Memory (CLAUDE.md, .claude/CLAUDE.md)
- Plugins (programmatici via `plugins` option)

`setting_sources` (Python) / `settingSources` (TS) per limitare cosa caricare.

**Provider auth**:
- `ANTHROPIC_API_KEY` (default)
- `CLAUDE_CODE_USE_BEDROCK=1`
- `CLAUDE_CODE_USE_VERTEX=1`
- `CLAUDE_CODE_USE_FOUNDRY=1`
- claude.ai login NON permesso per terze parti.

**Opus 4.7 requirement**: Agent SDK v0.2.111+. Errore `thinking.type.enabled` → upgrade.

**Branding** (per partner): "Claude Agent" o "Claude" (preferito). NON "Claude Code" o "Claude Code Agent".

Changelog SDK separati:
- TypeScript: github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python: github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md

> Fonti: `/en/headless`, `/en/agent-sdk/overview` (+ python/typescript/quickstart/hooks/sessions/permissions/skills/slash-commands/subagents/mcp/structured-outputs/streaming-output/custom-tools/file-checkpointing/observability/secure-deployment/hosting/migration-guide/cost-tracking/agent-loop/user-input/todo-tracking/tool-search).

---

## 12. IDE integrations

### VS Code (`/en/vs-code`)
Requires VS Code 1.98.0+. `vscode:extension/anthropic.claude-code`.

**Features GUI**:
- Inline diff con permission prompt
- @-mentions con file:line ranges (Option+K / Alt+K)
- Plan review (markdown editor con inline comments)
- Conversation history (Local + Remote tabs per claude.ai web sessions)
- Multiple tabs / windows
- Spark icon in Editor Toolbar / Activity Bar / Status Bar
- Drag panel su Sidebar / Secondary sidebar / Editor area
- `/plugins` UI graphical
- `@browser` con [Claude in Chrome extension](https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn) (v1.0.36+)
- Built-in `ide` MCP server (`mcp__ide__getDiagnostics`, `mcp__ide__executeCode` con Quick Pick confirmation per Jupyter)

**Permission modes UI**:
- Ask before edits (`default`)
- Edit automatically (`acceptEdits`)
- Plan mode (`plan`)
- Auto mode (`auto`) — richiede `allowDangerouslySkipPermissions`
- Bypass permissions (`bypassPermissions`)

**Settings** (Extensions → Claude Code):
- `useTerminal` (default false)
- `initialPermissionMode`
- `preferredLocation` (sidebar | panel)
- `autosave` (default true)
- `useCtrlEnterToSend`
- `enableNewConversationShortcut` (Cmd+N)
- `hideOnboarding`, `respectGitIgnore`, `usePythonEnvironment`
- `environmentVariables`
- `disableLoginPrompt`
- `allowDangerouslySkipPermissions`
- `claudeProcessWrapper`

**URI handler**: `vscode://anthropic.claude-code/open?prompt=<urlencoded>&session=<id>` per launch da scripts/bookmarklet.

**Limitations vs CLI**:
| Feature | CLI | VS Code |
|---|---|---|
| Commands/skills | All | Subset |
| MCP config | Yes | Partial (add via CLI) |
| Checkpoints | Yes | Yes |
| `!` bash shortcut | Yes | No |
| Tab completion | Yes | No |

### JetBrains
Plugin marketplace (https://plugins.jetbrains.com/plugin/27310-claude-code-beta-). Runs in IDE terminal: switching modes uguale al CLI. IntelliJ, PyCharm, WebStorm.

### Desktop app (`/en/desktop`)
Standalone macOS/Windows/Windows ARM64. Visual diff review, parallel sessions, scheduled tasks, cloud kick-off. Auth richiede paid subscription. **Sessions from Dispatch**: messaggia da phone, apri Desktop session.

### Web (`/en/claude-code-on-the-web`)
- claude.ai/code
- Cloud session (fresh repo clone)
- Mobile via iOS app
- `--remote "<task>"` per kick-off cloud session
- `--teleport` per pull session locale
- Routines (cloud) + Desktop scheduled tasks (local) + `/loop` (session-scoped)

### Slack (`/en/slack`)
@Claude mention con bug report → PR.

### Channels (`/en/channels`, research preview)
Push events da Telegram, Discord, iMessage, webhooks → running session.

### Remote Control (`/en/remote-control`)
Continue local session da phone/browser. `/remote-control` o `claude --remote-control [name]`.

> Fonti aggregate.

---

## 13. Settings & Permissions

### Settings precedence (top to bottom)
1. **Managed** (cannot override): server-distributed, plist/registry, system `managed-settings.json`
   - macOS: `/Library/Application Support/ClaudeCode/`
   - Linux/WSL: `/etc/claude-code/`
   - Windows: `C:\Program Files\ClaudeCode\`
2. **Command-line args**
3. **Local project**: `.claude/settings.local.json` (gitignored)
4. **Shared project**: `.claude/settings.json` (git-shared)
5. **User**: `~/.claude/settings.json`

Array settings **merge** across scopes (concat + dedupe). Schema: `"$schema": "https://json.schemastore.org/claude-code-settings.json"`.

### Campi principali (selezione)
- **Model**: `model`, `availableModels`, `modelOverrides`, `effortLevel`
- **Permissions**: `allow`, `ask`, `deny`, `additionalDirectories`, `defaultMode`, `disableBypassPermissionsMode`, `disableAutoMode`
- **Env**: `env: { KEY: "value" }`
- **Auth**: `apiKeyHelper`, `awsCredentialExport`, `awsAuthRefresh`, `otelHeadersHelper`, `forceLoginMethod`, `forceLoginOrgUUID`
- **Sandbox**: vedere sezione 10
- **Hooks**: `hooks`, `disableAllHooks`, `allowManagedHooksOnly`, `allowedHttpHookUrls`, `httpHookAllowedEnvVars`
- **TUI / display**: `tui`, `autoScrollEnabled`, `showTurnDuration`, `showThinkingSummaries`, `editorMode`, `prefersReducedMotion`, `spinnerTipsEnabled`, `spinnerVerbs`, `terminalProgressBarEnabled`, `awaySummaryEnabled`
- **Memory**: `autoMemoryEnabled`, `autoMemoryDirectory`, `cleanupPeriodDays`, `plansDirectory`
- **Attribution**: `attribution.commit`, `attribution.pr`
- **Plugins**: `enabledPlugins`, `extraKnownMarketplaces`, `strictKnownMarketplaces`, `blockedMarketplaces`, `pluginTrustMessage`
- **MCP**: `allowedMcpServers`, `deniedMcpServers`, `allowManagedMcpServersOnly`, `enableAllProjectMcpServers`, `enabledMcpjsonServers`, `disabledMcpjsonServers`
- **Advanced**: `alwaysThinkingEnabled`, `fastModePerSessionOptIn`, `autoMode.soft_deny`, `useAutoModeDuringPlan`, `defaultShell`, `outputStyle`, `language`, `voice.enabled`
- **Worktree**: `worktree.symlinkDirectories`, `worktree.sparsePaths`
- **Other**: `agent`, `autoUpdatesChannel`, `minimumVersion`, `companyAnnouncements`, `fileSuggestion`, `statusLine`, `prUrlTemplate`, `respectGitignore`, `feedbackSurveyRate`, `disableSkillShellExecution`, `disableDeepLinkRegistration`, `skipWebFetchPreflight`, `showClearContextOnPlanAccept`, `teammateMode`, `viewMode`, `channelsEnabled`, `allowedChannelPlugins`, `claudeMdExcludes`

### Permission rule syntax
- `Tool` o `Tool(specifier)`
- `Bash`, `Bash(npm run *)`, `Bash(git diff *)` (spazio prima di `*` importante!)
- `Read(./.env)`, `Read(~/.zshrc)`, `Read(//absolute/path)`
- `Edit(...)`, `WebFetch(domain:example.com)`
- `MCP(server)`, `Skill(name)`, `Skill(name *)` (prefix)
- `Agent(...)`

### Read-only commands
Set predefinito (always allow in `dontAsk` mode + auto mode). Vedi `/en/permissions#read-only-commands`.

### Authentication
- **Storage**: macOS Keychain (encrypted), Linux/Windows `~/.claude/.credentials.json` (mode 0600 / user profile ACLs)
- **Tipi**: claude.ai, Claude API, Azure, Bedrock, Vertex
- **`apiKeyHelper`**: shell script, refresh ogni 5 min o HTTP 401 (`CLAUDE_CODE_API_KEY_HELPER_TTL_MS` per custom)
- **Slow helper**: warning se >10s

**Authentication precedence**:
1. Cloud provider env vars (Bedrock/Vertex/Foundry)
2. `ANTHROPIC_AUTH_TOKEN` (Authorization Bearer)
3. `ANTHROPIC_API_KEY` (X-Api-Key)
4. `apiKeyHelper`
5. `CLAUDE_CODE_OAUTH_TOKEN` (long-lived, generato con `claude setup-token`)
6. Subscription OAuth (`/login`)

Note: `CLAUDE_CODE_OAUTH_TOKEN` NON letto in bare mode. Web sessions usano sempre subscription credentials.

### Claude for Teams / Enterprise
- **Teams**: self-service, collaboration, admin tools
- **Enterprise**: SSO, domain capture, RBAC, compliance API, managed policy settings

### Console authentication
- **Claude Code role**: solo Claude Code API key
- **Developer role**: any API key

> Fonti: `/en/settings`, `/en/permissions`, `/en/authentication`, `/en/permission-modes`.

---

## 14. Teams & Agent Teams

### Claude for Teams/Enterprise (organizational)
Vedi sezione 13 (settings precedence + auth + managed policies).

### Agent Teams (sperimentale, da v2.1.32)
> "Coordinate multiple Claude Code instances working together as a team"

**Enable**:
```json
{ "env": { "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1" } }
```

**Avvio** (natural language al lead):
```
Create an agent team to explore this CLI tool from different angles:
one teammate on UX, one on technical architecture, one playing devil's advocate.
```

**Componenti**:
- **Team lead**: sessione main che coordina
- **Teammates**: Claude Code instances separate, ognuno con context proprio
- **Task list**: shared, file locking per claim
- **Mailbox**: messaging direct teammate-to-teammate

**Display modes** (`teammateMode` / `--teammate-mode`):
- `auto` (default): tmux se già in tmux, in-process altrimenti
- `in-process`: Shift+Down per cycle, type per messaggio diretto
- `tmux`: split panes (richiede tmux o iTerm2 + `it2` CLI)

**Subagent vs Agent Teams**:
| | Subagents | Agent Teams |
|---|---|---|
| Context | Own, results back to caller | Own, fully independent |
| Communication | Solo to caller | Direct teammate-to-teammate |
| Coordination | Main agent | Shared task list + self-coord |
| Token cost | Lower | Higher (each = full instance) |

**Storage**:
- Team config: `~/.claude/teams/{team-name}/config.json` (NON editare a mano)
- Task list: `~/.claude/tasks/{team-name}/`

**Subagent definitions per teammate**: spawn referenziando agent type (`Spawn a teammate using the security-reviewer agent type to audit auth`). `tools` allowlist e `model` rispettati. `skills`/`mcpServers` frontmatter NON caricati (teammate carica da settings come regular session).

**Plan approval per teammates** (workflow):
1. Teammate lavora in plan mode read-only
2. Submit plan al lead
3. Lead approve o reject con feedback
4. Loop fino approval
5. Implementation

**Hooks per quality gates**: `TeammateIdle`, `TaskCreated`, `TaskCompleted` (exit 2 = block + feedback).

**Cleanup**: ask lead "Clean up the team". Lead controlla active teammates first.

**Limitations** (sperimentale):
- No session resumption con in-process teammates
- Task status può laggare
- Shutdown lento (finish current request first)
- One team per session
- No nested teams
- Lead fixed (no promote/transfer)
- Permissions set at spawn (modificabili dopo)
- Split panes NON in VS Code integrated terminal, Windows Terminal, Ghostty

### Task list (built-in)
Tools: `TaskCreate`, `TaskGet`, `TaskList`, `TaskUpdate`, `TaskStop`, `TaskOutput` (deprecated). Stati: `pending`, `in_progress`, `completed`, `deleted`. Dependencies: `addBlockedBy`, `addBlocks`.

`TodoWrite` solo in non-interactive mode + Agent SDK.

> Fonte: https://code.claude.com/docs/en/agent-teams + tools-reference.

---

## 15. Monitor / Loop / Routines / Ultraplan / Ultrareview (DETTAGLIO MASSIMO)

### Monitor tool (da v2.1.98)
> "Lets Claude watch something in the background and react when it changes, without pausing the conversation."

**Use case**:
- Tail log file e flag errors
- Poll PR/CI job per status change
- Watch directory per file changes
- Track output di long-running script

**Come funziona**:
1. Claude scrive piccolo script
2. Run in background
3. Ogni output line arriva come notifica → Claude interjects
4. Stop: ask Claude o end session

**Permessi**: stesse rules di `Bash` (allow/deny patterns matchano).

**Non disponibile** su: Bedrock, Vertex AI, Foundry. Disabilitato con `DISABLE_TELEMETRY` o `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC`.

**Plugin monitors** (da v2.1.106): `monitors/monitors.json`:
```json
[
  {
    "name": "error-log",
    "command": "tail -F ./logs/error.log",
    "description": "Application error log"
  }
]
```
Ogni stdout line → notifica nella sessione. Auto-start con plugin.

### `/loop` (bundled skill, da v2.1.72)
**Sintassi**:
| Input | Esempio | Comportamento |
|---|---|---|
| Interval + prompt | `/loop 5m check the deploy` | Cron schedule fisso |
| Solo prompt | `/loop check CI` | Claude self-paces (1 min - 1 ora) ad ogni iterazione |
| Solo interval o niente | `/loop` o `/loop 15m` | Maintenance prompt o `loop.md` |

Cron: 1-min granularity. Intervalli non-clean (`7m`, `90m`) round to nearest. Units: `s`, `m`, `h`, `d`.

Claude self-pace usa **Monitor tool** quando appropriato (più efficiente di polling).

**Maintenance prompt built-in** (omitting both):
- Continue unfinished work
- Tend current branch PR (review comments, failed CI, conflicts)
- Cleanup passes (bug hunts, simplification)
- NO new initiatives, irreversible actions solo se transcript le ha autorizzate

**`loop.md` custom**:
- `.claude/loop.md` (project) precede `~/.claude/loop.md` (user)
- Plain Markdown, no required structure
- Edits effective on next iteration
- Cap 25,000 bytes

**Stop**: Esc (clear pending wakeup). Tasks scheduled by asking Claude direttamente NON cancellate da Esc.

**One-time reminders**:
```
remind me at 3pm to push the release branch
in 45 minutes, check tests
```
Claude crea single-fire task con cron expression.

**Tools sotto il cofano**:
- `CronCreate` (5-field cron + prompt + recurs/once)
- `CronList`
- `CronDelete` (8-char ID)

Max 50 scheduled tasks per sessione.

**Scheduler**:
- Check ogni 1 sec
- Fire low priority **between turns** (mai mid-response)
- Local timezone (es. `0 9 * * *` = 9am locale)
- **Jitter**: recurring fire fino 10% periodo late (cap 15 min); one-shot top/bottom hour fino 90s early. Per timing esatto, usa minute non-`:00`/`:30`.
- **7-day expiry**: recurring fire una volta finale poi delete. Cancel & recreate per longer.

**Cron expressions**: 5-field `minute hour dom month dow`. Wildcards, single, steps `*/15`, ranges `1-5`, lists `1,15,30`. NO `L`, `W`, `?`, `MON`/`JAN` aliases.

**Disable**: `CLAUDE_CODE_DISABLE_CRON=1`.

**Limitations**:
- Solo while session running + idle
- No catch-up missed fires
- Fresh conversation clears tasks
- `--resume`/`--continue` restore unexpired

**Comparazione**:
|  | **Routines (cloud)** | **Desktop scheduled** | **`/loop`** |
|---|---|---|---|
| Runs on | Anthropic cloud | Your machine | Your machine |
| Machine on | No | Yes | Yes |
| Open session | No | No | Yes |
| Restart persistent | Yes | Yes | Resume if unexpired |
| Local files | No (fresh clone) | Yes | Yes |
| MCP | Connectors per task | Config files + connectors | Inherits |
| Permission prompts | No (autonomo) | Configurable | Inherits |
| Min interval | 1 hour | 1 minute | 1 minute |

### Routines (research preview, cloud automation)
> "Put Claude Code on autopilot. Define routines that run on a schedule, trigger on API calls, or react to GitHub events."

Plans: Pro, Max, Team, Enterprise (con web access).
Beta header: `experimental-cc-routine-2026-04-01`.

**Componenti**: prompt + repos + connectors + environment + triggers.

**Tipi trigger**:
1. **Scheduled**: hourly/daily/weekdays/weekly preset, o custom cron via `/schedule update` (min 1 ora). Times locali → UTC. One-off: descrivi in natural language (`/schedule tomorrow at 9am, summarize PRs`).
2. **API**: per-routine endpoint con bearer token. POST con `text` field opzionale (freeform string, non parsed).
   ```bash
   curl -X POST https://api.anthropic.com/v1/claude_code/routines/trig_01ABCDEF.../fire \
     -H "Authorization: Bearer sk-ant-oat01-xxxxx" \
     -H "anthropic-beta: experimental-cc-routine-2026-04-01" \
     -H "anthropic-version: 2023-06-01" \
     -d '{"text": "Sentry alert SEN-4521 fired"}'
   ```
   Response: `{ type, claude_code_session_id, claude_code_session_url }`. Token shown once, generate da web only (CLI non può).
3. **GitHub**: install Claude GitHub App (≠ `/web-setup`). Eventi: `pull_request.*`, `release.*`. Filtri: author, title, body, base/head branch, labels, is_draft, is_merged. Operatori: equals, contains, starts_with, is_one_of, regex (matches entire field).

Ogni event = nuova session. Per-routine + per-account hourly caps.

**Creation** (web/desktop/CLI):
- Web: claude.ai/code/routines
- Desktop: Routines sidebar → New routine → Remote
- CLI: `/schedule [description]` o `/schedule daily PR review at 9am` o `/schedule clean up flag in one week`. CLI **solo scheduled**, API/GitHub trigger via web.

**CLI subcommands**:
- `/schedule list` / `update` / `run`
- `/web-setup` (GitHub access, NOT GitHub App)

**Permissions**: routines run autonome (no permission prompt). Allow unrestricted branch pushes per repo (default: solo `claude/*` branches).

**Connectors**: tutti connectors connected default-included. Removable. No tool restriction durante run.

**Environments**: cloud env controlla network, env vars, setup script. Custom env via web before routine creation.

**Run management**:
- Click routine → detail page (repos, connectors, prompt, schedule, tokens, GitHub triggers, runs)
- "Run now" — immediato
- Pause/resume toggle
- Edit pencil
- Delete (past sessions kept)

**Usage**:
- Subscription usage standard
- Daily cap routine runs per account
- One-off NON conta verso daily cap (ma sì verso sub usage)
- Extra usage abilitabile per overage

### Ultraplan (research preview, da v2.1.91)
> "Hands a planning task from your local CLI to a Claude Code on the web session running in plan mode."

**Requisiti**: web account + GitHub repo. NON disponibile su Bedrock/Vertex/Foundry.

**Launch** (3 modi):
1. `/ultraplan migrate auth from sessions to JWTs`
2. Keyword `ultraplan` in normal prompt
3. Da local plan dialog: "No, refine with Ultraplan on Claude Code on the web"

Confirmation dialog (skipped per path 3). Remote Control si disconnette automaticamente (entrambi occupano claude.ai/code).

**Status indicators**:
- `◇ ultraplan` — drafting
- `◇ ultraplan needs your input` — clarifying question
- `◆ ultraplan ready` — review nel browser

`/tasks` → entry ultraplan → session link, agent activity, **Stop ultraplan**.

**Browser review view**:
- Inline comments (highlight passage)
- Emoji reactions
- Outline sidebar
- Iterate finché soddisfatto

**Execute (3 opzioni dal browser)**:
1. **Approve and start coding** (web): runa nella stessa cloud session, review diff via web, create PR
2. **Approve and teleport back to terminal**: web archivata; terminale dialog "Ultraplan approved":
   - **Implement here** (inject in current conversation)
   - **Start new session** (clear + plan as context, prints `claude --resume <id>` per ritornare)
   - **Cancel** (save plan to file, prints path)
3. (Implicit) Cancel from browser

Da v2.1.101: auto-creazione default cloud environment se mancante.

### Ultrareview (research preview, da v2.1.86)
> "Run a deep, multi-agent code review in the cloud with /ultrareview to find and verify bugs before you merge."

**vs `/review`**:
| | `/review` | `/ultrareview` |
|---|---|---|
| Runs | Locally | Remote sandbox |
| Depth | Single-pass | Multi-agent fleet + verification |
| Duration | Seconds-minutes | 5-10 min |
| Cost | Plan usage | Free runs (3 Pro/Max → 5 mag 2026), poi $5-$20 extra usage |
| Best for | Iteration | Pre-merge confidence |

**Vantaggi**:
- High signal: ogni finding verificato indipendentemente
- Broad coverage: molti reviewer in parallelo
- No local resource

**Auth**: claude.ai account (no API key only). NON disponibile su Bedrock/Vertex/Foundry, ZDR organizations.

**Sintassi**:
```
/ultrareview              # diff branch vs default + uncommitted/staged
/ultrareview 1234         # review GitHub PR (clone diretto, requires github.com remote)
```

Pre-launch dialog: scope (file/line count), free runs rimanenti, cost estimate. Solo user-invocable (Claude non auto-spawn).

**Pricing**:
| Plan | Free runs | After |
|---|---|---|
| Pro | 3 free runs through May 5, 2026 | extra usage |
| Max | 3 free runs through May 5, 2026 | extra usage |
| Team / Enterprise | none | extra usage |

3 runs = one-time, no refresh, scadono 5 mag 2026. Extra usage **must be enabled** (organization). `/extra-usage` per check/change.

**Run management**: 5-10 min, background. `/tasks` per detail/stop. Stop archivia, no partial findings. Findings = notifica con file location + spiegazione.

> Fonti: `/en/scheduled-tasks`, `/en/routines`, `/en/ultraplan`, `/en/ultrareview`, `/en/tools-reference#monitor-tool`.

---

## 16. Changelog feb→apr 2026

### Week 13 (March 23–27, 2026, v2.1.83–v2.1.85)
**Lancio Auto mode** (research preview): classifier model gestisce permission prompts; safe actions auto, risky bloccate.
- Computer use in Desktop app
- PR auto-fix on Web
- Transcript search con `/`
- **Native PowerShell tool** per Windows (rolling out, opt-in Linux/macOS via `pwsh`)
- Conditional `if` hooks
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

### Versioni dettagliate (estratte da `/en/changelog`)

**v2.1.119 (23 apr)** — `/config` settings persist con precedence project/local/policy; `prUrlTemplate` per custom code-review URL; `CLAUDE_CODE_HIDE_CWD`; `--from-pr` accepts GitLab MR/Bitbucket PR/GHE; PowerShell auto-approvable; PostToolUse hooks include `duration_ms`; MCP server reconfiguration parallela.

**v2.1.118 (23 apr)** — **Vim visual mode** (`v`) + visual-line (`V`); `/usage` unifica `/cost` + `/stats`; **custom themes** in `~/.claude/themes/`; **Hooks `mcp_tool` type**; `DISABLE_UPDATES` env; `--continue`/`--resume` finds `--add-dir` sessions; `/color` syncs Remote Control.

**v2.1.117 (22 apr)** — Forked subagents su external builds (`CLAUDE_CODE_FORK_SUBAGENT=1`); agent frontmatter `mcpServers` per main-thread agent sessions; `/model` selections persist con project pins; **plugin dependencies auto-install**; managed-settings `blockedMarketplaces`/`strictKnownMarketplaces` enforced; **default effort `high` per Pro/Max su Opus 4.6 + Sonnet 4.6**; cleanup retention `~/.claude/tasks/`, `~/.claude/shell-snapshots/`, `~/.claude/backups/`.

**v2.1.116 (20 apr)** — **`/resume` 67% più veloce** (40MB+ sessions); smoother fullscreen scrolling VS Code/Cursor/Windsurf; thinking spinner progress inline; `/config` search; `/doctor` apribile durante response; `/reload-plugins` auto-install missing deps; Bash hint rate-limit GitHub.

**v2.1.114 (18 apr)** — Crash permission dialog agent teammate fix.

**v2.1.113 (17 apr)** — **CLI spawna native binary** (per-platform optional dep); `sandbox.network.deniedDomains`; fullscreen Shift+↑/↓ scroll viewport; `Ctrl+A`/`Ctrl+E` start/end logical line multiline; URL wrapping clickable con OSC 8 hyperlinks; `/loop` Esc cancel pending wakeups; `/extra-usage` from Remote Control.

**v2.1.112 (16 apr)** — Fix "claude-opus-4-7 temporarily unavailable" auto mode.

**v2.1.111 (16 apr)** — **Claude Opus 4.7 xhigh availability**; **Auto mode per Max subscribers su Opus 4.7**; **Effort level `xhigh`** (tra `high` e `max`); `/effort` interactive slider; **"Auto (match terminal)" theme**; `/fewer-permission-prompts` skill; **`/ultrareview` general availability**; auto mode senza `--enable-auto-mode`; PowerShell tool gradual rollout; read-only bash glob + `cd <project-dir> &&` no prompt; CLI typo suggestion; plan files named (`fix-auth-race-snug-otter.md`); `/skills` sort by token; `Ctrl+U` clear input buffer; `Ctrl+L` redraw + clear; headless `plugin_errors` init event; `OTEL_LOG_RAW_API_BODIES`.

**v2.1.110 (15 apr)** — `/tui` fullscreen flicker-free; **push notification tool Remote Control**; `Ctrl+O` toggle normal/verbose; `autoScrollEnabled`; `Ctrl+G` external editor; `/plugin` Installed tab favorite/attention top; `/doctor` MCP multi-scope warning; `--resume`/`--continue` resurrecting unexpired scheduled tasks; `/context`, `/exit`, `/reload-plugins` su Remote Control; Write tool IDE diff acceptance notify; Bash max timeout enforcement; SDK/headless `TRACEPARENT`/`TRACESTATE` distributed trace; session recap per `DISABLE_TELEMETRY` users.

**v2.1.109 (15 apr)** — Extended-thinking indicator rotating progress.

**v2.1.108 (14 apr)** — `ENABLE_PROMPT_CACHING_1H` opt-in 1h TTL; `FORCE_PROMPT_CACHING_5M`; **session recap returning context** configurable `/recap`; **model built-in slash commands discovery via Skill tool**; `/undo` alias `/rewind`; `/model` mid-conversation switch warning; `/resume` picker default current dir, Ctrl+A all projects; rate limits vs plan usage distinction; closest match suggestion unknown commands; ridotto memory footprint file reads.

**v2.1.107 (14 apr)** — Thinking hints sooner long ops.

**v2.1.106 (13 apr)** — `EnterWorktree` `path` param existing worktree; **`PreCompact` hook support** (exit 2 / `decision: block`); **plugin background monitor support** (`monitors` manifest); `/proactive` alias `/loop`; stalled API stream 5-min abort + non-streaming retry; `/doctor` status icons + `f` Claude fix; `/config` labels clarity; **skill description 250→1,536 chars cap**; `WebFetch` strip CSS-heavy pages; stale agent worktree cleanup squash-merged PR; MCP large-output truncation format-specific; token counts ≥1M display "1.5m".

**v2.1.105 (13 apr)** — *(non documentato nel changelog).*

**v2.1.104 (12 apr)** — *(non documentato nel changelog).*

**v2.1.103 (12 apr)** — *(non documentato nel changelog).*

**v2.1.102 (11 apr)** — *(non documentato nel changelog).*

**v2.1.101 (10 apr)** — `/team-onboarding` teammate ramp-up guide; OS CA cert store trust default (`CLAUDE_CODE_CERT_STORE=bundled` override); **`/ultraplan` remote-session auto-create default cloud env**; brief mode retry plain text; focus mode self-contained summaries; tool-not-available errors why/proceed; rate-limit retry limit/reset; refusal error API explanation; `claude -p --resume <name>`; settings resilience unrecognized hook event; plugin force-enabled managed settings hook run; `/plugin` `claude plugin update` marketplace warning; plan mode "Refine with Ultraplan" remote capability check; beta tracing `OTEL_LOG_USER_PROMPTS`/`TOOL_DETAILS`/`TOOL_CONTENT`; SDK `query()` cleanup subprocess/temp.

**v2.1.100 e precedenti** — coperto da release notes settimanali week 13/14/15.

> Fonte master: https://code.claude.com/docs/en/changelog (o GitHub mirror https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md). Settimanali: https://code.claude.com/docs/en/whats-new/index

---

## Note finali per la riscrittura della repo

### Highlight cambiamenti chiave dal 15 feb 2026
1. **Auto mode** (w13, v2.1.83) — feature flagship research preview
2. **Computer use CLI + Desktop** (w13–w14)
3. **PowerShell tool nativo** (w13)
4. **`/ultrareview`** (w14, v2.1.86)
5. **Ultraplan** (w15, v2.1.91)
6. **Monitor tool** (v2.1.98)
7. **`/loop` evoluzione self-pacing**
8. **Plugin background monitors** (v2.1.106)
9. **Hooks `mcp_tool` type + `PreCompact`** (v2.1.106, 2.1.118)
10. **Opus 4.7 + xhigh effort** (v2.1.111)
11. **Flicker-free fullscreen** (`/tui`, v2.1.110)
12. **Vim visual mode** (v2.1.118)
13. **`/team-onboarding` + `/autofix-pr`** (w15)
14. **Skill description cap 1,536 char** (v2.1.106)
15. **Routines** (research preview, web/desktop/CLI con `/schedule`)

### Aree non documentate pubblicamente (al 27 apr 2026)
- Plan mode standalone page (404 su `/en/plan-mode`) — coperto inline su `/en/permission-modes`
- Checkpoints via `/en/checkpoints` (404) — esiste come `/en/checkpointing`
- Monitor page standalone (404) — coperto in `/en/tools-reference#monitor-tool`
- Pricing dettagliato Opus 4.7 — non in docs

### File cross-reference rilevanti
- Index completo docs: https://code.claude.com/docs/llms.txt (117 documenti)
- Changelog: https://code.claude.com/docs/en/changelog (versione per versione)
- What's new weekly: https://code.claude.com/docs/en/whats-new/index
- GitHub mirror changelog: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Demo plugins marketplace: https://github.com/anthropics/claude-code/tree/main/plugins (`claude-code-plugins`)
- Sandbox runtime open source: https://github.com/anthropic-experimental/sandbox-runtime
- Agent SDK demos: https://github.com/anthropics/claude-agent-sdk-demos
- Agent SDK TS: https://github.com/anthropics/claude-agent-sdk-typescript
- Agent SDK Python: https://github.com/anthropics/claude-agent-sdk-python
