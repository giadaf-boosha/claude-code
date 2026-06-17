# Live Claude Code — 17 giugno 2026

> Materiale per lo slot di **Giada Franceschini** (Boosha AI) alla live del **17 giugno 2026, 18:00-20:00 (ora italiana)**. Slot personale: **19:00-19:30** (20 min di demo + 10 min Q&A). Focus esclusivo su **Claude Code**, pubblico misto (dev e non-dev). Questo file e' l'indice del materiale e contiene anche il testo di risposta da inviare all'organizzatore.

## Contesto evento

| Voce | Dettaglio |
|---|---|
| Data | 17 giugno 2026 |
| Orario evento | 18:00-20:00 (Europe/Rome) |
| Slot Giada | 19:00-19:30 |
| Struttura slot | 20 min demo + 10 min Q&A |
| Tema | Claude Code (solo Claude Code, niente altri prodotti) |
| Pubblico | Misto: sviluppatori e non-sviluppatori |
| Speaker | Giada Franceschini — Boosha AI |

## Agenda dei 20 minuti

> Due demo, da mostrare **in quest'ordine**: prima il caso concreto e tangibile (team marketing multi-agente), poi la visione di piattaforma (AI Operating System). Si parte dal "cosa fa per me oggi" e si chiude con il "dove sta andando".

1. **Apertura** (~1 min) — chi sono, cosa e' Claude Code in una frase, cosa vedremo.
2. **Caso 1 — Team marketing AI multi-agente** (~8-9 min) — vedi [`01-marketing-multiagente/`](./01-marketing-multiagente/).
3. **Caso 2 — Claude Code come AI Operating System** (~8-9 min) — vedi [`02-ai-operating-system/`](./02-ai-operating-system/).
4. **Chiusura + ponte al Q&A** (~1-2 min, buffer) — sintesi dei due livelli (assistente oggi / piattaforma domani), invito alle domande.
5. **Q&A** (10 min, fuori dai 20 di demo).

## I due casi d'uso

| Caso | Cartella | Sintesi (1 riga) |
|---|---|---|
| 1 — Team marketing AI multi-agente | [`01-marketing-multiagente/`](./01-marketing-multiagente/) | Claude Code orchestra piu' agent specializzati che producono contenuti marketing per Boosha AI in parallelo, come un team. |
| 2 — Claude Code come AI Operating System | [`02-ai-operating-system/`](./02-ai-operating-system/) | Routine cloud che girano a laptop spento, governate dal telefono: Claude Code come sistema operativo per il lavoro, non solo come assistente di coding. |

### Ordine e razionale

- **Prima il Caso 1**: e' visivamente leggibile anche per chi non scrive codice (output marketing concreto), aggancia subito il pubblico misto e mostra il multi-agente "dal vivo".
- **Poi il Caso 2**: alza lo sguardo dalla singola sessione alla piattaforma (cloud, async, mobile). Chiude con la visione e prepara naturalmente il Q&A.

## Timing dei 20 minuti

| Blocco | Durata | Note |
|---|---|---|
| Apertura | 1 min | Hook + una frase su cosa e' Claude Code |
| Caso 1 — marketing multi-agente | 8-9 min | Demo live, output visibile |
| Caso 2 — AI Operating System | 8-9 min | Routine cloud + controllo da telefono |
| Chiusura + buffer | 1-2 min | Recupero se una demo sfora; ponte al Q&A |
| **Totale demo** | **20 min** | Q&A separato, 10 min |

> **Nota timing**: il buffer di 1-2 min e' la prima cosa da sacrificare se una demo va lunga. Tenere un cronometro visibile. Se il Caso 1 sfora oltre i 10 min, tagliare la parte di setup e mostrare solo l'output gia' generato.

## Checklist pre-live

### Da testare PRIMA (il giorno prima e 30 min prima)

- [ ] Eseguire un dry-run completo di entrambe le demo end-to-end, cronometrato.
- [ ] Verificare connessione internet stabile + piano B (hotspot da telefono).
- [ ] Caso 1: confermare che gli agent partano e producano output entro il timing previsto; avere un output gia' generato come fallback.
- [ ] Caso 2: confermare che la routine cloud sia gia' schedulata e che l'ultimo run sia visibile da telefono (`/schedule list`).
- [ ] Verificare login/autenticazione attivi (sessione Claude Code, accesso GitHub via `/web-setup` se serve al Caso 2).
- [ ] Controllare il budget usage (`/extra-usage`) per non esaurire le routine durante la live.
- [ ] Silenziare notifiche di sistema, chat e mail; modalita' non disturbare.

### Da aprire PRIMA di salire (finestra/tab pronti)

- [ ] Terminale nella cartella [`01-marketing-multiagente/`](./01-marketing-multiagente/) con sessione Claude Code pronta.
- [ ] Telefono con app/interfaccia per mostrare la routine cloud del Caso 2 (laptop spento o messo da parte per l'effetto "AI Operating System").
- [ ] Questo README aperto come traccia/scaletta.
- [ ] Font del terminale ingrandito per leggibilita' in proiezione.
- [ ] Output di fallback di entrambe le demo aperto in un tab, pronto se una demo fallisce live.

## Risposta alla mail

> Testo pronto da inviare all'organizzatore per dichiarare i due task scelti ed evitare sovrapposizioni con gli altri ospiti. Copiare e incollare; sostituire `[Nome organizzatore]` con il nome reale.

---

Oggetto: Live 17 giugno — i miei due task (slot 19:00-19:30)

Ciao [Nome organizzatore],

confermo la mia presenza per lo slot delle 19:00-19:30 del 17 giugno. Per evitare sovrapposizioni con gli altri ospiti, ti anticipo i due task che mostrero', entrambi 100% su Claude Code:

1. **Team marketing AI multi-agente** — Claude Code che orchestra piu' agent specializzati in parallelo per produrre contenuti marketing reali (caso Boosha AI). L'idea e' far vedere il multi-agente "dal vivo", in modo leggibile anche per chi non scrive codice.

2. **Claude Code come AI Operating System** — routine cloud che girano a laptop spento, governate dal telefono. Sposto il focus da "assistente di coding" a "sistema operativo per il lavoro", chiudendo sulla visione di piattaforma.

Struttura prevista: ~20 min di demo (circa 8-9 min a caso, con un piccolo buffer) + 10 min di Q&A.

Se qualcuno degli altri ospiti tratta gli stessi temi (multi-agente o routine/automazioni cloud), fammelo sapere: ho margine per ridurre uno dei due casi o cambiare angolo, cosi' non ci sovrapponiamo.

Grazie e a presto,
Giada Franceschini — Boosha AI

---

## File in questa cartella

| File | Cosa |
|---|---|
| [`README.md`](./README.md) | Questo file — indice live, agenda, timing, checklist e risposta mail |
| [`01-marketing-multiagente/`](./01-marketing-multiagente/) | Caso 1 — team marketing AI multi-agente per Boosha AI |
| [`02-ai-operating-system/`](./02-ai-operating-system/) | Caso 2 — Claude Code come AI Operating System (routine cloud, controllo da telefono) |

## Riferimenti

- [docs/13 — Routines cloud](../../docs/13-routines-cloud.md) (base del Caso 2)
- [automations/daily-whats-new/](../../automations/daily-whats-new/) (esempio reale di routine cloud nella repo)
- [README master](../../README.md)

← [examples/](../../examples/) · [README master](../../README.md)
