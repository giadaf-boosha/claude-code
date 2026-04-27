# Claude Code 2.0 + Sonnet 4.5

## Annuncio ufficiale di Anthropic

L'account ufficiale @claudeai ha annunciato il rilascio di Claude Sonnet 4.5, definendolo "the best coding model in the world". Il modello è descritto come il più performante per costruire agenti complessi e per l'utilizzo di computer, mostrando guadagni sostanziali nei test di reasoning e matematica.

## Claude Sonnet 4.5: Performance e Benchmark

### Benchmark specifici riportati

| Benchmark | Sonnet 4.5 | Opus 4.1 | Sonnet 4 | GPT-5 | Gemini 2.5 Pro |
|-----------|-----------|----------|----------|-------|----------------|
| Agentic coding (self-hosted testing) | 82.0% | 79.4% | 77.2% | 72.8% | 67.2% |
| Agentic reasoning (coding) | 80.2% | 46.5% | 34.4% | 43.8% | 25.3% |
| Agentic tool use (2-tools) | 86.2% | 86.8% | 83.8% | 81.1% | - |
| Agentic tool use (function calls) | 70.0% | 63.0% | 63.0% | 62.6% | - |
| Computer use (OSWorld) | 96.0% | 71.5% | 49.6% | 96.7% | - |
| High school math (competition) | 100% | 78.0% | 70.5% | 99.6% | 88.0% |
| Graduate-level reasoning (GPQA) | 83.4% | 81.0% | 74.1% | 85.7% | 86.4% |
| Multilingual QA (MMMLU) | 89.1% | 89.5% | 86.5% | 89.4% | - |
| Visual reasoning (MMMU collection) | 77.8% | 77.1% | 74.4% | 84.2% | 82.0% |
| Financial analysis (Finance Agent) | 55.3% | 50.9% | 44.6% | 40.9% | 29.4% |

### Posizionamento nell'API

Il modello è accessibile tramite API con il model string `claude-sonnet-4-5-20250929`. Ian Nuttall riferisce che è già disponibile nell'API e che la maggior parte degli strumenti agentici lo supportano già.

### Pricing

Alex Albert conferma che Sonnet 4.5 è un drop-in replacement per Sonnet 4 allo stesso prezzo, con performance significativamente migliori su tutta la linea.

### Computer use capabilities

Alex Albert sottolinea che Sonnet 4.5 raggiunge il 61.4% su OSWorld, rappresentando un salto del 19.2% rispetto a Sonnet 4. Questo è il primo caso in cui l'uso del computer ha raggiunto il territorio "effettivamente utile per me personalmente", specialmente quando usato nell'estensione Chrome di Claude.

## Claude Code 2.0: Novità specifiche

### Aggiornamenti annunciati ufficialmente

L'account @claudeai ha annunciato diversi upgrade a Claude Code, oltre a due nuove funzionalità per gestire il contesto sulla Claude Developer Platform.

### Caratteristiche dell'interfaccia

Ian Nuttall descrive Claude Code 2.0 come un'interfaccia che "non sembra nemmeno una CLI, molto 'Warp' come interazioni". Questo indica un allontanamento dall'esperienza command-line tradizionale verso qualcosa di più conversazionale e user-friendly.

### Funzionalità specifiche documentate

#### 1. Comando /rewind

> "Use the new /rewind command to roll back code changes instantly. Model messes up? No biggie, just rewind it back to when it worked!" — Ian Nuttall

Kieran Klaassen espande:

> "Tip! New in Claude code 2.0: When Claude messes up, run /rewind to undo code changes"

Aggiunge inoltre: "New native VS Code extension".

#### 2. Gestione del contesto migliorata

Sulla Claude API sono state aggiunte "two new capabilities to build agents that handle long-running tasks without frequently hitting context limits":

- **Context editing** per eliminare automaticamente contesto obsoleto
- La possibilità per gli agenti di fare review di large pull request in minuti, gestire multi-file reasoning senza wandering, e rimanere terse quando richiesto

#### 3. Context window optimization

> "Very interesting observation by the Cognition/Devin team about enabling the 1M context window with Sonnet 4.5 but still capping it at 200k" — Ian Nuttall

Questa scoperta ha portato a un modello che "thinks it has plenty of runway and behaves normally, without the anxiety-driven shortcuts or degraded performance".

### Nuove capacità per la gestione dei progetti

**Bash command requirements**: Ian Nuttall segnala una caratteristica di warp code:

> "One really cool feature I like about warp code is that when your bash command requires input to select an option - it just lets you do it. With other CLIs they have to try and run the command again and pass the arg with another tool call"

**File e progetto capabilities** - Claude Code 2.0 presenta opzioni per:
- New conversation
- Resume conversation
- Clear conversation
- Manage Context
- Mention a file
- Attach file
- Select model

### System prompt migliorato

Un utente ha estratto e pubblicato il system prompt completo del nuovo Sonnet 4.5, che ammonta a quasi 10k tokens.

> "Here's the new sonnet 4.5 system prompt, almost 10k tokens! Time to see if anthropic cooked" — Ian Nuttall

### Tracking dell'utilizzo

L'account ufficiale Claude ha annunciato: "You can now track your usage in real time across the Claude apps and Claude Code. Head to Settings -> Usage or type /usage in Claude Code."

Il pannello mostra:
- Plan usage limits
- Current session (con timer di reset)
- Weekly limits (con breakdown per utilizzo)
- All models (con dettagli specifici)
- Opus only (con percentuale di utilizzo)

## Developer Platform: Nuove funzionalità

Alex Albert conferma: "We also launched two new features for managing context on the Claude Developer Platform."

- **Context editing** per eliminare automaticamente contesto obsoleto durante task agentici lunghi
- Capacità migliorate per gli agenti di gestire review multi-file

L'Agent SDK viene presentato come strumento principale:

> "I've re-branded the Claude Code SDK to the Claude Agent SDK to reflect that it's the best way to build any general purpose agent, not just coding agents. Especially now when paired with Sonnet 4.5." — Alex Albert

Documentazione disponibile su: docs.claude.com (Agent SDK overview)

## Reazioni e casi d'uso dalla community

### Capacità di reasoning economico/statistico

> "AI agents are now capable of doing real, if bounded, work. But that work can be very valuable. For example, the new Claude Sonnet 4.5 was able to replicate published economics research from data files & the paper." — Ethan Mollick

> "I had some early access to Sonnet 4.5. It is a really good model. I saw especially big jumps in doing finance and statistics, which tend to get overlooked in the focus on coding." — Ethan Mollick

### User experience migliorata

Dan Shipper di Every conferma nei suoi test che il modello è "GREAT" dopo averlo testato per alcuni giorni.

### Affidabilità per uso professionale

Kieran Klaassen condivide la sua esperienza costruendo con @CoraComputer e @nityeshaga con reazioni molto positive per le capacità del modello.

### Progetti complessi realizzati

> "Oh yeah, I vibe-coded an iOS app for @CoraComputer this weekend with Sonnet 4.5 in Claude Code! DM for testflight." — Kieran Klaassen

Questo dimostra che Claude Code 2.0 può essere utilizzato per sviluppare applicazioni mobile complete.

### Velocità e affidabilità

Robin Ebers commenta:

> "Zero shill. GPT-5 still skills in thinking, but Sonnet 4.5 is a dramatic departure from 4.0 and runs incredibly fast. That's the model release in a nutshell."

Evidenzia:
- Velocità di esecuzione percepita come significativamente superiore
- Miglioramento sostanziale rispetto alla versione 4.0
- Tradeoff riconosciuto: GPT-5 mantiene vantaggio in alcuni aspetti di reasoning, ma Sonnet 4.5 compensa con velocità

### File creation capabilities

Alex Albert evidenzia:

> "This feature is now available for Pro users too! Sonnet 4.5 brings significant gains to Claude's file creation abilities across industries. What coding agents have been doing for software engineering is soon expanding to all knowledge work – this is just the beginning."

### Casi d'uso avanzati

Simon Willison riporta un caso d'uso pratico: Armin (creator di Flask, Jinja, Click) ha dichiarato che il 90% di un nuovo progetto infrastrutturale è stato generato dall'AI.

Questo evidenzia:
- Utilizzo da parte di sviluppatori senior e creator di framework importanti
- Applicabilità a progetti infrastrutturali complessi
- Validazione da fonti credibili e tecnicamente competenti

## Ecosistema di strumenti complementari

### Emdash

Ian Nuttall menziona "emdash":

> "Run a bunch of Codex CLI agents in parallel, all in their own isolated worktrees so they don't get in each others way. Fully open source mac app you can fork + build custom features that suit your workflow (using AI agents ofc)"

Suggerisce l'emergere di un ecosistema di strumenti che orchestrano multiple istanze di Claude Code con:
- Esecuzione parallela di agenti
- Isolamento tramite git worktrees
- Approccio open-source e customizzabile

### Alternative open-source

Paul Couvert presenta un'alternativa open-source:
- Local AI model con Qwen3 Coder
- Esecuzione su machine locale con LM Studio
- Estensione VS Code open-source con Cline
- Completamente privato (offline) e illimitato

## Informazioni su Opus 4.5 e roadmap futura

- Aspettative su versioni Opus future dalla community
- Competizione serrata tra modelli top di gamma
- Possibili annunci da Google (Gemini 3) a ottobre
- Ian Nuttall sul timing: "Jury is still out but I think no - gpt5 and opus 4.1 is a deadly combo"
