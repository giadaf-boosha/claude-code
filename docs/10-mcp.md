# 10 — MCP (Model Context Protocol)

MCP e' il protocollo open per collegare LLM a tool esterni (DB, API, file, app). Donato a Linux Foundation a dicembre 2025.

> Fonte: [`/en/mcp`](https://code.claude.com/docs/en/mcp).

---

## 10.1 Configurazione base

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    },
    "github-remote": {
      "type": "http",
      "url": "https://mcp.githubapp.com/v1/sse",
      "headers": { "Authorization": "Bearer ${GITHUB_TOKEN}" }
    }
  }
}
```

---

## 10.2 Transports

| Transport | Quando |
|---|---|
| `stdio` | Server eseguito come comando locale (default) |
| `http` / `sse` | Server remoto su URL |

---

## 10.3 Comandi

```bash
claude mcp add <name>            # CLI wizard
claude mcp serve                 # gestione
/mcp                              # UI interattiva (in sessione) + OAuth
--mcp-config <file-or-json>       # ripetibile
--strict-mcp-config               # solo server elencati
```

---

## 10.4 Scope settings

| Campo | Effetto |
|---|---|
| `enabledMcpjsonServers` | Whitelist server da `.mcp.json` |
| `disabledMcpjsonServers` | Blacklist |
| `enableAllProjectMcpServers` | Abilita tutti i server progetto |
| `allowedMcpServers` / `deniedMcpServers` | Allow/deny rules |
| `allowManagedMcpServersOnly` | Enterprise: solo server policy |

---

## 10.5 MCP Registry ufficiale

Anthropic mantiene un registry pubblico:
```
https://api.anthropic.com/mcp-registry/v0/servers
```

Server "commercial" includono: GitHub, GitLab, Atlassian, Slack, Notion, Figma, Vercel, Sentry, Linear, Asana, Firebase, Supabase, ecc.

> 770+ MCP server censiti tra ufficiali e community (riferimento: [claudemarketplaces.com](https://claudemarketplaces.com)).

---

## 10.6 MCP tool search (scale)

Per server con molti tool, Claude Code carica gli schemi **on-demand** via `ToolSearch`. Quando un tool diventa rilevante per il task, viene "promosso" e diventa direttamente chiamabile.

> Fonte: [`/en/mcp#scale-with-mcp-tool-search`](https://code.claude.com/docs/en/mcp#scale-with-mcp-tool-search).

Vantaggi:
- Riduce token consumption all'avvio
- Permette di tenere connessi decine di server senza esplodere il context

---

## 10.7 MCP prompts come slash commands

I server possono esporre prompts che diventano automaticamente:
```
/mcp__<server>__<prompt>
```

Discovery: `/mcp` mostra tutti i prompts dei server connessi.

---

## 10.8 Channels (research preview)

Server MCP possono **pushare eventi** nella sessione attiva (notifications real-time invece di polling). Tipici use case: Telegram, Discord, iMessage, webhook custom.

CLI:
```bash
claude --channels    # ascolta eventi Channels
```

Settings:
```json
{
  "channelsEnabled": true,
  "allowedChannelPlugins": ["telegram", "discord"]
}
```

> Fonte: [`/en/channels`](https://code.claude.com/docs/en/channels).

---

## 10.9 Permission per tool MCP

Sintassi nelle deny/allow rules:
```
MCP(server)            // tutti i tool del server
MCP(server *)          // prefix match
MCP(server.tool)       // tool specifico
```

---

## 10.10 Per-tool result-size override

Da v2.1.94 (Week 14):
```json
{
  "mcpResultSizeOverrides": {
    "playwright.screenshot": 524288,    // 500KB per questo tool
    "github.fetch_pr": 65536
  }
}
```

Default cap: ~25KB. Se troppo basso, tool restituiscono "TRUNCATED".

---

## 10.11 OAuth per server remoti

I server HTTP/SSE possono richiedere OAuth. Flow:
1. `/mcp` → seleziona server → Authorize
2. Browser apre OAuth provider
3. Redirect locale → token salvato in keychain
4. Refresh automatico

Esempio: server GitHub remoto, Linear, Asana, Notion, Atlassian.

---

## 10.12 Tips operative

1. **MCP > custom CLI tool** quando il tool serve a piu' Claude Code session.
2. **Stdio per local-only** (es. database in dev), HTTP per shared (es. servizio team).
3. **`--strict-mcp-config`** in CI per riproducibilita'.
4. **Channels per real-time**: invece di `/loop` polling, lascia che il server pushi gli eventi.
5. **Restringi permessi MCP** specialmente in plan/auto mode: alcuni tool MCP possono fare azioni con effetto esterno (POST, delete).
6. **Valuta tool search** se hai molti server connessi: meno token in init.

---

## 10.13 Risorse

- Specifica MCP: https://modelcontextprotocol.io
- Server ufficiali: vedi `claude mcp list` o registry
- Community list: https://github.com/punkpeye/awesome-mcp-servers
- Marketplace plugin con MCP integrati: https://claudemarketplaces.com

---

← [09 Skills](./09-skills.md) · Successivo → [11 Plugins & Marketplace](./11-plugins-marketplace.md)
