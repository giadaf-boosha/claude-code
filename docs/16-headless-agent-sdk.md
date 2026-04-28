# 16 — Headless & Agent SDK

> 📍 [README](../README.md) → [Integrazione](../README.md#integrazione) → **16 Headless & Agent SDK**
> 🔧 Operational · 🟡 Intermediate

Per usare Claude Code in **CI/CD**, **batch**, o come **libreria** in app Python/TypeScript.

## Cosa e' concettualmente

> Il headless mode espone l'harness Claude Code come **componente embeddabile**: stessa engine ma senza UI interattiva, output strutturato (text/json/stream-json), modalita' bare per CI riproducibili. L'Agent SDK e' la versione "library" — si integra in app Python/TS e mantiene tutte le capabilities (hooks, MCP, subagent, skills, memory) configurabili programmaticamente.

**Modello mentale**: come `npx <tool>` vs `import {tool} from 'package'` — stesso engine, due interfacce, library e CLI.

**Componente harness IMPACT**: trasversale (espone tutto l'harness) + ottimizzato per riproducibilita' (`--bare`).

**Per il deep-dive**: [00 — Harness overview](./00-harness-overview.md) per quando usare CC vs SDK leggero.

---

## 16.1 CLI Headless (`-p`)

```bash
claude -p "Find and fix the bug in auth.ts" --allowedTools "Read,Edit,Bash"
```

### Output formats

| Format | Quando |
|---|---|
| `text` (default) | Human-readable |
| `json` | One-shot result JSON |
| `stream-json` | NDJSON real-time (events streamed) |

### Bare mode (`--bare`)

Skip auto-discovery (hooks, skills, plugins, MCP, auto-memory, CLAUDE.md). **Will be default for `-p`** in future releases.

Requires `ANTHROPIC_API_KEY` o `apiKeyHelper` (NON legge `CLAUDE_CODE_OAUTH_TOKEN` ne' keychain in bare mode).

### Stream events
- `system/init` (with `plugins`, `plugin_errors`)
- `system/api_retry` (con `attempt`, `max_retries`, `retry_delay_ms`, `error_status`, `error`)
- `system/plugin_install` (sotto `CLAUDE_CODE_SYNC_PLUGIN_INSTALL`)
- `stream_event` (text deltas)

### Structured outputs

```bash
claude -p "Estrai entita' dal documento" \
  --output-format json \
  --json-schema '{"type":"object","properties":{"entities":{"type":"array"}}}'
```
→ campo `structured_output` validato.

### Auto-approve in CI

```bash
claude -p "..." --allowedTools "Read,Edit" --permission-mode dontAsk
```

Modi: `acceptEdits`, `dontAsk`, `bypassPermissions` (in container/CI).

> Fonte: [`/en/headless`](https://code.claude.com/docs/en/headless).

---

## 16.2 Agent SDK

> "Build production AI agents with Claude Code as a library" — [`/en/agent-sdk/overview`](https://code.claude.com/docs/en/agent-sdk/overview)

Renamed da Claude Code SDK. Migration guide: [`/en/agent-sdk/migration-guide`](https://code.claude.com/docs/en/agent-sdk/migration-guide).

### Install

```bash
# TypeScript
npm install @anthropic-ai/claude-agent-sdk

# Python
pip install claude-agent-sdk
```

> TypeScript SDK bundles native binary as optional dependency (no separate install needed).

### TypeScript example

```typescript
import { query } from "@anthropic-ai/claude-agent-sdk";

for await (const message of query({
  prompt: "Find and fix the bug in auth.ts",
  options: {
    allowedTools: ["Read", "Edit", "Bash"],
    model: "claude-sonnet-4-6",
    permissionMode: "acceptEdits"
  }
})) {
  console.log(message);
}
```

### Python example

```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

async def main():
    async for message in query(
        prompt="Find and fix the bug in auth.py",
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Edit", "Bash"],
            model="claude-sonnet-4-6",
        ),
    ):
        print(message)

asyncio.run(main())
```

### Capabilities

- **Built-in tools**: Read, Write, Edit, Bash, Monitor, Glob, Grep, WebSearch, WebFetch, AskUserQuestion
- **Hooks**: callback functions (PreToolUse, PostToolUse, Stop, SessionStart/End, UserPromptSubmit, ecc.)
- **Subagents**: option `agents:` + Agent tool
- **MCP**: option `mcpServers:`, full registry
- **Permissions**: `allowedTools`, `permissionMode`
- **Sessions**: capture `session_id`, `resume` per continuare

### Filesystem features caricate

L'SDK carica automaticamente, dal cwd e da `~/.claude/`:
- Skills (`.claude/skills/*/SKILL.md`)
- Slash commands (`.claude/commands/*.md`)
- Memory (CLAUDE.md, `.claude/CLAUDE.md`)
- Plugins (programmatici via `plugins` option)

`setting_sources` (Python) / `settingSources` (TS) per limitare cosa caricare:
```python
ClaudeAgentOptions(setting_sources=["project"])
```

### Provider auth

| Variabile | Effetto |
|---|---|
| `ANTHROPIC_API_KEY` | Default |
| `CLAUDE_CODE_USE_BEDROCK=1` | Bedrock |
| `CLAUDE_CODE_USE_VERTEX=1` | Vertex AI |
| `CLAUDE_CODE_USE_FOUNDRY=1` | Microsoft Foundry |

> claude.ai login NON permesso per terze parti via SDK.

### Opus 4.7 requirement
Agent SDK v0.2.111+. Errore `thinking.type.enabled` → upgrade.

### Branding (per partner)
"Claude Agent" o "Claude" (preferito). NON "Claude Code" o "Claude Code Agent".

### Changelog SDK separati

- TypeScript: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
- Demos: https://github.com/anthropics/claude-agent-sdk-demos

> Fonti aggregate: `/en/agent-sdk/overview`, `/en/agent-sdk/python`, `/en/agent-sdk/typescript`, `/en/agent-sdk/quickstart`, `/en/agent-sdk/hooks`, `/en/agent-sdk/sessions`, `/en/agent-sdk/permissions`, `/en/agent-sdk/skills`, `/en/agent-sdk/slash-commands`, `/en/agent-sdk/subagents`, `/en/agent-sdk/mcp`, `/en/agent-sdk/structured-outputs`, `/en/agent-sdk/streaming-output`, `/en/agent-sdk/custom-tools`, `/en/agent-sdk/file-checkpointing`, `/en/agent-sdk/observability`, `/en/agent-sdk/secure-deployment`, `/en/agent-sdk/hosting`, `/en/agent-sdk/cost-tracking`, `/en/agent-sdk/agent-loop`, `/en/agent-sdk/user-input`, `/en/agent-sdk/todo-tracking`, `/en/agent-sdk/tool-search`.

---

## 16.3 GitHub Actions / CI

```yaml
- name: Claude Code review
  run: |
    npm install -g @anthropic-ai/claude-code
    claude setup-token   # one-time, stores OAuth token
    claude -p "Review changes in PR ${{ github.event.pull_request.number }}" \
      --allowedTools "Read,Bash(git *)" \
      --permission-mode dontAsk \
      --output-format json > review.json
  env:
    ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
```

`/install-github-app` setup integrato. Code Review (PR agents) GA su Team/Enterprise (vedi [15](./15-ultraplan-ultrareview.md#code-review-pr-agents---feature-correlata)).

---

## 16.4 Tips operative

1. **`--bare` in CI**: skippa discovery che non serve, riduce overhead.
2. **`--max-budget-usd 5.00`** in pipeline costose.
3. **Structured output con JSON Schema**: il modo migliore per estrarre dati strutturati riproducibilmente.
4. **`claude setup-token`** (1 anno OAuth) per CI invece di `ANTHROPIC_API_KEY`.
5. **MCP server da CI**: usa `--mcp-config` con file dedicato in repo, `--strict-mcp-config` per riproducibilita'.
6. **Stream-json per pipeline real-time**: utile per dashboards.
7. **Distributed tracing**: `TRACEPARENT`, `TRACESTATE`, `OTEL_LOG_RAW_API_BODIES` (v2.1.110, v2.1.111).

---

## 16.5 Risorse

- Headless docs: https://code.claude.com/docs/en/headless
- Agent SDK overview: https://code.claude.com/docs/en/agent-sdk/overview
- Quickstart: https://code.claude.com/docs/en/agent-sdk/quickstart
- TypeScript repo: https://github.com/anthropics/claude-agent-sdk-typescript
- Python repo: https://github.com/anthropics/claude-agent-sdk-python
- Demos: https://github.com/anthropics/claude-agent-sdk-demos

---

← [15 Ultraplan & Ultrareview](./15-ultraplan-ultrareview.md) · Successivo → [17 IDE & surface](./17-ide-surface.md)
