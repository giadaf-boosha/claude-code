# 06 — CLAUDE.md, rules, auto-memory

Claude Code ha **due sistemi di memoria** complementari: CLAUDE.md (scritto da te) e auto-memory (scritto da Claude). Questo documento copre entrambi + il sistema rules path-specific.

---

## 6.1 Confronto

|  | CLAUDE.md | Auto-memory |
|---|---|---|
| Chi scrive | Tu (a mano o via `/init`) | Claude (al volo durante sessioni) |
| Contenuto | Instructions, rules, naming, architecture | Learnings, build commands, debugging insights |
| Scope | Project / user / org | Per working tree (git-derived) |
| Loaded | Ogni sessione | First 200 lines / 25KB di MEMORY.md |
| Per | Coding standards, architecture | Pattern ricorrenti, comandi del progetto |

---

## 6.2 CLAUDE.md: locations e precedence

Tutti i file scoperti vengono **concatenati** (non override). Precedenza: piu' locale prima.

| Scope | Path | Shared with |
|---|---|---|
| Managed policy | `/Library/Application Support/ClaudeCode/CLAUDE.md` (macOS), `/etc/claude-code/CLAUDE.md` (Linux/WSL), `C:\Program Files\ClaudeCode\CLAUDE.md` (Windows) | Tutti gli utenti dell'org |
| Project (shared) | `./CLAUDE.md` o `./.claude/CLAUDE.md` | Team via VCS |
| User (globale) | `~/.claude/CLAUDE.md` | Te, ovunque |
| Local (privato) | `./CLAUDE.local.md` (gitignore) | Te, repo |

### Auto-discovery sub-tree
Claude scopre anche CLAUDE.md in subdirectory quando legge file in quelle dir (monorepo support). Skip via:
```json
{ "claudeMdExcludes": ["**/monorepo/CLAUDE.md"] }
```

### `/init`
Genera CLAUDE.md scansionando il progetto. Con `CLAUDE_CODE_NEW_INIT=1` flow interattivo multi-fase.

---

## 6.3 Imports

```markdown
@README.md
@docs/git-instructions.md
@~/.claude/my-project-instructions.md
```

- Max 5 hops
- Approval dialog la prima volta che un import viene scoperto
- Block-level `<!-- HTML comments -->` strippati prima dell'injection

### AGENTS.md interop
Claude Code legge **CLAUDE.md**, non AGENTS.md. Workaround:
```markdown
@AGENTS.md

## Claude Code
Use plan mode for changes under `src/billing/`.
```

### Additional dirs CLAUDE.md
```bash
CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1
claude --add-dir /Users/me/shared-rules
```

---

## 6.4 `.claude/rules/`: regole path-specific

File `.md` con frontmatter `paths:` → rule attivate solo quando file matchanti vengono toccati.

```yaml
---
paths:
  - "src/api/**/*.ts"
  - "tests/**/*.test.ts"
---
# API rules
- Validate input
- Use standard error format
```

- Senza `paths:`: load unconditional
- Symlinks supportati per share cross-project
- User-level: `~/.claude/rules/`

Cosa caricare e' deciso dal motore di context engineering, non da te (vedi anche [Skills paths frontmatter](./09-skills.md#paths)).

---

## 6.5 Auto-memory

> Richiede v2.1.59+. Default: ON.

### Cosa fa
Claude scrive memorie persistenti (file markdown) in `~/.claude/projects/<project-key>/memory/`. Il file index e' `MEMORY.md`. Le prime 200 righe (cap 25KB) sono caricate **automaticamente** ogni sessione di quel progetto. Topic file (`debugging.md`, `architecture.md`) sono lazy-loaded on demand.

### Locations
```
~/.claude/projects/<sanitized-cwd>/memory/
├── MEMORY.md           # entry index (auto-loaded)
├── architecture.md     # topic file (lazy)
├── debugging.md        # ...
└── ...
```

Il `<project-key>` e' derivato dal git remote (worktrees condividono memory).

### Toggle
- CLI: `/memory`
- Settings:
  ```json
  {
    "autoMemoryEnabled": true,
    "autoMemoryDirectory": "/custom/path"   // policy/local/user, NON project
  }
  ```
- Env: `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`

### Subagents auto-memory
Subagents possono mantenere memoria propria — vedi [`/en/sub-agents#enable-persistent-memory`](https://code.claude.com/docs/en/sub-agents#enable-persistent-memory).

### Cosa va in auto-memory
- Build / test / deploy commands del progetto
- Debugging insights ricorrenti
- Pattern del codebase (es. "useStore() returns Pinia store, not Vuex")
- Convenzioni team viste in PR

### Cosa NON va in auto-memory
- Code patterns derivabili leggendo i file
- Git history (c'e' git log)
- Decisioni che cambiano frequentemente (mettile in CLAUDE.md o ADR)
- Roba sensibile (credentials, business secrets)

---

## 6.6 Compaction & memory

- **Project-root CLAUDE.md** sopravvive `/compact` (re-iniettato).
- **Nested CLAUDE.md** ricaricano on next file read in subdir.
- **PreCompact hook** (da v2.1.106) puo' bloccare compaction o aggiungere context.

---

## 6.7 Tips operative

### Dimensione CLAUDE.md
Tienilo **sotto 200 righe**. Se cresce: spezza in `@import` per dominio (`@docs/api-rules.md`, `@docs/security.md`).

### Ordine consigliato
1. Identita' / lingua
2. Anti-hallucination rules
3. Anti-context-loss
4. Anti-over-engineering
5. Anti-inconsistency
6. Anti-placeholder
7. Anti-sycophancy
8. Security defaults
9. Testing quality
10. Workflow operativo

(Esempio: vedi `~/.claude/CLAUDE.md` "BP Coding System" 152 regole numerate.)

### Auto-memory + memorie esplicite
Se chiedi a Claude "ricordati X", lui scrive auto-memory. Se vuoi che lo metta in CLAUDE.md project-shared, dillo esplicitamente.

### `/init` per progetti esistenti
- `CLAUDE_CODE_NEW_INIT=1 claude /init` → flow multi-fase: scopre stack, propone sezioni, ti chiede preferenze.

---

## 6.8 Fonti

- Docs ufficiali: [`/en/memory`](https://code.claude.com/docs/en/memory)
- Auto-memory section: [`/en/sub-agents#enable-persistent-memory`](https://code.claude.com/docs/en/sub-agents#enable-persistent-memory)

---

← [05 Fast mode + 1M context](./05-fast-mode-1m-context.md) · Successivo → [07 Hooks](./07-hooks.md)
