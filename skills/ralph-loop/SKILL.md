---
name: ralph-loop
description: |
  Ralph Loop - Autonomous coding loop per Claude Code. Usa per:
  eseguire task complessi in modo autonomo mentre dormi, implementare feature
  complete basate su PRD, eseguire iterazioni multiple con fresh context.
  Basato sul pattern di Geoffrey Huntley.
user-invocable: true
disable-model-invocation: false
allowed-tools: Bash, Read, Write, Edit, Grep, Glob, Task
---

# Ralph Loop - Autonomous Coding Agent

Ralph è un loop autonomo che esegue Claude Code ripetutamente fino al completamento di tutti i task nel PRD.

## Concetto Chiave

```
while :; do cat PROMPT.md | claude ; done
```

Ogni iterazione:
1. Fresh context window
2. Legge prd.json per i task
3. Implementa UN task
4. Commit se i test passano
5. Aggiorna prd.json
6. Logga learnings
7. Ripete fino a `passes: true` per tutti

## File Structure

```
scripts/ralph/
├── ralph.sh          # Il loop bash
├── prompt.md         # Istruzioni per ogni iterazione
├── prd.json          # Lista user stories con status
└── progress.txt      # Learnings tra iterazioni
```

## ralph.sh (Template)

```bash
#!/bin/bash
set -e

MAX_ITERATIONS=${1:-10}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Starting Ralph"

for i in $(seq 1 $MAX_ITERATIONS); do
  echo "═══ Iteration $i ═══"

  OUTPUT=$(cat "$SCRIPT_DIR/prompt.md" \
    | claude --dangerously-skip-permissions 2>&1 \
    | tee /dev/stderr) || true

  if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
    echo "✅ Done!"
    exit 0
  fi

  sleep 2
done

echo "⚠️ Max iterations reached"
exit 1
```

## prompt.md (Template)

```markdown
# Ralph Agent Instructions

## Your Task

1. Read `scripts/ralph/prd.json`
2. Read `scripts/ralph/progress.txt` (check Codebase Patterns first)
3. Check you're on the correct branch
4. Pick highest priority story where `passes: false`
5. Implement that ONE story
6. Run typecheck and tests
7. Update AGENTS.md files with learnings
8. Commit: `feat: [ID] - [Title]`
9. Update prd.json: `passes: true`
10. Append learnings to progress.txt

## Progress Format

APPEND to progress.txt:

## [Date] - [Story ID]
- What was implemented
- Files changed
- **Learnings:**
  - Patterns discovered
  - Gotchas encountered
---

## Stop Condition

If ALL stories pass, reply:
<promise>COMPLETE</promise>

Otherwise end normally.
```

## prd.json (Formato)

```json
{
  "branchName": "ralph/feature-name",
  "userStories": [
    {
      "id": "US-001",
      "title": "Add login form",
      "acceptanceCriteria": [
        "Email/password fields exist",
        "Validates email format",
        "typecheck passes",
        "tests pass"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

## Regole Critiche

### 1. User Stories PICCOLE

Ogni story deve completarsi in UN context window:

**✅ Giuste**:
- "Add a database column and migration"
- "Add a UI component to existing page"
- "Update server action with new logic"

**❌ Troppo grandi** (da splittare):
- "Build entire auth system"
- "Add authentication"
- "Refactor the API"

### 2. Acceptance Criteria VERIFICABILI

```
❌ Vago: "Users can log in"
✅ Specifico:
- Email/password fields exist
- Validates email format
- Shows error on failure
- typecheck passes
- Verify at localhost:3000/login
```

### 3. Feedback Loops OBBLIGATORI

Ralph funziona SOLO con feedback automatici:
- `npm run typecheck` - cattura errori tipo
- `npm test` - verifica comportamento
- CI deve restare verde

### 4. AGENTS.md Updates

Dopo ogni iterazione, aggiorna AGENTS.md con:
- Pattern scoperti
- Gotcha da evitare
- Convenzioni del codebase

## Workflow Completo

### 1. Crea PRD

```
Load the prd skill and create a PRD for [feature description]
```

### 2. Converti a prd.json

```
Load the ralph skill and convert tasks/prd-[feature].md to prd.json
```

### 3. Esegui Ralph

```bash
./scripts/ralph/ralph.sh 25
```

### 4. Monitora

```bash
# Stato stories
cat prd.json | jq '.userStories[] | {id, passes}'

# Learnings
cat progress.txt

# Commit history
git log --oneline -10
```

## Costi Tipici

- 1 iterazione: ~$3 (Opus 4.5)
- Feature completa (10 iter): ~$30
- Compensa facilmente tempo umano risparmiato

## Best Practice

1. **50/50 Rule**: 50% fixing, 50% documenting learnings
2. **Browser Testing**: Per UI, usa dev-browser skill per verificare
3. **Idempotent Migrations**: Usa `IF NOT EXISTS`
4. **No Interactive**: Mai `-i` flag (git rebase -i, etc.)
5. **Commit spesso**: Permette rollback granulare
