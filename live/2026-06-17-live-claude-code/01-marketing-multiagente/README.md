# Caso d'uso 1: Team marketing AI multi-agente

> Da UN solo prompt, 5 subagent specializzati si passano il lavoro in catena e producono una campagna marketing completa per Boosha AI: ricerca competitor -> brief -> hook -> copy ads -> KPI/report. "Il team che lavora mentre dormi."

## Cosa fa

1. **Lanci un solo prompt** (`prompt-orchestratore.md`) in una sessione `claude` aperta in questa cartella.
2. **`competitor-researcher`** ricerca il panorama consulenza/formazione AI in Italia e scrive `output/01-competitor-research.md`.
3. **`brief-writer`** legge la ricerca e produce un brief di campagna strutturato in `output/02-brief-campagna.md`.
4. **`hook-generator`** trasforma il brief in 5 hook persuasivi distinti in `output/03-hook.md`.
5. **`ads-copywriter`** scrive 4 varianti di copy ads (LinkedIn + Meta) in `output/04-ads-copy.md`.
6. **`performance-reporter`** definisce KPI, proiezioni e struttura report in `output/05-report-kpi.md`.
7. **Handoff automatico**: ogni agent legge con `Read` il file dell'agent precedente e scrive il proprio con `Write`. L'orchestratore (Claude) li invoca in sequenza, senza intervento manuale.
8. **Risultato**: 5 deliverable concatenati = una campagna pronta da rivedere, a partire da un singolo input.

> **Nota safety**: questa demo NON pubblica ads e NON pusha nulla. I subagent scrivono solo file locali in `output/`. Nessun claim numerico reale viene generato: le proiezioni sono benchmark di settore marcati come stime da validare.

## Due modalita' di esecuzione

### Modalita' A — Live, catena reale (raccomandata)

Pro: mostra i subagent che si passano il lavoro davvero, file che compaiono uno dopo l'altro.
Contro: la ricerca web e' lo step piu' lento; tempo totale 4-7 minuti.

**Setup**:
```bash
# dalla cartella di questo caso
cd live/2026-06-17-live-claude-code/01-marketing-multiagente
claude
```
Poi incolla nel prompt il blocco delimitato in [`prompt-orchestratore.md`](./prompt-orchestratore.md) (sezione "PROMPT DA INCOLLARE").

Verifica durante l'esecuzione:
```bash
ls output/    # i file 01..05 compaiono in sequenza
```

### Modalita' B — Fallback con output di esempio (backup live)

Pro: istantaneo, zero attesa, utile se la live va lunga o la rete e' lenta.
Contro: non mostra gli agent che girano dal vivo.

**Uso**: apri [`output-esempio/campagna-boosha-esempio.md`](./output-esempio/campagna-boosha-esempio.md) e mostra il risultato gia' prodotto dalla catena, commentando come se fosse appena uscito.

## File in questa cartella

| File | Cosa |
|---|---|
| [`README.md`](./README.md) | Questo file |
| [`prompt-orchestratore.md`](./prompt-orchestratore.md) | Il singolo prompt copia-incolla che orchestra i 5 agent in catena |
| [`runbook-demo.md`](./runbook-demo.md) | Copione timed minuto-per-minuto per ~10 minuti di demo |
| [`.claude/agents/01-competitor-researcher.md`](./.claude/agents/01-competitor-researcher.md) | Subagent 1: ricerca competitor |
| [`.claude/agents/02-brief-writer.md`](./.claude/agents/02-brief-writer.md) | Subagent 2: brief di campagna |
| [`.claude/agents/03-hook-generator.md`](./.claude/agents/03-hook-generator.md) | Subagent 3: hook persuasivi |
| [`.claude/agents/04-ads-copywriter.md`](./.claude/agents/04-ads-copywriter.md) | Subagent 4: copy ads LinkedIn/Meta |
| [`.claude/agents/05-performance-reporter.md`](./.claude/agents/05-performance-reporter.md) | Subagent 5: KPI e report |
| [`output-esempio/campagna-boosha-esempio.md`](./output-esempio/campagna-boosha-esempio.md) | Output fallback completo (campagna gia' prodotta) |

## I 5 subagent

| # | Agent | Tools | Input | Output |
|---|---|---|---|---|
| 1 | `competitor-researcher` | WebSearch, WebFetch, Read, Write | {PRODOTTO/SERVIZIO} | `output/01-competitor-research.md` |
| 2 | `brief-writer` | Read, Write | file 01 | `output/02-brief-campagna.md` |
| 3 | `hook-generator` | Read, Write | file 02 | `output/03-hook.md` |
| 4 | `ads-copywriter` | Read, Write | file 03 (+ brief) | `output/04-ads-copy.md` |
| 5 | `performance-reporter` | Read, Write | file 04 + 02 | `output/05-report-kpi.md` |

## Perche' e' interessante per il pubblico

- **Per i principianti**: vedi un "team" di AI che si organizza da solo. Tu dai un'idea, loro si passano il lavoro come un'agenzia. Un prompt -> una campagna.
- **Per gli esperti**: i subagent sono file dichiarativi (`.claude/agents/*.md`) con frontmatter, tools scoping (solo `competitor-researcher` ha accesso al web), e handoff via filesystem. E' orchestrazione multi-agente senza scrivere codice: l'isolamento del contesto evita che un agent "inquini" il prompt del successivo.

## Talking points

**Per principianti**:
- "Non e' un chatbot che risponde: e' un team che produce deliverable."
- "Ogni agent fa una cosa sola e la fa bene, poi passa il testimone."
- "Tu controlli il risultato finale, non devi gestire i singoli passaggi."

**Per esperti**:
- Tools scoping per least-privilege: solo il researcher tocca la rete (`WebSearch`, `WebFetch`), gli altri sono `Read`/`Write` only.
- Handoff via file = stato esplicito e ispezionabile, non contesto implicito che si degrada.
- Context isolation: ogni subagent parte da un contesto pulito, riducendo drift e allucinazioni.
- I file `output/*` sono artefatti versionabili: la campagna e' riproducibile e diff-abile.

## Fallback se la live va lunga

Se la catena reale supera i tempi (rete lenta, ricerca web bloccata):
1. Interrompi senza drammi: "ve la faccio vedere gia' pronta".
2. Apri [`output-esempio/campagna-boosha-esempio.md`](./output-esempio/campagna-boosha-esempio.md).
3. Scorri ricerca -> brief -> hook -> ads -> KPI commentando l'handoff tra agent.
4. Chiudi sul concetto: "questo e' uscito da un prompt solo, mentre il team dormiva".

## Riferimenti

- [docs/08 — Subagents](../../../docs/08-subagents.md)
- [examples/personas — pattern .claude/agents](../../../examples/personas/)
- [prompt-orchestratore](./prompt-orchestratore.md) · [runbook demo](./runbook-demo.md)

← [live/](../) · [README master](../../../README.md)
