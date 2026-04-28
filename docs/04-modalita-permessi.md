# 04 — Modalita' permessi, Sandbox, Checkpoints

> 📍 [README](../README.md) → [Workflow](../README.md#workflow) → **04 Permessi**
> 🔧 Operational · 🟡 Intermediate

Claude Code ha 6 permission modes, una sandbox OS-level e un sistema di checkpoint per il rollback. Questo documento li copre tutti.

## Cosa e' concettualmente

> Le modalita' permessi sono il **Layer 1** dell'Authority dell'harness: dichiari cosa l'agent puo' fare a runtime. La sandbox e' il **Layer 2** (OS-level). I checkpoint sono il **layer State**: snapshot per recovery deterministico.

**Modello mentale**: permission mode = profilo `sudoers`; sandbox = container Docker; checkpoint = snapshot di filesystem.

**Componente harness IMPACT**: Authority (permission + sandbox) + State (checkpoints).

**Per il deep-dive**: [04b — Authority model](./04b-authority-model.md) per il framework completo.

---

## 4.1 Permission modes

Cycle: `Shift+Tab` → `default` → `acceptEdits` → `plan`.

| Mode | Run senza prompt | Use case |
|---|---|---|
| `default` | Solo reads | Sensitive work |
| `acceptEdits` | Reads + file edits + filesystem cmd (mkdir, touch, mv, cp, rm, rmdir, sed) entro working dir | Iterazione |
| `plan` | Solo reads | Esplora prima di modificare |
| `auto` | Tutto + classifier | Long task (richiede Max/Team/Enterprise/API + Anthropic provider + Sonnet 4.6 / Opus 4.6 / 4.7) |
| `dontAsk` | Solo pre-approved tools + read-only Bash | CI |
| `bypassPermissions` | Tutto eccetto protected paths | Container/VM isolated |

CLI: `--permission-mode default|acceptEdits|plan|auto|dontAsk|bypassPermissions`.

### Protected paths (mai auto-approved)
- Directories: `.git`, `.vscode`, `.idea`, `.husky`, `.claude` (eccetto `.claude/commands`, `.claude/agents`, `.claude/skills`, `.claude/worktrees`)
- Files: `.gitconfig`, `.gitmodules`, `.bashrc`, `.zshrc`, `.profile`, `.ripgreprc`, `.mcp.json`, `.claude.json`

> Fonte: [`/en/permission-modes`](https://code.claude.com/docs/en/permission-modes).

---

## 4.2 Plan mode

Annunciato giugno 2025 ([@_catwu](https://x.com/_catwu/status/1932857816131547453)), GA su tutti i piani.

### Entrare
- `Shift+Tab` (cycle)
- `/plan [task]`
- `--permission-mode plan`

### Comportamento
- Read-only: Claude esplora, ma non modifica
- Quando il piano e' pronto, dialog con 3 opzioni:
  1. **Yes, implement here** (esce da plan mode)
  2. **No, refine with Ultraplan on Claude Code on the web** (web review piu' profondo, vedi [15](./15-ultraplan-ultrareview.md))
  3. **No, give feedback** (continua a iterare)

### Tip Cat Wu
> "Give Claude Code your full task context upfront: goal, constraints, acceptance criteria in the first turn." — [@_catwu](https://x.com/_catwu/status/2044808536790847693)

### `/model` Opus per plan mode
Da agosto 2025: Opus 4.x per plan + Sonnet per execution. [@_catwu](https://x.com/_catwu/status/1955694117264261609)

---

## 4.3 Auto mode (research preview, da v2.1.83)

Lanciato w13 (24 mar 2026). Alternativa piu' sicura a `--dangerously-skip-permissions`: un classifier separato decide cosa Claude puo' fare senza chiedere.

### Caratteristiche
- Classifier model review actions (separato dal main model)
- Boundaries dichiarate in conversation rispettate (ma non rules permanenti)
- Block dopo 3 consecutivi / 20 totali → fallback prompts
- Ancora chiede conferma per delete/force-push/reset, non per build/test/edit

### Prerequisiti
- Plan: Max, Team, Enterprise (o API + Anthropic provider)
- Modello: Sonnet 4.6, Opus 4.6, Opus 4.7

### Comandi
```bash
claude auto-mode defaults    # vedi regole classifier
claude auto-mode config      # config attuale
```

### Settings
```json
{
  "autoMode": {
    "environment": "trusted",
    "soft_deny": false
  },
  "useAutoModeDuringPlan": true
}
```
Disable: `disableAutoMode: "disable"` in managed settings.

### Da v2.1.111 (16 apr 2026)
- Auto mode disponibile su Opus 4.7 per Max
- `--enable-auto-mode` non piu' richiesto
- `/effort` slider interattivo

> Fonti: [`/en/auto-mode-config`](https://code.claude.com/docs/en/auto-mode-config), [Auto mode guide claudefa.st](https://claudefa.st/blog/guide/development/auto-mode).

---

## 4.4 Sandbox mode {#sandbox}

OS-level enforcement su Bash e child processes. Filesystem isolation + network isolation. Riduce permission prompt dell'~84% in uso interno Anthropic.

### Piattaforme
- **macOS**: Seatbelt (out of the box)
- **Linux/WSL2**: bubblewrap + socat (`apt-get install bubblewrap socat`). WSL1 NON supportato.
- **Windows nativo**: non supportato (usare WSL2)

### Attivazione
- CLI: `/sandbox` (toggle)
- Settings: `sandbox.mode`, `sandbox.failIfUnavailable: true`

### Modalita'
| Mode | Cosa fa |
|---|---|
| `auto-allow` | Sandboxed cmd auto-approved; cmd non sandboxabili tornano al permission flow normale |
| `regular` | Standard prompt flow con sandbox come protezione extra |

### Filesystem isolation
```json
{
  "sandbox": {
    "filesystem": {
      "allowWrite": ["/Users/me/repo/**"],
      "denyWrite": ["/Users/me/repo/.env"],
      "allowRead": ["/Users/me/configs/**"],
      "denyRead": []
    }
  }
}
```
Paths merge across scopes (managed > project > user).

### Network isolation
```json
{
  "sandbox": {
    "network": {
      "allowedDomains": ["api.github.com", "*.npmjs.org"],
      "deniedDomains": ["*.evil.example"],
      "httpProxyPort": 8443,
      "socksProxyPort": 8444
    }
  }
}
```

### Altre opzioni
- `allowUnixSockets`, `allowMachLookup`, `allowLocalBinding`
- `allowUnsandboxedCommands: false` per blockare escape hatch

### Open source runtime
```bash
npx @anthropic-ai/sandbox-runtime <command>
```
Repo: https://github.com/anthropic-experimental/sandbox-runtime

### Aggiornamenti aprile 2026
- v2.1.113-v2.1.117 (17-22 apr): tightening bash sandbox + security checks. Possibili leggermente piu' prompt su edge case.
- v2.1.113: `sandbox.network.deniedDomains` aggiunto

> Fonti: [`/en/sandboxing`](https://code.claude.com/docs/en/sandboxing), [Engineering blog](https://www.anthropic.com/engineering/claude-code-sandboxing).

---

## 4.5 Checkpoints e rewind

Claude Code traccia automaticamente edit. **NON** traccia bash file mods (`rm`, `mv`, `cp`).

### Comandi
- `/rewind` (alias `/checkpoint`, `/undo`)
- **Esc Esc**: menu scrollable con prompts della sessione

### Opzioni per ogni messaggio
- **Restore code and conversation**
- **Restore conversation** (mantiene code)
- **Restore code** (mantiene conversation)
- **Summarize from here** (compatta da quel punto in avanti, simile a `/compact` targeted)
- **Never mind**

### Persistenza
- Cross-session
- Cleanup default: 30 giorni (`cleanupPeriodDays`)
- Non sostituisce git

> Fonte: [`/en/checkpointing`](https://code.claude.com/docs/en/checkpointing).

---

## 4.6 Tip operative

1. **Default a `default`**: il prompt ti protegge. Passa a `acceptEdits` solo quando sai cosa stai facendo.
2. **Plan mode prima di refactor grosso**: Shift+Tab e descrivi obiettivo + constraints + acceptance.
3. **Auto mode quando hai task lunghi**: meglio del bypass; il classifier blocca le cose pericolose.
4. **Sandbox e' tuo amico**: il prompt-fatigue si riduce molto. Su macOS funziona out of the box, su Linux installa bubblewrap.
5. **`/rewind` come undo cognitivo**: se Claude prende strada sbagliata, torna indietro e riformula, invece di "correggi". Piu' veloce.
6. **`/fewer-permission-prompts`** scansiona la transcript e crea allowlist read-only mirate.

---

← [03 Slash commands](./03-slash-commands.md) · Successivo → [05 Fast mode + 1M context](./05-fast-mode-1m-context.md)
