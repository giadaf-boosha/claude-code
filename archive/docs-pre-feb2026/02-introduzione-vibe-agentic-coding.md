# Introduzione: dall'Vibe Coding all'Agentic Coding

## Cos'è il vibe coding

Il vibe coding è stato il primo approccio all'AI-assisted coding, iniziato circa un anno fa. È caratterizzato da:

- Un'idea che viene trasformata in codice attraverso un feedback loop stretto
- Collaborazione diretta con l'AI in tempo reale
- Capacità di creare cose che richiederebbero settimane o mesi senza competenze di programmazione

## Cos'è l'agentic coding

L'agentic coding rappresenta l'evoluzione successiva:

- È come avere un team di collaboratori molto capaci
- Si fornisce una specifica o un compito più ampio e si delega all'agente
- Il feedback loop è meno stretto ma più potente
- Possibilità di gestire più agenti in parallelo

> **Citazione chiave:** "È come essere un manager e avere un team di persone molto capaci"

## Perché Claude Code sta superando Cursor per utenti avanzati

### Vantaggi di Claude Code

- Interfaccia minimalista che riduce le distrazioni
- Focus su un'unica azione: digitare quello che si vuole fare
- Migliore per utenti che vogliono concentrarsi sul lavoro vero
- Ottimo per chi ha già esperienza di ingegneria software

### Differenze filosofiche

- Claude Code è progettato per chi costruisce software reale
- Meno adatto per vibe coding, più per produzione sostenibile
- Evita il problema del "cancellare tutto e ricominciare"

## Installazione e setup iniziale

### Requisiti

- Terminale (qualsiasi terminale va bene, l'esempio usa Warp)
- Installazione di Claude Code dal sito web ufficiale

### Primo avvio

```bash
claude
```

L'interfaccia iniziale mostra solo una schermata vuota dove digitare i comandi.

## Funzionalità fondamentali

### Sistema di to-do

Claude Code utilizza automaticamente un sistema di to-do per:

- Mantenere l'agente focalizzato
- Evitare azioni casuali
- Procedere passo dopo passo

### Capacità di ricerca

L'agente può:

- Cercare sul web
- Connettersi a MCP (Model Context Protocol) come Context 7
- Esplorare il file system
- Eseguire qualsiasi comando CLI

### Modalità planning

Attivabile con `Shift + Tab`, permette di:

- Ottenere informazioni e pensare senza codificare
- Fare ricerca approfondita prima di iniziare
- Migliorare la qualità del risultato finale

## Comandi e prompt trigger avanzati

### Comandi essenziali per ricerca

```
"Puoi fare ricerca su cosa fa questa app? Come molto generale."
```

```
"Puoi guardare il codice e dire cosa fa questo progetto? Che linguaggio, cosa c'è qui?"
```

### Trigger words per migliorare l'output

- `"crea to-do"`: genera una lista di compiti strutturata
- `"pensa ultra difficile"`: aumenta la qualità dell'output usando più token
- `"pensa profondamente"`: attiva modalità di ragionamento avanzato

> **Principio:** Usa "pensa ultra difficile" per compiti complessi, non per modifiche semplici

### Comandi per la pianificazione

```
"Voglio ricercare una funzionalità e usare il client Gmail e il gem RubyLM.
Voglio aggiungere modelli di database per le email che memorizzeranno le email
dal client Gmail. Poi voglio un servizio che prenderà un'email e la riassumerà
per me. Puoi usare il gem Ruby LM. E terzo, voglio un'UI che posso leggere
attraverso queste email. Puoi fare ricerca su cosa consiglieresti e magari puoi
creare questi tre problemi separati e puoi farli in parallelo usando sub agenti
così non devo aspettare troppo a lungo."
```

## Gestione di progetti complessi con git worktrees

### Cos'è git worktrees

- Funzionalità di git che crea nuovi branch in cartelle separate
- Permette di avere più agenti che lavorano contemporaneamente
- Evita conflitti quando più agenti modificano gli stessi file

### Script personalizzato per worktrees

```bash
wt() {
    if [ -z "$1" ]; then
        echo "Errore: il nome del branch è richiesto."
        echo "Uso: wt <nome-branch> [branch-base]"
        return 1
    fi

    # Imposta il branch base (default su 'main' se non fornito)
    base_branch="${2:-main}"

    # Ottieni la directory root del repository Git
    git_root=$(git rev-parse --show-toplevel)
    if [ -z "$git_root" ]; then
        echo "Errore: non è un repository git."
        return 1
    fi

    worktree_dir="$git_root/.worktrees"
    worktree_path="$worktree_dir/$1"
    gitignore_path="$git_root/.gitignore"

    # Crea la directory .worktrees se non esiste
    mkdir -p "$worktree_dir"

    # Aggiungi .worktrees a .gitignore se non c'è già
    if ! grep -q "^\.worktrees$" "$gitignore_path"; then
        echo ".worktrees" >> "$gitignore_path"
    fi

    # Crea il worktree
    git worktree add "$worktree_path" "$base_branch" -b "$1"

    # Cambia alla directory del worktree
    cd "$worktree_path"
}
```

### Funzioni di utilità

```bash
# Funzione cc: avvia Claude Code con skip permissions
cc() {
    /percorso/to/claude --dangerously-skip-permissions
}

# Cleanup worktrees
wtc() {
    worktree_dir="$git_root/.worktrees"
    if [ -d "$worktree_dir" ]; then
        # Pulisci worktrees prima per pulire lo stato interno di git
        git worktree prune
        # Rimuovi forzatamente la directory .worktrees
        rm -rf "$worktree_dir"
        echo "Tutti i worktrees sono stati rimossi."
    else
        echo "Nessuna directory .worktrees trovata."
    fi
}
```

### Workflow con worktrees

1. Crea un worktree per ogni funzionalità: `wt feature-name`
2. Avvia Claude Code in ogni worktree: `cc`
3. Lavora su funzionalità parallele senza conflitti
4. Merge quando completato

## Sistema di slash commands personalizzati

### Perché usare slash commands

- Riduce la necessità di digitare prompt lunghi ripetutamente
- Standardizza processi comuni
- Migliora l'efficienza del workflow

### Creazione di slash commands

I commands vengono salvati in file `.md` nella cartella `.claude/commands/`.

### Esempio: comando per ricerca e issue creation

```markdown
# Issues Command

Sei un assistente AI incaricato di creare issue GitHub ben strutturate per richieste di
funzionalità, bug report o idee di miglioramento. Il tuo obiettivo è trasformare la
descrizione della funzionalità fornita in un'issue GitHub completa che segue le migliori
pratiche e le convenzioni del progetto.

Prima ti verrà data una descrizione della funzionalità e un URL del repository.
Ecco sono:

<feature_description> #$ARGUMENTS </feature_description>

Segui questi passaggi per completare il compito, crea una lista to-do e pensa ultra
difficile:

1. **Ricerca il repository**:
   - Visita l'URL del repo fornito ed esamina la struttura del repository, issue
     esistenti e documentazione
   - Cerca file CONTRIBUTING.md, ISSUE_TEMPLATE.md o simili che potrebbero contenere
     linee guida per creare issue
   - Nota lo stile di codifica del progetto, convenzioni di naming e requisiti specifici
     per inviare issue

2. **Ricerca migliori pratiche**:
   - Cerca le migliori pratiche attuali per scrivere issue GitHub, concentrandoti su
     chiarezza, completezza e attuabilità
   - Cerca esempi di issue ben scritte in progetti open-source popolari per ispirazione

3. **Presenta un piano**:
   - Basandoti sulla tua ricerca, delinea un piano per creare l'issue GitHub
   - Includi la struttura proposta dell'issue, eventuali label o milestone che pianifichi
     di usare, e come incorporerai le convenzioni specifiche del progetto
   - Presenta questo piano in tag <plan>
   - Includi il link di riferimento a featurebase o qualsiasi altro link che ha la fonte
     della richiesta utente
   - Assicurati che qualsiasi riferimento a file locali con numeri di riga o repository
     GitHub siano inclusi in fondo all'issue GitHub per riferimento futuro

4. **Crea l'issue GitHub**:
   - Una volta approvato il piano, drafta il contenuto dell'issue GitHub
   - Includi un titolo chiaro, descrizione dettagliata, criteri di accettazione e
     qualsiasi contesto aggiuntivo o risorse che sarebbero utili per gli sviluppatori
   - Usa formattazione appropriata (es. Markdown) per migliorare la leggibilità
   - Aggiungi label, milestone o assegnati rilevanti basati sulle convenzioni del progetto

5. **Output finale**:
   - Presenta il contenuto completo dell'issue GitHub in tag <github_issue>
   - Non includere spiegazioni o note al di fuori di questi tag nel tuo output finale

Ricorda di pensare attentamente alla descrizione della funzionalità e come presentarla
al meglio per facilitare una implementazione di successo.
```

### Altri esempi di slash commands utili

#### Comando proofread

```markdown
# AI Line Editor & Proofreader System Prompt

Sei un meticoloso line editor e proofreader specializzato in grammatica e meccanica.
Il tuo ruolo è rivedere bozze per aderenza alle specifiche linee guida di stile e regole
delineate nella Every Style Guide nei file di questo progetto, aiutando i writer a
preparare copie pulite prima della revisione editoriale umana.

Il tuo prossimo incarico:
- $ARGUMENTS

## Responsabilità

1. **Revisione riga per riga**: Esamina ogni frase per grammatica, punteggiatura,
   meccanica e conformità alla guida di stile
2. **Identificazione errori**: Segnala tutte le deviazioni dalle regole della guida
   di stile
3. **Suggerimenti di correzione**: Fornisci correzioni specifiche per ogni problema
   trovato
4. **Riconoscimento pattern**: Nota errori ricorrenti per aiutare i writer a migliorare

## Processo di revisione

Quando rivedi una bozza, segui questo approccio sistematico:

### Passo 1: Lettura iniziale
- Leggi l'intero pezzo per comprendere contesto e tono

### Passo 2: Analisi riga per riga
- Esamina ogni frase per chiarezza e correttezza
- Controlla conformità alla guida di stile
- Identifica problemi di flusso o leggibilità

### Passo 3: Revisione complessiva
- Assicurati coerenza nel tono e stile
- Verifica che tutti gli standard siano rispettati
```

#### Comando fix-critical

```markdown
Questo è un aspetto severamente critico dell'applicazione e per ogni file cambiato devi
rivedere accuratamente tutti i possibili posti che il cambiamento può impattare e
scrutinarlo per assicurarti che non facciamo cambiamenti non intenzionali o rompiamo
funzionalità che non vogliamo.

Per ogni file cambiato, guarda tutte le altre parti del codice che interagiscono con esso
per assicurarti che non abbiamo rotto nulla involontariamente.

Bisogna ultrathink ultrahard durante l'esecuzione di questo piano.

Dopo che hai finito con una fase del piano, avremo un checkpoint dove devi chiedermi la
mia revisione. Dopo che approvo, committa il lavoro in quella fase.
```

#### Comando best-practice

```markdown
# Tech stack:

## Le tue competenze includono:
- Forti capacità di problem-solving e abilità di articolare piani tecnici chiari
- Attitudine positiva e incoraggiante quando si affrontano sfide tecniche difficili
- Senso dell'umorismo che aiuta ad alleggerire l'umore durante situazioni difficili
- Fiducia nel pensare fuori dagli schemi quando gli approcci standard non funzionano
- Costruire applicazioni web il "modo Rails" - seguendo convenzioni oltre configurazione

# Tech stack:
- Rails 7.1
- Hotwire (Stimulus e Turbo)
- TailwindCSS
- tailwindcss-stimulus-components
- ViewComponents (con LookBook) nelle viste
- Jumpstart Pro
- Database Postgres
- pgvector con neighbor gem per embeddings
- Devise gem per autenticazione utente e login
- Render per deployment
- Overmind o Foreman per eseguire tutti i processi in sviluppo
- Ahoy events

# Migliori pratiche Rails che dovresti cercare di seguire:
- Usa convenzioni Rails quando possibile
- Mantieni controller snelli, logica nei modelli
- Usa partial per codice riutilizzabile nelle viste
- ViewComponents per logica di vista complessa
- Stimulus per JavaScript dove necessario
- Turbo Frames per aggiornamenti parziali di pagina
- Usa helper per logica di vista semplice
- Segui naming conventions Rails
- Usa migrazioni per cambiamenti database
- Test per funzionalità critiche
```

## Gestione avanzata dei modelli

### Attivazione di Opus

Usa la frase trigger `"pensa ultra difficile"` per attivare automaticamente Claude Opus invece di Sonnet, ottenendo:

- Migliore qualità di output
- Ragionamento più approfondito
- Gestione di compiti più complessi

### Selezione manuale del modello

```bash
model opus
```

## Workflow di sviluppo con sub-agents

### Esecuzione in parallelo

Comando per avviare sub-agents in parallelo:

```
"Puoi fare ricerca su cosa consiglieresti e magari puoi creare questi tre problemi
separati e puoi farli in parallelo usando sub agenti così non devo aspettare troppo
a lungo."
```

### Vantaggi dei sub-agents

- Riduzione dei token nel contesto principale
- Possibilità di lavorare su più task contemporaneamente
- Ogni sub-agent ha il proprio contesto isolato

### Modalità "dangerously skip"

```bash
claude --dangerously-skip-permissions
```

- Salta tutte le conferme manuali
- Da usare solo in ambienti sicuri/containerizzati
- Accelera drasticamente il workflow

## Sistema di review e quality assurance

### Review automatizzato con Claude

```
"review"
```

Questo comando nativo attiva una review automatica del codice che identifica:

- Potenziali problemi di sicurezza
- Best practices non seguite
- Possibili bug o memory leak
- Ottimizzazioni suggerite

### Review multi-prospettiva

```
"Puoi rivedere questo con tre diversi cappelli come una persona di business o come
un ricercatore di sicurezza"
```

### Integrazione GitHub

- Caricamento automatico di PR comments
- Collegamento con GitHub CLI
- Review collaborativo con altri AI bot

### Esempio di output review

Il sistema può identificare problemi come:

- "Questo potrebbe causare memory leak"
- "Considera di aggiungere gestione errori qui"
- "Questa implementazione potrebbe essere ottimizzata"

## Gestione costi e piani

### Piani consigliati

- **Piano $20**: base, può raggiungere limiti
- **Piano $200**: consigliato per uso professionale
- Utilizzo esempio: $1,800 in token in un mese per sviluppo intensivo

### Ottimizzazione costi

- Uso di sub-agents per ridurre token nel contesto principale
- Comandi specifici invece di conversazioni lunghe
- Planning mode per ricerca senza coding immediato

## Integrazione con GitHub e CI/CD

### GitHub Actions

Dal 2025, Claude Code può essere eseguito direttamente in GitHub Actions:

```
@claude running on GitHub
```

### Vantaggi dell'integrazione CI/CD

- Non necessità di worktrees locali
- Esecuzione in ambiente pulito
- Scaling automatico

## Sviluppo di Kora: caso di studio

### Architettura del prodotto

Kora è un assistente email AI che:

- Si connette a Gmail
- Archivia automaticamente email non importanti
- Fornisce riassunti due volte al giorno
- Categorizza e prioritizza i messaggi

### Tecnologie utilizzate

- Multiple workflow LLM
- Diversi modelli per diversi compiti
- Sistema di regole complesso
- Personalizzazione basata sul profilo rischio utente

### Learnings dal progetto

- L'AI deve imparare dalle preferenze dell'utente
- Diversi utenti hanno diversa tolleranza al rischio
- Importanza del feedback continuo

## Best practices e consigli

### Per principianti

- **Inizia semplice**: non cercare di rifare intere workflow subito
- **Sperimenta**: prova una cosa semplice e vedi se funziona
- **Non ascoltare solo i guru**: trova il tuo modo di lavorare
- **Gioca con lo strumento**: l'aspetto ludico è importante

### Per sviluppatori esperti

- **Pensa come un tech lead**: dai direzioni chiare
- **Struttura i prompt**: più chiaro sei, migliori risultati ottieni
- **Usa starter projects**: progetti con stack pre-configurato
- **Automatizza tutto**: crea slash commands per azioni ripetitive

### Starter projects consigliati

- **Jumpstart Pro (Rails)**: di Chris Oliver
- Altri starter kit con stack pre-selezionato
- Riducono decisioni tecniche, permettono focus sulla business logic

### Come trovare starter projects

```
"ChatGPT, ricerca approfondita starter projects. Spiega che tipo di problemi sto
risolvendo e che tipo di cose dovrei probabilmente avere incluse"
```

## Integrazione con strumenti di speech-to-text

### Monologue

Tool interno per speech-to-text che:

- Si integra perfettamente con Claude Code
- Permette di evitare completamente la digitazione
- Legge anche il contesto per migliorare la trascrizione

### Benefici del voice input

- Riduzione dell'attrito
- Comunicazione più naturale
- Velocità aumentata per prompt lunghi

## Troubleshooting comune

### Problemi di versioning

```
"Questo è un problema di versioning. Era sempre parte della libreria e questo è come
un LLM non è aggiornato abbastanza con questa versione bleeding edge"
```

**Soluzione:** Aggiornare manualmente le dipendenze o usare versioni più stabili

### Gestione degli errori

- Sempre wrappare in try-catch quando possibile
- Usare starter projects per evitare configurazioni complesse
- Mantenere fallback a metodi "old school"

### File non trovati in worktrees

Assicurarsi di:

- Essere nella directory del worktree corretto
- Aver committato i file necessari
- Usare i path relativi corretti

## Conclusioni

L'agentic coding con Claude Code rappresenta un cambio di paradigma nel development:

- **Passa da assistente a collaboratore**: pensa all'AI come un team member competente
- **Struttura è importante**: investment in planning e setup ripaga nel lungo termine
- **Automazione compounding**: ogni processo che fai oggi, trasformalo in un slash command per domani
- **Sperimentazione continua**: gli strumenti evolvono rapidamente, resta aggiornato

> **Principio fondamentale:** Il lavoro nello sviluppo software non è solo codice - è ricerca, product marketing, understanding di cosa costruire. L'agentic coding eccelle in tutti questi aspetti.
