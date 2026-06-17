# Prompt orchestratore — Team marketing AI multi-agente

> Copia-incolla il blocco qui sotto in una sessione `claude` aperta nella cartella `01-marketing-multiagente/`. Un solo prompt mette in catena i 5 subagent: l'output di ognuno diventa l'input del successivo, fino alla campagna completa.

## Come funziona l'handoff

I 5 subagent vivono in `.claude/agents/` e si passano il lavoro tramite file scritti in `output/`:

```
competitor-researcher  ->  output/01-competitor-research.md
        v (Read)
brief-writer           ->  output/02-brief-campagna.md
        v (Read)
hook-generator         ->  output/03-hook.md
        v (Read)
ads-copywriter         ->  output/04-ads-copy.md
        v (Read)
performance-reporter   ->  output/05-report-kpi.md
```

Ogni agent legge con `Read` il file dell'agent precedente e scrive con `Write` il proprio. La catena e' orchestrata dall'agent principale (Claude) che invoca i subagent in sequenza: non serve lanciarli a mano uno per uno.

## Come lanciarlo

```bash
# dalla cartella 01-marketing-multiagente/
claude
```
Poi incolla nel prompt il blocco delimitato qui sotto.

---

PROMPT DA INCOLLARE (da qui in giu'):

Sei l'orchestratore di un team marketing multi-agente. Produci una campagna marketing completa per il seguente prodotto/servizio, delegando il lavoro ai 5 subagent specializzati che trovi in `.claude/agents/`. Crea prima la cartella `output/` se non esiste.

{PRODOTTO/SERVIZIO} = Boosha AI — realta' italiana di consulenza e servizi AI per aziende (https://boosha.it). Tre linee di servizio: (1) Assessment AI aziendali (mappatura processi AS-IS, fattibilita', requisiti, proposta POC, SAL con milestone e ROI); (2) Formazione AI aziendale (brief, syllabus, prompt eseguibili in aula, classificazione attivita' ottimizzabili); (3) Sviluppo soluzioni AI custom (metodologia BDM, delivery con Claude Code). Target: PMI e organizzazioni strutturate italiane + decision maker (direzione, IT, innovation/operations) + team tech che adottano tooling agentic. Tono: italiano professionale, didattico-divulgativo ma rigoroso, valori grounding/anti-hallucination, trasparenza, pragmatismo, anti-buzzword. Vincolo critico: NESSUN claim numerico non verificabile (no numero clienti, fatturato, percentuali di risultato spacciate per reali).

Esegui in sequenza, passando l'output di ognuno al successivo:

1. Invoca il subagent `competitor-researcher`: deve ricercare il panorama competitor (consulenza/formazione AI in Italia) e scrivere `output/01-competitor-research.md`. Se la ricerca web non e' disponibile o restituisce poco, deve dichiararlo e procedere con il panorama plausibile marcato come ipotesi da validare.
2. Invoca `brief-writer`: legge `output/01-competitor-research.md`, produce `output/02-brief-campagna.md`.
3. Invoca `hook-generator`: legge `output/02-brief-campagna.md`, produce `output/03-hook.md`.
4. Invoca `ads-copywriter`: legge `output/03-hook.md` (e il brief), produce `output/04-ads-copy.md`.
5. Invoca `performance-reporter`: legge `output/04-ads-copy.md` e `output/02-brief-campagna.md`, produce `output/05-report-kpi.md`.

Vincoli per tutta la catena:
- Lingua italiana, termini tecnici in inglese non tradotti.
- Accenti in stile ASCII apostrofo ("perche'", "piu'", "cosi'"), mai unicode (é è ì à ò).
- Nessun placeholder, TODO o sezione vuota: ogni file deve essere completo e pubblicabile.
- Ogni numero in proiezione va etichettato come stima/benchmark da validare, mai come risultato reale.

Al termine, stampa un riepilogo finale con: i 5 file prodotti in `output/`, la value proposition scelta, i 2 hook consigliati per A/B test e il KPI primario con il range stimato.

(fine del prompt da incollare)

---

## Note operative

- Tempo tipico: 4-7 minuti per l'intera catena (la ricerca web e' lo step piu' lento).
- Se vuoi rilanciare solo un anello, apri di nuovo `claude` e chiedi: "rilancia il subagent hook-generator leggendo output/02-brief-campagna.md".
- I file in `output/` sono sovrascritti a ogni run: salva una copia se vuoi conservare un risultato.
- Fallback se la live va lunga: mostra `output-esempio/campagna-boosha-esempio.md` invece di attendere la catena.

← [README del caso](./README.md) · [runbook demo](./runbook-demo.md)
