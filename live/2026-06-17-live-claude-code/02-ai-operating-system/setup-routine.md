# Setup routine: Morning Brief (live demo)

> Istruzioni passo-passo per attivare la routine cloud `morning-brief`: collega GitHub, crea la routine daily 07:00 Europe/Rome, verifica, fai run-now per la demo, mettila in pausa. Tutti i comandi sono quelli reali documentati in [`docs/13`](../../../docs/13-routines-cloud.md) e [`docs/17`](../../../docs/17-ide-surface.md).

## Prerequisiti

- Claude Code installato (`claude --version`)
- Login **Pro / Max / Team / Enterprise** (le routine cloud richiedono web access plan, non API-only — vedi [docs/13 § 13.12](../../../docs/13-routines-cloud.md))
- Repo `giadaf-boosha/claude-code` clonata localmente
- GitHub App "Claude" autorizzata sul repo (`https://claude.ai/settings/apps`)

## Step 1 — Collega GitHub

Dalla root della repo, apri la sessione:

```bash
claude
```

Poi nella sessione:

```
/web-setup
```

`/web-setup` collega l'accesso GitHub per le routine cloud. Nota: e' una cosa diversa dalla **GitHub App** (trigger su eventi GitHub) — qui serve solo l'accesso repo per scheduled trigger.

## Step 2 — Crea la routine daily

Da CLI puoi creare **solo trigger scheduled** (API e GitHub trigger si configurano via web). Crea la routine in linguaggio naturale:

```
/schedule daily morning brief at 07:00 Europe/Rome
```

In alternativa, lancia `/schedule` senza argomenti per aprire il wizard interattivo, poi:

1. Quando chiede **"What should this routine do?"**, incolla **tutto** il contenuto di [`routine-prompt.md`](./routine-prompt.md)
2. Quando chiede lo **schedule**, indica "Every day at 07:00 in Europe/Rome timezone"
3. Quando chiede il **repo**, conferma `giadaf-boosha/claude-code`

> Nota sintassi: i preset scheduled documentati sono `hourly / daily / weekdays / weekly` (docs/13 § 13.3). Il cron custom si imposta con `/schedule update` (intervallo minimo 1 ora), **non** con flag tipo `--cron` / `--time` / `--tz` (non esistono). Times locali -> UTC convertiti automaticamente.

## Step 3 — Verifica

```
/schedule list
```

Mostra le routine attive con il loro nome. Annota il **nome** assegnato alla routine (es. `morning-brief`) — serve per run-now e pause.

## Step 4 — Run-now per la demo (test manuale)

```
/schedule run <name>
```

esempio:

```
/schedule run morning-brief
```

`Run now` esegue subito la routine senza aspettare le 07:00. Utile per la demo live e per testare prima di fidarsi dello schedule. **Run now NON conta verso il daily cap** (ma si' verso l'usage della subscription) — docs/13 § 13.9.

## Step 5 — Mettere in pausa

Dalla UI web/mobile (Run management, docs/13 § 13.8): **Pause/Resume** toggle sulla detail page della routine.

Da CLI i file automation del repo usano anche:

```
/schedule pause <name>
```

> Cautela: `/schedule pause` e' usato nei file automation del repo ma **non compare** nella lista subcommands ufficiale di docs/13 (`list`, `update`, `run <name>`). Se da CLI non risponde, usa il toggle Pause/Resume dalla UI web o mobile. Verifica con `/schedule --help` prima di affidartici in live.

---

## Controllo da telefono (mobile app / Remote Control)

Tutto quello che segue usa **solo** feature reali documentate in [docs/17](../../../docs/17-ide-surface.md).

### Setup app mobile

```
/mobile          # alias /ios, /android — mostra un QR code per il setup app
```

- **iOS**: app dedicata da App Store
- **Android**: via mobile web (`claude.ai/code`)
- Funzioni mobile documentate (docs/17 § 17.10): **Remote Control**, **Routines control**, **push notifications**, brief mode

### Lanciare / monitorare le routine da telefono

- **Routines control da mobile**: dall'app puoi vedere le routine, aprire la detail page, fare **Run now** e **Pause/Resume** (stesse azioni della UI web, docs/13 § 13.8). Cosi' triggeri il morning brief dal telefono.
- **Push notifications** (opzionali, v2.1.110): ricevi la notifica quando il run finisce. Cosi' al risveglio sai che la PR e' pronta.

### Remote Control (sessione locale dal telefono)

Diverso dalle routine: **Remote Control** collega una **sessione locale** al telefono (docs/17 § 17.6). Serve se vuoi continuare/ispezionare una sessione interattiva da mobile, non per far girare la routine cloud.

```
/remote-control            # in sessione (alias /rc)
claude --remote-control    # CLI flag
```

Limiti Remote Control (docs/17 § 17.6): 1 sola connessione remota per istanza, il terminale deve restare aperto, timeout di rete 10 min, solo Pro/Max. Quindi: per "laptop spento" usa le **Routines** (cloud), non Remote Control. Remote Control e' per quando il laptop e' acceso e vuoi pilotarlo dal telefono.

---

## Costi stimati

| Voce | Stima per run | Note |
|---|---|---|
| Routine cloud (Sonnet) | ~25K token in + ~4K out | WebFetch su poche fonti + 1 file output |
| Costo mese (30 run) | incluso nel plan fino al cap, oppure overage | Max plan: tipicamente coperto. Extra usage abilitabile per overage (docs/13 § 13.9) |
| Run-now demo | conta verso usage subscription, **non** verso daily cap | docs/13 § 13.9 |

## Limiti quota routine per plan

Cap giornaliero su **scheduled trigger** (docs/13 § 13.9):

| Plan | Routine scheduled / giorno |
|---|---|
| Pro | 5 |
| Max | 15 |
| Team / Enterprise | 25 |

> Webhook / API trigger **non** contano verso il cap. `Run now` non conta verso il daily cap (ma si' verso l'usage subscription). Extra usage abilitabile per overage.

## Riferimenti

- [docs/13 — Routines cloud](../../../docs/13-routines-cloud.md) — trigger, subcommands, quota, run management
- [docs/17 — IDE surface](../../../docs/17-ide-surface.md) — Remote Control, mobile, push notification
- [`routine-prompt.md`](./routine-prompt.md) — il prompt da incollare
- [`runbook-demo.md`](./runbook-demo.md) — copione della demo live

---

← [02-ai-operating-system](./README.md) · [README master](../../../README.md)
