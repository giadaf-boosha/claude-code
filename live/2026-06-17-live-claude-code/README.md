# Due casi d'uso pratici di Claude Code

> Qui trovi due casi d'uso reali di **Claude Code**, completi di prompt pronti da copiare e file da riutilizzare: un team marketing AI multi-agente e Claude Code usato come "AI Operating System". Materiale nato per la live Boosha AI del 17 giugno 2026, riutilizzabile da chiunque (dev e non-dev) per replicare i due scenari in autonomia.

## I due casi d'uso

| Caso | Cartella | Sintesi (1 riga) |
|---|---|---|
| 1 — Team marketing AI multi-agente | [`01-marketing-multiagente/`](./01-marketing-multiagente/) | Da un solo prompt, 5 subagent specializzati si passano il lavoro in catena e producono una campagna marketing completa per Boosha AI. |
| 2 — Claude Code come AI Operating System | [`02-ai-operating-system/`](./02-ai-operating-system/) | Una routine cloud gira a laptop spento, la lanci e la monitori dal telefono, e al risveglio trovi il risultato pronto come PR. |

### Caso 1 — Team marketing AI multi-agente

Lanci **un solo prompt** e Claude Code orchestra **5 subagent specializzati** che si passano il lavoro in sequenza: ricerca competitor -> brief di campagna -> hook -> copy ads -> KPI/report. Ogni agent legge l'output di quello precedente e scrive il proprio file, senza intervento manuale, producendo 5 deliverable concatenati = una campagna marketing pronta da rivedere. Impari a costruire una pipeline multi-agente reale, leggibile anche se non scrivi codice, e porti a casa il prompt orchestratore e gli output di esempio gia' pronti.

### Caso 2 — Claude Code come AI Operating System

Una **routine cloud** schedulata gira ogni mattina sull'infrastruttura Anthropic **a laptop spento**, senza sessione aperta: ricerca le novita' AI/marketing delle ultime 24h, genera un "morning brief" e lo consegna come **Pull Request** pronta per la review. La lanci e la monitori **dal telefono**, e al risveglio trovi il lavoro gia' fatto. Impari a spostare il focus da "assistente di coding che uso mentre lavoro" a "sistema operativo per il lavoro che lavora per me in autonomia 24/7", con boundary di sicurezza espliciti (scrive solo in `output/`, mai push diretto su `main`).

## Come usare questo materiale

**Prerequisiti**:

- **Caso 1**: Claude Code installato e una sessione `claude` avviabile dal terminale. Funziona su qualsiasi piano.
- **Caso 2**: oltre a Claude Code, un piano **Pro/Max/Team/Enterprise** (web access plan, non API-only), perche' le routine cloud girano sull'infrastruttura Anthropic.

**Come procedere**: entra nella cartella del caso che ti interessa e segui il suo `README.md`. Ogni caso e' self-contained e contiene la mappa file esatta, i prompt pronti da copiare, i boundary di sicurezza, i costi e il troubleshooting.

- Caso 1 -> [`01-marketing-multiagente/`](./01-marketing-multiagente/)
- Caso 2 -> [`02-ai-operating-system/`](./02-ai-operating-system/)

## File in questa cartella

| File | Cosa |
|---|---|
| [`README.md`](./README.md) | Questo file — pagina di benvenuto ai due casi d'uso |
| [`01-marketing-multiagente/`](./01-marketing-multiagente/) | Caso 1 — team marketing AI multi-agente per Boosha AI |
| [`02-ai-operating-system/`](./02-ai-operating-system/) | Caso 2 — Claude Code come AI Operating System (routine cloud, controllo da telefono) |

## Riferimenti

- [docs/13 — Routines cloud](../../docs/13-routines-cloud.md) (base del Caso 2)
- [automations/daily-whats-new/](../../automations/daily-whats-new/) (esempio reale di routine cloud nella repo)
- [README master](../../README.md)

← [live/](../) · [README master](../../README.md)
