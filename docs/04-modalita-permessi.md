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

### File con prompt di conferma aggiuntivo in `acceptEdits` (v2.1.160)

Oltre ai protected paths, v2.1.160 introduce un prompt di conferma esplicita prima di scrivere su due categorie di file sensibili, anche quando `acceptEdits` e' attivo:

**File di avvio shell** (eseguiti ad ogni nuova sessione terminale):
- `.zshenv`, `.zlogin`, `.bash_login`
- `~/.config/git/`

**File di configurazione build-tool** (possono concedere accesso all'esecuzione di codice):
- `.npmrc`, `.yarnrc*`, `bunfig.toml`
- `.bazelrc`, `.pre-commit-config.yaml`
- `.devcontainer/`

La differenza rispetto ai protected paths: questi file possono comunque essere modificati, ma richiedono conferma esplicita a prescindere dal permission mode attivo. Rilevante per sessioni CI/headless con `acceptEdits` di default.

<sub>Aggiornato 2026-06-02 via daily what's new. Fonte: [GitHub Releases v2.1.160](https://github.com/anthropics/claude-code/releases/tag/v2.1.160).</sub>

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
- Provider cloud: Bedrock, Vertex e Foundry (Opus 4.7 e Opus 4.8) con `CLAUDE_CODE_ENABLE_AUTO_MODE=1`
- Modello: Sonnet 4.6, Opus 4.6, Opus 4.7, Opus 4.8

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

### Da v2.1.158 (30 mag 2026)

Auto mode disponibile su **AWS Bedrock**, **Google Vertex AI** e **Azure Foundry** per Opus 4.7 e Opus 4.8. Opt-in:

```bash
export CLAUDE_CODE_ENABLE_AUTO_MODE=1
claude --permission-mode auto
```

Prima di questa release, auto mode richiedeva il provider diretto Anthropic (claude.ai/code, Desktop, CLI via API key). Da v2.1.158 funziona anche su deployment enterprise su cloud provider.

<sub>Aggiornato 2026-05-31 via daily what's new. Fonte: [GitHub Releases v2.1.158](https://github.com/anthropics/claude-code/releases/tag/v2.1.158).</sub>

### Hard deny rules (v2.1.134–136, Week 19)

`settings.autoMode.hard_deny` definisce una lista di azioni bloccate incondizionatamente in auto mode, indipendentemente da eventuali eccezioni "allow" configurate. A differenza di `soft_deny`, le hard deny non possono essere sovrascritte da allow rules.

```json
{
  "autoMode": {
    "hard_deny": ["bash:rm -rf *", "bash:git push --force"]
  }
}
```

Utile per garantire che operazioni distruttive non vengano mai auto-approvate indipendentemente dalla configurazione.

<sub>Aggiornato 2026-05-09 via daily what's new. Fonte: [code.claude.com/docs/en/whats-new/2026-w19](https://code.claude.com/docs/en/whats-new/2026-w19).</sub>

> Fonti: [`/en/auto-mode-config`](https://code.claude.com/docs/en/auto-mode-config), [Auto mode guide claudefa.st](https://claudefa.st/blog/guide/development/auto-mode).

### Blocco comandi distruttivi in auto mode (v2.1.183)

Da v2.1.183 (19 giu 2026), auto mode blocca automaticamente una serie di azioni distruttive quando **non esplicitamente richieste** dall'utente nel prompt corrente:

**Git distruttivo:**
- `git reset --hard`
- `git checkout -- .`
- `git clean -fd`
- `git stash drop`
- `git commit --amend` (quando il commit originale non e' stato creato dall'agente)

**Infra destroy:**
- `terraform destroy`
- `pulumi destroy`
- `cdk destroy`

Il blocco e' contestuale: se il task dichiarato esplicitamente nel turno e' "resetta il repo allo stato pulito", `git reset --hard` viene permesso. Complementa le regole `autoMode.hard_deny` configurabili manualmente (che bloccano incondizionatamente, indipendentemente dal contesto del prompt).

<sub>Aggiornato 2026-06-19 via daily what's new. Fonte: [GitHub Releases v2.1.183](https://github.com/anthropics/claude-code/releases/tag/v2.1.183).</sub>

### `autoMode.classifyAllShell` e denial reasons (v2.1.193)

Da v2.1.193 (25 giu 2026), due aggiunte al sistema auto mode:

**`autoMode.classifyAllShell`**: instrada **tutti** i comandi Bash e PowerShell attraverso il classificatore auto mode, non solo i pattern riconosciuti come arbitrary-code-execution. Utile in ambienti dove si vuole una supervisione piu' granulare su ogni shell invocation.

```json
{
  "autoMode": {
    "classifyAllShell": true
  }
}
```

**Denial reasons trasparenti**: quando auto mode blocca un'azione, la motivazione viene ora scritta in tre posti:
- **Transcript**: riga visibile nella conversazione
- **Toast**: notifica momentanea nell'interfaccia
- **`/permissions` → "Recently denied"**: tab consultabile per capire pattern di blocco nel tempo

Utile per diagnosticare perche' un comando specifico viene fermato e affinare le regole `allow`/`deny` o `hard_deny` di conseguenza.

<sub>Aggiornato 2026-06-26 via daily what's new. Fonte: [GitHub Releases v2.1.193](https://github.com/anthropics/claude-code/releases/tag/v2.1.193).</sub>

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

## 4.5 Safe Mode {#safe-mode}

Safe Mode (da v2.1.169) avvia Claude Code con **tutte le customizzazioni disabilitate** per sessioni di troubleshooting isolate.

### Cosa disabilita

| Componente | Disabilitato in safe mode |
|---|---|
| `CLAUDE.md` | Si' (non viene caricato) |
| Plugin | Si' (nessun plugin attivo) |
| Skills | Si' (bundled e custom non disponibili) |
| Hooks | Si' (nessun hook eseguito) |
| MCP servers | Si' (nessun server MCP connesso) |

### Attivazione

```bash
# Flag CLI
claude --safe-mode

# Env var (persistente per la sessione)
CLAUDE_CODE_SAFE_MODE=1 claude
```

Safe Mode non modifica nessun file di configurazione: le customizzazioni restano in place per le sessioni normali. Utile per verificare se un comportamento inatteso e' causato da hook, plugin, skill o CLAUDE.md prima di fare un debug piu' specifico.

<sub>Aggiornato 2026-06-09 via daily what's new. Fonte: [GitHub Releases v2.1.169](https://github.com/anthropics/claude-code/releases/tag/v2.1.169).</sub>

---

## 4.6 Checkpoints e rewind

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

### Recupero post-`/clear` (da v2.1.191)

Da v2.1.191, `/rewind` recupera anche il context di conversazione azzerato da un `/clear` — in precedenza `/clear` era irreversibile nella sessione corrente. Nel menu Esc Esc i punti precedenti al `/clear` appaiono ora come checkpoint selezionabili come tutti gli altri.

### Persistenza
- Cross-session
- Cleanup default: 30 giorni (`cleanupPeriodDays`)
- Non sostituisce git

> Fonte: [`/en/checkpointing`](https://code.claude.com/docs/en/checkpointing).

<sub>Aggiornato 2026-06-25 via daily what's new. Fonte: [GitHub Releases v2.1.191](https://github.com/anthropics/claude-code/releases/tag/v2.1.191).</sub>

---

## 4.7 Tip operative

1. **Default a `default`**: il prompt ti protegge. Passa a `acceptEdits` solo quando sai cosa stai facendo.
2. **Plan mode prima di refactor grosso**: Shift+Tab e descrivi obiettivo + constraints + acceptance.
3. **Auto mode quando hai task lunghi**: meglio del bypass; il classifier blocca le cose pericolose.
4. **Sandbox e' tuo amico**: il prompt-fatigue si riduce molto. Su macOS funziona out of the box, su Linux installa bubblewrap.
5. **`/rewind` come undo cognitivo**: se Claude prende strada sbagliata, torna indietro e riformula, invece di "correggi". Piu' veloce.
6. **`/fewer-permission-prompts`** scansiona la transcript e crea allowlist read-only mirate.

---

← [03 Slash commands](./03-slash-commands.md) · Successivo → [05 Fast mode + 1M context](./05-fast-mode-1m-context.md)
