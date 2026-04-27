# 02 — CLI: installazione, comandi, flag

Reference completa CLI di Claude Code aggiornata a v2.1.119.

---

## 2.1 Installazione

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

> Native install ha **auto-update in background**. Homebrew/WinGet richiedono upgrade manuale (`brew upgrade --cask claude-code` / `winget upgrade Anthropic.ClaudeCode`).

Per disabilitare auto-update: `DISABLE_AUTOUPDATER=1`. Per forzare canale: `autoUpdatesChannel: "stable"|"latest"`.

---

## 2.2 Comandi CLI principali

| Comando | Descrizione |
|---|---|
| `claude` | Sessione interattiva |
| `claude "query"` | Sessione interattiva con prompt iniziale |
| `claude -p "query"` | Print/headless mode (SDK), poi exit |
| `claude -c` / `--continue` | Continua l'ultima conversazione nella cwd |
| `claude -r "<id-or-name>"` / `--resume` | Riprende sessione per ID o nome |
| `claude update` | Aggiorna alla versione piu' recente |
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
| `claude ultrareview [target]` | (v2.1.120) Lancia `/ultrareview` non-interattivo per CI/script |

Fonte: [`/en/cli-reference`](https://code.claude.com/docs/en/cli-reference).

---

## 2.3 Flag CLI selezionati (al 2.1.119)

### Modello e effort
- `--model claude-sonnet-4-6` — alias `sonnet`/`opus` o full ID
- `--effort low|medium|high|xhigh|max` — effort level (session-only)
- `--fallback-model sonnet` — fallback se primario overloaded (print only)

### Permessi
- `--permission-mode default|acceptEdits|plan|auto|dontAsk|bypassPermissions`
- `--allowedTools "Bash,Edit,Read"` — pre-approve tools
- `--tools "Bash,Edit,Read"` / `""` / `"default"` — restringe built-in tools
- `--allow-dangerously-skip-permissions` — aggiunge `bypassPermissions` al ciclo Shift+Tab
- `--dangerously-skip-permissions` — equivalente a `--permission-mode bypassPermissions`
- `--permission-prompt-tool <mcp-tool>` — gestore prompt non-interactive

### Sessione
- `--name`, `-n "feature-x"` — nome sessione (per `/resume`)
- `--resume`, `-r` / `--session-id <uuid>`
- `--fork-session` — con `--resume`/`--continue` crea nuovo session ID
- `--no-session-persistence` — non salva sessioni (print only)
- `--from-pr <num\|url>` — riprende sessione collegata a PR (GitHub, GitLab MR, Bitbucket, GHE)

### Headless / output
- `--print`, `-p` — non-interactive
- `--bare` — modalita' minimale per CI/SDK (skip auto-discovery, sara' default per `-p`)
- `--input-format` / `--output-format text|json|stream-json`
- `--json-schema '<schema>'` — structured outputs validati (print only)
- `--include-hook-events` / `--include-partial-messages` — stream-json output extra
- `--replay-user-messages` — re-emit user messages (stream-json)

### System prompt
- `--append-system-prompt[-file]` / `--system-prompt[-file]`
- `--exclude-dynamic-system-prompt-sections` — migliora cache hit cross-machine

### Agents/Plugins/MCP
- `--agent <name>` / `--agents '<json>'` — agent per la sessione / definizione dinamica
- `--plugin-dir <path>` — load plugin locale (ripetibile)
- `--mcp-config <file-or-json>` (ripetibile) / `--strict-mcp-config`
- `--betas` — beta headers (API key only)
- `--channels` — research preview, ascolto eventi Channels MCP

### Remote / web
- `--remote "<task>"` — crea web session su claude.ai
- `--remote-control "<name>"` (alias `--rc`) / `--remote-control-session-name-prefix`
- `--teleport` — pull web session in terminale
- `--ide` — connect automatico IDE all'avvio

### Worktree / tmux
- `--worktree`, `-w [name]` — worktree isolato in `<repo>/.claude/worktrees/<name>`
- `--tmux[=classic]` — crea tmux session per worktree
- `--teammate-mode auto|in-process|tmux` — display mode agent teams (sperimentale)

### Limiti / debug
- `--max-budget-usd 5.00` / `--max-turns N`
- `--debug "api,hooks"` / `--debug-file <path>`
- `--add-dir <path>...` — directory aggiuntive (file access, NON config)
- `--init` / `--init-only` / `--maintenance` — esegue hook di lifecycle
- `--setting-sources user,project,local` / `--settings <file-or-json>`
- `--disable-slash-commands`
- `--chrome` / `--no-chrome`
- `--verbose` / `--version`, `-v`

> Per la lista esaustiva: [`/en/cli-reference`](https://code.claude.com/docs/en/cli-reference).

---

## 2.4 Variabili d'ambiente principali

| Variabile | Effetto |
|---|---|
| `ANTHROPIC_API_KEY` | API key (default auth) |
| `ANTHROPIC_AUTH_TOKEN` | Bearer token (precedenza su API_KEY) |
| `CLAUDE_CODE_OAUTH_TOKEN` | OAuth long-lived (genera con `claude setup-token`) |
| `CLAUDE_CODE_USE_BEDROCK=1` | Provider Bedrock |
| `CLAUDE_CODE_USE_VERTEX=1` | Provider Vertex AI |
| `CLAUDE_CODE_USE_FOUNDRY=1` | Provider Microsoft Foundry |
| `CLAUDE_CODE_DISABLE_FAST_MODE=1` | Disabilita fast mode totalmente |
| `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` | Disabilita auto-memory |
| `CLAUDE_CODE_DISABLE_CRON=1` | Disabilita scheduler `/loop` |
| `CLAUDE_CODE_FORK_SUBAGENT=1` | Abilita `/fork` come spawn subagent |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` | Abilita Agent Teams sperimentali |
| `CLAUDE_CODE_HIDE_CWD=1` | Nasconde cwd dal status line (v2.1.119) |
| `CLAUDE_CODE_NEW_INIT=1` | Flow interattivo multi-fase per `/init` |
| `DISABLE_AUTOUPDATER=1` | Disabilita auto-update (CC + plugin) |
| `FORCE_AUTOUPDATE_PLUGINS=1` | Mantiene plugin auto-update con autoupdater off |
| `DISABLE_TELEMETRY=1` | Disabilita telemetria (e Monitor cloud features) |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1` | Same |
| `CLAUDE_CODE_API_KEY_HELPER_TTL_MS` | TTL custom per `apiKeyHelper` |
| `SLASH_COMMAND_TOOL_CHAR_BUDGET` | Cap char per skill (default 1% context, fallback 8000) |
| `ENABLE_PROMPT_CACHING_1H` | Opt-in 1h TTL cache (v2.1.108) |
| `FORCE_PROMPT_CACHING_5M` | Override TTL a 5m |

---

## 2.5 Diagnostica

```bash
claude --version           # versione installata
claude doctor              # health check (nel CLI: /doctor)
claude auth status         # stato auth
claude --debug "api,hooks" # debug categorie
```

`/doctor` ha modalita' "fix automatico" attivabile con `f`. `/heapdump` per troubleshooting memoria.

---

← [01 Snapshot](./01-snapshot.md) · Successivo → [03 Slash commands](./03-slash-commands.md)
