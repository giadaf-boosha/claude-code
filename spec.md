# spec.md — Specifica funzionale repo `claude-code`

> Ultimo aggiornamento: **28 aprile 2026**.
> Owner: [Boosha AI](https://boosha.it) · Maintainer: Giada Franceschini.

---

## 1. Scopo

`https://github.com/giadaf-boosha/claude-code` e' una **guida ragionata e didattica** su Claude Code (CLI / IDE / Web / Desktop / SDK) curata in italiano da Boosha AI. Si distingue da:

- **docs.claude.com** (riferimento ufficiale Anthropic): qui c'e' la sintesi narrativa con citazioni alle fonti, non la verbosita' della doc completa.
- **post X singoli** (frammenti): qui c'e' il filo conduttore tra concetti foundation, feature, workflow e tip operative.
- **tutorial generici** (date 2025): qui i contenuti sono aggiornati ad **aprile 2026** (CLI v2.1.119+, Opus 4.7).

Pubblico target:
- Developer professionali (Solo, Senior backend, Frontend, DevOps, Tech lead, AI/ML, Legacy stack maintainer)
- Beginner / non-coder che vogliono produrre con Claude Code
- Formatori / educator che usano la repo come traccia per workshop

---

## 2. Cosa la guida copre

La guida e' organizzata su **3 livelli stratificati**:

### Livello 1 — Concetti foundation (`docs/00-*` + `docs/0Nb-*` + `docs/22-*`)
Modelli mentali e teoria pre-operativa:
- Agent harness engineering (IMPACT framework)
- Context engineering
- ReAct pattern e agent loop
- Authority model
- Memory architecture
- Planning strategy
- Compound engineering

Pubblico: chi vuole capire **perche'** Claude Code esiste e quale paradigma incarna.

### Livello 2 — Reference operational (`docs/01-21`)
Reference completa feature-per-feature:
- Snapshot prodotto, CLI, slash commands
- Modalita' permessi, fast mode, CLAUDE.md
- Hooks, subagents, skills, MCP, plugins, agent teams
- Routines, /loop + Monitor, Ultraplan/Ultrareview
- Headless + Agent SDK, IDE + surface, settings + auth
- Changelog, tips, target user

Pubblico: chi cerca **come** fare X.

### Livello 3 — Wayfinding (`README.md`, `README-NAVIGATION.md`, `docs/23-glossario.md`)
Sistema di navigazione:
- Field guide stile Ruben Hassid (32 voci numerate per categoria)
- Quick start path per profilo (beginner, dev intermedio, harness engineer)
- Glossario 30+ termini con cross-link
- Indice per concetto IMPACT
- Indice per persona

Pubblico: chi naviga la repo per la prima volta o cerca qualcosa di specifico.

---

## 3. Cosa la guida NON copre

- **Documentazione di feature non rilasciate pubblicamente** (es. roadmap interna Anthropic). La guida e' aggiornata al 27 aprile 2026 con CLI v2.1.119+.
- **Tutorial introduttivi su LLM** (cos'e' un transformer, come funzionano gli embedding). Diamo per scontato che il lettore sappia che Claude e' un LLM.
- **Confronto dettagliato con altri agentic CLI** (Codex, Cursor, Aider). Solo cenni quando rilevanti.
- **Localizzazioni** (la guida e' in italiano; nomi tecnici in inglese).
- **Materiali audio/video** (solo testo + diagrammi mermaid + ASCII).

---

## 4. Governance e aggiornamento

### Frequenza aggiornamento target
- **Settimanale per il changelog** (`docs/19-changelog.md`): ogni release CC pubblicata su `code.claude.com/docs/en/changelog`
- **Mensile per i contenuti** (`docs/01-21`): rivedere quando emergono feature nuove rilevanti per il target audience
- **On-demand per i concetti** (`docs/00-*`, `docs/22-*`): aggiornare quando emergono nuovi paradigmi (es. nuovo paper ReAct successor, nuovo case study harness)

### Pattern di citazione
- Ogni affermazione fattuale ha un link a fonte primaria: docs ufficiale (`code.claude.com/docs/en/*`), post X (`x.com/*`), blog (`anthropic.com/news/*`), paper (`arxiv.org/*`)
- Niente claim senza fonte ("perche' lo dice Boris" non basta — link al post)
- Citazioni testuali tra virgolette quando integralmente trascritte; parafrasi italiana con `[parafrasi]` quando lunghe

### Anti-pattern
- Speculazione su feature non documentate (annotare "non documentato pubblicamente")
- Tutorial scopiazzati da altri blog (la guida deve essere narrativa originale + citazione)
- Tono "guru" / "10x developer" (mantenere registro tecnico neutro)

---

## 5. Struttura delle cartelle

```
claude-code/
├── README.md                    Master index + Field Guide stile Ruben Hassid
├── README-NAVIGATION.md         Wayfinding system (quick start, mappe, indici)
├── spec.md                      Questo file
├── implementation_plan.md       Roadmap implementativa
├── docs/
│   ├── 00-harness-overview.md             Foundation: agent harness
│   ├── 00b-context-engineering.md         Foundation: context engineering
│   ├── 01-snapshot.md                     Operational: snapshot prodotto
│   ├── 02-cli-installazione.md            Operational: CLI
│   ├── 03-slash-commands.md               Operational: slash commands
│   ├── 04-modalita-permessi.md            Operational: permissions
│   ├── 04b-authority-model.md             Foundation: authority IMPACT
│   ├── 05-fast-mode-1m-context.md         Operational: fast mode + context
│   ├── 06-claude-md-memory.md             Operational: CLAUDE.md + memory
│   ├── 06b-memory-architecture.md         Foundation: memory IMPACT
│   ├── 07-hooks.md                        Operational: hooks
│   ├── 08-subagents.md                    Operational: subagents
│   ├── 09-skills.md                       Operational: skills
│   ├── 10-mcp.md                          Operational: MCP
│   ├── 11-plugins-marketplace.md          Operational: plugins
│   ├── 12-agent-teams.md                  Operational: agent teams
│   ├── 13-routines-cloud.md               Operational: routines
│   ├── 14-loop-monitor.md                 Operational: /loop + Monitor
│   ├── 14b-agent-loop-react.md            Foundation: ReAct + agent loop
│   ├── 15-ultraplan-ultrareview.md        Operational: ultraplan/ultrareview
│   ├── 15b-planning-strategy.md           Foundation: planning IMPACT
│   ├── 16-headless-agent-sdk.md           Operational: headless + SDK
│   ├── 17-ide-surface.md                  Operational: IDE/surface
│   ├── 18-settings-auth.md                Operational: settings + auth
│   ├── 19-changelog.md                    Reference: changelog feb 2025+
│   ├── 20-tips-best-practices.md          Reference: tips dal team
│   ├── 21-guide-target-user.md            Workflow: 8 personas
│   ├── 22-compound-engineering.md         Foundation: compound engineering
│   └── 23-glossario.md                    Reference: glossario 30+ termini
├── posts/                       Post X di riferimento (Boris, Cat, Noah, Thariq, ...)
├── _research/                   Dossier di ricerca (~10 file)
├── archive/                     Snapshot pre-feb 2026
└── skills/                      76 skill curate (raccolta originale)
```

---

## 6. Convenzioni redazionali

| Aspetto | Convenzione |
|---|---|
| **Lingua** | Italiano per testo, inglese per nomi tecnici (CLI, slash commands, skill, MCP) |
| **Accenti** | "perche' / e' / piu' / cosi'" con apostrofo, NON `é/è` o `ì` (compatibilita' con hook) |
| **Citazioni** | Tra virgolette quando testuali; con `[parafrasi]` quando lunghe |
| **Link interni** | `[label](./NN-file.md)` o `[label](#anchor)` |
| **Link esterni** | `https://...` completo, mai shortener |
| **Code block** | Triple backtick con language hint (`bash`, `json`, `yaml`, `python`, `typescript`) |
| **Tabelle** | Markdown native, allineamento sinistra di default |
| **Diagrammi** | Mermaid (`flowchart TD`, `sequenceDiagram`, `graph LR`) o ASCII art |
| **Numerazione doc** | Insert con suffissi (`00`, `00b`, `04b`, ...) per non rompere link |
| **Footer** | `← [N-1] · Successivo → [N+1]` su ogni doc |
| **Header breadcrumb** | `> 📍 [README](../README.md) → [Sezione](../README.md#anchor) → **Doc corrente**` |
| **Badge** | `📘 Concettuale`, `🔧 Operational`, `🚀 Workflow`, `📚 Reference` |
| **Verbi** | Infiniti per istruzioni ("Configurare", "Lanciare", "Verificare") |

---

## 7. Verifica qualita'

Checklist da eseguire prima di un release:

- [ ] Tutti i link interni puntano a file esistenti (`grep -E '\[.*\]\(\.[^)]+\)' docs/*.md` + verifica path)
- [ ] Tutti i link esterni rispondono HTTP 200 o sono annotati come "non accessibile"
- [ ] Glossario: ogni termine cross-linkato compare in almeno 1 doc
- [ ] Ogni doc operational ha intro `Cosa e' concettualmente`
- [ ] Ogni doc ha breadcrumb header
- [ ] Ogni doc ha footer `← Successivo →`
- [ ] README ha mermaid IMPACT framework renderizzato su GitHub
- [ ] Versione CLI di riferimento aggiornata in `01-snapshot.md` e `README.md`
- [ ] Nessuna affermazione fattuale senza fonte
- [ ] Date in formato ISO (`YYYY-MM-DD`) o italiano (`27 aprile 2026`), mai US (`04/27/2026`)

---

## 8. Riferimenti

- Repo GitHub: https://github.com/giadaf-boosha/claude-code
- Boosha AI: https://boosha.it
- Docs ufficiali Claude Code: https://code.claude.com/docs/
- Changelog ufficiale: https://code.claude.com/docs/en/changelog

Per la roadmap di implementazione vedere [`implementation_plan.md`](./implementation_plan.md).
