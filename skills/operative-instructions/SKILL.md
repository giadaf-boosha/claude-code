---
name: operative-instructions
description: |
  Istruzioni operative standard da applicare a TUTTI i task.
  Include: generazione spec.md, implementation_plan.md, interview dettagliate,
  nessun placeholder, commit/push automatici, uso di subagent.
user-invocable: false
disable-model-invocation: true
---

# Istruzioni Operative Standard

Queste istruzioni si applicano a OGNI task eseguito.

## Principi Fondamentali

### 1. Solo Informazioni Fornite

```
REGOLA: Svolgi il task basandoti SOLO ed ESCLUSIVAMENTE sulle informazioni
fornite nel contesto, senza inventare o assumere dati non presenti.

Se mancano informazioni:
- STOP
- Chiedi esplicitamente
- Non procedere con assunzioni
```

### 2. Interview Dettagliate

```
REGOLA: Prima di iniziare qualsiasi implementazione, intervista l'utente
in dettaglio su LETTERALMENTE TUTTO:
- Technical implementation
- UI & UX
- Concerns
- Tradeoffs
- Edge cases

Le domande NON devono essere ovvie - sii MOLTO approfondito.
Continua a intervistare finché non hai TUTTE le informazioni necessarie.
```

### 3. Generazione File di Specifica

```
REGOLA: All'inizio di OGNI progetto genera:

1. spec.md - Specifiche complete del progetto
2. implementation_plan.md - Piano di implementazione dettagliato

PRIMA di scrivere codice.
```

### 4. Lettura File Completa

```
REGOLA: Se durante il task devi leggere file e riscontri errori,
NON PROSEGUIRE finché non hai letto con successo il contenuto
di TUTTI i file necessari.

Mai procedere con informazioni parziali.
```

### 5. Ragionamento Approfondito

```
REGOLA: Prendi TUTTO il tempo necessario per ragionare approfonditamente.
Fornisci la migliore valutazione possibile.
Svolgi il task PASSO PASSO.

Non affrettare le decisioni.
```

### 6. Nessuna Scorciatoia

```
REGOLA: NON cercare o applicare scorciatoie che simulino il risultato.
Assicurati di:
- Sviluppare TUTTO
- Fixare TUTTI i bug ed errori
- Soddisfare TUTTI i requisiti

Nessuna simulazione, nessun mock permanente.
```

### 7. Zero Placeholder

```
REGOLA: NON mettere MAI placeholder.
Implementa OGNI singola funzione necessaria al raggiungimento
dell'obiettivo e soddisfazione dei requisiti.

Se qualcosa richiede implementazione, implementala.
```

### 8. Utilizzo Subagent

```
REGOLA: Utilizza PIÙ subagent sia nella fase di:
- Pianificazione
- Esecuzione dell'analisi
- Review del codice

Per migliorare la qualità dell'output.
Parallelizza quando possibile.
```

### 9. Soluzione Minimale Elegante

```
REGOLA: Pensa attentamente e agisci SOLO sul task specifico assegnato
con la soluzione più concisa ed elegante che cambia il MINIMO codice possibile.

Evita over-engineering.
```

### 10. Commit e Push

```
REGOLA: Al termine di OGNI implementazione:
1. git add <specific files>
2. git commit -m "feat: descrizione"
3. git push

Per tenere sempre traccia di tutto e tutto aggiornato.

NOTA: Solo se esplicitamente richiesto o se la repository esiste.
```

## Template spec.md

```markdown
# Specifica: [Nome Progetto]

## Obiettivo
[Descrizione chiara dell'obiettivo]

## Requisiti Funzionali
- RF1: [Requisito con criterio di accettazione]
- RF2: [Requisito con criterio di accettazione]

## Requisiti Non Funzionali
- RNF1: [Performance, sicurezza, etc.]

## User Flow
1. [Step 1]
2. [Step 2]
3. [Step N]

## Edge Cases
- [Caso limite 1 e come gestirlo]
- [Caso limite 2 e come gestirlo]

## Vincoli Tecnici
- [Vincolo 1]
- [Vincolo 2]

## Decisioni Aperte
- [Domanda da risolvere]

## Criteri di Successo
- [ ] [Criterio verificabile]
```

## Template implementation_plan.md

```markdown
# Piano di Implementazione: [Nome Progetto]

## Fase 1: Setup
- [ ] Task 1.1
- [ ] Task 1.2

## Fase 2: Core Implementation
- [ ] Task 2.1
- [ ] Task 2.2

## Fase 3: Testing
- [ ] Task 3.1
- [ ] Task 3.2

## Fase 4: Polish & Deploy
- [ ] Task 4.1
- [ ] Task 4.2

## Dipendenze
- Fase 2 dipende da Fase 1
- Fase 3 dipende da Fase 2

## Rischi e Mitigazioni
- Rischio 1: [Descrizione] → Mitigazione: [Azione]

## Timeline Stimata
- Fase 1: [X giorni]
- Fase 2: [Y giorni]
```

## Checklist Pre-Implementazione

Prima di scrivere codice, verifica:

- [ ] Ho intervistato l'utente su tutti gli aspetti
- [ ] Ho creato spec.md
- [ ] Ho creato implementation_plan.md
- [ ] Ho letto tutti i file necessari
- [ ] Ho identificato tutti gli edge cases
- [ ] Ho chiaro cosa NON devo fare (non-goals)

## Checklist Post-Implementazione

Dopo aver scritto codice, verifica:

- [ ] Tutti i requisiti sono soddisfatti
- [ ] Nessun placeholder rimasto
- [ ] Nessun bug noto
- [ ] Tests passano
- [ ] Typecheck passa
- [ ] Commit effettuato
- [ ] Push effettuato (se richiesto)
