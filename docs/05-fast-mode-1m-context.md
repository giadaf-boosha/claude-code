# 05 — Fast mode, 1M context, Opus 4.7

> 📍 [README](../README.md) → [Workflow](../README.md#workflow) → **05 Fast mode + 1M context**
> 🔧 Operational · 🟡 Intermediate

Tre feature legate ai modelli: il **fast mode** (Opus 4.7 piu' veloce, da v2.1.142), il **context window da 1M token GA**, e il modello premium **Opus 4.7** con effort `xhigh`.

## Cosa e' concettualmente

> Le tre feature gestiscono il trade-off **velocita' / qualita' / capacita'** del modello. Fast mode taglia la latenza, 1M context espande la "memoria di lavoro", Opus 4.7 amplia il reasoning. Sono leve indipendenti per dimensionare l'engine all'applicazione.

**Modello mentale**: scegliere il modello e' come scegliere il motore di un'auto: cilindrata (effort), cavalli (Opus vs Sonnet), elaborazione (fast mode).

**Componente harness IMPACT**: trasversale (impatta tutti i pilastri via cambio motore).

**Per il deep-dive**: [00b — Context engineering](./00b-context-engineering.md) per come 1M context si combina con tecniche context.

---

## 5.1 Fast mode (Opus 4.7 di default, da v2.1.142)

### Cosa fa
Routing su un serving path piu' rapido (~2.5x). Stesso modello, stessi pesi, stessa qualita'. Solo latenza ridotta. **Non** e' downgrade su Haiku/Sonnet.

**Da v2.1.142 (14 mag 2026)**, Fast mode usa **Opus 4.7** di default. In precedenza (v2.1.36–v2.1.141) usava Opus 4.6. Per tornare al comportamento precedente: `CLAUDE_CODE_OPUS_4_6_FAST_MODE_OVERRIDE=1`.

### Annunciato
- 7 febbraio 2026 (lancio con Opus 4.6): [@claudeai](https://x.com/claudeai/status/2020207322124132504)
- Anthropic l'ha usato internamente per accelerare la velocita' di sviluppo: [@_catwu](https://x.com/_catwu/status/2020207767479546031)
- 14 maggio 2026 (upgrade a Opus 4.7 di default): [GitHub Releases v2.1.142](https://github.com/anthropics/claude-code/releases/tag/v2.1.142)

### Come si attiva
```
/fast            # toggle on/off
/fast on
/fast off
```
In sessione: digita `/fast` e premi `Tab`. Appare un'icona fulmine `↯` nello status line.

Settings:
```json
{
  "fastMode": true,
  "fastModePerSessionOptIn": true   // reset a OFF ogni sessione
}
```

### Pricing
- Input: **$30/MTok** (vs $15/MTok base Opus 4.6)
- Output: **$150/MTok** (vs $75/MTok base Opus 4.6)
- Bills sempre come **extra usage** (anche con plan rimanente)
- Pricing Opus 4.7 Fast mode: non documentato pubblicamente al 15 mag 2026

### Limiti / requisiti
- Solo Anthropic API (NO Bedrock/Vertex/Foundry)
- Extra usage abilitato (`/extra-usage`)
- Team/Enterprise: admin enable
- v2.1.36+

### Disable e override
- `CLAUDE_CODE_DISABLE_FAST_MODE=1` — disabilita Fast mode completamente
- `CLAUDE_CODE_OPUS_4_6_FAST_MODE_OVERRIDE=1` — forza Opus 4.6 invece di Opus 4.7

### Rate-limit fallback
Automatico a standard (icon `↯` grigia in cooldown).

### $50 free credit (febbraio 2026)
Anthropic ha distribuito $50 di extra usage a tutti i Pro/Max. [@_catwu](https://x.com/_catwu/status/2020221012605038985):
> "claim the credit and toggle on extra usage... Then run `claude update && claude` and `/fast`."

> Fonte: [`/en/fast-mode`](https://code.claude.com/docs/en/fast-mode).

<sub>Aggiornato 2026-05-15 via daily what's new. Fonte: [GitHub Releases v2.1.142](https://github.com/anthropics/claude-code/releases/tag/v2.1.142).</sub>

---

## 5.2 1M context window (GA)

### Cosa cambia
Contesto da 1M token GA per **Opus 4.6** e **Sonnet 4.6** a pricing standard (no multiplier). Sonnet 4.6: $3/$15 per MTok anche su 900K-token request.

### Annunciato
- 13 marzo 2026: [blog Anthropic](https://claude.com/blog/1m-context-ga)

### Disponibilita'
| Plan | Comportamento |
|---|---|
| Pro | Va abilitato esplicitamente |
| Max | Upgrade automatico, no flag |
| Team / Enterprise | Upgrade automatico |

### Use case
- Codebase intero in single request
- Contratti / legal lunghi
- Decine di paper accademici
- Sessioni con cronologia massiva (`/continue` su lunghi giorni)

### Token display
Da v2.1.106: token counts ≥1M mostrati come "1.5m" invece che "1500000".

> Fonte: [`/en/build-with-claude/context-windows`](https://platform.claude.com/docs/en/build-with-claude/context-windows).

---

## 5.3 Opus 4.7 + effort `xhigh`

### Annunciato
v2.1.111 (16 aprile 2026). `claude-opus-4-7` con effort `xhigh` (tra `high` e `max`).

### Disponibilita'
- Max plan
- Auto mode disponibile per Max su Opus 4.7 (v2.1.111)

### Effort levels
```bash
/effort low|medium|high|xhigh|max     # set
/effort                                # slider interattivo
/effort auto                           # auto-pick
```

Default da v2.1.117: `high` per Pro/Max su Opus 4.6 + Sonnet 4.6.

### Pricing
Non documentato pubblicamente nel dettaglio (al 27 apr 2026).

### Hackathon Opus 4.7
> "The Claude Code hackathon is back for Opus 4.7. Join builders from around the world for a week with the Claude Code team in the room, with a prize pool of $100K in API credits." — [@claudeai](https://x.com/claudeai/status/2045248224659644654)

---

## 5.4 Quando usare cosa

| Situazione | Scelta |
|---|---|
| Task complesso, vuoi ragionamento | Opus 4.7 + `xhigh` o `max` |
| Task tecnico, vuoi velocita' | Sonnet 4.6 (default) |
| Iterazione fitta su Opus 4.6 | `/fast` (paghi extra usage ma 2.5x latency) |
| Codebase enorme | 1M context (Sonnet 4.6 o Opus 4.6) |
| Plan mode | Opus per plan + Sonnet per execution (`/model` Opus per plan mode) |
| CI/headless | Sonnet 4.6 + `--bare` |

---

## 5.5 Rapporto con il post-mortem aprile 2026

Il [post-mortem qualita' aprile 2026](https://x.com/ClaudeDevs/status/2047371124238062069) ha precisato che le 3 issue erano nel **Claude Code harness e Agent SDK**, non nei modelli stessi. I modelli **non** hanno avuto regressioni. Fix in `v2.1.116+` con reset usage limits per tutti gli abbonati.

---

← [04 Modalita' permessi](./04-modalita-permessi.md) · Successivo → [06 CLAUDE.md e memory](./06-claude-md-memory.md)
