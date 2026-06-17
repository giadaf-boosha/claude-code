# Runbook demo: Caso 2 — AI Operating System (~10 min)

> Copione cronometrato per la demo live del Caso 2. Target ~8-9 min di demo dentro lo slot 19:00-19:30 (vedi [README live](../README.md)). Tutti i comandi sono reali e documentati: [docs/13](../../../docs/13-routines-cloud.md) e [docs/17](../../../docs/17-ide-surface.md). Tenere un cronometro visibile.

## Prima di salire (setup, NON durante la demo)

- [ ] Routine `morning-brief` gia' creata e schedulata (vedi [`setup-routine.md`](./setup-routine.md), Step 1-3). **Non** crearla live: troppo lenta e fragile.
- [ ] Sessione `claude` aperta dalla root della repo, font ingrandito per proiezione.
- [ ] Telefono carico, app mobile gia' loggata, schermo del telefono mostrabile (mirroring o ripresa).
- [ ] `/extra-usage` controllato: budget sufficiente per un Run now.
- [ ] Tab GitHub PR del repo gia' aperto.
- [ ] Fallback pronto in un tab: [`output-esempio/brief-esempio.md`](./output-esempio/brief-esempio.md).
- [ ] Notifiche di sistema silenziate (tranne quelle di Claude, se mostri la push).

## Copione cronometrato

| Tempo | Blocco | Cosa fai / dici |
|---|---|---|
| 0:00-1:00 | **Hook** | "Il caso precedente lavora mentre io sono al computer. Questo lavora mentre il computer e' **spento**." Chiudi/metti da parte il laptop per un istante per enfatizzare. Una frase: "Claude Code non e' solo un assistente nel terminale, e' un sistema operativo per il lavoro: routine che girano nel cloud, le governo dal telefono." |
| 1:00-2:30 | **Concetto cloud** | Mostra `/schedule list` in sessione. Indica la routine `morning-brief` schedulata 07:00 Europe/Rome. Spiega: gira su infra Anthropic, niente laptop acceso, niente sessione aperta, fresh clone della repo (docs/13 § 13.1). "E' l'agent loop, ma in cloud." |
| 2:30-4:30 | **Trigger live** | Lancia `/schedule run morning-brief` (Run now). Mentre parte, spiega cosa fa: legge novita' AI/marketing delle 24h, genera max 8 voci, scrive **un solo file** in `output/` e apre una **PR** — mai push su `main`. Sottolinea i boundary: path ristretto, abort se repo non clean. |
| 4:30-6:30 | **Il telefono** | Prendi il telefono. Mostra l'app mobile: la stessa routine, la detail page, il bottone **Run now** e **Pause/Resume** (docs/13 § 13.8, docs/17 § 17.10). "La lancio e la monitoro da qui." Se hai le **push notification** attive (v2.1.110), mostra la notifica di fine run. Messaggio: "Posso essere ovunque, il lavoro arriva pronto." |
| 6:30-8:00 | **La PR pronta** | Torna al laptop (o mostra da telefono il link PR). Apri la **PR** su GitHub creata dal run: branch `live-demo-brief/YYYY-MM-DD`, label `automation,live-demo-brief`, il file `brief-YYYY-MM-DD.md`. Apri il file: 8 voci con fonte, sezione "Take del giorno". "Questo e' quello che troverei al risveglio. Lo rivedo e mergio." |
| 8:00-8:45 | **Chiusura** | Sintesi del livello: "Il Caso 1 e' l'assistente di oggi, il Caso 2 e' la piattaforma di domani. Async, cloud, mobile." Ponte al Q&A. |
| 8:45-10:00 | **Q&A buffer** | Vedi domande probabili sotto. Se il Run now e' lento, usa questo tempo come copertura e mostra il fallback. |

## Comandi esatti da digitare (in ordine)

```text
/schedule list
/schedule run morning-brief
```

(Opzionale, dal telefono: detail page della routine -> Run now / Pause-Resume; mostra la push notification.)

> Sintassi verificata in docs/13 § 13.4 (`/schedule list`, `/schedule run <name>`). NON usare flag inventati tipo `--cron` / `--time` / `--tz`: non esistono.

## Domande probabili (Q&A)

| Domanda | Risposta breve |
|---|---|
| "Gira davvero a laptop spento?" | Si', la routine cloud esegue su infra Anthropic. Remote Control invece richiede il terminale aperto: e' una cosa diversa (docs/17 § 17.6). |
| "E se fa danni in autonomia?" | Boundary nel prompt: scrive solo in `output/`, mai push su `main`, apre solo PR per review umana, abort se repo non clean. Auto-merge non attivo per default. |
| "Quanto costa / quante ne posso lanciare?" | Cap scheduled per plan: Pro 5, Max 15, Team/Enterprise 25 al giorno. Run-now e webhook/API non contano verso il cap (docs/13 § 13.9). |
| "Posso triggerarla da un evento, non solo a orario?" | Si': trigger API (webhook con bearer token) e GitHub event, ma si configurano da web, non da CLI (docs/13 § 13.3-13.4). |
| "Funziona su qualsiasi piano?" | Serve un web access plan (Pro/Max/Team/Enterprise), non API-only. No Bedrock/Vertex, no ZDR org (docs/13 § 13.12). |

## Piano B (se la demo live fallisce)

1. **Run now lento o in timeout**: non aspettare. Apri il fallback [`output-esempio/brief-esempio.md`](./output-esempio/brief-esempio.md) e racconta "questo e' il tipo di output". Mostra una PR gia' mergiata dei giorni precedenti se disponibile.
2. **`/schedule run` non risponde**: mostra `/schedule list` (la routine esiste) e spiega il concetto col fallback. Il messaggio "gira a laptop spento" non dipende dal trigger live.
3. **Niente rete**: usa hotspot da telefono (gia' in checklist live). Se cade tutto, la demo diventa narrativa sul file di esempio + screenshot di una PR.
4. **GitHub/PR non si apre**: mostra il file `output-esempio/brief-esempio.md` come surrogato del deliverable; spiega che in condizioni normali finisce in PR.

> Regola d'oro: la tesi della demo ("laptop spento, lavoro pronto al risveglio") deve reggere **anche** senza il trigger live. Il fallback statico la dimostra comunque.

## Riferimenti

- [`setup-routine.md`](./setup-routine.md) — come la routine e' stata creata e si controlla
- [`routine-prompt.md`](./routine-prompt.md) — cosa fa esattamente la routine
- [docs/13 — Routines cloud](../../../docs/13-routines-cloud.md) · [docs/17 — IDE surface](../../../docs/17-ide-surface.md)

← [02-ai-operating-system](./README.md) · [README master](../../../README.md)
