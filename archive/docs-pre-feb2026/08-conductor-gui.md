# Conductor: GUI per Claude Code Paralleli

## Cos'è Conductor

Conductor è un'interfaccia grafica che permette di eseguire più istanze di Claude Code in parallelo, ciascuna con il proprio workspace isolato.

## Caratteristiche principali

- **Workspace isolati**: Ogni Claude Code ottiene un ambiente separato usando git worktrees
- **Gestione visuale**: Vedi chi sta lavorando, chi è bloccato e cosa è cambiato
- **Integrazione GitHub**: Lavora su issue con un clic, aggiungi facilmente repository privati
- **Sessioni persistenti**: Le sessioni terminale persistono quando navighi tra workspace

## Come funziona

1. **Aggiungi il tuo repo**: Conductor lo clona e lavora interamente sul tuo Mac
2. **Distribuisci agenti**: Ogni Claude Code che avvii ottiene un workspace isolato
3. **Conduci**: Vedi chi sta lavorando, cosa ha bisogno di attenzione e rivedi il codice

## Funzionalità recenti

- **Comandi slash**: Gestisci i tuoi comandi nelle Impostazioni
- **Provider Claude personalizzati**: Personalizza il tuo provider Claude
- **MCP**: Aggiungi server popolari con un clic dalla scheda MCP
- **Code di messaggi**: Invia più messaggi che verranno processati in ordine
- **Permessi GitHub fine-grained**: Dai a Conductor accesso granulare ai repository
- **Allegati**: Carica file tramite copia (⌘+V), drag and drop, o clic sull'icona graffetta

## Domande frequenti

**Conductor usa worktrees?**
Sì, ogni workspace Conductor è un nuovo git worktree.

**Quali agenti di codifica supporta Conductor?**
Al momento solo Claude Code. Altri in arrivo presto.

**Come paga Conductor per Claude Code?**
Conductor usa Claude Code comunque tu sia già loggato. Se sei loggato in Claude Code con una chiave API, Conductor userà quella. Se sei loggato con il piano Claude Pro o Max, Conductor userà quello.
