# Guida Completa a Claude Code: dalla Configurazione ai Workflow Avanzati

## Introduzione a Claude Code

Claude Code è uno strumento di sviluppo AI che trasforma il modo di programmare, fornendo un assistente intelligente che può comprendere, modificare e gestire il tuo codice attraverso un'interfaccia a riga di comando.

## Installazione e configurazione iniziale

### Requisiti di sistema

- Terminale (qualsiasi terminale compatibile)
- Connessione internet per l'API di Anthropic

### Primo avvio

```bash
claude
```

### Comandi di configurazione base

```bash
# Aggiornamento alla versione più recente
claude update

# Configurazione generale
claude config list                    # mostra tutte le impostazioni
claude config get <chiave>           # visualizza una specifica impostazione
claude config set <chiave> <valore>  # modifica un'impostazione
claude config set -g <chiave> <valore> # configurazione globale
```

## Configurazione del terminale per performance ottimali

### Configurazione di interruzioni di riga

Hai diverse opzioni per inserire interruzioni di riga:

Metodo escape rapido:

```
\ + Invio
```

Configurazione automatica per VS Code o iTerm2:

```
/terminal-setup
```

Per macOS Terminal.app:

1. Apri Impostazioni → Profili → Tastiera
2. Spunta "Usa Opzione come tasto Meta"

### Configurazione delle notifiche

Notifiche audio del terminale:

```bash
claude config set --global preferredNotifChannel terminal_bell
```

Per utenti macOS: Abilita le autorizzazioni di notifica in Impostazioni Sistema → Notifiche → [La tua app Terminal]

Per notifiche di sistema iTerm2:

1. Apri le preferenze di iTerm2
2. Vai su Profili → Terminale
3. Abilita "Silenza suoneria" e Filtra avvisi → "Invia avvisi generati da sequenza di escape"

### Configurazione temi

```bash
# Opzioni tema disponibili
claude config set -g theme dark
claude config set -g theme light
claude config set -g theme light-daltonized
claude config set -g theme dark-daltonized
```

### Modalità Vim

```bash
# Abilita modalità Vim
/vim

# Oppure configura permanentemente
claude config set -g vimMode true
```

Comandi Vim supportati:

- **Cambio modalità:** Esc (NORMALE), i/I, a/A, o/O (INSERIMENTO)
- **Navigazione:** h/j/k/l, w/e/b, 0/$/^, gg/G
- **Modifica:** x, dw/de/db/dd/D, cw/ce/cb/cc/C, . (ripeti)

## Workflow comuni e pattern di utilizzo

### Comprensione di nuove codebase

Panoramica veloce del progetto:

```
> dammi una panoramica di questa codebase
```

Approfondimento su componenti specifici:

```
> spiega i principali pattern architetturali usati qui
> quali sono i modelli dati chiave?
> come viene gestita l'autenticazione?
```

Trovare codice rilevante:

```
> trova i file che gestiscono l'autenticazione utente
> come funzionano insieme questi file di autenticazione?
> traccia il processo di login dal front-end al database
```

### Correzione efficace di bug

Condividere l'errore con Claude:

```
> sto vedendo un errore quando eseguo npm test
```

Chiedere raccomandazioni per la correzione:

```
> suggerisci alcuni modi per correggere il @ts-ignore in user.ts
```

Applicare la correzione:

```
> aggiorna user.ts per aggiungere il controllo null che hai suggerito
```

### Refactoring del codice

Identificare codice legacy per il refactoring:

```
> trova l'utilizzo di API deprecate nella nostra codebase
```

Ottenere raccomandazioni di refactoring:

```
> suggerisci come fare refactoring di utils.js per usare funzionalità JavaScript moderne
```

Applicare i cambiamenti in sicurezza:

```
> fai refactoring di utils.js per usare funzionalità ES2024 mantenendo lo stesso comportamento
```

Verificare il refactoring:

```
> esegui i test per il codice refactorizzato
```

### Lavoro con i test

Identificare codice non testato:

```
> trova le funzioni in NotificationsService.swift che non sono coperte dai test
```

Generare scaffold di test:

```
> aggiungi test per il servizio di notifiche
```

Aggiungere casi di test significativi:

```
> aggiungi casi di test per condizioni limite nel servizio di notifiche
```

Eseguire e verificare i test:

```
> esegui i nuovi test e correggi eventuali errori
```

### Creazione di pull request

Riassumere i tuoi cambiamenti:

```
> riassumi i cambiamenti che ho fatto al modulo di autenticazione
```

Generare una PR con Claude:

```
> crea una pr
```

Rivedere e perfezionare:

```
> migliora la descrizione della PR con più contesto sui miglioramenti di sicurezza
```

Aggiungere dettagli sui test:

```
> aggiungi informazioni su come questi cambiamenti sono stati testati
```

### Gestione della documentazione

Identificare codice non documentato:

```
> trova le funzioni senza commenti JSDoc appropriati nel modulo auth
```

Generare documentazione:

```
> aggiungi commenti JSDoc alle funzioni non documentate in auth.js
```

Rivedere e migliorare:

```
> migliora la documentazione generata con più contesto ed esempi
```

### Lavoro con immagini

Aggiungere un'immagine alla conversazione:

- Trascina e rilascia un'immagine nella finestra di Claude Code
- Copia un'immagine e incollala con ctrl+v
- Fornisci un percorso immagine a Claude: "Analizza questa immagine: /percorso/alla/tua/immagine.png"

Esempi di analisi:

```
> cosa mostra questa immagine?
> descrivi gli elementi UI in questo screenshot
> ci sono elementi problematici in questo diagramma?
> genera CSS per corrispondere a questo mockup di design
```

### Riferimenti a file e directory

Riferimento a un singolo file:

```
> spiega la logica in @src/utils/auth.js
```

Riferimento a una directory:

```
> qual è la struttura di @src/components?
```

Riferimento a risorse MCP:

```
> mostrami i dati da @github:repos/owner/repo/issues
```

### Utilizzo del pensiero esteso

Per decisioni architetturali complesse:

```
> devo implementare un nuovo sistema di autenticazione usando OAuth2 per la nostra API. Pensa profondamente al miglior approccio per implementarlo nella nostra codebase.
```

Perfezionare il pensiero con prompt di follow-up:

```
> pensa alle potenziali vulnerabilità di sicurezza in questo approccio
> pensa più duramente ai casi limite che dovremmo gestire
```

Livelli di intensità del pensiero:

- "pensa" attiva il pensiero esteso di base
- "pensa di più", "pensa molto", "pensa più duramente", "pensa più a lungo" attiva un pensiero più profondo

### Riprendere conversazioni precedenti

Continuare la conversazione più recente:

```bash
claude --continue
```

Continuare in modalità non interattiva:

```bash
claude --continue --print "continua con il mio compito"
```

Mostrare il selettore di conversazioni:

```bash
claude --resume
```

### Esecuzione di sessioni Claude Code parallele con git worktrees

Creare un nuovo worktree:

```bash
# Crea un nuovo worktree con un nuovo branch
git worktree add ../project-feature-a -b feature-a

# Oppure crea un worktree con un branch esistente
git worktree add ../project-bugfix bugfix-123
```

Eseguire Claude Code in ogni worktree:

```bash
# Naviga al tuo worktree
cd ../project-feature-a

# Esegui Claude Code in questo ambiente isolato
claude
```

Gestire i tuoi worktrees:

```bash
# Elenca tutti i worktrees
git worktree list

# Rimuovi un worktree quando finito
git worktree remove ../project-feature-a
```

### Uso di Claude come utility Unix

Aggiungere Claude al tuo processo di verifica:

```json
// package.json
{
    "scripts": {
        "lint:claude": "claude -p 'sei un linter. guarda i cambiamenti vs. main e segnala problemi relativi a errori di battitura. riporta il nome del file e il numero di riga su una riga, e una descrizione del problema sulla seconda riga. non restituire altro testo.'"
    }
}
```

Passare dati attraverso Claude:

```bash
cat build-error.txt | claude -p 'spiega concisamente la causa principale di questo errore di build' > output.txt
```

Controllare il formato di output:

```bash
# Formato testo (predefinito)
cat data.txt | claude -p 'riassumi questi dati' --output-format text > summary.txt

# Formato JSON
cat code.py | claude -p 'analizza questo codice per bug' --output-format json > analysis.json

# Formato JSON streaming
cat log.txt | claude -p 'analizza questo file di log per errori' --output-format stream-json
```

## Comandi slash personalizzati

### Creazione di comandi specifici per progetto

Creare una directory di comandi nel tuo progetto:

```bash
mkdir -p .claude/commands
```

Creare un file Markdown per ogni comando:

```bash
echo "Analizza le prestazioni di questo codice e suggerisci tre ottimizzazioni specifiche:" > .claude/commands/optimize.md
```

Utilizzare il tuo comando personalizzato:

```
> /optimize
```

### Aggiungere argomenti ai comandi con $ARGUMENTS

Creare un file di comando con il placeholder $ARGUMENTS:

```bash
echo "Trova e correggi l'issue #$ARGUMENTS. Segui questi passaggi: 1. Comprendi l'issue descritto nel ticket 2. Localizza il codice rilevante nella nostra codebase 3. Implementa una soluzione che affronta la causa principale 4. Aggiungi test appropriati 5. Prepara una descrizione PR concisa" > .claude/commands/fix-issue.md
```

Utilizzare il comando con un numero di issue:

```
> /fix-issue 123
```

### Comandi slash personali

Creare una directory di comandi nella tua cartella home:

```bash
mkdir -p ~/.claude/commands
```

Creare comandi personali riutilizzabili:

```bash
echo "Rivedi questo codice per vulnerabilità di sicurezza, concentrandoti su:" > ~/.claude/commands/security-review.md
```

### Esempi di comandi slash avanzati

Comando di revisione sicurezza:

```markdown
---
name: security-review
description: Rivedi il codice per vulnerabilità di sicurezza, problemi di validazione input e potenziali falle
tools: Read, Grep, Glob
---

Sei un esperto di sicurezza informatica specializzato nella revisione del codice.

Quando invocato:
1. Analizza il codice per vulnerabilità comuni
2. Controlla la validazione dell'input
3. Cerca chiavi API esposte o segreti
4. Verifica la gestione degli errori
5. Esamina l'autenticazione e l'autorizzazione

Checklist di sicurezza:
- Nessun dato sensibile hardcoded
- Validazione input implementata
- Gestione appropriata degli errori
- Autenticazione e autorizzazione sicure
- Protezione contro XSS e injection
- Crittografia appropriata per dati sensibili

Fornisci feedback organizzato per priorità:
- Problemi critici (da correggere)
- Avvisi (dovrebbero essere corretti)
- Suggerimenti (considera di migliorare)
```

Comando ottimizzazione performance:

```markdown
---
name: optimize
description: Analizza il codice per problemi di performance e suggerisci ottimizzazioni specifiche
tools: Read, Grep, Bash
---

Sei un esperto di ottimizzazione delle performance.

Quando invocato:
1. Identifica colli di bottiglia nel codice
2. Analizza complessità algoritmica
3. Cerca ottimizzazioni di memoria
4. Verifica pattern di accesso ai dati
5. Suggerisci miglioramenti specifici

Aree di focus:
- Complessità algoritmica O(n)
- Utilizzo memoria e garbage collection
- Query database e accesso I/O
- Rendering e aggiornamenti UI
- Bundle size e lazy loading

Per ogni problema identificato:
- Spiega l'impatto sulle performance
- Fornisci soluzione specifica
- Quantifica il miglioramento atteso
- Suggerisci metriche per misurare il miglioramento
```

## Sub agents specializzati

### Panoramica dei sub agents

I sub agents sono assistenti AI specializzati che Claude Code può delegare per gestire specifici tipi di compiti. Ogni sub agent:

- Ha uno scopo specifico e un'area di competenza
- Usa il proprio contesto separato dalla conversazione principale
- Può essere configurato con strumenti specifici che può utilizzare
- Include un prompt di sistema personalizzato che guida il suo comportamento

### Avvio rapido con sub agents

Aprire l'interfaccia sub agents:

```
/agents
```

Selezionare 'Crea nuovo agente':

1. Scegli se creare un sub agent a livello progetto o utente
2. Raccomandato: Genera prima con Claude, poi personalizza

Definire il sub agent:

1. Descrivi il tuo subagent in dettaglio e quando dovrebbe essere utilizzato
2. Seleziona gli strumenti a cui vuoi dare accesso
3. Modifica il prompt di sistema se necessario

### Posizioni file sub agents

| Tipo | Posizione | Ambito | Priorità |
|------|-----------|--------|----------|
| Sub agents progetto | `.claude/agents/` | Disponibile nel progetto corrente | Massima |
| Sub agents utente | `~/.claude/agents/` | Disponibile in tutti i progetti | Minore |

### Formato file sub agent

```markdown
---
name: nome-sub-agent
description: Descrizione di quando questo sub agent dovrebbe essere invocato
tools: tool1, tool2, tool3  # Opzionale - eredita tutti gli strumenti se omesso
---

Il prompt di sistema del tuo sub agent va qui. Può essere composto da più paragrafi
e dovrebbe definire chiaramente il ruolo, le capacità e l'approccio del sub agent
per risolvere i problemi.

Includi istruzioni specifiche, migliori pratiche e qualsiasi vincolo
che il sub agent dovrebbe seguire.
```

### Utilizzo efficace dei sub agents

**Delegazione automatica:**

Claude Code delega proattivamente i compiti basandosi su:

- La descrizione del compito nella tua richiesta
- Il campo description nelle configurazioni dei sub agent
- Il contesto attuale e gli strumenti disponibili

**Invocazione esplicita:**

```
> usa il sub agent test-runner per correggere i test falliti
> fai controllare al sub agent code-reviewer i miei cambiamenti recenti
> chiedi al sub agent debugger di investigare questo errore
```

### Esempi di sub agents

**Revisore di codice:**

```markdown
---
name: code-reviewer
description: Specialista revisione codice esperto. Rivede proattivamente il codice per qualità, sicurezza e manutenibilità. Da usare immediatamente dopo aver scritto o modificato codice.
tools: Read, Grep, Glob, Bash
---

Sei un senior code reviewer che garantisce alti standard di qualità e sicurezza del codice.

Quando invocato:
1. Esegui git diff per vedere i cambiamenti recenti
2. Concentrati sui file modificati
3. Inizia la revisione immediatamente

Checklist di revisione:
- Il codice è semplice e leggibile
- Funzioni e variabili hanno nomi appropriati
- Nessun codice duplicato
- Gestione errori appropriata
- Nessun segreto o chiave API esposta
- Validazione input implementata
- Buona copertura dei test
- Considerazioni sulle performance

Fornisci feedback organizzato per priorità:
- Problemi critici (da correggere)
- Avvisi (dovrebbero essere corretti)
- Suggerimenti (considera di migliorare)

Includi esempi specifici di come correggere i problemi.
```

**Debugger:**

```markdown
---
name: debugger
description: Specialista debugging per errori, fallimenti di test e comportamenti inaspettati. Da usare proattivamente quando si incontrano problemi.
tools: Read, Edit, Bash, Grep, Glob
---

Sei un debugger esperto specializzato nell'analisi delle cause principali.

Quando invocato:
1. Cattura messaggio di errore e stack trace
2. Identifica i passaggi di riproduzione
3. Isola la posizione del fallimento
4. Implementa correzione minimale
5. Verifica che la soluzione funzioni

Processo di debugging:
- Analizza messaggi di errore e log
- Controlla cambiamenti di codice recenti
- Formula e testa ipotesi
- Aggiungi logging di debug strategico
- Ispeziona stati delle variabili

Per ogni problema, fornisci:
- Spiegazione della causa principale
- Evidenza che supporta la diagnosi
- Correzione specifica del codice
- Approccio di testing
- Raccomandazioni di prevenzione

Concentrati sulla correzione del problema sottostante, non solo sui sintomi.
```

### Concatenamento di sub agents

Per workflow complessi, puoi concatenare più sub agents:

```
> prima usa il sub agent code-analyzer per trovare problemi di performance, poi usa il sub agent optimizer per correggerli
```

## Hook personalizzati

### Panoramica degli hook

Gli hook di Claude Code sono comandi shell definiti dall'utente che si eseguono in vari punti del ciclo di vita di Claude Code, fornendo controllo deterministico sul comportamento.

### Eventi hook disponibili

| Evento | Descrizione | Quando si attiva |
|--------|-------------|------------------|
| PreToolUse | Prima dell'esecuzione degli strumenti | Può bloccare le chiamate agli strumenti |
| PostToolUse | Dopo il completamento degli strumenti | Immediatamente dopo il successo |
| Notification | Quando Claude invia notifiche | Permessi richiesti o input in attesa |
| UserPromptSubmit | Quando l'utente invia un prompt | Prima che Claude lo elabori |
| Stop | Quando Claude finisce di rispondere | Agente principale completato |
| SubagentStop | Quando un sub agent finisce | Task del sub agent completato |

### Configurazione hook di base

Aprire configurazione hook:

```
/hooks
```

Esempio: logging comandi bash:

```bash
jq -r '"\\(.tool_input.command) - \\(.tool_input.description // "Nessuna descrizione")"' >> ~/.claude/bash-command-log.txt
```

### Esempi di hook avanzati

**Hook formattazione codice:**

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|MultiEdit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | { read file_path; if echo \"$file_path\" | grep -q '\\.ts$'; then npx prettier --write \"$file_path\"; fi; }"
          }
        ]
      }
    ]
  }
}
```

**Hook notifica desktop personalizzata:**

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "notify-send 'Claude Code' 'In attesa del tuo input'"
          }
        ]
      }
    ]
  }
}
```

**Hook protezione file:**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|MultiEdit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "python3 -c \"import json, sys; data=json.load(sys.stdin); path=data.get('tool_input',{}).get('file_path',''); sys.exit(2 if any(p in path for p in ['.env', 'package-lock.json', '.git/']) else 0)\""
          }
        ]
      }
    ]
  }
}
```

### Input e output degli hook

Struttura input hook:

```json
{
  "session_id": "abc123",
  "transcript_path": "/percorso/alla/conversazione.jsonl",
  "cwd": "/directory/corrente",
  "hook_event_name": "PreToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/percorso/al/file.txt",
    "content": "contenuto file"
  }
}
```

Controllo output con codici di uscita:

- **Codice 0:** Successo, stdout mostrato in modalità trascrizione
- **Codice 2:** Errore bloccante, stderr passato a Claude
- **Altri codici:** Errore non bloccante, stderr mostrato all'utente

## Model Context Protocol (MCP)

### Configurazione server MCP

Aggiungere un server MCP stdio:

```bash
# Sintassi base
claude mcp add <nome> <comando> [args...]

# Esempio: aggiungere un server locale
claude mcp add my-server -e API_KEY=123 -- /percorso/al/server arg1 arg2
```

Aggiungere un server MCP SSE:

```bash
# Sintassi base
claude mcp add --transport sse <nome> <url>

# Esempio: aggiungere un server SSE
claude mcp add --transport sse sse-server https://example.com/sse-endpoint

# Esempio: aggiungere un server SSE con header personalizzati
claude mcp add --transport sse api-server https://api.example.com/mcp --header "X-API-Key: your-key"
```

Aggiungere un server MCP HTTP:

```bash
# Sintassi base
claude mcp add --transport http <nome> <url>

# Esempio: aggiungere un server HTTP streamable
claude mcp add --transport http http-server https://example.com/mcp
```

Gestire i tuoi server MCP:

```bash
# Elencare tutti i server configurati
claude mcp list

# Ottenere dettagli per un server specifico
claude mcp get my-server

# Rimuovere un server
claude mcp remove my-server
```

### Ambiti server MCP

Ambito locale (predefinito):

```bash
# Aggiungere un server con ambito locale
claude mcp add my-private-server /percorso/al/server

# Specificare esplicitamente ambito locale
claude mcp add my-private-server -s local /percorso/al/server
```

Ambito progetto:

```bash
# Aggiungere un server con ambito progetto
claude mcp add shared-server -s project /percorso/al/server
```

Ambito utente:

```bash
# Aggiungere un server utente
claude mcp add my-user-server -s user /percorso/al/server
```

### Utilizzo risorse MCP

Riferimento risorse MCP:

```
> puoi analizzare @github:issue://123 e suggerire una correzione?
> per favore rivedi la documentazione API a @docs:file://api/authentication
> confronta @postgres:schema://users con @docs:file://database/user-model
```

### Prompt MCP come comandi slash

I server MCP possono esporre prompt che diventano disponibili come comandi slash in Claude Code.

Formato comandi MCP:

```
/mcp__<nome-server>__<nome-prompt> [argomenti]
```

Esempi di utilizzo:

```
# Senza argomenti
> /mcp__github__list_prs

# Con argomenti
> /mcp__github__pr_review 456
> /mcp__jira__create_issue "Titolo bug" high
```

## GitHub Actions con Claude Code

### Setup rapido

Installazione attraverso Claude Code:

```
/install-github-app
```

### Setup manuale

1. Installare la GitHub app Claude: https://github.com/apps/claude
2. Aggiungere `ANTHROPIC_API_KEY` ai segreti del repository
3. Copiare il file workflow da `examples/claude.yml` in `.github/workflows/`

### Casi d'uso esempio

Trasformare issue in PR:

```
@claude implementa questa funzionalità basata sulla descrizione dell'issue
```

Ottenere aiuto per implementazione:

```
@claude come dovrei implementare l'autenticazione utente per questo endpoint?
```

Correggere bug rapidamente:

```
@claude correggi il TypeError nel componente dashboard utente
```

### File CLAUDE.md per configurazione

Crea un file CLAUDE.md nella root del tuo repository per definire:

- Linee guida di stile del codice
- Criteri di revisione
- Regole specifiche del progetto
- Pattern preferiti

### Configurazione per AWS Bedrock

Segreti richiesti:

- `AWS_ROLE_TO_ASSUME`: ARN del ruolo IAM per accesso Bedrock
- `APP_ID`: ID della tua GitHub App
- `APP_PRIVATE_KEY`: Chiave privata della tua GitHub App

Esempio workflow:

```yaml
name: Claude PR Action

permissions:
  contents: write
  pull-requests: write
  issues: write
  id-token: write

on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
  issues:
    types: [opened, assigned]

jobs:
  claude-pr:
    if: |
      (github.event_name == 'issue_comment' && contains(github.event.comment.body, '@claude')) ||
      (github.event_name == 'pull_request_review_comment' && contains(github.event.comment.body, '@claude')) ||
      (github.event_name == 'issues' && contains(github.event.issue.body, '@claude'))
    runs-on: ubuntu-latest
    env:
      AWS_REGION: us-west-2
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Generate GitHub App token
        id: app-token
        uses: actions/create-github-app-token@v2
        with:
          app-id: ${{ secrets.APP_ID }}
          private-key: ${{ secrets.APP_PRIVATE_KEY }}

      - name: Configure AWS Credentials (OIDC)
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_TO_ASSUME }}
          aws-region: us-west-2

      - uses: ./.github/actions/claude-pr-action
        with:
          trigger_phrase: "@claude"
          timeout_minutes: "60"
          github_token: ${{ steps.app-token.outputs.token }}
          use_bedrock: "true"
          model: "us.anthropic.claude-3-7-sonnet-20250219-v1:0"
```

### Configurazione per Google Vertex AI

Segreti richiesti:

- `GCP_WORKLOAD_IDENTITY_PROVIDER`: Nome risorsa provider identità workload
- `GCP_SERVICE_ACCOUNT`: Email account servizio con accesso Vertex AI
- `APP_ID`: ID della tua GitHub App
- `APP_PRIVATE_KEY`: Chiave privata della tua GitHub App

Esempio workflow:

```yaml
name: Claude PR Action

permissions:
  contents: write
  pull-requests: write
  issues: write
  id-token: write

on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
  issues:
    types: [opened, assigned]

jobs:
  claude-pr:
    if: |
      (github.event_name == 'issue_comment' && contains(github.event.comment.body, '@claude')) ||
      (github.event_name == 'pull_request_review_comment' && contains(github.event.comment.body, '@claude')) ||
      (github.event_name == 'issues' && contains(github.event.issue.body, '@claude'))
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Generate GitHub App token
        id: app-token
        uses: actions/create-github-app-token@v2
        with:
          app-id: ${{ secrets.APP_ID }}
          private-key: ${{ secrets.APP_PRIVATE_KEY }}

      - name: Authenticate to Google Cloud
        id: auth
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: ${{ secrets.GCP_WORKLOAD_IDENTITY_PROVIDER }}
          service_account: ${{ secrets.GCP_SERVICE_ACCOUNT }}

      - uses: ./.github/actions/claude-pr-action
        with:
          trigger_phrase: "@claude"
          timeout_minutes: "60"
          github_token: ${{ steps.app-token.outputs.token }}
          use_vertex: "true"
          model: "claude-3-7-sonnet@20250219"
        env:
          ANTHROPIC_VERTEX_PROJECT_ID: ${{ steps.auth.outputs.project_id }}
          CLOUD_ML_REGION: us-east5
          VERTEX_REGION_CLAUDE_3_7_SONNET: us-east5
```

## Gestione della memoria di Claude

### Tipi di memoria

| Tipo di memoria | Posizione | Scopo | Esempi di caso d'uso |
|-----------------|-----------|-------|----------------------|
| Memoria progetto | `./CLAUDE.md` | Istruzioni condivise dal team per il progetto | Architettura progetto, standard di codifica, workflow comuni |
| Memoria utente | `~/.claude/CLAUDE.md` | Preferenze personali per tutti i progetti | Preferenze stile codice, scorciatoie tooling personali |
| Memoria progetto (locale) | `./CLAUDE.local.md` | Preferenze personali specifiche del progetto | (Deprecato) URL sandbox, dati test preferiti |

### Import CLAUDE.md

I file CLAUDE.md possono importare file aggiuntivi usando la sintassi `@percorso/all/import`:

```markdown
Vedi @README per panoramica progetto e @package.json per comandi npm disponibili.

# Istruzioni aggiuntive
- workflow git @docs/git-instructions.md

# Preferenze individuali
- @~/.claude/my-project-instructions.md
```

### Scorciatoia rapida per aggiungere memoria

Usare il carattere `#`:

```
# usa sempre nomi di variabili descrittivi
```

Ti verrà chiesto di selezionare in quale file di memoria memorizzare questo.

### Modificare direttamente le memorie

Comando `/memory`:

```
/memory
```

Apre qualsiasi file di memoria nel tuo editor di sistema per aggiunte o organizzazione più estese.

### Configurare memoria progetto

Bootstrap di un CLAUDE.md per la tua codebase:

```
/init
```

### Migliori pratiche per la memoria

- **Sii specifico:** "Usa indentazione di 2 spazi" è meglio di "Formatta il codice correttamente"
- **Usa struttura per organizzare:** Formatta ogni memoria individuale come punto elenco e raggruppa memorie correlate sotto intestazioni markdown descrittive
- **Rivedi periodicamente:** Aggiorna le memorie man mano che il tuo progetto evolve

## Comandi slash integrati

### Comandi di gestione sessione

| Comando | Scopo |
|---------|-------|
| `/add-dir` | Aggiunge directory di lavoro aggiuntive |
| `/clear` | Cancella cronologia conversazione |
| `/compact [istruzioni]` | Compatta conversazione con istruzioni focus opzionali |
| `/cost` | Mostra statistiche utilizzo token |
| `/help` | Ottieni aiuto sull'utilizzo |
| `/status` | Visualizza stati account e sistema |

### Comandi di configurazione

| Comando | Scopo |
|---------|-------|
| `/config` | Visualizza/modifica configurazione |
| `/login` | Cambia account Anthropic |
| `/logout` | Disconnetti dal tuo account Anthropic |
| `/model` | Seleziona o cambia il modello AI |
| `/permissions` | Visualizza o aggiorna permessi |
| `/terminal-setup` | Installa binding tasto Shift+Enter per newline |
| `/vim` | Entra in modalità vim |

### Comandi di sviluppo

| Comando | Scopo |
|---------|-------|
| `/agents` | Gestisci sub agent AI personalizzati |
| `/hooks` | Gestisci hook personalizzati |
| `/init` | Inizializza progetto con guida CLAUDE.md |
| `/memory` | Modifica file memoria CLAUDE.md |
| `/mcp` | Gestisci connessioni server MCP |
| `/pr_comments` | Visualizza commenti pull request |
| `/review` | Richiedi revisione codice |

### Comandi di supporto

| Comando | Scopo |
|---------|-------|
| `/bug` | Segnala bug (invia conversazione ad Anthropic) |
| `/doctor` | Controlla salute installazione Claude Code |

## Configurazioni avanzate

### File settings.json

Posizioni dei file di impostazioni:

- **Impostazioni utente:** `~/.claude/settings.json` - si applicano a tutti i progetti
- **Impostazioni progetto:** `.claude/settings.json` - condivise con il team
- **Impostazioni locali progetto:** `.claude/settings.local.json` - non committate

Esempio settings.json:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test:*)",
      "Read(~/.zshrc)"
    ],
    "deny": [
      "Bash(curl:*)"
    ]
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_METRICS_EXPORTER": "otlp"
  },
  "model": "claude-3-5-sonnet-20241022",
  "cleanupPeriodDays": 20,
  "includeCoAuthoredBy": false
}
```

### Impostazioni disponibili

| Chiave | Descrizione | Esempio |
|--------|-------------|---------|
| `apiKeyHelper` | Script personalizzato per generare valore auth | `/bin/generate_temp_api_key.sh` |
| `cleanupPeriodDays` | Quanto mantenere localmente le trascrizioni chat | `20` |
| `env` | Variabili ambiente applicate a ogni sessione | `{"FOO": "bar"}` |
| `includeCoAuthoredBy` | Se includere byline co-authored-by Claude | `false` |
| `model` | Sovrascrive modello predefinito | `"claude-3-5-sonnet-20241022"` |
| `forceLoginMethod` | Usa claudeai o console per restringere login | `claudeai` |

### Impostazioni permessi

| Chiave | Descrizione | Esempio |
|--------|-------------|---------|
| `allow` | Array di regole permessi per consentire uso strumenti | `[ "Bash(git diff:*)" ]` |
| `deny` | Array di regole permessi per negare uso strumenti | `[ "WebFetch", "Bash(curl:*)" ]` |
| `additionalDirectories` | Directory di lavoro aggiuntive a cui Claude ha accesso | `[ "../docs/" ]` |
| `defaultMode` | Modalità permessi predefinita all'apertura | `"acceptEdits"` |

### Variabili ambiente

| Variabile | Scopo |
|-----------|-------|
| `ANTHROPIC_API_KEY` | Chiave API inviata come header X-Api-Key |
| `ANTHROPIC_MODEL` | Nome modello personalizzato da usare |
| `CLAUDE_CODE_USE_BEDROCK` | Usa Bedrock |
| `CLAUDE_CODE_USE_VERTEX` | Usa Vertex |
| `DISABLE_TELEMETRY` | Imposta a 1 per disattivare telemetria |
| `HTTP_PROXY` | Specifica server proxy HTTP |
| `MCP_TIMEOUT` | Timeout in millisecondi per avvio server MCP |

### Strumenti disponibili per Claude

| Strumento | Descrizione | Permesso richiesto |
|-----------|-------------|-------------------|
| Bash | Esegue comandi shell nel tuo ambiente | Si |
| Edit | Effettua modifiche mirate a file specifici | Si |
| Glob | Trova file basati su pattern matching | No |
| Grep | Cerca pattern nei contenuti file | No |
| LS | Elenca file e directory | No |
| MultiEdit | Effettua modifiche multiple su singolo file atomicamente | Si |
| Read | Legge contenuti dei file | No |
| Task | Esegue sub agent per gestire task complessi multi-step | No |
| WebFetch | Recupera contenuto da URL specificato | Si |
| WebSearch | Effettua ricerche web con filtro domini | Si |
| Write | Crea o sovrascrive file | Si |

## Risoluzione problemi comuni

### Claude non risponde ai comandi @claude

- Verifica che la GitHub App sia installata correttamente
- Controlla che i workflow siano abilitati
- Assicurati che la chiave API sia impostata nei segreti del repository
- Conferma che il commento contenga `@claude` (non `/claude`)

### Errori di autenticazione

- Conferma che la chiave API sia valida e abbia permessi sufficienti
- Per Bedrock/Vertex, controlla configurazione credenziali
- Assicurati che i segreti siano nominati correttamente nei workflow

### Problemi di performance

- Usa query specifiche per ridurre chiamate API non necessarie
- Configura limiti `max_turns` appropriati
- Imposta `timeout_minutes` ragionevoli
- Considera l'uso di controlli concorrenza GitHub

### Hook non funzionano

- **Controlla configurazione** - Esegui `/hooks` per vedere se il tuo hook è registrato
- **Verifica sintassi** - Assicurati che le impostazioni JSON siano valide
- **Testa comandi** - Esegui prima i comandi hook manualmente
- **Controlla permessi** - Assicurati che gli script siano eseguibili
- **Rivedi log** - Usa `claude --debug` per vedere dettagli esecuzione hook

## Conclusioni

Claude Code rappresenta una rivoluzione nel modo di sviluppare software, offrendo un assistente AI potente e flessibile che può adattarsi a qualsiasi workflow di sviluppo. Dalla comprensione di nuove codebase alla gestione di workflow complessi con sub agents e hook personalizzati, Claude Code fornisce gli strumenti necessari per aumentare significativamente la produttività di sviluppo.

### Punti chiave da ricordare

- **Inizia semplice:** Usa Claude Code per compiti base prima di passare a configurazioni avanzate
- **Personalizza gradualmente:** Aggiungi comandi slash, sub agents e hook man mano che identifichi pattern ricorrenti
- **Sperimenta:** Ogni progetto è diverso, trova il workflow che funziona meglio per te
- **Condividi:** Usa configurazioni a livello progetto per condividere setup efficaci con il tuo team

L'evoluzione continua di Claude Code, con nuove funzionalità come l'integrazione GitHub Actions e il supporto MCP esteso, promette di rendere lo sviluppo assistito da AI sempre più potente e accessibile.
