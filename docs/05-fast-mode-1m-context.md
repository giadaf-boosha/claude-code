# 05 — Fast mode, 1M context, Opus 4.8, Fable 5

> 📍 [README](../README.md) → [Workflow](../README.md#workflow) → **05 Fast mode + 1M context**
> 🔧 Operational · 🟡 Intermediate

Feature legate ai modelli: il **fast mode** (Opus 4.8 di default, da v2.1.154), il **context window da 1M token GA**, gli **effort level** (default `high`, `xhigh` per i task piu' duri, piu' `ultracode`), **Opus 4.8** come modello premium corrente (v2.1.154), **Claude Fable 5** come primo modello Mythos-class disponibile pubblicamente (v2.1.170), e **Claude Sonnet 5** come nuovo modello di default (v2.1.197, 30 giu 2026).

## Cosa e' concettualmente

> Le tre feature gestiscono il trade-off **velocita' / qualita' / capacita'** del modello. Fast mode taglia la latenza, 1M context espande la "memoria di lavoro", Opus 4.8 con effort `xhigh` amplia il reasoning. Sono leve indipendenti per dimensionare l'engine all'applicazione.

**Modello mentale**: scegliere il modello e' come scegliere il motore di un'auto: cilindrata (effort), cavalli (Opus vs Sonnet), elaborazione (fast mode).

**Componente harness IMPACT**: trasversale (impatta tutti i pilastri via cambio motore).

**Per il deep-dive**: [00b — Context engineering](./00b-context-engineering.md) per come 1M context si combina con tecniche context.

---

## 5.1 Fast mode (Opus 4.8 di default, da v2.1.154)

### Cosa fa
Routing su un serving path piu' rapido (~2.5x). Stesso modello, stessi pesi, stessa qualita'. Solo latenza ridotta. **Non** e' downgrade su Haiku/Sonnet.

**Da v2.1.154 (28 mag 2026)**, Fast mode usa **Opus 4.8** di default. In precedenza (v2.1.142–v2.1.153) usava Opus 4.7; prima ancora (v2.1.36–v2.1.141) usava Opus 4.6. Per forzare Opus 4.6: `CLAUDE_CODE_OPUS_4_6_FAST_MODE_OVERRIDE=1`.

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
- Opus 4.8 standard: **$5/MTok** input, **$25/MTok** output
- Opus 4.8 Fast Mode: **$10/MTok** input, **$50/MTok** output (2x del rate standard per ~2.5x velocita')
- Bills sempre come **extra usage** (anche con plan rimanente)
- Piu' economico di Opus 4.7 Fast Mode
- Storico Opus 4.6: $15/$75 base, $30/$150 fast

### Limiti / requisiti
- Solo Anthropic API (NO Bedrock/Vertex/Foundry)
- Extra usage abilitato (`/extra-usage`)
- Team/Enterprise: admin enable
- v2.1.36+

### Disable e override
- `CLAUDE_CODE_DISABLE_FAST_MODE=1` — disabilita Fast mode completamente
- `CLAUDE_CODE_OPUS_4_6_FAST_MODE_OVERRIDE=1` — forza Opus 4.6 invece di Opus 4.8

### Rate-limit fallback
Automatico a standard (icon `↯` grigia in cooldown).

### $50 free credit (febbraio 2026)
Anthropic ha distribuito $50 di extra usage a tutti i Pro/Max. [@_catwu](https://x.com/_catwu/status/2020221012605038985):
> "claim the credit and toggle on extra usage... Then run `claude update && claude` and `/fast`."

> Fonte: [`/en/fast-mode`](https://code.claude.com/docs/en/fast-mode).

<sub>Aggiornato 2026-05-29 via daily what's new. Fonte: [GitHub Releases v2.1.154](https://github.com/anthropics/claude-code/releases/tag/v2.1.154).</sub>

---

## 5.2 1M context window (GA)

### Cosa cambia
Contesto da 1M token GA per **Opus 4.6**, **Sonnet 4.6** e (nativo) **Sonnet 5** a pricing standard (no multiplier). Sonnet 4.6: $3/$15 per MTok anche su 900K-token request. **Sonnet 5** espone 1M token come context window nativa (non richiede flag aggiuntivi).

### Annunciato
- 13 marzo 2026: [blog Anthropic](https://claude.com/blog/1m-context-ga)
- 30 giugno 2026: Sonnet 5 con 1M context nativo di default

### Disponibilita'
| Plan | Comportamento |
|---|---|
| Pro | Va abilitato esplicitamente (Sonnet 4.6); nativo con Sonnet 5 |
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

Su Opus 4.8 l'effort di **default e' `high`**; `xhigh` (tra `high` e `max`) e' pensato per i task piu' duri. Oltre a questi esiste **`ultracode`** = `xhigh` + orchestrazione workflow automatica (vedi [./24-workflows.md](./24-workflows.md)).

Default da v2.1.117: `high` per Pro/Max su Opus 4.6 + Sonnet 4.6.

### Pricing
Non documentato pubblicamente nel dettaglio (al 27 apr 2026).

### Hackathon Opus 4.7
> "The Claude Code hackathon is back for Opus 4.7. Join builders from around the world for a week with the Claude Code team in the room, with a prize pool of $100K in API credits." — [@claudeai](https://x.com/claudeai/status/2045248224659644654)

---

## 5.4 Opus 4.8 (da v2.1.154)

### Annunciato
v2.1.154 (28 maggio 2026). `claude-opus-4-8` diventa il **modello premium corrente** in Claude Code, con effort di default `high` e `xhigh` per i task piu' duri (piu' `ultracode` = `xhigh` + orchestrazione workflow automatica, vedi [./24-workflows.md](./24-workflows.md)); Fast Mode su Opus 4.8 disponibile a ~2.5x velocita' per 2x del costo standard (piu' economico di Opus 4.7 Fast Mode).

### Disponibilita'
- Max plan (default effort `xhigh`)
- Fast Mode: Anthropic API
- Lean system prompt abilitato di default (tranne Haiku, Sonnet, Opus 4.7 e precedenti)

### Note di migrazione
Opus 4.7 rimane disponibile via `/model claude-opus-4-7` o `/effort` manuale. Per forzare Opus 4.6 in Fast Mode: `CLAUDE_CODE_OPUS_4_6_FAST_MODE_OVERRIDE=1`.

<sub>Aggiornato 2026-05-29 via daily what's new. Fonte: [GitHub Releases v2.1.154](https://github.com/anthropics/claude-code/releases/tag/v2.1.154).</sub>

---

## 5.5 Quando usare cosa

| Situazione | Scelta |
|---|---|
| Reasoning max, agentico long-horizon | Fable 5 (`/model claude-fable-5`) |
| Task complesso massima qualita' | Opus 4.8 + `xhigh` o `max` |
| Task duro con workflow automatico | Opus 4.8 + `ultracode` (vedi [./24-workflows.md](./24-workflows.md)) |
| Default ragionamento | Opus 4.8 + `high` (effort di default) |
| Task tecnico, velocita', codebase grande | Sonnet 5 (default da v2.1.197, 1M context nativo) |
| Task tecnico, pinned su modello precedente | Sonnet 4.6 (`/model claude-sonnet-4-6`) |
| Iterazione fitta veloce | `/fast` (Opus 4.8, ~2.5x velocita', 2x costo: $10/$50 per MTok) |
| Codebase enorme | 1M context (Sonnet 5 nativo, o Sonnet 4.6 / Opus 4.6) |
| Plan mode | Opus 4.8 per plan + Sonnet 5 per execution (`/model` Opus per plan mode) |
| CI/headless | Sonnet 5 + `--bare` |

---

## 5.7 Claude Fable 5 (da v2.1.170)

### Annunciato
v2.1.170 (9 giugno 2026). `claude-fable-5` e' il primo modello **Mythos-class** di Anthropic disponibile pubblicamente — prestazioni superiori a qualsiasi modello precedentemente rilasciato al pubblico, ottimizzato per reasoning profondo e lavoro agentico di lunga durata.

### Come si usa in Claude Code
```bash
/model claude-fable-5
```

### Caratteristiche principali
| Caratteristica | Valore |
|---|---|
| Model ID | `claude-fable-5` |
| Context window | 1M token |
| Output max per request | 128k token |
| Pricing | $10/MTok input, $50/MTok output |
| Thinking | Adaptive thinking sempre attivo (non disabilitabile) |
| Raw thinking | Non restituito (solo `"summarized"` o `"omitted"`) |
| Refusals | HTTP 200 con `stop_reason: "refusal"` (non errore) |

### Disponibilita'
Generale su Claude API, Claude Platform on AWS, Amazon Bedrock, Vertex AI e Microsoft Foundry (dal 9 giugno 2026).

### Relazione con Opus 4.8
Fable 5 supera Opus 4.8 in capacita'. Se una richiesta viene rifiutata dai classifier di sicurezza, il meccanismo `fallbackModel` puo' riservare automaticamente su Opus 4.8. Il parametro `fallbacks` nell'API gestisce questo caso lato server.

### Note su `disableBundledSkills`
Con `/model claude-fable-5` il reasoning e' sempre on — `MAX_THINKING_TOKENS=0` non ha effetto su Fable 5 (vedi sezione 5.6). Per Fable 5 usa il parametro `effort` per controllare la profondita' del thinking.

> **2026-07-05 (auto-update)**: Fable 5 e' accessibile fino al **7 luglio 2026** a tutti i paid plan con usage incluso (50% del weekly limit) — dopo quella data si continua solo acquistando usage credits. Fonte: [@claudeai](https://x.com/claudeai/status/2072402639644766602). Vedi anche README "What's new today" del giorno.

<sub>Aggiornato 2026-07-05 via daily what's new. Fonte: [GitHub Releases v2.1.170](https://github.com/anthropics/claude-code/releases/tag/v2.1.170) · [Anthropic docs](https://platform.claude.com/docs/en/about-claude/models/introducing-claude-fable-5-and-claude-mythos-5).</sub>

---

## 5.8 Claude Sonnet 5 — nuovo modello default (da v2.1.197)

### Annunciato
v2.1.197 (30 giugno 2026). `claude-sonnet-5` diventa il **modello di default** in Claude Code per Free e Pro, sostituendo Sonnet 4.6. Disponibile anche su Max, Team e Enterprise.

### Come si usa in Claude Code
```bash
# default automatico da v2.1.197 — nessuna configurazione necessaria
/model claude-sonnet-5    # se si vuole esplicitare
/model claude-sonnet-4-6  # per tornare al predecessore
```

### Caratteristiche principali
| Caratteristica | Valore |
|---|---|
| Model ID | `claude-sonnet-5` |
| Context window | 1M token (nativo, senza flag aggiuntivi) |
| Output max per request | 128k token |
| Pricing promozionale | $2/MTok input, $10/MTok output (fino al 31 ago 2026) |
| Pricing standard | $3/MTok input, $15/MTok output (dal 1 set 2026) |
| Thinking | Adaptive thinking (stessa configurazione di Sonnet 4.6) |
| APEX-SWE | 43.7% Pass@1 (#3 dopo Opus 4.8 e Fable 5) |

### Disponibilita'
Generale su Claude API, Claude Platform, Amazon Bedrock, Vertex AI e Microsoft Foundry (dal 30 giugno 2026).

### Aggiornamento da Sonnet 4.6
`claude update` porta alla v2.1.197. Sonnet 4.6 rimane selezionabile via `/model claude-sonnet-4-6` o `ANTHROPIC_MODEL=claude-sonnet-4-6`.

<sub>Aggiornato 2026-07-01 via daily what's new. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2072018504392601762) · [GitHub Releases v2.1.197](https://github.com/anthropics/claude-code/releases/tag/v2.1.197).</sub>

---

## 5.5 Rapporto con il post-mortem aprile 2026

Il [post-mortem qualita' aprile 2026](https://x.com/ClaudeDevs/status/2047371124238062069) ha precisato che le 3 issue erano nel **Claude Code harness e Agent SDK**, non nei modelli stessi. I modelli **non** hanno avuto regressioni. Fix in `v2.1.116+` con reset usage limits per tutti gli abbonati.

---

## 5.6 Thinking Token Control (da v2.1.166)

Alcuni modelli — in particolare Opus 4.8 con `alwaysThinkingEnabled` — attivano il thinking di default via Claude API. Da v2.1.166 e' possibile disabilitarlo in tre modi:

| Metodo | Come |
|---|---|
| Env var | `MAX_THINKING_TOKENS=0` |
| Flag CLI | `--thinking disabled` |
| Toggle per-modello | in `/model`, persistente per la sessione corrente |

**Quando usarlo**: workflow dove la latenza conta piu' del reasoning (CI headless, scripting `-p`, pipeline di estrazione dati), o quando il provider terzo non supporta thinking e si vuole comportamento uniforme.

**Scope**: si applica solo alla Claude API diretta. I provider third-party (Bedrock, Vertex, Azure Foundry) rimangono invariati — la configurazione thinking su quei provider e' gestita lato provider.

<sub>Aggiornato 2026-06-06 via daily what's new. Fonte: [GitHub Releases v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166).</sub>

---

← [04 Modalita' permessi](./04-modalita-permessi.md) · Successivo → [06 CLAUDE.md e memory](./06-claude-md-memory.md)
