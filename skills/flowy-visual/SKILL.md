---
name: flowy-visual
description: |
  Visual feedback loop per pianificazione UI/UX con Flowy.
  Usa per: creare flowchart interattivi, UI mockups, diagrammi di navigazione,
  iterare visualmente prima di scrivere codice.
user-invocable: true
disable-model-invocation: false
allowed-tools: Read, Write, Edit
---

# Flowy - Visual Feedback Loop

Sistema di diagrammi JSON-based che Claude può scrivere e tu puoi editare visualmente.

## Concetto

```
Claude scrive JSON → Dev server renderizza → Tu editi visualmente → JSON si aggiorna → Claude vede le modifiche
```

**Problema risolto**: Descrivere layout/UI con testo è difficile e impreciso.

**Soluzione**: Claude scrive diagrammi come JSON, tu li editi come Figma.

## File Structure

```
.flowy/
├── navigation-flow.json
├── gameplay-flow.json
└── screen-mockups.json
```

## Formato JSON

```json
{
  "version": "1.0",
  "name": "Quiz Navigation Flow",
  "nodes": [
    {
      "id": "learn-tab",
      "type": "rect",
      "label": "Learn Tab\n(index.tsx)",
      "position": { "x": 80, "y": 200 },
      "size": { "width": 120, "height": 70 },
      "style": {
        "fill": "#d0ebff",
        "stroke": "#1c7ed6",
        "cornerRadius": 10
      },
      "icon": { "name": "book-open", "size": 18, "color": "#1c7ed6" }
    }
  ],
  "edges": [
    {
      "id": "e1",
      "from": "learn-tab",
      "to": "quiz-card",
      "type": "arrow",
      "label": "displays"
    }
  ]
}
```

## Tipi di Nodo

| Type | Uso |
|------|-----|
| `rect` | Box rettangolare (default) |
| `circle` | Cerchio (stati, punti decisionali) |
| `diamond` | Diamante (decisioni if/else) |

## Tipi di Edge

| Type | Uso |
|------|-----|
| `arrow` | Freccia direzionale |
| `dashed` | Connessione opzionale |
| `line` | Connessione semplice |
| `orthogonal` | Linee a 90 gradi |
| `curved` | Linee curve |

## Workflow Completo

### 1. Pianifica Feature

```
Crea un flowchart Flowy per la feature [nome]:
- Navigation flow
- Gameplay/logic flow
- Screen mockups
```

### 2. Claude Genera JSON

```json
// .flowy/quiz-navigation.json
{
  "name": "Quiz Navigation",
  "nodes": [
    {"id": "intro", "type": "rect", "label": "Quiz Intro"},
    {"id": "questions", "type": "rect", "label": "Questions"},
    {"id": "results", "type": "rect", "label": "Results"}
  ],
  "edges": [
    {"from": "intro", "to": "questions", "label": "Start"},
    {"from": "questions", "to": "results", "label": "Complete"}
  ]
}
```

### 3. Visualizza

```bash
cd .flowy && npm run dev
# Apri http://localhost:3000
```

### 4. Edita Visualmente

- Drag nodes per riposizionare
- Click per modificare testo
- Connetti/disconnetti edges
- Cambia stili

### 5. Claude Vede Modifiche

```
Ho modificato il flowchart:
- Spostato "Results" più a destra
- Aggiunto nodo "Error State"
- Cambiato label da "Start" a "Begin Quiz"

Aggiorna il plan di conseguenza.
```

## UI Mockups

### iPhone Frame

```json
{
  "type": "iphone-frame",
  "nodes": [
    {
      "type": "status-bar",
      "position": {"x": 0, "y": 0}
    },
    {
      "type": "component",
      "component": "button",
      "label": "Start Quiz",
      "position": {"x": 20, "y": 400},
      "style": {"fill": "#007AFF", "textColor": "white"}
    }
  ]
}
```

### Componenti UI

| Component | Props |
|-----------|-------|
| `button` | label, fill, textColor |
| `card` | title, content, shadow |
| `progress-bar` | value, max, color |
| `input` | placeholder, type |
| `list` | items[] |
| `tab-bar` | tabs[], active |

## Casi d'Uso

### 1. Navigation Flow

```
Prima di implementare routing:
- Mappa tutti gli screen
- Definisci transizioni
- Identifica stati edge-case
```

### 2. State Machine

```
Prima di implementare logica complessa:
- Visualizza tutti gli stati
- Mappa transizioni
- Trova edge cases
```

### 3. UI Mockups

```
Prima di scrivere React/SwiftUI:
- Layout screen principali
- Itera con stakeholder
- Definisci design system
```

## Integrazione con Skills

### /flowy-flowchart

```
Crea flowchart per [processo]:
- Process flows
- State machines
- Architecture diagrams
- Decision trees
```

### /flowy-ui-mockup

```
Crea mockup iPhone per [screen]:
- Device frames
- iOS-style components
- Safe area handling
```

## Best Practices

### 1. Visual Before Code

```
❌ Scrivi codice → Scopri problemi → Riscrivi

✅ Visualizza → Itera → Conferma → Implementa
```

### 2. Usa per Comunicazione

```
Invece di: "Il pulsante dovrebbe essere in basso a destra"
Mostra: Il flowchart con il pulsante posizionato
```

### 3. Versiona i Diagrammi

```
.flowy/
├── v1-initial-concept.json
├── v2-after-feedback.json
└── v3-final.json
```

## Setup Flowy

```bash
# Clona repo
git clone https://github.com/user/flowy .flowy

# Installa
cd .flowy && npm install

# Avvia dev server
npm run dev
```

## Vantaggi

| Testo | Flowy |
|-------|-------|
| "Il box dovrebbe essere più a sinistra" | Drag & drop |
| "Aggiungi una freccia da A a B" | Click & connect |
| 3 messaggi per allinearsi | 1 screenshot |
| Claude deve immaginare | Claude vede JSON |
