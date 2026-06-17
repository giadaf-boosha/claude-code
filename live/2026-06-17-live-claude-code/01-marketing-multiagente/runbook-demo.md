# Runbook demo — Team marketing AI multi-agente (~10 min)

> Copione timed minuto-per-minuto per la demo del Caso d'uso 1. Slot: 20 min demo totali (questo caso ~10 min) + 10 Q&A. Pubblico misto: principianti -> esperti. Obiettivo: far vedere 5 subagent che si passano il lavoro e producono una campagna completa da un solo prompt.

## Prima della live (checklist setup, T-10 min)

- [ ] Terminale gia' aperto nella cartella: `cd live/2026-06-17-live-claude-code/01-marketing-multiagente`
- [ ] `prompt-orchestratore.md` aperto in un editor, pronto a copiare il blocco "PROMPT DA INCOLLARE"
- [ ] `output-esempio/campagna-boosha-esempio.md` aperto in una tab nascosta (piano B)
- [ ] Cartella `output/` vuota o inesistente (cosi' i file compaiono dal vivo): `rm -rf output/ 2>/dev/null`
- [ ] Connessione di rete verificata (la ricerca web e' lo step lento)
- [ ] Font del terminale ingrandito per leggibilita' in sala

## Copione timed

### 0:00 - 1:00 — Hook di apertura

Cosa dici:
> "Immaginate di avere un'agenzia marketing intera dentro il vostro terminale. Voi le dite una cosa sola: 'fammi una campagna per Boosha AI'. Poi andate a dormire. Al risveglio: ricerca competitor, brief, hook, copy degli ads e il piano dei KPI. Fatto. Oggi ve lo faccio vedere succedere in diretta."

Cosa mostri: il terminale vuoto e la cartella `.claude/agents/` con i 5 file.
```bash
ls .claude/agents/
```

### 1:00 - 2:30 — Spiega l'architettura (semplice)

Cosa dici:
> "Non e' un mega-prompt magico. Sono 5 specialisti, ognuno fa UNA cosa. Il primo cerca i competitor. Il secondo scrive il brief. Il terzo gli hook. Il quarto gli ads. Il quinto i numeri. E si passano il lavoro: l'output di uno e' l'input del successivo."

Cosa mostri: apri `01-competitor-researcher.md`, indica frontmatter `tools: WebSearch, WebFetch, ...`.
> "Notate: solo il primo agent puo' andare su internet. Gli altri leggono e scrivono file. Ognuno ha i permessi minimi che gli servono."

Talking point esperti (1 frase, veloce): "context isolation — ogni subagent parte da contesto pulito, niente drift."

### 2:30 - 3:30 — Lancia il prompt

Cosa dici mentre fai:
> "Un prompt solo. Lo incollo e basta."
```bash
claude
```
Incolla il blocco "PROMPT DA INCOLLARE" da `prompt-orchestratore.md`. Premi invio.

> "Da qui in poi non tocco piu' niente. Guardiamo il team lavorare."

### 3:30 - 6:00 — Mentre gli agent girano (riempi il tempo)

Mentre `competitor-researcher` cerca (step piu' lento), narra:
> "Ora il primo agent sta cercando chi fa consulenza e formazione AI in Italia. Sta leggendo pagine vere, non se le inventa. E quando non trova un dato, lo dichiara: niente numeri spacciati per reali."

Apri una seconda finestra e mostra i file che compaiono:
```bash
watch -n 2 ls output/
```
> "Ecco — `01-competitor-research.md` e' nato. Adesso il brief-writer lo legge e... ecco `02`. Vedete il testimone che passa di mano in mano."

Per i principianti:
> "E' esattamente come un'agenzia: il ricercatore consegna allo stratega, lo stratega al copy, il copy al data analyst."

Per gli esperti (quando appaiono i file):
> "L'handoff e' via filesystem: stato esplicito, ispezionabile, diff-abile. Non sto passando un contesto implicito che si degrada — passo un artefatto."

### 6:00 - 8:30 — Mostra i risultati

Quando la catena finisce (compaiono tutti i file 01..05):
```bash
ls output/
```
Apri 2-3 file e commenta i punti forti:
- `03-hook.md`: "5 hook, angoli diversi: problema, contrarian, autorevolezza. Marcati i 2 da testare."
- `04-ads-copy.md`: "copy pronti per LinkedIn e Meta, con headline e CTA. Copia-incolla nell'ad manager."
- `05-report-kpi.md`: "e i numeri sono onesti — tutti etichettati come stime di benchmark, non risultati inventati."

Cosa dici:
> "Da un prompt: ricerca, brief, hook, ads, KPI. Coerenti tra loro perche' si sono passati il lavoro davvero."

### 8:30 - 10:00 — Chiusura e ponte alle Q&A

Cosa dici:
> "Il punto non e' che l'AI scrive testi. Il punto e' che un team di agenti si auto-organizza intorno a un obiettivo, mentre voi fate altro. Questo e' il 'lavorare mentre dormi'."

Ponte:
> "Domande? Vi mostro volentieri come e' fatto dentro un singolo agent, o come si aggiunge un sesto specialista."

## Gestione Q&A (10 min) — risposte pronte

| Domanda probabile | Risposta breve |
|---|---|
| "Posso aggiungere un agent?" | "Si: un nuovo file in `.claude/agents/`, frontmatter + system prompt, e lo metti nella catena nel prompt orchestratore." |
| "Come evita le allucinazioni?" | "Il researcher cita le fonti e marca le ipotesi; il reporter etichetta ogni numero come stima. E' grounding by design nel system prompt." |
| "Funziona per altri prodotti?" | "Si: cambi solo la variabile {PRODOTTO/SERVIZIO} nel prompt. Gli agent sono riutilizzabili." |
| "Quanto costa / quanto ci mette?" | "4-7 minuti, la ricerca web e' il collo di bottiglia. Costo: pochi cent di token per run." |
| "Pubblica davvero gli ads?" | "No: questa demo scrive solo file locali. La pubblicazione e' un passo separato e umano." |
| "Perche' file e non un mega-prompt?" | "Context isolation: ogni agent parte pulito, meno drift e meno allucinazioni; e gli artefatti sono ispezionabili." |

## Piano B (se qualcosa va storto)

- **Rete lenta / ricerca bloccata oltre 2 min**: "ve la faccio vedere gia' pronta" -> apri `output-esempio/campagna-boosha-esempio.md` e scorri ricerca -> brief -> hook -> ads -> KPI come se fosse appena uscita.
- **Un agent fallisce a meta'**: rilancia solo quell'anello: "rilancia il subagent hook-generator leggendo output/02-brief-campagna.md".
- **Si esaurisce il tempo**: salta direttamente a 8:30 (chiusura) usando l'output di esempio gia' aperto.
- **Domanda fuori scope tecnica**: "ottima, te la riprendo a fine sessione / nel caso 2" e prosegui.

## Dopo la demo

- Lascia i file `output/` visibili per chi vuole curiosare.
- Punta alla repo: i 5 agent e il prompt sono copiabili e adattabili.

← [README del caso](./README.md) · [prompt-orchestratore](./prompt-orchestratore.md)
