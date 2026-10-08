# 05 — Fast mode, 1M context, Opus 5, Fable 5

> 📍 [README](../README.md) → [Workflow](../README.md#workflow) → **05 Fast mode + 1M context**
> 🔧 Operational · 🟡 Intermediate

Feature legate ai modelli: il **fast mode** (Opus 5 e Opus 4.8 di default, da v2.1.219), il **context window da 1M token GA**, gli **effort level** (default `high`, `xhigh` per i task piu' duri, piu' `ultracode`), **Claude Opus 5** come nuovo modello premium (v2.1.219, 24 lug 2026), **Claude Fable 5** come primo modello Mythos-class disponibile pubblicamente (v2.1.170), **Claude Sonnet 5** come modello di default (v2.1.197, 30 giu 2026), **Claude Opus 5.5** come nuovo modello Opus di default, con Pro e Team Standard che passano da Sonnet a Opus (v2.1.280, 22 set 2026), e la famiglia **Claude 5.5** completata da Sonnet 5.5 (v2.1.284, 28 set 2026) e **Haiku 5.5** (v2.1.293, 7 ott 2026).

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

**Da v2.1.219 (24 lug 2026)**, Opus 4.7 e' stato rimosso da Fast mode: `/fast` copre ora **Opus 5** e Opus 4.8 (vedi [5.9](#59-claude-opus-5-da-v21219)).

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
| Task complesso massima qualita', premium default Max | Opus 5 (`/model claude-opus-5`) + effort `high` (vedi [5.9](#59-claude-opus-5-da-v21219)) |
| Task complesso, pinned su modello precedente | Opus 4.8 + `xhigh` o `max` |
| Task duro con workflow automatico | Opus 5 o Opus 4.8 + `ultracode` (vedi [./24-workflows.md](./24-workflows.md)) |
| Default ragionamento | Opus 5 + `high` (effort di default) |
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

<sub>Aggiornato 2026-06-10 via daily what's new. Fonte: [GitHub Releases v2.1.170](https://github.com/anthropics/claude-code/releases/tag/v2.1.170) · [Anthropic docs](https://platform.claude.com/docs/en/about-claude/models/introducing-claude-fable-5-and-claude-mythos-5).</sub>

### Fable 5.1 — nuovo modello Fable di default (da v2.1.257)

Dal 1 settembre 2026 (v2.1.257), `claude-fable-5-1` sostituisce Fable 5 come modello Fable di default in Claude Code e sulla Claude Platform. Stesso pricing di Fable 5 ($10/MTok input, $50/MTok output), ma cache read tagliate del 75% ($0.25/MTok contro $1/MTok). Rispetto al predecessore arriva piu' lontano in un task lungo prima di aver bisogno di input, segnala meglio quando e' bloccato, e ha uno stile di scrittura piu' naturale.

```bash
/model claude-fable-5-1
```

Nei gateway (Claude apps gateway, deployment di terze parti) non ancora aggiornati per Fable 5.1, gli alias `fable` e `best` continuano a risolvere su Fable 5 fino all'aggiornamento del gateway; selezionare `claude-fable-5-1` esplicitamente in `/model` per usare la nuova versione.

<sub>Aggiornato 2026-09-02 via daily what's new. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2094851229734277228) · [GitHub Releases v2.1.257](https://github.com/anthropics/claude-code/releases/tag/v2.1.257).</sub>

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

## 5.9 Claude Opus 5 (da v2.1.219)

### Annunciato
v2.1.219 (24 luglio 2026). `claude-opus-5` diventa il **nuovo modello Opus premium** in Claude Code — Anthropic lo descrive come vicino alla frontiera di Fable 5 su gran parte dei benchmark, a meta' del prezzo. Diventa il modello di default su **Max** e il piu' forte disponibile su **Pro**.

### Come si usa in Claude Code
```bash
/model claude-opus-5      # esplicito
/effort low|medium|high   # bilancia costo/capacita' su Opus 5
```

### Caratteristiche principali
| Caratteristica | Valore |
|---|---|
| Model ID | `claude-opus-5` |
| Context window | 1M token |
| Output max per request | 128k token |
| Pricing standard | $5/MTok input, $25/MTok output (invariato vs Opus 4.8) |
| Pricing Fast Mode | $10/MTok input, $50/MTok output |
| Thinking | On di default |
| Effort toggle | `low` / `medium` / `high` per bilanciare costo e capacita' del task |
| Sicurezza | Modello Anthropic meno "prompt-injectable" ad oggi (probe + red teaming); combinato con Auto Mode in Claude Code riduce ulteriormente il tasso di successo degli attacchi |

### Relazione con Opus 4.8 e Fast mode
Opus 4.7 e' stato rimosso da Fast mode: da v2.1.219 `/fast` copre **Opus 5** e Opus 4.8 (vedi [5.1](#51-fast-mode-opus-48-di-default-da-v21154)). Opus 4.8 resta disponibile via `/model claude-opus-4-8` per chi vuole restare pinned sul modello precedente.

<sub>Aggiornato 2026-07-26 via daily what's new. Fonte: [Anthropic news](https://www.anthropic.com/news/claude-opus-5) · [GitHub Releases v2.1.219](https://github.com/anthropics/claude-code/releases/tag/v2.1.219).</sub>

---

## 5.10 Claude Opus 5.5 (da v2.1.280)

### Annunciato
v2.1.280 (22 settembre 2026). `claude-opus-5-5` diventa il **nuovo modello Opus di default** in Claude Code e nella Claude app (incluso Cowork), su Pro, Max e Team. E' il primo modello della nuova famiglia Claude 5.5: performa al livello di Fable 5.1 sulla gran parte dei task, con output oltre il 30% piu' veloce e un costo di esercizio il 40% piu' basso di Opus 5. Contestualmente, il modello di default su **Pro e Team Standard passa da Sonnet a Opus**, allineandosi a Max/Team Premium/Enterprise.

### Come si usa in Claude Code
```bash
/model claude-opus-5-5   # esplicito
/model claude-opus-5     # per restare sul predecessore
```

### Caratteristiche principali
| Caratteristica | Valore |
|---|---|
| Model ID | `claude-opus-5-5` |
| Context window | 1M token |
| Pricing standard | $4/MTok input, $20/MTok output (-20% vs Opus 5) |
| Cache read | $0.20/MTok (-60% vs Opus 5) |
| Velocita' output | Oltre il 30% piu' veloce di Opus 5 |
| Rate limit | Vanno il 25% piu' lontano rispetto a Opus 5 a parita' di piano |
| Disponibilita' | Anthropic API, AWS, Google Cloud, Microsoft Foundry |

### Relazione con Opus 5 e default dei piani
Opus 5 resta selezionabile via `/model claude-opus-5`. Da v2.1.280 anche i piani **Pro** e **Team Standard** passano a Opus come modello di default (in precedenza Sonnet) — vedi [1.1](./01-snapshot.md#11-versioni-e-modelli). Con **Sonnet 5.5** (28 settembre, [5.11](#511-claude-sonnet-55-da-v21284)) e **Haiku 5.5** (7 ottobre, [5.12](#512-claude-haiku-55-da-v21293)) la famiglia Claude 5.5 e' ora completa su tutti i livelli.

<sub>Aggiornato 2026-09-23 via daily what's new. Fonte: [Anthropic](https://www.anthropic.com/claude-opus-5-5) · [GitHub Releases v2.1.280](https://github.com/anthropics/claude-code/releases/tag/v2.1.280).</sub>

---

## 5.11 Claude Sonnet 5.5 (da v2.1.284)

### Annunciato
v2.1.284 (28 settembre 2026). `claude-sonnet-5-5` diventa il **nuovo modello Sonnet di default** sulla Claude API e in Claude Code, sostituendo Sonnet 5. E' il secondo modello della famiglia Claude 5.5 dopo Opus 5.5 (vedi [5.10](#510-claude-opus-55-da-v21280)): stesso pricing del predecessore, output oltre il 30% piu' veloce e un numero di token/tool call per task nettamente inferiore, con un salto su Terminal-Bench 4.0 dal 10,3% di Sonnet 5 al 70,6%. E' anche la prima Sonnet a ricevere safeguard e fallback cyber equivalenti a quelli riservati finora a Opus 5, oltre al watermarking invisibile del testo generato.

### Come si usa in Claude Code
```bash
/model claude-sonnet-5-5   # esplicito
/model claude-sonnet-5     # per restare sul predecessore
```

### Caratteristiche principali
| Caratteristica | Valore |
|---|---|
| Model ID | `claude-sonnet-5-5` |
| Context window | 1M token (nativo) |
| Pricing | $2/MTok input, $10/MTok output (invariato vs Sonnet 5) |
| Cache read | $0.20/MTok |
| Velocita' output | Oltre il 30% piu' veloce di Sonnet 5, meno token/tool call per task equivalente |
| Terminal-Bench 4.0 | 70,6% (Sonnet 5: 10,3%) |
| Sicurezza | Prima Sonnet con cyber safeguard/fallback al livello di Opus 5; watermarking invisibile del testo |
| Disponibilita' | Claude API, Claude Platform; anche in GitHub Copilot dallo stesso giorno |

### Relazione con Sonnet 5 e Opus 5.5
Sonnet 5 resta selezionabile via `/model claude-sonnet-5`. Con Sonnet 5.5 la famiglia Claude 5.5 copre sia il livello premium (Opus 5.5, [5.10](#510-claude-opus-55-da-v21280)) che il default di massa; il livello small-model e' coperto da **Haiku 5.5** dal 7 ottobre 2026 ([5.12](#512-claude-haiku-55-da-v21293)).

<sub>Aggiornato 2026-09-29 via daily what's new. Fonte: [Anthropic](https://www.anthropic.com/claude-sonnet-5-5) · [GitHub Releases v2.1.284](https://github.com/anthropics/claude-code/releases/tag/v2.1.284).</sub>

---

## 5.12 Claude Haiku 5.5 (da v2.1.293)

### Annunciato
v2.1.293 (7 ottobre 2026). `claude-haiku-5-5` diventa il **nuovo modello Haiku di default** sulla Claude API, terzo e ultimo tassello della famiglia Claude 5.5 dopo Opus 5.5 ([5.10](#510-claude-opus-55-da-v21280)) e Sonnet 5.5 ([5.11](#511-claude-sonnet-55-da-v21284)). Anthropic lo descrive come "il modello small piu' economico, veloce e capace mai rilasciato": pensato per lavoro ad alto volume — riassunti, compaction, query su database, classificazione — e utilizzabile come sub-agent di coding affiancato a Opus 5.5/Sonnet 5.5 (es. Devin CLI di Cognition lo usa come "sidekick" con Opus 5.5 come lead). E' la prima Haiku con **effort regolabile**.

### Come si usa in Claude Code
```bash
/model claude-haiku-5-5   # esplicito
/model claude-haiku-4-5   # per restare sul predecessore
```

### Caratteristiche principali
| Caratteristica | Valore |
|---|---|
| Model ID | `claude-haiku-5-5` |
| Context window | 1M token |
| Pricing (prompt ≤100K) | $0,10/MTok input, $0,50/MTok output |
| Pricing (prompt >100K) | $0,50/MTok input, $2,50/MTok output |
| Cache read / write | $0,01 / $0,125 per MTok (≤100K) |
| Costo vs Haiku 4.5 | Circa -75% in media |
| Effort | Regolabile (prima volta su una Haiku) |
| Terminal-Bench 4.0 | 39,2% (Haiku 4.5: 0,0%; Sonnet 5.5: 70,6%) |
| Disponibilita' | Claude API, AWS, Google Cloud, Microsoft Azure |

### Relazione con Haiku 4.5 e uso come sub-agent
Haiku 4.5 resta selezionabile via `/model claude-haiku-4-5`. Haiku 5.5 e' indicato per i sub-agent Claude Code su task ristretti (es. `Explore`, riassunti di contesto) dove Opus 5.5/Sonnet 5.5 sarebbero sovradimensionati — vedi [8](./08-subagents.md) per la configurazione del modello dei sub-agent.

<sub>Aggiornato 2026-10-08 via daily what's new. Fonte: [Anthropic](https://www.anthropic.com/claude-haiku-5-5) · [GitHub Releases v2.1.293](https://github.com/anthropics/claude-code/releases/tag/v2.1.293).</sub>

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
