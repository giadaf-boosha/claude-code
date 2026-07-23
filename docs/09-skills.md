# 09 — Skills

> 📍 [README](../README.md) → [Estensibilita'](../README.md#estensibilita) → **09 Skills**
> 🔧 Operational · 🟡 Intermediate

Skills = Markdown con YAML frontmatter che estendono Claude. Compatibile con [Agent Skills open standard](https://agentskills.io). Custom commands e skills sono **fusi**: un file in `.claude/commands/deploy.md` e uno in `.claude/skills/deploy/SKILL.md` creano entrambi `/deploy`.

## Cosa e' concettualmente

> Le skill sono **memoria eseguibile**. Un file markdown contiene contestualmente: regole (Intent), tool autorizzati (Authority), workflow (Control flow), parametri (Argument). Quando l'utente dice `/skill-name`, il body markdown diventa singolo messaggio nella conversation. Sono il modo nativo per estendere l'harness senza scrivere codice.

**Modello mentale**: come le funzioni in una libreria Python: ne hai 1000 disponibili, ne carichi solo quelle che usi. Le skill markdown sono "funzioni" del tuo agent.

**Componente harness IMPACT**: trasversale (Tool + Memory + Intent + Control flow in un file solo).

**Per il deep-dive**: [00b — Context engineering § tecniche](./00b-context-engineering.md) per come le skill ottimizzano il context.

> Fonte: [`/en/skills`](https://code.claude.com/docs/en/skills).

---

## 9.1 Bundled skills (sempre disponibili)

| Skill | Funzione |
|---|---|
| `/simplify [focus]` | Alias di `/code-review --fix` (da v2.1.152; era rimosso in v2.1.146, reintrodotto come alias) |
| `/batch <instruction>` | Refactor large-scale: 5-30 unit, 1 worktree+PR per agente |
| `/debug [description]` | Debug logging mid-session |
| `/loop` | Re-run prompt (vedi [14](./14-loop-monitor.md)) |
| `/claude-api` | Reference API + tool migration |
| `/fewer-permission-prompts` | Scansiona transcript e crea allowlist read-only |
| `/dataviz` | Progettazione grafici, chart e dashboard — validatore tavolozza colori integrato e linee guida accessibilita' per output coerenti in light/dark mode (da v2.1.198) |
| `/verify` | Esercita end-to-end il flusso toccato da una modifica e osserva il comportamento reale, invece di fermarsi a test/typecheck |

<sub>Aggiornato 2026-07-02 via daily what's new. Fonte: [GitHub Releases v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198).</sub>

### Invocazione manuale per `/verify` e `/code-review` (da v2.1.215)

Fino a v2.1.214, Claude poteva decidere da solo di lanciare `/verify` o `/code-review` a fine task, senza che l'utente lo chiedesse esplicitamente. Da v2.1.215 questo comportamento e' disattivato: entrambe le skill vanno invocate esplicitamente (`/verify`, `/code-review [focus] [effort]`) quando si vuole che girino — Claude non le esegue piu' di propria iniziativa nel mezzo di un task. La modifica riduce le review "a sorpresa" non richieste e lascia all'utente il controllo su quando spendere il turno in verifica. Vedi anche [03 Slash commands](./03-slash-commands.md#31-tabella-completa) per la tabella comandi.

<sub>Aggiornato 2026-07-19 via daily what's new. Fonte: [GitHub Releases v2.1.215](https://github.com/anthropics/claude-code/releases/tag/v2.1.215).</sub>

---

### `context: fork` in background (da v2.1.218) {#context-fork-in-background-da-v2218}

Da v2.1.218 le skill con `context: fork` (vedi [9.3 Frontmatter completo](#93-frontmatter-completo)) girano in background di default invece che in-linea nella conversazione principale — stesso trattamento gia' riservato ai subagent spawnati da `/fork`. `/code-review` e' il primo caso pratico: la review a 3 agent paralleli non riempie piu' il thread principale mentre gira, e il risultato torna quando e' pronto. Per una singola skill si puo' tornare al comportamento in-linea con `background: false` nel frontmatter. Stessa release: `/deep-research` smette di auto-invocarsi e parte solo su richiesta esplicita. Vedi anche [08 Subagents § Cap subagent concorrenti](./08-subagents.md#cap-subagent-concorrenti-da-v2217).

<sub>Aggiornato 2026-07-23 via daily what's new. Fonte: [GitHub Releases v2.1.218](https://github.com/anthropics/claude-code/releases/tag/v2.1.218).</sub>

---

### Disabilita le bundled skills (v2.1.169)

Il setting `disableBundledSkills: true` (o env var `CLAUDE_CODE_DISABLE_BUNDLED_SKILLS=1`) nasconde le skill bundled e i comandi slash built-in dalla visibilita' del modello. Le skill custom rimangono attive; solo quelle pre-installate vengono rimosse dal context.

```json
{ "disableBundledSkills": true }
```

Utile in ambienti enterprise dove si vogliono esporre esclusivamente le skill custom del team, senza che il modello sia distratto da comandi built-in non pertinenti al workflow aziendale.

<sub>Aggiornato 2026-06-09 via daily what's new. Fonte: [GitHub Releases v2.1.169](https://github.com/anthropics/claude-code/releases/tag/v2.1.169).</sub>

---

## 9.2 Path / scope

| Location | Path | Applies to |
|---|---|---|
| Enterprise | Managed settings | Tutti utenti dell'org |
| User | `~/.claude/skills/<name>/SKILL.md` | Tutti progetti |
| Project | `.claude/skills/<name>/SKILL.md` | Progetto |
| Plugin | `<plugin>/skills/<name>/SKILL.md` | Plugin enabled |
| Plugin root | `<plugin>/SKILL.md` | Plugin enabled (da v2.1.142) |

Plugin skills usano namespace `plugin-name:skill-name`. Override: enterprise > personal > project.

Da v2.1.142, un plugin con `SKILL.md` nella directory root (senza sottocartella `skills/`) viene esposto direttamente come skill — utile per plugin mono-skill che non necessitano della struttura `skills/<name>/`.

Da v2.1.157, plugin completi (con `.claude-plugin/plugin.json`) posizionati in `.claude/skills/<nome>/` vengono caricati automaticamente senza richiedere `/plugin install` — vedi [11 — Plugins § auto-loading](./11-plugins-marketplace.md#plugin-locali-auto-loading-e-scaffolding-da-v21157).

---

## 9.3 Frontmatter completo

```yaml
---
name: my-skill                      # max 64 chars, [a-z0-9-]
description: When/what (key text)   # raccomandato; cap 1,536 char per entry (da v2.1.106)
when_to_use: trigger phrases        # opzionale, appended a description
argument-hint: "[issue-number]"     # autocomplete hint
arguments: [issue, branch]          # named positional args (string o list)
disable-model-invocation: false     # se true, solo user invoke
user-invocable: true                # se false, solo Claude invoke
allowed-tools: "Bash(git *) Read"   # pre-approved tools (list o string)
disallowed-tools: "Bash Write Edit" # tool rimossi dal modello durante l'esecuzione (da v2.1.152)
model: sonnet|opus|inherit          # override modello
effort: low|medium|high|xhigh|max   # override effort
context: fork                       # esegue in subagent
agent: Explore                      # tipo subagent quando context: fork
hooks: { PreToolUse: [...] }        # hook scoped al skill
paths: ["src/api/**/*.ts"]          # auto-attivazione path-specific {#paths}
shell: bash|powershell              # shell per !`...` blocks
---

# Skill content (Markdown)

Substitution: `$ARGUMENTS`, `$ARGUMENTS[0]` / `$0`, `$1`, `$name`.
Env: `${CLAUDE_SESSION_ID}`, `${CLAUDE_SKILL_DIR}`, `${CLAUDE_EFFORT}` (livello effort corrente: `low|medium|high|xhigh|max`).

<sub>Aggiornato 2026-05-27 via daily what's new. Fonte: [GitHub Releases v2.1.152](https://github.com/anthropics/claude-code/releases/tag/v2.1.152).</sub>

## Dynamic context injection
Inline: !`gh pr diff`
Multi-line block:
```!
node --version
npm --version
```
```

---

## 9.4 Lifecycle del content

- Quando invocato, `SKILL.md` rendered diventa **singolo messaggio** nella conversation
- Auto-compaction: re-attaches most recent invocation di ogni skill (5K token cap each, 25K total budget)
- Per skill di grandi dimensioni dopo molte invocations, considera re-invoke dopo `/compact`

---

## 9.5 Allowed-tools e Disallowed-tools

`allowed-tools` pre-approva tool senza prompt. **Non restringe** (per restringere usa permission deny rules).

```yaml
allowed-tools: "Bash(git *) Read(./.env) Edit"
```

`disallowed-tools` (da v2.1.152) rimuove tool specifici dal modello per tutta la durata dell'esecuzione della skill — il modello non li vede nemmeno come opzione. Utile per isolare skill read-only o skill di analisi che non devono modificare file:

```yaml
disallowed-tools: "Bash Write Edit NotebookEdit"
```

La combinazione tipica: `allowed-tools` per pre-approvare i tool necessari, `disallowed-tools` per escludere quelli non pertinenti.

Vedi sintassi permessi in [18 Settings & Auth](./18-settings-auth.md).

---

## 9.6 Auto-discovery e nested

Lavorando in `packages/frontend/`, anche `packages/frontend/.claude/skills/` viene caricato (monorepo support).

### Precedenza e clash resolution (da v2.1.178)

Quando esiste piu' di una directory `.claude/` nella gerarchia (tipico nei monorepo), valgono le seguenti regole:

- **Skill**: la skill nella directory `.claude/skills/` piu' vicina alla working directory ha la precedenza. In caso di clash di nome tra una skill di progetto e una annidata, quella annidata e' disponibile con il prefisso `<dir>:<name>` (es. `packages/frontend:deploy`) — entrambe restano attive, nessuna sovrascrive l'altra.
- **Agenti, workflow, output-style**: come per le skill, la definizione nella `.claude/` piu' vicina alla working directory vince. Quando salvi un workflow a livello progetto (`/workflow save`), Claude Code punta alla `.claude/workflows/` piu' vicina gia' esistente.

```
repo/
├── .claude/skills/deploy/SKILL.md        # "/deploy"
├── packages/
│   └── frontend/
│       └── .claude/skills/deploy/SKILL.md  # "packages/frontend:deploy"
└── ...
```

Il clash resolution tramite `<dir>:<name>` evita di dover rinominare skill in ogni pacchetto del monorepo.

### Live change detection
Aggiungere/modificare/rimuovere skill in `~/.claude/skills/`, project `.claude/skills/`, o `--add-dir` directory: **effetto immediato** senza restart (hot reload, da v2.1.0).

Da v2.1.152, il comando `/reload-skills` riscansiona esplicitamente tutte le directory skill nella sessione corrente — utile dopo aver installato un plugin via `claude plugin install` o copiato file SKILL.md in path non monitorati automaticamente. I `SessionStart` hook possono restituire `reloadSkills: true` per lo stesso effetto all'avvio.

<sub>Aggiornato 2026-06-16 via daily what's new. Fonte: [GitHub Releases v2.1.178](https://github.com/anthropics/claude-code/releases/tag/v2.1.178).</sub>

### Invocazione in cascata (stacked, da v2.1.199)

Da v2.1.199, e' possibile invocare piu' skill contemporaneamente in una singola riga inserendo piu' slash-command come prefissi:

    /skill-a /skill-b /skill-c do XYZ

Il runtime carica tutte le skill che compaiono come prefissi (fino a 5 in sequenza); il testo dopo l'ultima skill diventa il prompt. Claude riceve tutti i contesti caricati. Casi d'uso tipici:

    /deep-research /dataviz analizza le metriche di performance del Q2 e genera un grafico
    /code-review /claude-api controlla la compatibilita' dell'implementazione con l'API corrente

Non richiede modifiche al frontmatter ne' configurazione aggiuntiva.

<sub>Aggiornato 2026-07-03 via daily what's new. Fonte: [GitHub Releases v2.1.199](https://github.com/anthropics/claude-code/releases/tag/v2.1.199).</sub>

---

## 9.7 Subagent + skills

| Pattern | Effetto |
|---|---|
| Skill con `context: fork` + `agent: Explore` | Skill body diventa task del subagent |
| Subagent con `skills:` field | Preload skill content nel system prompt del subagent |

---

## 9.8 Disabilitare e restringere

```json
{
  "disableSkillShellExecution": true,         // utile in managed
  "permissions": {
    "deny": ["Skill", "Skill(my-skill)", "Skill(my-skill *)"]
  }
}
```

`disable-model-invocation: true` nel frontmatter → solo user puo' invocare.

---

## 9.9 Char budget

`SLASH_COMMAND_TOOL_CHAR_BUDGET` env var (default: 1% context window, fallback 8000 char).

---

## 9.10 Esempio reale: skill Excalidraw architecture diagrams

Articolo fonte: [Yee Fei (Medium, dic 2025)](https://medium.com/@ooi_yee_fei/custom-claude-code-skill-auto-generating-updating-architecture-diagrams-with-excalidraw-431022f75a13). Skill repo: https://github.com/ooiyeefei/ccc.

### Cosa fa
Insegna a Claude Code a generare/aggiornare diagrammi `.excalidraw` analizzando il codebase, con export PNG/SVG via Playwright. Frecce a 90 gradi (no curve), componenti color-coded per tipo (DB, API, storage), label dinamiche.

### Install
```bash
/plugin install ccc-skills@ccc
```

### Trigger naturali
- "Genera un diagramma di architettura per questo progetto"
- "Crea un diagramma excalidraw del sistema"
- "Esporta in PNG"

### Caratteristiche didattiche
- **Two-file pattern**: `README.md` come quick start utenti, `SKILL.md` come istruzioni dettagliate per Claude
- **Skill-only**: nessun MCP server necessario, solo Markdown
- Esempio Terraform GCP/AWS: testato su EKS+Karpenter+GPU+Rafay con 15+ risorse
- Funziona su qualsiasi stack (Node.js, Python, Java, Go, Terraform...)

> Esempio reale di skill Markdown-only che insegna un task complesso a Claude senza scrivere codice nuovo.

---

## 9.11 Esempio: skill `/release-notes` custom

`.claude/skills/release-notes/SKILL.md`:
```yaml
---
name: release-notes
description: Genera release notes da git log dell'ultimo tag
allowed-tools: Bash(git *) Read Write
argument-hint: "[from-tag] [to-tag]"
---

# Release notes generator

Genera release notes leggibili da:
- !`git describe --abbrev=0 --tags`
- !`git log $(git describe --abbrev=0 --tags)..HEAD --oneline`

Format:
## $0..$1

### Features
...
### Fixes
...

Salva in `RELEASE_NOTES.md`.
```

---

## 9.12 Annunci e changelog rilevanti

- **Hot reload Skills + custom agent support + invoke con `/`** (CC 2.1.0, dic 2025) — [@bcherny](https://x.com/bcherny/status/2009072293826453669)
- **`/simplify` e `/batch`** (mar 2026) — [@bcherny](https://x.com/bcherny/status/2027534984534544489)
- **Description cap 250 → 1,536 char** (v2.1.106, 13 apr 2026)
- **Hooks in skill frontmatter** (CC 2.1.0)
- **Plugin auto-install dependencies** (v2.1.117, 22 apr 2026)
- **Plugin SKILL.md root come skill** (v2.1.142, 14 mag 2026): plugin con `SKILL.md` nella directory root esposto automaticamente come skill, senza richiedere la struttura `skills/<name>/`

<sub>Aggiornato 2026-05-15 via daily what's new. Fonte: [GitHub Releases v2.1.142](https://github.com/anthropics/claude-code/releases/tag/v2.1.142).</sub>

---

## 9.13 Marketplace skill

Vedi [11 Plugins & Marketplace](./11-plugins-marketplace.md) per installare skill da marketplace ufficiale e community.

Marketplace community popolari:
- `daymade/claude-code-skills`
- `alirezarezvani/claude-skills` (232+ skill)
- `dashed/claude-marketplace` (locale)

---

← [08 Subagents](./08-subagents.md) · Successivo → [10 MCP](./10-mcp.md)
