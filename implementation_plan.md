# implementation_plan.md — Roadmap repo `claude-code`

> Ultimo aggiornamento: **28 aprile 2026**.

---

## Stato corrente

| Fase | Stato | Commit |
|---|---|---|
| **F1** Restructure (20 doc + 5 post X) | ✅ done | `0ad7a2f` (27 apr 2026) |
| **F2** Enrichment (changelog feb 2025+, target user, field guide, +76 post) | ✅ done | `65bf32a` (27 apr 2026) |
| **F3** Conceptual layer (8 capitoli foundation + intro + nav) | ✅ done | (28 apr 2026) |
| **F4** Archive integration sistematica | ✅ done | (28 apr 2026) |
| **F5-light** Quick Start + persona templates | ✅ done | (28 apr 2026) |
| **F5-full** Open governance (CONTRIBUTING.md, license, issue templates) | ⏳ later | — |

---

## Fase 3 — Conceptual layer (in progress)

### Obiettivo
Trasformare la repo da **65% operational / 15% conceptual** a un bilanciamento ~50/50 con sistema di navigazione coerente.

### Sotto-task

#### 3.1 — Ricerca foundation (4 dossier paralleli)
- [x] `dossier-conceptual-harness.md` — IMPACT framework, 8 componenti, case studies
- [x] `dossier-conceptual-react.md` — paper ReAct (Yao 2022), agent loop, applicazioni CC
- [x] `dossier-conceptual-context.md` — context engineering, Hashline +919%, tecniche
- [x] `dossier-navigation-design.md` — breadcrumb, glossario, mappe, mermaid

> Tutti e 4 generati in parallelo da subagent. Cancellati al termine della fase 3.

#### 3.2 — 8 nuovi capitoli concettuali (foundation)

| # | File | Status |
|---|---|---|
| 1 | `docs/00-harness-overview.md` | ✅ done |
| 2 | `docs/00b-context-engineering.md` | ✅ done |
| 3 | `docs/04b-authority-model.md` | ✅ done |
| 4 | `docs/06b-memory-architecture.md` | ✅ done |
| 5 | `docs/14b-agent-loop-react.md` | ✅ done |
| 6 | `docs/15b-planning-strategy.md` | ✅ done |
| 7 | `docs/22-compound-engineering.md` | ✅ done |
| 8 | `docs/23-glossario.md` | ✅ done |

#### 3.3 — Intro concettuale ai 21 doc esistenti

A ogni `docs/01-*.md` → `docs/21-*.md` aggiungere subito dopo titolo + breadcrumb un blocco standardizzato:

```markdown
## Cosa e' concettualmente

> [TL;DR di 1-2 frasi che inquadra la feature]

**Modello mentale**: [analogia]

**Componente harness IMPACT**: [Intent | Memory | Planning | Authority | Control flow | Tool layer]

**Per il deep-dive**: [link al capitolo concettuale corrispondente]
```

Status:
- [x] 01-snapshot.md
- [x] 02-cli-installazione.md
- [x] 03-slash-commands.md
- [x] 04-modalita-permessi.md
- [x] 05-fast-mode-1m-context.md
- [x] 06-claude-md-memory.md
- [x] 07-hooks.md
- [x] 08-subagents.md
- [x] 09-skills.md
- [x] 10-mcp.md
- [x] 11-plugins-marketplace.md
- [x] 12-agent-teams.md
- [x] 13-routines-cloud.md
- [x] 14-loop-monitor.md
- [x] 15-ultraplan-ultrareview.md
- [x] 16-headless-agent-sdk.md
- [x] 17-ide-surface.md
- [x] 18-settings-auth.md
- [x] 19-changelog.md
- [x] 20-tips-best-practices.md
- [x] 21-guide-target-user.md

#### 3.4 — Sistema di navigazione

- [ ] **Breadcrumb header** in ognuno dei 29 doc: `> 📍 [README](../README.md) → [Sezione](#anchor) → **Doc corrente**`
- [ ] **`README-NAVIGATION.md`** nuovo file root con:
  - 3 quick start path (Beginner / Dev intermedio / Harness engineer)
  - Mermaid mappa concetti foundation → doc operational
  - Indice per concetto IMPACT
  - Indice per persona
  - Cross-link a glossario
- [ ] **README.md** aggiornato:
  - Nuova sezione "Concetti foundation" prima di "Field Guide"
  - Diagramma mermaid IMPACT framework
  - Indice esteso a 29 doc con badge `📘 Concettuale` / `🔧 Operational`
  - Pointer a `README-NAVIGATION.md` e `docs/23-glossario.md`

#### 3.5 — Diagrammi mermaid

| Diagramma | Tipo | File destinazione |
|---|---|---|
| IMPACT framework | `flowchart TD` | `docs/00`, `README.md` |
| Agent loop ReAct | `sequenceDiagram` | `docs/14b`, `README-NAVIGATION` |
| Memory hierarchy | `graph LR` | `docs/06b` |
| Authority decision tree | `flowchart TB` | `docs/04b` |
| Compound engineering patterns | `flowchart LR` | `docs/22` |
| Harness components → CC features | `flowchart LR` | `docs/00`, `README-NAVIGATION` |

#### 3.6 — Aggiornamento file di tracking

- [ ] Aggiornare `spec.md` (gia' creato in F3.1)
- [ ] Aggiornare `implementation_plan.md` (questo file): marcare task done
- [ ] Aggiornare `README.md` Cronologia revisioni

#### 3.7 — Verifica end-to-end

```bash
# Numerosita'
ls docs/*.md | wc -l                                            # atteso: 29

# Intro concettuale
grep -l "Cosa e' concettualmente" docs/*.md | wc -l             # atteso: 21+

# Mermaid presenti
grep -l "\`\`\`mermaid" docs/*.md README*.md | wc -l            # atteso: 6+

# Breadcrumb
grep -c "📍 \[README\]" docs/*.md                              # atteso: 1 per file

# Glossario
grep -c "^### " docs/23-glossario.md                            # atteso: 25+

# Link rotti
for f in docs/*.md; do
  grep -oE '\[.*\]\(\./[^)]+\)' "$f" | while read link; do
    target=$(echo "$link" | sed -E 's|.*\(\./([^)]+)\).*|\1|')
    [ -f "docs/$target" ] || echo "BROKEN in $f: $target"
  done
done
```

#### 3.8 — Commit + push

```bash
git add -A
git commit -m "feat(conceptual): F3 layer foundation + nav system + mermaid"
git push origin main
```

#### 3.9 — Cleanup

- [ ] Shutdown 4 teammates ricerca
- [ ] TeamDelete del team `claude-code-conceptual` (se creato)
- [ ] Eliminare `_research/dossier-conceptual-*.md` (mantenere solo i tre dossier originali per traccia)
  - Oppure mantenerli in `_research/` per riferimento storico (decisione finale: mantenere)

---

## Fase 4 — Diagrams + Quick Start paths (next)

### Obiettivo
Aggiungere visualizzazioni avanzate e quick start onboarding per profilo.

### Sotto-task

- [ ] Mappa interattiva concetti (mermaid `mindmap`)
- [ ] Quick Start "60 minutes" per beginner (script step-by-step)
- [ ] Quick Start "advanced" per harness engineer
- [ ] Diagrammi multi-livello (overview + drill-down)
- [ ] Esempio di `.claude/settings.json` di partenza per ogni persona

---

## Fase 5 — Open governance (later)

- [ ] `CONTRIBUTING.md` (linee guida contributi)
- [ ] `LICENSE` (MIT o CC-BY-SA)
- [ ] Issue templates (bug report, feature request, doc fix)
- [ ] PR template
- [ ] GitHub Actions per link checker automatico
- [ ] Pubblicazione su https://claude-code-it.boosha.it (sito statico generato da repo)

---

## Cronologia revisioni implementation_plan.md

| Data | Modifica |
|---|---|
| 27 apr 2026 | F1 + F2 completate |
| 28 apr 2026 | F3 avviata, scritto plan iniziale |
| 28 apr 2026 | F3 completata: 8 capitoli concettuali + intro 21 doc + nav + mermaid (commit `3ec4c56`) |
| 28 apr 2026 | F4 + F5-light completate: archive integration sistematica (Kora case + vibe-to-agentic + worktree workflow + Conductor + Ralph + Sonnet 4.5 callout + cheat sheet tips), QUICKSTART.md, 8 examples/personas/ |
