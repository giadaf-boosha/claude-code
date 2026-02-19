---
name: prd-generator
description: |
  Genera Product Requirement Documents (PRD) strutturati.
  Usa per: trasformare idee in specifiche dettagliate,
  creare user stories con acceptance criteria, preparare input per Ralph Loop.
user-invocable: true
disable-model-invocation: false
allowed-tools: Read, Write, AskUserQuestion
---

# PRD Generator

Trasforma descrizioni feature in PRD strutturati pronti per implementazione.

## Workflow

### 1. Input (Voice/Text)

```
Voglio aggiungere una feature di quiz per testare
le conoscenze degli utenti sui comandi Claude Code.
Dovrebbe avere 5 domande, mostrare il punteggio alla fine,
e salvare il best score.
```

### 2. Clarifying Questions (3-5)

Prima di generare il PRD, chiedi:

1. **Scope**: Quali sono i confini della feature?
2. **Users**: Chi la userà? (tutti, premium, admin?)
3. **Integration**: Come si integra con l'esistente?
4. **Success**: Come misuriamo il successo?
5. **Constraints**: Ci sono vincoli tecnici/business?

### 3. Output: PRD Markdown

```markdown
# PRD: [Feature Name]

## Overview
[1-2 paragrafi che descrivono la feature]

## Goals
- [Goal 1 misurabile]
- [Goal 2 misurabile]

## Non-Goals
- [Cosa NON faremo in questa versione]

## User Stories

### US-001: [Title]
**As a** [user type]
**I want to** [action]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] [Criterio verificabile 1]
- [ ] [Criterio verificabile 2]
- [ ] typecheck passes
- [ ] tests pass

**Priority:** P0/P1/P2

### US-002: [Title]
...

## Technical Considerations
- [Dipendenze]
- [Rischi tecnici]
- [Decisioni architetturali]

## Success Metrics
- [KPI 1]
- [KPI 2]

## Timeline
- Week 1: [Milestone]
- Week 2: [Milestone]

## Open Questions
- [Domanda da risolvere]
```

## Regole per User Stories

### 1. PICCOLE

Ogni story deve completarsi in 1 context window Claude.

```
❌ Troppo grande:
"Build authentication system"

✅ Atomiche:
- "Create User model with email/password"
- "Add password validation"
- "Create login endpoint"
- "Add session management"
```

### 2. VERIFICABILI

Acceptance criteria devono essere testabili automaticamente.

```
❌ Vago:
- Users can log in

✅ Verificabile:
- Login form has email and password fields
- Email field validates format (regex)
- Password field has minimum 8 chars
- Submit shows loading state
- Success redirects to /dashboard
- Error shows message below form
- typecheck passes
- tests pass
```

### 3. INDIPENDENTI (quando possibile)

```
❌ Dipendenza implicita:
US-001: Create login page
US-002: Add password reset (assume login exists)

✅ Dipendenza esplicita:
US-001: Create login page
US-002: Add password reset
  Dependencies: US-001
```

### 4. PRIORITIZZATE

```
P0: Must have (MVP)
P1: Should have (important)
P2: Nice to have (if time)
```

## Conversione a prd.json

Dopo aver creato il PRD markdown, converti per Ralph:

```json
{
  "branchName": "ralph/quiz-feature",
  "userStories": [
    {
      "id": "US-001",
      "title": "Create quiz intro screen",
      "acceptanceCriteria": [
        "Screen shows at /quiz route",
        "Displays quiz title and description",
        "Has 'Start Quiz' button",
        "Button navigates to first question",
        "typecheck passes"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

## Template per Domini Comuni

### E-commerce Feature

```
- US: Product listing page
- US: Product detail page
- US: Add to cart functionality
- US: Cart page with quantities
- US: Checkout flow step 1 (shipping)
- US: Checkout flow step 2 (payment)
- US: Order confirmation
```

### Auth Feature

```
- US: User model and migration
- US: Registration form
- US: Email validation
- US: Password requirements
- US: Login form
- US: Session management
- US: Logout functionality
- US: Password reset request
- US: Password reset execution
```

### CRUD Feature

```
- US: List view with pagination
- US: Detail view
- US: Create form
- US: Edit form
- US: Delete with confirmation
- US: Search/filter
```

## Best Practices

### 1. Start with User Journey

```
Mappa il flusso completo prima di scrivere stories:
Entry → Screen 1 → Screen 2 → Success → Exit
```

### 2. Include Edge Cases

```
Non solo happy path:
- Cosa succede se l'utente è offline?
- Cosa succede con input invalido?
- Cosa succede se la sessione scade?
```

### 3. Define Done

```
Ogni story include SEMPRE:
- typecheck passes
- tests pass
- Verified in browser (se UI)
```

### 4. Keep Context

```
PRD deve contenere abbastanza contesto che
un developer (o Claude) possa implementare
senza fare altre domande.
```

## Output Files

```
tasks/
├── prd-quiz-feature.md      # PRD completo
└── prd-quiz-feature.json    # Per Ralph Loop
```
