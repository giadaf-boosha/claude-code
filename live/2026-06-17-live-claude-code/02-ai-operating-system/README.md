# Caso 2: Claude Code come AI Operating System

> Claude Code non e' solo un assistente nel terminale: e' un sistema operativo per il lavoro. Una **routine cloud** gira a **laptop spento** sull'infrastruttura Anthropic, la lanci e la monitori **dal telefono**, e al risveglio trovi il risultato pronto come **PR**. Qui la routine e' un "morning brief" AI/marketing sicuro, che scrive solo nella cartella output via branch + PR. Questa guida ti spiega cosa fa, perche' conta e come replicarla da solo.

## Cosa fa

La routine `morning-brief` esegue ogni mattina questi step, in autonomia:

1. **Parte da sola in cloud**: ogni mattina alle **07:00 Europe/Rome** si avvia sull'infrastruttura Anthropic, senza laptop acceso e senza sessione aperta (vedi [docs/13](../../../docs/13-routines-cloud.md)).
2. **Cerca le novita' delle ultime 24h**: legge fonti AI/LLM (Anthropic, OpenAI, Hugging Face, changelog Claude Code) e segnali marketing/GTM. Le fonti complete sono elencate in [`routine-prompt.md`](./routine-prompt.md) Step 1.
3. **Genera il brief**: massimo **8 voci**, ognuna con tipo, TLDR, "perche' conta" (taglio marketing) e fonte con URL.
4. **Scrive un file nuovo al giorno** in [`output/`](./output/): `brief-YYYY-MM-DD.md`, **mai** sovrascrivendo i precedenti.
5. **Apre branch + PR**: crea il branch `morning-brief/YYYY-MM-DD`, committa il solo file output e apre una PR con label `automation,morning-brief`. **Mai push diretto su `main`**.
6. **Si controlla dal telefono**: la routine si lancia (Run now) e si monitora dalla **mobile app** / UI web; **push notification** opzionale a fine run.
7. **Lascia il risultato pronto al risveglio**: la PR e' pronta per review umana. Auto-merge **non** attivo per default.
8. **Si mette in pausa quando serve**: dal toggle Pause/Resume (web/mobile) o, da CLI, con `/schedule pause <name>`.

> **Nota safety**: la routine scrive **esclusivamente** dentro [`output/`](./output/) e non tocca nessun altro file della repo. Mai push su `main`, mai `--force`, abort se `git status` non e' clean. I boundary completi sono nel prompt ([`routine-prompt.md`](./routine-prompt.md) Step 0 e Step 4).

## Perche' e' potente (laptop spento)

Il salto concettuale e' questo: si passa da "agent locale che gira finche' tieni aperta la sessione" (`/loop`) a "agent cloud che lavora per te in autonomia 24/7". Il lavoro si sposta dalla sessione interattiva all'esecuzione async: non "uso l'AI mentre lavoro" ma "trovo il lavoro gia' fatto quando arrivo". Per chi non scrive codice il messaggio e' semplice: il computer e' spento, ma il lavoro si fa lo stesso; lo lanci dal telefono come un'app e al risveglio trovi il riepilogo pronto.

Esistono due modalita' diverse, ed e' importante non confonderle:

### Modalita' A — Routine cloud (il "laptop spento")

Pro: gira su infra Anthropic, **laptop spento**, niente sessione aperta, niente CI esterna; gestione DST automatica; lanciabile e monitorabile da telefono.
Contro: richiede plan **Pro/Max/Team/Enterprise** (web access plan, non API-only) ed e' soggetta al daily cap routine (vedi [`setup-routine.md`](./setup-routine.md)).

E' la modalita' usata in questo caso: l'agent gira in cloud, fa fresh clone della repo ed esegue il prompt in autonomia, con permission governate dai boundary scritti nel prompt (path restricted, no push su main, PR review).

### Modalita' B — Remote Control (NON e' il caso "laptop spento")

Pro: piloti una **sessione locale** dal telefono in tempo reale (docs/17 § 17.6).
Contro: il terminale deve **restare aperto**, 1 sola connessione remota, timeout di rete 10 min, solo Pro/Max. Quindi per "laptop spento" si usano le **Routines**, non Remote Control. Remote Control e' per quando il laptop e' acceso e lo si pilota dal telefono.

## Come si attiva / come si usa

I comandi chiave (il dettaglio passo-passo, con prerequisiti e setup GitHub, e' in [`setup-routine.md`](./setup-routine.md)):

```
/web-setup                                   # collega l'accesso GitHub per le routine cloud
/schedule daily morning brief at 07:00 Europe/Rome   # crea la routine daily
/schedule list                               # verifica che la routine sia attiva e annota il nome
/schedule run morning-brief                  # esegue subito la routine senza aspettare le 07:00
```

`/schedule run <name>` (Run now) e' utile per testare la routine prima di fidarti dello schedule: non conta verso il daily cap (ma si' verso l'usage della subscription). Per il prompt da incollare quando Claude Code chiede "What should this routine do?", vedi [`routine-prompt.md`](./routine-prompt.md).

## File in questa cartella

| File | Cosa |
|---|---|
| [`README.md`](./README.md) | Questo file — overview del caso, perche' conta, mappa file, come si usa |
| [`routine-prompt.md`](./routine-prompt.md) | Prompt completo e self-contained della routine cloud (da incollare in `/schedule`) |
| [`setup-routine.md`](./setup-routine.md) | Istruzioni passo-passo: `/web-setup`, `/schedule`, verifica, run-now, pausa, controllo da telefono, costi, quota |
| [`output-esempio/brief-esempio.md`](./output-esempio/brief-esempio.md) | Esempio statico del tipo di output prodotto dalla routine (riferimento del formato) |
| [`output/`](./output/) | Cartella dove la routine scrive i brief reali (`brief-YYYY-MM-DD.md`) |

## Boundary del prompt (importante)

Guardrail espliciti nel prompt ([`routine-prompt.md`](./routine-prompt.md)):

- **Mai push diretto su `main`** — sempre branch `morning-brief/YYYY-MM-DD` + PR
- Niente push `--force` mai
- **Path write-restricted**: scrive solo dentro [`output/`](./output/), mai `README`, `docs/`, `spec.md`, `implementation_plan.md`, `archive/`, `examples/`, `posts/`, `skills/`
- Un file nuovo al giorno, **mai** rewrite dei precedenti
- Massimo **8 voci** per brief (filtro qualita')
- Se `git status` non clean prima del commit: **abort + log**
- Se nessuna novita' nelle 24h: scrive comunque il file con una nota, senza forzare
- PR resta in attesa di review umana. Auto-merge non attivo per default

## Costo stimato

| Voce | Costo per run | Costo mese (30 run) |
|---|---|---|
| Routine cloud (Sonnet) | ~25K token in + ~4K out | Incluso nel plan fino al cap; overage abilitabile (Max: tipicamente coperto) |
| Run now (test manuale) | conta verso usage subscription, **non** verso il daily cap | trascurabile |

Dettaglio costi e quota per plan in [`setup-routine.md`](./setup-routine.md).

## Troubleshooting

| Problema | Fix |
|---|---|
| Routine non compare | `/schedule list` per verificarla attiva; `/extra-usage` per check budget |
| Run now non parte | Verifica plan compatibile e quota residua; controlla `/web-setup` fatto |
| `/schedule pause` non risponde da CLI | Usa il toggle Pause/Resume dalla UI web o mobile (docs/13 § 13.8) |
| PR non si apre | Verifica `/web-setup` fatto e GitHub App autorizzata sul repo |
| Push notification non arriva | Opzionale (v2.1.110), richiede setup mobile via `/mobile`; non bloccante |

## Disabilitare temporaneamente

```bash
# Da CLI (se supportato dalla tua versione)
/schedule pause morning-brief

# In alternativa: toggle Pause/Resume dalla detail page (UI web o mobile)
```

## Riferimenti

- [docs/13 — Routines cloud](../../../docs/13-routines-cloud.md) — trigger, subcommands `/schedule`, quota, run management
- [docs/17 — IDE surface](../../../docs/17-ide-surface.md) — Remote Control, mobile, push notification
- [automations/daily-whats-new/](../../../automations/daily-whats-new/) — esempio reale di routine cloud nella repo

← [Indice](../README.md) · [README master](../../../README.md)
