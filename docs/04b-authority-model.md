# 04b — Authority model

> 📍 [README](../README.md) → [Concetti foundation](../README.md#concetti-foundation) → **04b Authority model**
> 📘 Concettuale · 🟡 Intermediate

> **Tesi del capitolo**: in un agent harness, "Authority" e' il pilastro IMPACT che risponde a 3 domande: **cosa l'agent puo' fare**, **chi approva**, **cosa lo blocca anche se l'LLM "vuole"**. Claude Code separa Authority in 4 layer: permission rules, sandbox, hooks, managed settings. Capirne la stratificazione e' essenziale per usare auto mode in produzione.

---

## 04b.1 Perche' "Authority" e' un componente IMPACT a se'

Senza Authority esplicita, un agent e' una mina vagante:
- Esegue `rm -rf` se gli viene chiesto
- Pubblica un PR su main senza review
- Manda email a clienti senza filtri
- Esfiltra credenziali in log

L'Authority **dichiarativa** trasforma "sperare che l'LLM si comporti bene" in "il sistema **non puo'** comportarsi male".

Mappa IMPACT:
- **Intent**: cosa vuoi ottenere (CLAUDE.md)
- **Memory**: cosa l'agent ricorda
- **Planning**: cosa propone di fare prima di farlo
- **Authority** ← *questo capitolo*: cosa puo' / non puo' fare
- **Control flow**: come e quando lo fa

---

## 04b.2 4 layer di Authority in Claude Code

```mermaid
flowchart TD
    A["LLM propone azione"]
    L1{Layer 1<br/>Permission rules<br/>(allow/ask/deny)}
    L2{Layer 2<br/>Sandbox<br/>(OS-level isolation)}
    L3{Layer 3<br/>Hooks<br/>(custom logic)}
    L4{Layer 4<br/>Managed settings<br/>(enterprise policy)}
    OK["Esegue tool"]
    NOK["Blocca / Chiede / Logga"]

    A --> L4
    L4 -->|policy ok| L1
    L4 -->|policy block| NOK
    L1 -->|allow| L2
    L1 -->|deny| NOK
    L1 -->|ask| ASK["Prompt utente"]
    ASK -->|user approves| L2
    ASK -->|user denies| NOK
    L2 -->|sandbox ok| L3
    L2 -->|sandbox violation| NOK
    L3 -->|hook ok| OK
    L3 -->|hook exit 2| NOK
```

### Layer 1 — Permission rules
**Cosa**: dichiarazioni `allow` / `ask` / `deny` per tool e pattern (Bash, Read, Write, Edit, MCP, Skill, Agent).

**Sintassi**:
```json
{
  "permissions": {
    "allow": ["Read", "Bash(npm test)", "Bash(git diff *)"],
    "ask":   ["Edit", "Write"],
    "deny":  ["Read(./.env)", "Bash(rm *)", "Skill(dangerous-skill)"]
  }
}
```

**Where**: `.claude/settings.json` (project), `.claude/settings.local.json` (private), `~/.claude/settings.json` (user).

**Vedi**: [04 — Modalita' permessi](./04-modalita-permessi.md) sez. 4.1, [18 — Settings & auth](./18-settings-auth.md) sez. 18.3.

### Layer 2 — Sandbox (OS-level)
**Cosa**: isolation a livello kernel (Seatbelt su macOS, bubblewrap+socat su Linux) per Bash e child process. Filesystem rules + network rules indipendenti dall'LLM.

**Anche se l'LLM "decide" di scrivere `/etc/passwd`, il sandbox blocca**.

```json
{
  "sandbox": {
    "filesystem": {
      "allowWrite": ["/Users/me/repo/**"],
      "denyWrite":  ["/Users/me/repo/.env*"]
    },
    "network": {
      "allowedDomains": ["api.github.com"],
      "deniedDomains":  ["*.evil.example"]
    }
  }
}
```

**Vedi**: [04 — Modalita' permessi](./04-modalita-permessi.md) sez. 4.4.

### Layer 3 — Hooks (custom logic)
**Cosa**: script eseguiti deterministicamente al lifecycle dell'agent. Possono **bloccare** un'azione (exit 2) o **modificarla** (`updatedInput`).

**Caso classico**: pre-commit hook che blocca commit con secret.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{
          "type": "command",
          "if": "Bash(git commit *)",
          "command": ".claude/hooks/secret-scan.sh"
        }]
      }
    ]
  }
}
```

**Vedi**: [07 — Hooks](./07-hooks.md).

### Layer 4 — Managed settings (enterprise)
**Cosa**: policy distribuite via MDM / managed config che **non possono essere override** dall'utente. Tipico in compliance SOC2/ISO.

**Locations**:
- macOS: `/Library/Application Support/ClaudeCode/managed-settings.json`
- Linux/WSL: `/etc/claude-code/managed-settings.json`
- Windows: `C:\Program Files\ClaudeCode\managed-settings.json`

```json
{
  "disableBypassPermissionsMode": true,
  "disableAutoMode": "disable",
  "strictKnownMarketplaces": ["claude-plugins-official"],
  "sandbox": { "failIfUnavailable": true }
}
```

**Vedi**: [18 — Settings & auth](./18-settings-auth.md) sez. 18.1.

---

## 04b.3 Decision tree: come scegliere il layer giusto

Quale layer usare per quale tipo di Authority?

| Esigenza | Layer raccomandato | Perche' |
|---|---|---|
| "Mai eseguire `rm -rf` in dev" | Layer 1 (deny rule) + Layer 2 (sandbox path-specific) | Doppio livello difensivo |
| "Approvare manualmente prima di push" | Layer 1 (`ask` su `Bash(git push *)`) | Friction al momento giusto |
| "Bloccare leak di secret in commit" | Layer 3 (hook PreToolUse `git commit`) | Logica custom (regex su staged) |
| "Forzare allowlist di MCP server in tutta l'org" | Layer 4 (managed `strictKnownMarketplaces`) | Non override-abile |
| "Limitare network solo a github.com" | Layer 2 (sandbox) | OS-level garantisce |
| "Routine cloud non puo' modificare > 50 file" | Boundary nel prompt + Layer 1 (`ask` post-N) | Soft + hard |
| "Dev junior non puo' usare auto mode" | Layer 4 (managed `disableAutoMode: "disable"`) | Policy enforced |

---

## 04b.4 Auto mode vs Authority

[Auto mode](./04-modalita-permessi.md#43-auto-mode-research-preview-da-v2183) e' una **automazione del Layer 1**: invece di chiedere all'utente, un classifier model decide se l'azione e' "safe" o "risky".

Importante: Auto mode **non sostituisce** gli altri layer.
- Layer 2 (sandbox) sta sotto: se attivo, blocca anche cio' che il classifier ha approvato
- Layer 3 (hooks) sta sopra: PreToolUse hook puo' rifiutare anche cio' che classifier ha ok
- Layer 4 (managed) sopra a tutto: se `disableAutoMode: "disable"`, l'utente non puo' nemmeno attivarlo

Auto mode + sandbox + managed + hooks = quattro reti di sicurezza in serie.

---

## 04b.5 Pattern operativi

### Pattern A — "Default allow per dev, default deny per prod"

```json
// .claude/settings.local.json (sviluppatore in dev)
{
  "defaultMode": "auto",
  "permissions": {
    "deny": ["Read(./.env*)", "Bash(rm -rf /*)"]
  }
}

// managed-settings.json (in CI / prod)
{
  "defaultMode": "dontAsk",
  "permissions": {
    "allow": ["Read", "Bash(npm test)"],
    "deny":  ["Bash(*)", "Edit", "Write"]
  },
  "disableAutoMode": "disable"
}
```

### Pattern B — "Hook come source of truth"

Per logica complessa (es. "blocca push su main il venerdi pomeriggio"), Layer 3 batte tutti gli altri perche' eseguibile in shell.

```bash
#!/bin/bash
# .claude/hooks/no-friday-push.sh
read -r EVENT
DAY=$(date +%u)
HOUR=$(date +%H)
if [ "$DAY" = "5" ] && [ "$HOUR" -ge "14" ]; then
  echo '{"decision":"block","reason":"Niente push su main venerdi pomeriggio"}'
fi
exit 0
```

### Pattern C — "Sandbox aggressiva, deny rules narrow"

Per task di analisi (no scrittura), partire dal sandbox network-only e tenere deny rules minime:

```json
{
  "sandbox": {
    "filesystem": {
      "allowRead":  ["/repo/**"],
      "allowWrite": []
    },
    "network": { "allowedDomains": [] }
  }
}
```
Risultato: read-only deterministico.

---

## 04b.6 Anti-pattern Authority

| Anti-pattern | Perche' male | Fix |
|---|---|---|
| `--dangerously-skip-permissions` come default | Disabilita Layer 1, sandbox resta ma non bastera' a coprire ogni gap | Usare auto mode |
| Sandbox disabilitata "per fastidio" | Layer 2 era la rete piu' affidabile | Tenere on, bilanciare con auto mode |
| Hook script lenti (>10s) | Bloccano flow, frustrano | Profilare, async hook (`async: true`) |
| Managed settings "tutto vietato" senza alternative | Team aggira via shell esterni | Bilanciare + comunicare policy |
| Permission rule troppo larga (`Bash(*)`) | Vanifica la dichiarativita' | Rule path-specific (`Bash(npm *)`, `Bash(git *)`) |

---

## 04b.7 Letture di approfondimento

- [04 — Modalita' permessi, Sandbox, Checkpoints](./04-modalita-permessi.md) — reference operational
- [07 — Hooks](./07-hooks.md) — Layer 3 in dettaglio
- [18 — Settings & auth](./18-settings-auth.md) — Layer 4 e gerarchia settings
- [00 — Harness overview](./00-harness-overview.md) sez. 0.7 — mapping completo
- [21 — Guide per target user](./21-guide-target-user.md) — Authority per persona

---

← [04 Modalita' permessi](./04-modalita-permessi.md) · Successivo → [05 Fast mode + 1M context](./05-fast-mode-1m-context.md)
