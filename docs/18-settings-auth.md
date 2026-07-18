# 18 — Settings & Authentication

> 📍 [README](../README.md) → [Integrazione](../README.md#integrazione) → **18 Settings & Auth**
> 🔧 Operational · 🟡 Intermediate

Gerarchia settings, sintassi permessi, autenticazione (claude.ai, API key, Bedrock/Vertex/Foundry, OAuth).

## Cosa e' concettualmente

> I settings sono la **configurazione dichiarativa dell'harness**. Cinque livelli di precedenza (managed > CLI args > local project > shared project > user) permettono di stratificare regole: enterprise impone policy, team condivide convenzioni, dev override locali. La sintassi permission e' Layer 1 dell'Authority.

**Modello mentale**: come la gerarchia `.gitconfig` (system > global > local > worktree).

**Componente harness IMPACT**: Authority (Layer 1 + Layer 4 managed) + Intent (env vars).

**Per il deep-dive**: [04b — Authority model](./04b-authority-model.md) per i 4 layer di Authority.

> **2026-07-18 (auto-update)**: v2.1.208 introduce la screen reader mode opt-in (`claude --ax-screen-reader`, env `CLAUDE_AX_SCREEN_READER=1`, o setting `"axScreenReader": true`) con rendering plain-text per utenti screen reader. Fonte: [GitHub Releases v2.1.208](https://github.com/anthropics/claude-code/releases/tag/v2.1.208). Vedi anche README "What's new today" del giorno.

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

### Impostazione inline con `/config` (da v2.1.181)

La sintassi `/config key=value` imposta qualsiasi campo di `settings.json` direttamente dal prompt, senza aprire file o riavviare la sessione. Funziona in modalita' interattiva, con `-p` e in Remote Control.

```
/config thinking=false        # disabilita il thinking per la sessione corrente
/config model=claude-fable-5  # cambia modello inline
/config effortLevel=high      # abbassa effort
```

La modifica e' persistente nella sessione (non viene scritta su disco a meno che il campo non sia gia' in `settings.json`). `/config` senza argomenti apre la UI settings interattiva.

<sub>Aggiornato 2026-06-18 via daily what's new. Fonte: [GitHub Releases v2.1.181](https://github.com/anthropics/claude-code/releases/tag/v2.1.181).</sub>

### Model & effort
- `model`, `availableModels`, `modelOverrides`, `effortLevel`, `fallbackModel`, `enforceAvailableModels`

> **`enforceAvailableModels`** (da v2.1.175, solo managed settings): quando `true`, l'allowlist `availableModels` vincola anche il Default model — se il Default risolverebbe a un modello non nella lista, viene sostituito dal primo modello consentito. Inoltre, user settings e project settings non possono espandere la lista: qualsiasi modello aggiunto a livelli inferiori viene ignorato se non gia' presente in `availableModels` managed. Garantisce compliance enterprise anche in presenza di overrides locali.
>
> ```json
> // managed-settings.json (sistema)
> {
>   "availableModels": ["claude-sonnet-4-6", "claude-haiku-4-5"],
>   "enforceAvailableModels": true
> }
> ```
>
> Senza `enforceAvailableModels: true`, un utente con `~/.claude/settings.json` potrebbe aggiungere `claude-fable-5` ad `availableModels` e bypassare la policy. Con il flag attivo, l'aggiunta viene ignorata.

<sub>Aggiornato 2026-06-12 via daily what's new. Fonte: [GitHub Releases v2.1.175](https://github.com/anthropics/claude-code/releases/tag/v2.1.175).</sub>

> **`fallbackModel`** (da v2.1.166): configura fino a 3 modelli di fallback provati in sequenza quando il modello primario e' sovraccarico o non disponibile. Il flag `--fallback-model` funziona ora anche nelle sessioni interattive (in precedenza solo in `-p`). Errori auth, rate-limit, request-size e transport vengono comunque segnalati immediatamente senza tentare il fallback.
>
> ```json
> { "fallbackModel": ["claude-sonnet-4-6", "claude-haiku-4-5"] }
> ```

> **Modello default organizzativo** (da v2.1.196): gli amministratori impostano il modello Claude predefinito per tutta l'organizzazione dalla console di amministrazione. Quando nessun override personale e' selezionato, il selettore `/model` mostra "Org default" (o "Role default" se il ruolo ha un proprio default). I setting locali (`model` in `settings.json`) sovrascrivono sempre l'org default per la sessione del singolo utente.

<sub>Aggiornato 2026-06-30 via daily what's new. Fonte: [GitHub Releases v2.1.196](https://github.com/anthropics/claude-code/releases/tag/v2.1.196).</sub>

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

> **`sandbox.credentials`** (da v2.1.187): quando `true`, i comandi eseguiti in ambiente sandboxato non possono leggere file di credenziali (`.env`, `~/.ssh/*`, token file, credential store) ne' variabili d'ambiente marcate come segrete. Utile in ambienti multi-tenant o pipeline CI/CD condivise dove il codice non deve accedere alle credenziali host.
>
> ```json
> { "sandbox": { "credentials": true } }
> ```
>
> La restrizione si applica solo ai comandi che girano dentro la sandbox; Claude Code stesso non e' limitato nell'accesso ai propri file di configurazione.

<sub>Aggiornato 2026-06-24 via daily what's new. Fonte: [GitHub Releases v2.1.187](https://github.com/anthropics/claude-code/releases/tag/v2.1.187).</sub>

### Hooks
- `hooks`, `disableAllHooks`, `allowManagedHooksOnly`
- `allowedHttpHookUrls`, `httpHookAllowedEnvVars`

### TUI / display
- `tui`, `autoScrollEnabled`, `showTurnDuration`, `showThinkingSummaries`
- `editorMode`, `prefersReducedMotion`
- `spinnerTipsEnabled`, `spinnerVerbs`, `terminalProgressBarEnabled`
- `awaySummaryEnabled`
- **`CLAUDE_CLIENT_PRESENCE_FILE`** (env var, da v2.1.181): punta a un file marker; finche' il file esiste, le push notification verso il mobile vengono soppresse — utile per chi ha Claude Code aperto sia in terminale che su mobile e non vuole duplicare le notifiche.

<sub>Aggiornato 2026-06-18 via daily what's new. Fonte: [GitHub Releases v2.1.181](https://github.com/anthropics/claude-code/releases/tag/v2.1.181).</sub>

### Memory
- `autoMemoryEnabled`, `autoMemoryDirectory`, `cleanupPeriodDays`, `plansDirectory`

### Attribution (commit/PR)
- `attribution.commit` (false per `Co-Authored-By` removal)
- `attribution.pr`

### Plugins
- `enabledPlugins`, `extraKnownMarketplaces`
- `strictKnownMarketplaces`, `blockedMarketplaces`, `pluginTrustMessage`
- **`disableBundledSkills`** (da v2.1.169): `true` nasconde le skill bundled e i comandi slash built-in dal modello; env var equivalente `CLAUDE_CODE_DISABLE_BUNDLED_SKILLS=1`. Le skill custom rimangono attive — solo quelle pre-installate vengono rimosse dal context.

### MCP
- `allowedMcpServers`, `deniedMcpServers`, `allowManagedMcpServersOnly`
- `enableAllProjectMcpServers`, `enabledMcpjsonServers`, `disabledMcpjsonServers`

### Advanced
- `alwaysThinkingEnabled`, `fastModePerSessionOptIn`
- `autoMode.soft_deny`, `useAutoModeDuringPlan`
- `defaultShell`, `outputStyle`, `language`, `voice.enabled`

> **Thinking Token Control** (da v2.1.166): tre modi per disabilitare il thinking su modelli che lo abilitano di default via Claude API (es. Opus 4.8 con `alwaysThinkingEnabled`):
> - Env var: `MAX_THINKING_TOKENS=0`
> - Flag CLI: `--thinking disabled`
> - Toggle per-modello in `/model` (settings persistente per sessione)
>
> I provider third-party (Bedrock, Vertex, Foundry) rimangono invariati — la disabilitazione si applica solo alla Claude API diretta.

### Worktree
- `worktree.symlinkDirectories`, `worktree.sparsePaths`
- **`worktree.baseRef`** (da v2.1.133): `"fresh"` (default) — il worktree si dirama da `origin/<default>`, garantendo uno stato pulito; `"head"` — si dirama dal `HEAD` locale corrente, utile quando si vuole portare il lavoro in corso nel worktree isolato.
- **`worktree.bgIsolation`** (da v2.1.143): controlla l'isolamento delle sessioni background rispetto al worktree.
  - `"worktree"` (default): la sessione background opera in un worktree git dedicato via `EnterWorktree`, isolata dalla working copy principale.
  - `"none"`: la sessione background edita la working copy direttamente, senza creare un worktree separato — utile per repository dove i worktree non sono pratici (monorepo con submodule, toolchain che non supportano working directory alternative).

```json
{
  "worktree": {
    "bgIsolation": "none"
  }
}
```

> **Attenzione**: con `"none"`, sessioni background concorrenti operano sulla stessa working copy. Usare solo quando il workflow garantisce serializzazione delle sessioni o quando il repo non supporta git worktree.

<sub>Aggiornato 2026-05-16 via daily what's new. Fonte: [GitHub Releases v2.1.143](https://github.com/anthropics/claude-code/releases/tag/v2.1.143).</sub>

### Safe Mode (da v2.1.169)

Il flag `--safe-mode` e la env var `CLAUDE_CODE_SAFE_MODE=1` avviano Claude Code con tutte le customizzazioni disabilitate (CLAUDE.md, plugin, skill, hook, MCP server). Non modifica nessun file di configurazione — le customizzazioni restano in place per le sessioni normali. Vedi [4.5 Safe Mode](./04-modalita-permessi.md#safe-mode) per i dettagli.

<sub>Aggiornato 2026-06-09 via daily what's new. Fonte: [GitHub Releases v2.1.169](https://github.com/anthropics/claude-code/releases/tag/v2.1.169).</sub>

### Version enforcement (da v2.1.163 — Managed only)

I campi `requiredMinimumVersion` e `requiredMaximumVersion` nel file `managed-settings.json` bloccano l'avvio di Claude Code se la versione installata e' fuori dal range specificato. Utile per team enterprise che devono garantire versioni stabili approvate o impedire l'uso di versioni troppo recenti (es. per compliance o testing controllato).

```json
{
  "requiredMinimumVersion": "2.1.163",
  "requiredMaximumVersion": "2.1.165"
}
```

Claude Code mostra un messaggio esplicativo e rifiuta di avviarsi fino a che la versione non rientra nel range. I valori sono indipendenti: si puo' usare solo `requiredMinimumVersion`, solo `requiredMaximumVersion`, o entrambi.

<sub>Aggiornato 2026-06-05 via daily what's new. Fonte: [GitHub Releases v2.1.163](https://github.com/anthropics/claude-code/releases/tag/v2.1.163).</sub>

### Other
- **`agent`** (da v2.1.157 per dispatch): specifica l'agente di default per le sessioni dispatch; override per sessione con `--agent <name>`. Precedentemente usato solo per sessioni non-dispatch.
- `autoUpdatesChannel`, `minimumVersion`, `companyAnnouncements`
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
| `Agent` | `Agent(model:opus)`, `Agent(model:claude-opus-*)` |

```json
{
  "permissions": {
    "allow": ["Read", "Bash(npm test)"],
    "ask": ["Edit", "Write"],
    "deny": ["Read(./.env)", "Bash(rm *)", "Skill(dangerous)"]
  }
}
```

### Sintassi `Tool(param:value)` (da v2.1.178)

Oltre al path-based specifier (`Bash(git *)`, `Read(./.env)`), le permission rules supportano ora il filtraggio per **parametro del tool**:

```
Tool(param:value)
Tool(param:*)       # wildcard: blocca su qualsiasi valore del parametro
```

Esempio pratico: bloccare sub-agenti che usano Opus (utile per contenere i costi in team):

```json
{
  "permissions": {
    "deny": ["Agent(model:claude-opus-4-8)", "Agent(model:claude-opus-*)"]
  }
}
```

Il parametro `model` di `Agent` corrisponde al campo `model` passato al tool Agent. Il wildcard `*` funziona come suffix match. Combinabile con le deny normali nella stessa lista.

<sub>Aggiornato 2026-06-16 via daily what's new. Fonte: [GitHub Releases v2.1.178](https://github.com/anthropics/claude-code/releases/tag/v2.1.178).</sub>

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

### OAuth paste-in-terminal (v2.1.126)

In ambienti dove il browser non riesce a raggiungere `localhost` (WSL2, SSH remoto, container), `claude auth login` mostra ora un URL di autorizzazione e accetta il codice OAuth incollato direttamente nel terminale al posto del callback automatico.

```bash
claude auth login
# → apri URL nel browser
# → copia il codice dalla pagina di redirect
# → incollalo nel terminale quando richiesto
```

Questa modalita' si attiva automaticamente quando il browser callback fallisce — nessuna configurazione necessaria.

<sub>Aggiornato 2026-05-01 via daily what's new. Fonte: [GitHub Releases v2.1.126](https://github.com/anthropics/claude-code/releases).</sub>

### Login con subscription vs API key — quando scegliere quale

La scelta tra **subscription OAuth** (Claude Pro/Max/Team/Enterprise) e **API key Anthropic Console** ha implicazioni di costo e capabilities concrete:

- **Subscription OAuth** (`/login` con account claude.ai)
  - Rate limit piu' alti rispetto al tier free
  - Accesso ai modelli piu' recenti (Sonnet 4.7, Opus 4.7) senza per-request cost se hai Max
  - **Nessun costo per richiesta** sul piano Max — adatto a sessioni lunghe e a `--dangerously-skip-permissions` in worktree isolati
  - Tracking unificato in `/usage` (sessione, settimana, breakdown per modello)
  - Verifica login: `/cost` deve mostrare info subscription, non saldo API
- **API key** (`ANTHROPIC_API_KEY`)
  - Pay-per-token, nessun cap settimanale
  - Necessaria per CI/CD, headless, GitHub Actions, container ephemeri
  - Indispensabile per Bedrock/Vertex (vedi 18.6)
  - Scelta default in scenari multi-tenant o team senza piano Max condiviso

> **Regola pratica**: subscription per uso interattivo locale quotidiano, API key per automazione / pipeline / agent SDK in produzione.

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
