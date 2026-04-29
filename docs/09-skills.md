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
| `/simplify [focus]` | 3 review agent paralleli + apply fix |
| `/batch <instruction>` | Refactor large-scale: 5-30 unit, 1 worktree+PR per agente |
| `/debug [description]` | Debug logging mid-session |
| `/loop` | Re-run prompt (vedi [14](./14-loop-monitor.md)) |
| `/claude-api` | Reference API + tool migration |
| `/fewer-permission-prompts` | Scansiona transcript e crea allowlist read-only |

---

## 9.2 Path / scope

| Location | Path | Applies to |
|---|---|---|
| Enterprise | Managed settings | Tutti utenti dell'org |
| User | `~/.claude/skills/<name>/SKILL.md` | Tutti progetti |
| Project | `.claude/skills/<name>/SKILL.md` | Progetto |
| Plugin | `<plugin>/skills/<name>/SKILL.md` | Plugin enabled |

Plugin skills usano namespace `plugin-name:skill-name`. Override: enterprise > personal > project.

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

<sub>Aggiornato 2026-04-29 via daily what's new. Fonte: [changelog](https://code.claude.com/docs/en/changelog).</sub>

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

## 9.5 Allowed-tools

Pre-approva tool senza prompt. **Non restringe** (per restringere usa permission deny rules).

```yaml
allowed-tools: "Bash(git *) Read(./.env) Edit"
```

Vedi sintassi permessi in [18 Settings & Auth](./18-settings-auth.md).

---

## 9.6 Auto-discovery e nested

Lavorando in `packages/frontend/`, anche `packages/frontend/.claude/skills/` viene caricato (monorepo support).

### Live change detection
Aggiungere/modificare/rimuovere skill in `~/.claude/skills/`, project `.claude/skills/`, o `--add-dir` directory: **effetto immediato** senza restart (hot reload, da v2.1.0).

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

---

## 9.13 Marketplace skill

Vedi [11 Plugins & Marketplace](./11-plugins-marketplace.md) per installare skill da marketplace ufficiale e community.

Marketplace community popolari:
- `daymade/claude-code-skills`
- `alirezarezvani/claude-skills` (232+ skill)
- `dashed/claude-marketplace` (locale)

---

← [08 Subagents](./08-subagents.md) · Successivo → [10 MCP](./10-mcp.md)
