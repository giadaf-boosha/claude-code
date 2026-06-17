# Caso d'uso 1: Team marketing AI multi-agente

> Da UN solo prompt, 5 subagent specializzati si passano il lavoro in catena e producono una campagna marketing completa: ricerca competitor -> brief -> hook -> copy ads -> KPI/report. Un team che lavora mentre fai altro.

## Cosa fa

1. **Lanci un solo prompt** ([`prompt-orchestratore.md`](./prompt-orchestratore.md)) in una sessione `claude` aperta in questa cartella.
2. **`competitor-researcher`** ricerca il panorama consulenza/formazione AI in Italia e scrive `output/01-competitor-research.md`.
3. **`brief-writer`** legge la ricerca e produce un brief di campagna strutturato in `output/02-brief-campagna.md`.
4. **`hook-generator`** trasforma il brief in 5 hook persuasivi distinti in `output/03-hook.md`.
5. **`ads-copywriter`** scrive 4 varianti di copy ads (LinkedIn + Meta) in `output/04-ads-copy.md`.
6. **`performance-reporter`** definisce KPI, proiezioni e struttura report in `output/05-report-kpi.md`.
7. **Handoff automatico**: ogni agent legge con `Read` il file dell'agent precedente e scrive il proprio con `Write`. L'orchestratore (Claude) li invoca in sequenza, senza intervento manuale.
8. **Risultato**: 5 deliverable concatenati = una campagna pronta da rivedere, a partire da un singolo input.

> **Nota safety**: questa catena NON pubblica ads e NON pusha nulla. I subagent scrivono solo file locali in `output/`. Nessun claim numerico reale viene generato: le proiezioni sono benchmark di settore marcati come stime da validare.

## Come si usa

La catena reale si esegue in tre passi. Tempo tipico: 4-7 minuti (la ricerca web e' lo step piu' lento).

**1. Apri una sessione `claude` nella cartella del caso:**

```bash
cd live/2026-06-17-live-claude-code/01-marketing-multiagente
claude
```

**2. Incolla il prompt orchestratore.**

Apri [`prompt-orchestratore.md`](./prompt-orchestratore.md), copia il blocco delimitato nella sezione "PROMPT DA INCOLLARE" e incollalo nella sessione. Quel blocco contiene la variabile `{PRODOTTO/SERVIZIO}` gia' compilata: l'orchestratore creera' la cartella `output/` e invochera' i 5 subagent in sequenza.

**3. Verifica i file in output.**

Mentre la catena gira, i file compaiono uno dopo l'altro:

```bash
ls output/    # i file 01..05 compaiono in sequenza
```

A fine catena trovi 5 file numerati in `output/`, dalla ricerca competitor al report KPI. L'orchestratore stampa anche un riepilogo finale con la value proposition scelta, i 2 hook consigliati per A/B test e il KPI primario.

> Se vuoi vedere com'e' fatto il risultato senza eseguire la catena, in [`output-esempio/campagna-boosha-esempio.md`](./output-esempio/campagna-boosha-esempio.md) trovi un esempio di output gia' pronto da consultare, con tutte e 5 le fasi concatenate.

## File in questa cartella

| File | Cosa |
|---|---|
| [`README.md`](./README.md) | Questo file |
| [`prompt-orchestratore.md`](./prompt-orchestratore.md) | Il singolo prompt copia-incolla che orchestra i 5 agent in catena |
| [`.claude/agents/01-competitor-researcher.md`](./.claude/agents/01-competitor-researcher.md) | Subagent 1: ricerca competitor |
| [`.claude/agents/02-brief-writer.md`](./.claude/agents/02-brief-writer.md) | Subagent 2: brief di campagna |
| [`.claude/agents/03-hook-generator.md`](./.claude/agents/03-hook-generator.md) | Subagent 3: hook persuasivi |
| [`.claude/agents/04-ads-copywriter.md`](./.claude/agents/04-ads-copywriter.md) | Subagent 4: copy ads LinkedIn/Meta |
| [`.claude/agents/05-performance-reporter.md`](./.claude/agents/05-performance-reporter.md) | Subagent 5: KPI e report |
| [`output-esempio/campagna-boosha-esempio.md`](./output-esempio/campagna-boosha-esempio.md) | Esempio di output completo (campagna gia' prodotta dalla catena) |

## I 5 subagent

| # | Agent | Tools | Input | Output |
|---|---|---|---|---|
| 1 | `competitor-researcher` | WebSearch, WebFetch, Read, Write | {PRODOTTO/SERVIZIO} | `output/01-competitor-research.md` |
| 2 | `brief-writer` | Read, Write | file 01 | `output/02-brief-campagna.md` |
| 3 | `hook-generator` | Read, Write | file 02 | `output/03-hook.md` |
| 4 | `ads-copywriter` | Read, Write | file 03 (+ brief) | `output/04-ads-copy.md` |
| 5 | `performance-reporter` | Read, Write | file 04 + 02 | `output/05-report-kpi.md` |

## Perche' conta

**Se parti da zero**: ottieni un "team" di AI che si organizza da solo. Tu dai un'idea, i subagent si passano il lavoro come un'agenzia: ricerca, brief, hook, copy e report. Un prompt -> una campagna pronta da rivedere. Ogni agent fa una cosa sola e la fa bene, poi passa il testimone; tu controlli il risultato finale, non devi gestire i singoli passaggi.

**Se sei tecnico**: i subagent sono file dichiarativi (`.claude/agents/*.md`) con frontmatter e tools scoping. Solo `competitor-researcher` ha accesso alla rete (`WebSearch`, `WebFetch`); gli altri sono `Read`/`Write` only, in logica least-privilege. L'handoff avviene via filesystem: lo stato e' esplicito e ispezionabile, non contesto implicito che si degrada. Ogni subagent parte da un contesto pulito (context isolation), riducendo drift e allucinazioni, e i file `output/*` sono artefatti versionabili e diff-abili, quindi la campagna e' riproducibile. E' orchestrazione multi-agente senza scrivere una riga di codice.

## Adattabile ad altri prodotti

La catena non e' legata a un brand specifico. Per usarla su un altro prodotto o servizio basta cambiare la variabile `{PRODOTTO/SERVIZIO}` dentro il prompt orchestratore: descrivi il tuo prodotto, il target, il tono e i vincoli, e i 5 subagent producono ricerca, brief, hook, copy e report calibrati su quel contesto. I file degli agent restano invariati.

## Riferimenti

- [docs/08 — Subagents](../../../docs/08-subagents.md)
- [examples/personas — pattern .claude/agents](../../../examples/personas/)
- [prompt-orchestratore](./prompt-orchestratore.md)

← [Indice](../) · [README master](../../../README.md)
