# 14 — `/loop` e Monitor tool

> 📍 [README](../README.md) → [Cloud](../README.md#cloud) → **14 `/loop` & Monitor**
> 🔧 Operational · 🟡 Intermediate

Due feature complementari per **automazione intra-sessione**: `/loop` esegue ripetutamente un prompt, Monitor tool guarda processi background e interrompe Claude quando emettono output rilevante. Entrambe lavorano in sessione (vs Routines che sono cloud).

## Cosa e' concettualmente

> `/loop` materializza il **Control flow** dell'agent: ricorsivita' deterministica (cron) o adattiva (self-pacing). Monitor tool materializza l'**Observe** dell'agent loop ReAct: invece di polling esplicito, gli eventi push svegliano Claude. Insieme, sono il loop ReAct esposto come feature.

**Modello mentale**: `/loop` = `setInterval` di JS; Monitor tool = `EventEmitter` push-based.

**Componente harness IMPACT**: Control flow (loop) + observation layer (Monitor).

**Per il deep-dive**: [14b — Agent loop ReAct](./14b-agent-loop-react.md) per il pattern teorico, [13 — Routines](./13-routines-cloud.md) per il loop in cloud.

---

## 14.1 `/loop` (bundled skill)

> Disponibile da v2.1.72 (base), evoluzione **self-pacing** in Week 15 (apr 2026). Alias: `/proactive`.

### Sintassi

| Input | Esempio | Comportamento |
|---|---|---|
| Interval + prompt | `/loop 5m check the deploy` | Cron schedule fisso |
| Solo prompt | `/loop check CI on my PR` | Claude self-paces (1 min – 1 ora) ad ogni iterazione |
| Solo interval o niente | `/loop` o `/loop 15m` | Maintenance prompt o `loop.md` |
| Cron | `/loop --cron "0 8 * * 1-5"` | Cron expression custom |
| Cancel | `/loop --cancel` | Stop loop attivo |

Unita' supportate per interval: `s`, `m`, `h`, `d`. Granularita' min: 1 minuto. Intervalli non-clean (`7m`, `90m`) round to nearest.

> Self-pacing usa **Monitor tool** quando appropriato (piu' efficiente di polling).

### Maintenance prompt built-in

Omettendo entrambi (prompt + interval) in `/loop`:
- Continue unfinished work
- Tend current branch PR (review comments, failed CI, conflicts)
- Cleanup passes (bug hunts, simplification)
- NO new initiatives, irreversible actions solo se transcript le ha autorizzate

### `loop.md` custom

```
.claude/loop.md       # project (precede)
~/.claude/loop.md     # user (fallback)
```

- Plain Markdown, no required structure
- Edits effective on next iteration
- Cap 25,000 bytes

### Stop

- **Esc**: clear pending wakeup (v2.1.113)
- Tasks scheduled chiedendo a Claude direttamente NON cancellate da Esc

### One-time reminders

```
remind me at 3pm to push the release branch
in 45 minutes, check tests
```

Claude crea single-fire task con cron expression.

### Tools sotto il cofano

- `CronCreate` (5-field cron + prompt + recurs/once)
- `CronList`
- `CronDelete` (8-char ID)

Max 50 scheduled tasks per sessione.

### Scheduler interno

- Check ogni 1 sec
- Fire low priority **between turns** (mai mid-response)
- Local timezone (`0 9 * * *` = 9am locale)
- **Jitter**: recurring fire fino 10% periodo late (cap 15 min); one-shot top/bottom hour fino 90s early. Per timing esatto, usa minute non-`:00`/`:30`.
- **7-day expiry**: recurring fire una volta finale poi delete. Cancel & recreate per longer.

### Cron expressions
5-field `minute hour dom month dow`. Wildcards, single, steps `*/15`, ranges `1-5`, lists `1,15,30`. NO `L`, `W`, `?`, `MON`/`JAN` aliases.

### Disable
`CLAUDE_CODE_DISABLE_CRON=1`

### Limitations

- Solo while session running + idle
- No catch-up missed fires
- Fresh conversation clears tasks
- `--resume`/`--continue` restore unexpired

> Fonte: [`/en/scheduled-tasks`](https://code.claude.com/docs/en/scheduled-tasks).

---

## 14.2 Monitor tool (da v2.1.98)

> "Lets Claude watch something in the background and react when it changes, without pausing the conversation."

Lanciato **9 aprile 2026** in v2.1.98. Sostituisce il polling con interrupt push-based.

### Use case

- Tail log file e flag errors
- Poll PR/CI job per status change
- Watch directory per file changes
- Track output di long-running script (build, test, deploy)
- Watch dev server per errori di compile/runtime

### Come funziona

1. Claude scrive piccolo script
2. Run in background
3. Ogni linea stdout arriva come notifica → Claude interjects nel main thread
4. Stop: chiedi a Claude o end session

### Permessi

Stesse rules di **Bash** (allow/deny patterns matchano).

### Non disponibile su

Bedrock, Vertex AI, Foundry. Disabilitato anche con `DISABLE_TELEMETRY=1` o `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1`.

### Plugin monitors (da v2.1.106)

`monitors/monitors.json` in plugin:
```json
[
  {
    "name": "error-log",
    "command": "tail -F ./logs/error.log",
    "description": "Application error log"
  }
]
```

Auto-start con plugin. Ogni stdout line → notifica nella sessione.

### Pattern "until-condition"

```bash
until <check>; do sleep 2; done
```
Ricevi notifica al completamento, evitando polling esplicito.

### Bash run_in_background

Anche il tool `Bash` ha `run_in_background: true` per one-shot wait. Tipicamente Monitor e' meglio per **stream continuo**, run_in_background per **task one-shot lunghi**.

---

## 14.3 Esempi pratici

### A. `/loop` polling CI (Boris-style)

```
/loop 5m /babysit
```
Esegue maintenance prompt ogni 5 minuti: addressa code review comments, auto-rebase, fixa CI failure.

> "Two of the most powerful features in Claude Code: /loop and /schedule. ... I have a bunch of loops running locally: /loop 5m /babysit, to auto-address code review, auto-rebase, and..." — [@bcherny](https://x.com/bcherny/status/2038454341884154269)

### B. `/loop` self-pacing su CI

```
/loop check CI on my PR
```
Niente intervallo: Claude decide quando ri-eseguire in base allo stato (e magari usa Monitor se vede polling utile).

### C. Monitor su dev server

> "you'll need to explicitly prompt Claude Code to use it, but the Monitor Tool is super powerful. e.g. 'start my dev server and use the MonitorTool to observe for errors'" — [@trq212](https://x.com/trq212/status/2042335178388103559)

```
Avvia il dev server con `npm run dev` e usa il Monitor tool per osservare errori di compile/runtime.
Quando vedi un errore, fixalo subito e ricarica.
```

### D. Monitor su kubectl logs

> "Use the monitor tool and `kubectl logs -f | grep ..` to listen for errors, make a pr to fix" — Alistair (https://x.com/alistaiir/status/2042345049980362819)

```
Usa Monitor tool con `kubectl logs -f deployment/api | grep ERROR` e quando vedi un error pattern,
diagnostica root cause e apri PR di fix.
```

### E. One-time reminder

```
remind me at 3pm to push the release branch
```

Claude crea single-fire task. Tu lavori intanto.

### F. Custom `loop.md` di progetto

`.claude/loop.md`:
```markdown
# Loop maintenance

Ad ogni iterazione:
1. Verifica `npm test` passa
2. Se ci sono PR comments non risolti su PR aperte, rispondi
3. Se ci sono CI failure, diagnostica e proponi fix
4. Aggiorna CHANGELOG.md se ci sono nuovi merge nel main
5. NON committare automaticamente, scrivi solo proposte
```

Lancia: `/loop 10m`.

---

## 14.4 Tips operative

1. **`/loop` con `tmux`/`screen`**: la sessione muore se chiudi il terminale. Persistenza solo dentro tmux/screen.
2. **Stimare costo per ciclo** prima di intervalli brevi (ogni iter consuma token).
3. **Output strutturato in `/loop`**: chiedi JSON o markdown report per fare pattern-recognition cross-iter.
4. **`/compact` periodico** in loop lunghi: tieni il context sotto controllo.
5. **Idempotenza**: il task del loop deve essere idempotente. Se ricalcola da zero, problema.
6. **Per scheduling robusto multi-user / 24/7**: preferisci [Routines (cloud)](./13-routines-cloud.md), `/loop` e' session-scoped.
7. **Monitor > polling**: meno token, latenza inferiore. Specialmente per logs/test runner.
8. **Self-pacing `/loop`** quando il task non e' strettamente periodico (es. "check CI": Claude decide quando ri-controllare).

---

## 14.5 Annunci e fonti

- `/loop` self-pacing: [@noahzweben](https://x.com/noahzweben/status/2042670949003153647), 9-10 apr 2026
- Monitor tool: [@noahzweben](https://x.com/noahzweben/status/2042332268450963774), 9 apr 2026
- Tip Thariq Monitor + dev server: [@trq212](https://x.com/trq212/status/2042335178388103559)
- Esempio Alistair Monitor + kubectl: https://x.com/alistaiir/status/2042345049980362819
- Tip Boris `/loop` + `/schedule`: [@bcherny](https://x.com/bcherny/status/2038454341884154269)
- Docs: [`/en/scheduled-tasks`](https://code.claude.com/docs/en/scheduled-tasks), [`/en/tools-reference#monitor-tool`](https://code.claude.com/docs/en/tools-reference)

---

← [13 Routines (cloud)](./13-routines-cloud.md) · Successivo → [15 Ultraplan & Ultrareview](./15-ultraplan-ultrareview.md)
