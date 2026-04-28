# 18 — Settings & Authentication

> 📍 [README](../README.md) → [Integrazione](../README.md#integrazione) → **18 Settings & Auth**
> 🔧 Operational · 🟡 Intermediate

Gerarchia settings, sintassi permessi, autenticazione (claude.ai, API key, Bedrock/Vertex/Foundry, OAuth).

## Cosa e' concettualmente

> I settings sono la **configurazione dichiarativa dell'harness**. Cinque livelli di precedenza (managed > CLI args > local project > shared project > user) permettono di stratificare regole: enterprise impone policy, team condivide convenzioni, dev override locali. La sintassi permission e' Layer 1 dell'Authority.

**Modello mentale**: come la gerarchia `.gitconfig` (system > global > local > worktree).

**Componente harness IMPACT**: Authority (Layer 1 + Layer 4 managed) + Intent (env vars).

**Per il deep-dive**: [04b — Authority model](./04b-authority-model.md) per i 4 layer di Authority.

---

## 18.1 Settings precedence (top to bottom)

1. **Managed** (cannot override): server-distributed, plist/registry, system `managed-settings.json`
   - macOS: `/Library/Application Support/ClaudeCode/`
   - Linux/WSL: `/etc/claude-code/`
   - Windows: `C:\Program Files\ClaudeCode\`
2. **Command-line args** (`--settings`, `--setting-sources`)
3. **Local project**: `.claude/settings.local.json` (gitignored)
4. **Shared project**: `.claude/settings.json` (git-shared)
5. **User**: `~/.claude/settings.json`

Array settings **merge** across scopes (concat + dedupe).

JSON Schema: `"$schema": "https://json.schemastore.org/claude-code-settings.json"` per autocomplete.

---

## 18.2 Campi principali (selezione)

### Model & effort
- `model`, `availableModels`, `modelOverrides`, `effortLevel`

### Permissions
- `allow`, `ask`, `deny`, `additionalDirectories`, `defaultMode`
- `disableBypassPermissionsMode`, `disableAutoMode`

### Env
```json
{ "env": { "KEY": "value" } }
```

### Auth
- `apiKeyHelper`, `awsCredentialExport`, `awsAuthRefresh`
- `otelHeadersHelper`, `forceLoginMethod`, `forceLoginOrgUUID`

### Sandbox
Vedi [4 Modalita' permessi § 4.4](./04-modalita-permessi.md#sandbox).

### Hooks
- `hooks`, `disableAllHooks`, `allowManagedHooksOnly`
- `allowedHttpHookUrls`, `httpHookAllowedEnvVars`

### TUI / display
- `tui`, `autoScrollEnabled`, `showTurnDuration`, `showThinkingSummaries`
- `editorMode`, `prefersReducedMotion`
- `spinnerTipsEnabled`, `spinnerVerbs`, `terminalProgressBarEnabled`
- `awaySummaryEnabled`

### Memory
- `autoMemoryEnabled`, `autoMemoryDirectory`, `cleanupPeriodDays`, `plansDirectory`

### Attribution (commit/PR)
- `attribution.commit` (false per `Co-Authored-By` removal)
- `attribution.pr`

### Plugins
- `enabledPlugins`, `extraKnownMarketplaces`
- `strictKnownMarketplaces`, `blockedMarketplaces`, `pluginTrustMessage`

### MCP
- `allowedMcpServers`, `deniedMcpServers`, `allowManagedMcpServersOnly`
- `enableAllProjectMcpServers`, `enabledMcpjsonServers`, `disabledMcpjsonServers`

### Advanced
- `alwaysThinkingEnabled`, `fastModePerSessionOptIn`
- `autoMode.soft_deny`, `useAutoModeDuringPlan`
- `defaultShell`, `outputStyle`, `language`, `voice.enabled`

### Worktree
- `worktree.symlinkDirectories`, `worktree.sparsePaths`

### Other
- `agent`, `autoUpdatesChannel`, `minimumVersion`, `companyAnnouncements`
- `fileSuggestion`, `statusLine`, `prUrlTemplate` (v2.1.119)
- `respectGitignore`, `feedbackSurveyRate`
- `disableSkillShellExecution`, `disableDeepLinkRegistration`
- `skipWebFetchPreflight`, `showClearContextOnPlanAccept`
- `teammateMode`, `viewMode`
- `channelsEnabled`, `allowedChannelPlugins`
- `claudeMdExcludes`

> Fonte: [`/en/settings`](https://code.claude.com/docs/en/settings).

---

## 18.3 Permission rule syntax

Rule format: `Tool` o `Tool(specifier)`.

| Tool | Esempi |
|---|---|
| `Bash` | `Bash`, `Bash(npm run *)`, `Bash(git diff *)` (spazio prima di `*` importante!) |
| `Read` | `Read(./.env)`, `Read(~/.zshrc)`, `Read(//absolute/path)` |
| `Edit` / `Write` | `Edit(...)`, `Write(...)` |
| `WebFetch` | `WebFetch(domain:example.com)` |
| `MCP` | `MCP(server)`, `MCP(server.tool)` |
| `Skill` | `Skill(name)`, `Skill(name *)` (prefix) |
| `Agent` | `Agent(...)` |

```json
{
  "permissions": {
    "allow": ["Read", "Bash(npm test)"],
    "ask": ["Edit", "Write"],
    "deny": ["Read(./.env)", "Bash(rm *)", "Skill(dangerous)"]
  }
}
```

---

## 18.4 Read-only commands

Set predefinito (always allow in `dontAsk` mode + auto mode). Vedi [`/en/permissions#read-only-commands`](https://code.claude.com/docs/en/permissions#read-only-commands).

Esempi: `git status`, `git log`, `ls`, `cat`, `pwd`, `which`.

Da v2.1.111: read-only bash glob + `cd <project-dir> &&` no prompt.

---

## 18.5 Authentication

### Storage
- macOS: Keychain (encrypted)
- Linux/Windows: `~/.claude/.credentials.json` (mode 0600 / user profile ACLs)

### Tipi
- claude.ai (subscription Pro/Max/Team/Enterprise)
- Claude API (`ANTHROPIC_API_KEY`)
- Azure
- Bedrock
- Vertex AI
- Microsoft Foundry

### `apiKeyHelper`
Shell script che ritorna API key. Refresh ogni 5 min o HTTP 401. Custom TTL: `CLAUDE_CODE_API_KEY_HELPER_TTL_MS`.

> Slow helper warning se >10s.

### Authentication precedence

1. Cloud provider env vars (Bedrock/Vertex/Foundry)
2. `ANTHROPIC_AUTH_TOKEN` (Authorization Bearer)
3. `ANTHROPIC_API_KEY` (X-Api-Key)
4. `apiKeyHelper`
5. `CLAUDE_CODE_OAUTH_TOKEN` (long-lived, generato con `claude setup-token`)
6. Subscription OAuth (`/login`)

> Note: `CLAUDE_CODE_OAUTH_TOKEN` NON letto in bare mode. Web sessions usano sempre subscription credentials.

> Fonte: [`/en/authentication`](https://code.claude.com/docs/en/authentication).

---

## 18.6 Claude for Teams / Enterprise

| Feature | Teams | Enterprise |
|---|---|---|
| Self-service | ✓ | |
| Collaboration | ✓ | ✓ |
| Admin tools | ✓ | ✓ |
| SSO | | ✓ |
| Domain capture | | ✓ |
| RBAC | | ✓ |
| Compliance API | | ✓ |
| Managed policy settings | Parziale | ✓ |
| Code Review GA | ✓ | ✓ |
| Claude Code Security | | ✓ |

### Console roles
- **Claude Code role**: solo Claude Code API key
- **Developer role**: any API key

---

## 18.7 Variabili d'ambiente principali

Vedi [02 CLI § 2.4](./02-cli-installazione.md#2.4-variabili-d-ambiente-principali).

---

## 18.8 Esempi pratici

### A. Settings minimal di progetto

`.claude/settings.json`:
```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "allow": ["Read", "Grep", "Glob", "Bash(npm test)", "Bash(npm run lint)"],
    "ask": ["Edit", "Write"],
    "deny": ["Read(./.env)", "Bash(rm -rf *)"]
  },
  "model": "claude-sonnet-4-6",
  "effortLevel": "high"
}
```

### B. Disable Co-Authored-By in commit

`~/.claude/settings.json`:
```json
{
  "attribution": { "commit": false, "pr": true }
}
```

### C. Managed enterprise con sandbox obbligatoria

`/Library/Application Support/ClaudeCode/managed-settings.json`:
```json
{
  "sandbox": {
    "mode": "auto-allow",
    "failIfUnavailable": true,
    "filesystem": {
      "allowWrite": ["/repo/**"],
      "denyWrite": ["/repo/.env*", "/repo/secrets/**"]
    },
    "network": {
      "allowedDomains": ["api.github.com", "registry.npmjs.org"]
    }
  },
  "disableBypassPermissionsMode": true,
  "disableAutoMode": "disable",
  "strictKnownMarketplaces": ["claude-plugins-official", "my-team-tools"]
}
```

### D. CI con bare mode

```bash
export ANTHROPIC_API_KEY=...
claude -p "Verify migration" \
  --bare \
  --permission-mode dontAsk \
  --max-budget-usd 2.00 \
  --output-format json
```

---

## 18.9 Tips operative

1. **Non committare `settings.local.json`**: lo sa fare gitignore di default.
2. **`$schema` field** abilita autocomplete in VS Code/Cursor.
3. **`prUrlTemplate`** per gestire repo con PR url custom (GHE, GitLab self-hosted).
4. **Managed settings sono incontestabili**: pianificale con cura, sono lock-in.
5. **`apiKeyHelper`** per rotazione automatica con vault tipo HashiCorp Vault, AWS Secrets Manager.
6. **Read-only commands list custom**: in plan/auto mode aggiunge cmd al safe-allow set.
7. **`disableSkillShellExecution: true`** se hai compliance strict.

---

← [17 IDE & surface](./17-ide-surface.md) · Successivo → [19 Changelog](./19-changelog.md)
