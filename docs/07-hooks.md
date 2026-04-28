# 07 — Hooks

> 📍 [README](../README.md) → [Estensibilita'](../README.md#estensibilita) → **07 Hooks**
> 🔧 Operational · 🔴 Advanced

Gli hook permettono di intercettare deterministicamente il lifecycle di Claude Code: 28+ eventi, 5 tipi di handler, condizioni `if`, scope multipli.

## Cosa e' concettualmente

> Gli hook sono **interrupt deterministici** del lifecycle agent. Sono il modo in cui dichiari **regole non negoziabili** che il modello non puo' aggirare: il check viene eseguito da uno script (shell, HTTP, MCP tool), non dall'LLM. Layer 3 dell'Authority dell'harness.

**Modello mentale**: come i `pre-commit` hook di git, ma per ogni evento del ciclo di vita dell'agent (PreToolUse, PostToolUse, Stop, Notification, ...). Deterministici per definizione.

**Componente harness IMPACT**: Authority (Layer 3) + Control flow (lifecycle injection).

**Per il deep-dive**: [04b — Authority model § Layer 3](./04b-authority-model.md#layer-3-—-hooks-custom-logic).

> Fonte: [`/en/hooks`](https://code.claude.com/docs/en/hooks).

---

## 7.1 Eventi supportati (28+)

| Evento | Quando fire | Bloccabile? |
|---|---|---|
| `SessionStart` | Inizio o resume sessione | No |
| `SessionEnd` | Termine sessione | No |
| `UserPromptSubmit` | Prompt utente prima di processing | Si' |
| `UserPromptExpansion` | Slash command appena espanso | Si' |
| `PreToolUse` | Prima di tool call | Si' |
| `PermissionRequest` | Permission dialog | Si' |
| `PermissionDenied` | Auto mode classifier nega | No |
| `PostToolUse` | Tool success | No |
| `PostToolUseFailure` | Tool fail | No |
| `PostToolBatch` | Fine batch parallelo | Si' |
| `Stop` | Claude termina turn | Si' |
| `StopFailure` | Turn ends per API error | No |
| `Notification` | Notifica Claude Code | No |
| `SubagentStart` / `SubagentStop` | Subagent spawn / finish | Stop=Si' |
| `TaskCreated` / `TaskCompleted` | Task list events | Si' |
| `TeammateIdle` | Teammate sta per idle (Agent Teams) | Si' |
| `InstructionsLoaded` | CLAUDE.md / rules caricati | No |
| `ConfigChange` | Config file cambia | Si' |
| `CwdChanged` | cwd cambia | No |
| `FileChanged` | File watched cambia | No |
| `WorktreeCreate` / `WorktreeRemove` | Worktree events | Create=Si' |
| `PreCompact` (da v2.1.106) | Prima di compaction | Si' |
| `PostCompact` | Dopo compaction | No |
| `Elicitation` / `ElicitationResult` | MCP server input request | Si' |

---

## 7.2 Anatomia (`settings.json`)

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

Conditional `if:` (da v2.1.83): permette di matchare pattern fini-grained dentro lo stesso evento+tool.

---

## 7.3 Cinque tipi di handler

1. **`command`** — esegue uno shell script
   - Input via stdin JSON (event payload)
   - Output via stdout (JSON) + exit code
   - Errori su stderr

2. **`http`** — POST con JSON body verso URL
   - Header configurabili
   - `allowedEnvVars` (whitelist) per secret in env
   - Timeout configurabile

3. **`mcp_tool`** (da v2.1.118) — chiama un tool di un server MCP
   - Output formato come `command`

4. **`prompt`** — single-turn al model con yes/no decision

5. **`agent`** — spawna subagent (Read, Grep, Glob), restituisce decision JSON

---

## 7.4 Matcher syntax

- `*` o `""` o omesso → match all
- Solo `[A-Za-z0-9_|]` → exact o list (`Bash`, `Edit|Write`)
- Altri caratteri → JS regex (`^Notebook`, `mcp__memory__.*`)

---

## 7.5 Exit codes (handler `command`)

| Exit | Significato |
|---|---|
| `0` + JSON output | Process decision |
| `2` | Blocking, stderr → Claude (motivazione) |
| altro | Non-blocking, stderr → log |

---

## 7.6 Output JSON tipici

### PreToolUse

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow|deny|ask|defer",
    "permissionDecisionReason": "...",
    "updatedInput": { "field": "modified" },
    "additionalContext": "..."
  }
}
```

### Top-level (UserPromptSubmit, PostToolUse, Stop)

```json
{
  "decision": "block",
  "reason": "...",
  "additionalContext": "..."
}
```

---

## 7.7 Scope dei hook

| Scope | Path |
|---|---|
| User-wide | `~/.claude/settings.json` |
| Project (git-shared) | `.claude/settings.json` |
| Project (gitignore) | `.claude/settings.local.json` |
| Plugin | `<plugin>/hooks/hooks.json` |
| Skill / Agent | frontmatter `hooks:` (component-scoped) |

Da v2.1.0: hooks possono stare direttamente nel frontmatter di skill e agent, scoped al componente.

---

## 7.8 Esempi pratici

### 1. Blocca `rm -rf` su path critici

`.claude/hooks/block-rm.sh`:
```bash
#!/bin/bash
read -r EVENT
PATTERN=$(echo "$EVENT" | jq -r '.tool_input.command')
if [[ "$PATTERN" == *"rm -rf"* && "$PATTERN" == *"/"* ]]; then
  echo '{"decision":"block","reason":"rm -rf su / bloccato"}'
  exit 0
fi
exit 0
```

```json
{
  "hooks": {
    "PreToolUse": [
      { "matcher": "Bash", "hooks": [{ "type": "command", "command": ".claude/hooks/block-rm.sh" }] }
    ]
  }
}
```

### 2. Linter automatico post-edit

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [{ "type": "command", "command": "npm run lint:fix" }]
      }
    ]
  }
}
```

### 3. Nudge fine-turno (tip Boris Cherny)

> "Set up hooks. Hooks are a way to deterministically hook into Claude's lifecycle. Use them to: Automatically route permission requests to Slack or Opus; Nudge Claude to keep going when it reaches the end of a turn (you can even kick off an agent or use a prompt to decide..." — [@bcherny](https://x.com/bcherny/status/2021701059253874861)

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [{
          "type": "prompt",
          "prompt": "Hai completato tutto il task? Se no, continua. Se si', conferma e ferma."
        }]
      }
    ]
  }
}
```

### 4. Slack approval per permission request

```json
{
  "hooks": {
    "PermissionRequest": [
      {
        "hooks": [{
          "type": "http",
          "url": "https://hooks.slack.com/...",
          "allowedEnvVars": ["SLACK_WEBHOOK"]
        }]
      }
    ]
  }
}
```

### 5. PreCompact hook (da v2.1.106)

```json
{
  "hooks": {
    "PreCompact": [
      {
        "hooks": [{
          "type": "command",
          "command": "echo 'Salvataggio stato pre-compact' && ./scripts/snapshot.sh"
        }]
      }
    ]
  }
}
```

Exit 2 / `decision: block` → blocca compaction.

---

## 7.9 Disabilitazione e safety

- `disableAllHooks: true` (managed)
- `allowManagedHooksOnly: true`
- `allowedHttpHookUrls: [...]`
- `httpHookAllowedEnvVars: [...]`

Slow helper warning se hook >10s. PostToolUse hooks da v2.1.119 includono `duration_ms`.

---

## 7.10 Fonti / annunci

- Docs: [`/en/hooks`](https://code.claude.com/docs/en/hooks)
- Tip Boris su hooks: [@bcherny](https://x.com/bcherny/status/2021701059253874861)
- `mcp_tool` hook type: v2.1.118 (23 apr 2026)
- `PreCompact`: v2.1.106 (13 apr 2026)
- Conditional `if:`: v2.1.83 (24 mar 2026)

---

← [06 CLAUDE.md + memory](./06-claude-md-memory.md) · Successivo → [08 Subagents](./08-subagents.md)
