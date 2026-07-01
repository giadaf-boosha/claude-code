# Claude — Note su Sonnet 5, Fable 5 e Dynamic Workflows

Materiale di riferimento su modelli Claude, prompting e workflow dinamici.
Vedi anche l'immagine [`how-to-choose-claude-model-and-effort.png`](./how-to-choose-claude-model-and-effort.png) per la scelta modello + effort.

---

## 1. TL;DR — Redeploying Claude Fable 5

Fonte: <https://www.anthropic.com/news/redeploying-fable-5>

- **Cos'è Fable 5**: modello Claude per uso generale, rilasciato da Anthropic il **9 giugno 2026**, con le protezioni di sicurezza più forti mai applicate a un modello.
- **Architettura condivisa**: Fable 5 condivide l'architettura sottostante con **Claude Mythos 5**, ma con salvaguardie molto più aggressive per ridurre i rischi in ambito cybersecurity.
- **Il ritiro (12 giugno 2026)**: ricercatori di Amazon hanno scoperto una tecnica per eludere le protezioni, che permetteva al modello di identificare vulnerabilità software e dimostrarne lo sfruttamento.
- **Motivo della sospensione**: il governo USA ha applicato controlli all'esportazione a Fable 5 e Mythos 5. Poiché i controlli vietavano l'accesso a cittadini stranieri e Anthropic non poteva verificare la nazionalità in tempo reale, il servizio è stato sospeso **per tutti gli utenti**.
- **La correzione**: Anthropic ha sviluppato un **classificatore di sicurezza migliorato** che blocca la tecnica descritta nel report Amazon in **oltre il 99% dei casi**.
- **Contesto rilevante**: i test hanno mostrato che diversi modelli meno capaci (Claude Opus 4.8, GPT-5.5, Kimi K2.7) erano già in grado di identificare le stesse vulnerabilità.
- **Posizionamento capacità**: Fable 5 non offre **alcuna capacità offensiva unica** ed è pensato per uso generale; Mythos 5 invece può trovare e sfruttare vulnerabilità software più efficacemente di qualsiasi altro modello.
- **Il ridispiegamento**: Fable 5 è tornato disponibile dal **30 giugno 2026**, con riavvio ufficiale il **1 luglio 2026**.
- **Cloud**: il ripristino delle integrazioni su AWS, Google Cloud e Microsoft Foundry è previsto "il più rapidamente possibile".
- **Framework per valutare i jailbreak** proposto da Anthropic come standard di settore, basato su 4 dimensioni:
  1. **Capability gain** — quanto avanzano le capacità rispetto agli strumenti esistenti;
  2. **Breadth** — quanti compiti offensivi diversi funzionano con la stessa tecnica;
  3. **Ease of weaponization** — quanto sforzo umano richiede;
  4. **Discoverability** — quanto è facile ottenere la tecnica.
- **Collaborazione col governo**: Anthropic si impegna su accesso pre-rilascio, condivisione rapida di informazioni sui jailbreak, ricerca congiunta e standard di sicurezza condivisi.
- **Nota assente**: il documento **non** fornisce benchmark diretti di confronto tra Fable 5, Opus e Sonnet.

---

## 2. TL;DR esaustivo — Prompting Claude Sonnet 5

Fonte: <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-sonnet-5>

Claude Sonnet 5 ha punti di forza particolari su **coding e task agentici** e funziona bene "out of the box" sui prompt già tarati per Sonnet 4.6. La guida copre i comportamenti che più spesso richiedono tuning.

### Migrazione da Sonnet 4.6 (cambi API principali)
- **Adaptive thinking attivo di default**: le richieste senza campo `thinking` girano con adaptive thinking (su 4.6 giravano senza thinking). Per disattivarlo: `thinking: {type: "disabled"}`.
- **Sampling non accettato**: impostare `temperature`, `top_p` o `top_k` a un valore non-default restituisce errore **400**. Vincolo nuovo per i modelli classe Sonnet.
- **Extended thinking manuale rimosso**: `thinking: {type: "enabled", budget_tokens: N}` restituisce **400**. Usare adaptive thinking + parametro `effort`.
- **Nuovo tokenizer**: produce circa **+30% token** per lo stesso testo → rivedere i limiti `max_tokens` tarati su 4.6, altrimenti l'output equivalente può venire troncato.

### Lunghezza risposta e verbosity
- Sonnet 5 calibra la lunghezza in base alla complessità del task: più corto su lookup semplici, più lungo su analisi aperte.
- Per ridurre la verbosity, aggiungere istruzioni esplicite (es. *"Provide concise, focused responses. Skip non-essential context, and keep examples minimal."*).
- Gli **esempi positivi** di concisione funzionano meglio delle istruzioni negative ("non fare X").

### Calibrare effort e profondità di thinking
- Il parametro **`effort`** bilancia intelligenza vs spesa in token. Default su Sonnet 5: **`high`** (come 4.6).
- Livelli disponibili:
  - **`max`** — massima capacità assoluta, nessun vincolo di spesa token;
  - **`xhigh`** — consigliato per i task di coding/agentici più difficili;
  - **`high`** — default, bilanciato per la maggior parte dei casi;
  - **`medium`** — per casi cost-sensitive, riduce token sacrificando intelligenza;
  - **`low`** — solo task brevi/circoscritti e workload latency-sensitive.
- **Mappatura cross-model** (indicativa): Sonnet 5 a `medium` ≈ Sonnet 4.6 a `high`; Sonnet 5 a `high` ≈ Sonnet 4.6 a `max`. Nei benchmark, confrontare per lunghezza di thinking osservata, non per nome dell'effort.
- Sonnet 5 **rispetta l'effort in modo rigoroso**, soprattutto ai livelli bassi: a `low`/`medium` fa esattamente ciò che è chiesto, senza "andare oltre". Rischio di under-thinking su task moderatamente complessi a `low`.
- Se il reasoning è superficiale su problemi complessi, **alzare l'effort** (a `high`/`xhigh`) invece di aggirarlo con il prompt. Se serve restare a `low` per latenza, aggiungere una guida mirata (es. *"This task involves multi-step reasoning. Think carefully through the problem before responding."*).
- Il **trigger dell'adaptive thinking è pilotabile**: se emette blocchi di thinking troppo spesso (tipico con system prompt grandi/complessi), aggiungere una guida per limitarlo ("usa il thinking solo quando migliora davvero la qualità...").
- **Headroom su `max_tokens`**: a `high`/`xhigh`/`max` lasciare margine, perché `max_tokens` è un tetto duro su thinking + risposta. Se il budget è stretto si rischia una risposta quasi tutta thinking + risposta troncata con `stop_reason: "max_tokens"`. Rimedio: alzare `max_tokens` o scendere a `medium`.

### Tool use triggering
- Sonnet 5 è **più agentico** di default: usa strumenti e cicli di auto-verifica più prontamente.
- Con thinking disabilitato è meno propenso a usare tool o a cercare → aggiungere un nudge esplicito nel system prompt se si dipende dai tool.
- Effort è una leva anche per i tool: `high`/`xhigh` mostrano molto più uso di strumenti in ricerca agentica e coding.

### Aggiornamenti di progresso all'utente
- Sonnet 5 fornisce update regolari e di qualità superiore durante trace agentiche lunghe.
- Se avevi scaffolding tipo "riassumi ogni 3 tool call", **prova a rimuoverlo**. Se il calibro degli update non va bene, descrivi esplicitamente forma ed esempi.

### Instruction following più letterale
- Sonnet 5 interpreta i prompt in modo **letterale ed esplicito**, specialmente a effort basso: non generalizza silenziosamente un'istruzione da un caso all'altro e non inferisce richieste non fatte.
- Vantaggio: precisione, ideale per estrazione strutturata e pipeline con comportamento prevedibile.
- Se serve applicare un'istruzione in modo ampio, **dichiarane lo scope** (es. *"Apply this formatting to every section, not just the first one"*).

### Tono e stile di scrittura
- Lo stile della prosa long-form può cambiare: se il prodotto dipende da una voce specifica, ri-valutare i prompt di stile.
- Per un tono più caldo/collaborativo, aggiungere istruzioni esplicite.
- Non usare più `temperature` per la varietà stilistica (dà 400): guidare tono e varietà via system prompt.

### Design e default frontend
- Sonnet 5 può assestarsi su uno **stile visuale di default** su brief frontend aperti: ok per alcuni brief, fuori tono per dashboard, dev tools, fintech, healthcare, enterprise.
- Istruzioni generiche ("non usare quel colore", "rendilo pulito e minimale") tendono a spostarlo su un'altra palette fissa, non a creare varietà. Due approcci affidabili:
  1. **Specificare un'alternativa concreta** (palette esatta con hex, tipografia, radius, spacing...): il modello segue le spec con precisione;
  2. **Far proporre 4 direzioni visive** prima di costruire (bg hex / accent hex / typeface + rationale), l'utente sceglie, poi si implementa solo quella. Approccio raccomandato per ottenere varietà, dato che `temperature` non è disponibile.
- Snippet anti "AI slop" utile nel system prompt: evitare font generici (Inter, Roboto, Arial), schemi cromatici cliché (gradienti viola su bianco/nero), layout prevedibili; preferire font unici, temi coerenti, animazioni e micro-interazioni.

### Prodotti di coding interattivi
- Il comportamento/consumo token differisce tra agenti autonomi (single turn) e interattivi (multi turn).
- Per massimizzare performance ed efficienza: usare **`xhigh`/`high`**, aggiungere feature autonome (es. auto mode), ridurre le interazioni umane necessarie.
- Specificare **task, intento e vincoli upfront** nel primo turno: prompt ambigui distribuiti su più turni riducono efficienza e talvolta performance.

### Harness di code review
- Un harness tarato su un modello precedente può mostrare **recall più basso** su Sonnet 5: è un effetto dell'harness, non una regressione di capacità.
- Con istruzioni tipo "riporta solo issue high-severity" / "sii conservativo", Sonnet 5 le segue più fedelmente: indaga a fondo ma **riporta meno** findings sotto la soglia dichiarata (precision su, recall misurato giù).
- Prompt consigliato per la fase di **finding**: puntare alla **coverage** ("riporta ogni issue, anche incerta o low-severity; il filtro avverrà in uno step separato; includi confidence e severity stimata").
- Se il filtro deve avvenire in un solo passaggio, essere **concreti** sulla soglia invece di usare termini vaghi come "important".

### Computer use
- Supporta il tool `computer_20251124`, fino a risoluzione massima **2576px / 3.75MP**.
- **1080p** è un buon equilibrio performance/costo; **720p** o **1366×768** sono opzioni più economiche con buone performance. Testare per il proprio caso.

---

## 3. Sonnet 5 + Claude Code Dynamic Workflows

> Sonnet 5 is here. It's worse than Opus 4.8 on nearly every benchmark...
>
> Does that mean it's useless? Absolutely not.
>
> Use it with Claude Code Dynamic Workflows!
>
> 1. `/model` set to Sonnet 5
> 2. `/effort` set to Ultracode
> 3. Any complex task will kick off a dynamic workflow
>
> This will only become more powerful when Fable is back.
>
> You'll use Fable 5 as the superintelligent advisor and Sonnet 5 as the fast and efficient implementer.
