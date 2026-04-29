# 03 — Slash commands

> 📍 [README](../README.md) → [Fondamenta](../README.md#fondamenta) → **03 Slash commands**
> 🔧 Operational · 🟢 Beginner-friendly

Riferimento completo dei comandi `/` built-in e bundled skills al 2.1.119. Type `/` in sessione per vederli filtrati. Convenzione: **[Skill]** = bundled skill (prompt-based, anche auto-invocabile da Claude); altri = built-in CLI.

## Cosa e' concettualmente

> Gli slash commands sono il **vocabolario condiviso** tra utente e agent. Sono shortcut a workflow ricorrenti: ognuno e' un'intent capture pre-codificato. I bundled skills (`/loop`, `/simplify`, `/batch`, `/debug`) sono skill markdown auto-installate; i built-in (`/plan`, `/compact`, `/effort`) sono comandi nativi del CLI.

**Modello mentale**: come le funzioni built-in di una shell vs gli script in `~/bin`. Stessa cosa, due classi.

**Componente harness IMPACT**: Tool layer (espongono capabilities) + Intent capture (riducono ambiguita' del prompt).

**Per il deep-dive**: [09 — Skills](./09-skills.md) per come scrivere i tuoi.

---

## 3.1 Tabella completa

| Comando | Tipo | Funzione |
|---|---|---|
| `/add-dir <path>` | built-in | Aggiunge working directory file-access |
| `/agents` | built-in | Gestione [subagents](./08-subagents.md) |
| `/autofix-pr [prompt]` | built-in | Spawn web session che watcha la PR e pusha fix su CI failure / review comment (richiede `gh`) |
| `/batch <instruction>` | **Skill** | Refactor large-scale: 5-30 unit, 1 worktree+PR per agente |
| `/branch [name]` (alias `/fork`) | built-in | Branch della conversazione |
| `/btw <question>` | built-in | Side question senza inquinare la conversation |
| `/chrome` | built-in | Configura Claude in Chrome |
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
| `/fast [on\|off]` | built-in | Toggle [fast mode](./05-fast-mode-1m-context.md) (Opus 4.6) |
| `/feedback [report]` (alias `/bug`) | built-in | Submit feedback |
| `/fewer-permission-prompts` | **Skill** | Scansiona transcript e crea allowlist read-only |
| `/focus` | built-in | Focus view (solo ultimo prompt + risposta), fullscreen only |
| `/heapdump` | built-in | Heap snapshot per troubleshooting memoria |
| `/help` | built-in | Help comandi |
| `/hooks` | built-in | View hook configurations (read-only browser) |
| `/ide` | built-in | Manage integrazioni IDE |
| `/init` | built-in | Genera CLAUDE.md (con `CLAUDE_CODE_NEW_INIT=1` flow interattivo multi-fase) |
| `/insights` | built-in | Report analytics sessioni |
| `/install-github-app` | built-in | Setup GitHub Actions |
| `/install-slack-app` | built-in | Setup Slack OAuth |
| `/keybindings` | built-in | Apre/crea config keybindings |
| `/login` / `/logout` | built-in | Auth |
| `/loop [interval] [prompt]` (alias `/proactive`) | **Skill** | Re-run prompt: con interval (cron), senza interval (Claude self-paces), senza prompt (maintenance prompt o `loop.md`). Vedi [14](./14-loop-monitor.md) |
| `/mcp` | built-in | Manage MCP server + OAuth |
| `/memory` | built-in | Edita CLAUDE.md, toggle auto-memory |
| `/mobile` (alias `/ios`, `/android`) | built-in | QR code app mobile |
| `/model [model]` | built-in | Cambia modello, slider effort |
| `/passes` | built-in | Free week to friends (se eligible) |
| `/permissions` (alias `/allowed-tools`) | built-in | Manage allow/ask/deny rules |
| `/plan [description]` | built-in | Entra in plan mode (con task opzionale) |
| `/plugin` | built-in | Gestione [plugins](./11-plugins-marketplace.md) |
| `/powerup` | built-in | Lessons interattive con demo animati |
| `/privacy-settings` | built-in | Privacy (Pro/Max only) |
| `/recap` | built-in | One-line summary on demand |
| `/release-notes` | built-in | Changelog interattivo |
| `/reload-plugins` | built-in | Reload plugins live (no restart) |
| `/remote-control` (alias `/rc`) | built-in | Espone sessione a [Remote Control](./17-ide-surface.md#remote-control) |
| `/remote-env` | built-in | Configura env remote per `--remote` |
| `/rename [name]` | built-in | Rinomina sessione |
| `/resume [session\|PR-URL]` (alias `/continue`) | built-in | Riprende sessione per ID/nome; accetta URL di PR (GitHub, GitHub Enterprise, GitLab, Bitbucket) per trovare la sessione che ha creato quella PR (da v2.1.122) |
| `/review [PR]` | built-in | Code review locale (cf. `/ultrareview` per cloud) |
| `/rewind` (alias `/checkpoint`, `/undo`) | built-in | Checkpoint rewind |
| `/sandbox` | built-in | Toggle [sandbox mode](./04-modalita-permessi.md#sandbox) |
| `/schedule [description]` (alias `/routines`) | built-in | Gestione [routines](./13-routines-cloud.md) |
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
| `/ultraplan <prompt>` | built-in | [Plan in cloud](./15-ultraplan-ultrareview.md), review browser, execute remote o local |
| `/ultrareview [PR]` | built-in | [Multi-agent cloud code review](./15-ultraplan-ultrareview.md) (3 free runs Pro/Max → 5 mag 2026) |
| `/upgrade` | built-in | Upgrade plan |
| `/usage` | built-in | Cost + plan usage + activity |
| `/voice [hold\|tap\|off]` | built-in | Voice dictation (Claude.ai account) |
| `/web-setup` | built-in | Connect GitHub a Claude Code on the web |

> Fonte: [`/en/commands`](https://code.claude.com/docs/en/commands).

<sub>Aggiornato 2026-04-29 via daily what's new. Fonte: [changelog](https://code.claude.com/docs/en/changelog).</sub>

---

## 3.2 Comandi rimossi / migrati

| Comando | Stato | Sostituto |
|---|---|---|
| `/vim` | rimosso v2.1.92 | `/config` → Editor mode (Vim ora con visual mode `v`/`V` da v2.1.118) |
| `/pr-comments` | rimosso v2.1.91 | Chiedere a Claude direttamente sui commenti PR |

---

## 3.3 MCP prompts come comandi

I server MCP possono esporre prompts che diventano automaticamente comandi:

```
/mcp__<server>__<prompt>
```

Discovery dinamica: `/mcp` mostra prompts disponibili per ogni server connesso.

---

## 3.4 Skills custom come comandi

Qualsiasi skill che metti in `.claude/skills/<name>/SKILL.md` diventa `/<name>`.
Stesso per `.claude/commands/<name>.md` (legacy, ancora supportato).

I plugin namespace i loro comandi: `/<plugin>:<name>`.

---

## 3.5 Fonti / annunci

- `/loop` self-pacing: [@noahzweben](https://x.com/noahzweben/status/2042670949003153647)
- `/ultraplan`: [@trq212](https://x.com/trq212/status/2042671370186973589)
- `/ultrareview`: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2046999435239133246), [@claudeai](https://x.com/claudeai/status/2044785266590622185)
- Routines / `/schedule`: [@claudeai](https://x.com/claudeai/status/2044095086460309790)
- Remote Control: [@_catwu](https://x.com/_catwu/status/2026421789476401182)
- `/simplify` e `/batch`: [@bcherny](https://x.com/bcherny/status/2027534984534544489)
- `/loop` + `/schedule` (tip Boris): [@bcherny](https://x.com/bcherny/status/2038454341884154269)

---

← [02 CLI](./02-cli-installazione.md) · Successivo → [04 Modalita' permessi](./04-modalita-permessi.md)
