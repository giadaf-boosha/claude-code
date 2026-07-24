# 11 — Plugins & Marketplace

> 📍 [README](../README.md) → [Estensibilita'](../README.md#estensibilita) → **11 Plugins & Marketplace**
> 🔧 Operational · 🟡 Intermediate

I plugin sono pacchetti che bundlano Skills, Subagents, Hooks, MCP server, LSP server, monitor di background e setting. Installabili da marketplace ufficiali, community o custom.

## Cosa e' concettualmente

> Un plugin e' un **bundle di harness components**: skill + agent + hook + MCP server + LSP + monitor + settings, distribuito come unita'. E' il packaging format dell'ecosistema. Quando installi un plugin, stai abilitando un set coordinato di capabilities (tool + memoria + guardrail) tutti insieme.

**Modello mentale**: come un'app del marketplace iOS — bundla codice, asset, permessi, integrazioni in un'unita' installabile.

**Componente harness IMPACT**: trasversale (un plugin puo' toccare tutti i pilastri).

**Per il deep-dive**: [09 — Skills](./09-skills.md), [10 — MCP](./10-mcp.md), [07 — Hooks](./07-hooks.md) per i singoli component types.

> Fonti: [`/en/plugins`](https://code.claude.com/docs/en/plugins), [`/en/discover-plugins`](https://code.claude.com/docs/en/discover-plugins), [`/en/plugin-marketplaces`](https://code.claude.com/docs/en/plugin-marketplaces).

---

## 11.1 Struttura di un plugin

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json     # manifest (name, description, version, author)
├── skills/<name>/SKILL.md
├── commands/*.md       # legacy, ora skills/
├── agents/<name>.md
├── hooks/hooks.json
├── .mcp.json           # MCP servers
├── .lsp.json           # LSP servers (code intelligence)
├── monitors/monitors.json   # background monitors (da v2.1.106)
├── bin/                # executable aggiunti a $PATH (da v2.1.94)
└── settings.json       # default settings (agent, subagentStatusLine)
```

### Manifest

```json
{
  "name": "my-plugin",
  "description": "Short description",
  "version": "1.0.0",
  "author": { "name": "Your name" },
  "homepage": "https://...",
  "repository": "https://github.com/...",
  "license": "MIT"
}
```

Se `version` e' omesso, viene usato il commit SHA (ogni commit = nuova versione). Specifica `version` per controllo update.

---

## 11.2 Marketplace ufficiale

- **`claude-plugins-official`** — auto-disponibile, ~101 plugin (mar 2026)
- Browse: https://claude.com/plugins
- Submit: https://claude.ai/settings/plugins/submit

### Categorie

1. **Code intelligence (LSP)**: `clangd-lsp`, `csharp-lsp`, `gopls-lsp`, `jdtls-lsp`, `kotlin-lsp`, `lua-lsp`, `php-lsp`, `pyright-lsp`, `rust-analyzer-lsp`, `swift-lsp`, `typescript-lsp` — danno automatic diagnostics + code navigation.
2. **External integrations**: `github`, `gitlab`, `atlassian`, `asana`, `linear`, `notion`, `figma`, `vercel`, `firebase`, `supabase`, `slack`, `sentry`.
3. **Development workflows**: `commit-commands`, `pr-review-toolkit`, `agent-sdk-dev`, `plugin-dev`.
4. **Output styles**: `explanatory-output-style`, `learning-output-style`.
5. **Security**: `claude-security` — scansione multi-agente delle vulnerabilita' (vedi § 11.3bis piu' sotto).

Demo plugin source: https://github.com/anthropics/claude-code/tree/main/plugins.

---

## 11.3 Comandi plugin

```bash
# Marketplace
/plugin marketplace add anthropics/claude-code
/plugin marketplace add https://gitlab.com/org/plugins.git#v1.0.0
/plugin marketplace add ./local-marketplace
/plugin marketplace list
/plugin marketplace update <name>
/plugin marketplace remove <name>

# Plugin
/plugin install plugin-name@marketplace-name
/plugin enable / disable / uninstall plugin-name@marketplace-name
/plugin list [--enabled|--disabled]    # elenca plugin installati, filtra per stato (da v2.1.163)
/plugin                            # UI tabbed: Discover, Installed, Marketplaces, Errors

# CLI
claude plugin install formatter@your-org --scope project
/reload-plugins                    # apply senza restart
```

### 11.3bis Claude Security — scan multi-agente delle vulnerabilita' (da 22 lug 2026)

Plugin ufficiale in beta pubblica che esegue, dentro una sessione Claude Code, una scansione di sicurezza multi-agente: un team di agenti mappa l'architettura del repo, costruisce un threat model, cerca vulnerabilita' (injection, bypass di autenticazione, memory corruption, logic error) e fa verificare ogni finding da un agente indipendente da chi l'ha trovato, prima di scriverlo nel report. E' il layer "deep scan on demand" accanto al [security guidance plugin](https://code.claude.com/docs/en/security-guidance) (review in-sessione mentre Claude scrive), a `/security-review` (single-pass sul branch corrente) e a Code Review (multi-agent su PR, Team/Enterprise).

```bash
# Installazione
/plugin install claude-security@claude-plugins-official
/reload-plugins

# Uso: apre un menu con Scan codebase / Scan changes / Suggest patches
/claude-security
/claude-security scan my branch      # solo il diff del branch corrente
/claude-security scan commit abc1234 # singolo commit
```

Richiede Claude Code v2.1.154+ (dynamic workflows), `python3` 3.9.6+ sul `PATH`, e git per gli scan di diff/PR/commit (uno scan completo funziona anche fuori da un repo versionato). Ogni scan scrive i risultati in una directory `CLAUDE-SECURITY-<timestamp>/` con report Markdown, JSONL machine-readable e uno stamp della revisione scansionata; la directory ha un proprio `.gitignore` cosi' un `git add` accidentale non la include nel commit. Le patch proposte finiscono in `patches/F<n>.patch`, ciascuna gia' revisionata da un agente indipendente, e **non vengono mai applicate in automatico** — vanno accettate a mano con `git apply` o chiedendo a Claude di aprirle come PR separata.

<sub>Aggiornato 2026-07-24 via daily what's new. Fonte: [Claude Code Docs — Claude Security](https://code.claude.com/docs/en/claude-security) · [@claudeai](https://x.com/claudeai/status/2079990597973057691).</sub>

---

### Gestione dipendenze tra plugin (da v2.1.143)

Quando un plugin dipende da un altro, il sistema applica la dipendenza in modo automatico:

- **Disabilitazione**: `claude plugin disable <name>` rifiuta l'operazione se un altro plugin abilitato dipende dal target. L'output include un hint con il comando copy-pasteable per disabilitare l'intera catena nell'ordine corretto.
- **Abilitazione**: `claude plugin enable <name>` forza l'abilitazione di tutte le dipendenze transitive, senza richiedere passi manuali.

```bash
# Esempio: formatter-pro dipende da base-lsp
claude plugin disable base-lsp
# → Errore: formatter-pro dipende da base-lsp.
# → Per disabilitare entrambi: claude plugin disable formatter-pro && claude plugin disable base-lsp

claude plugin enable formatter-pro
# → Abilita automaticamente base-lsp (dipendenza transitiva)
```

<sub>Aggiornato 2026-05-16 via daily what's new. Fonte: [GitHub Releases v2.1.143](https://github.com/anthropics/claude-code/releases/tag/v2.1.143).</sub>

### Pre-install preview (da v2.1.145)

Prima di installare un plugin, le tab **Discover** e **Browse** del marketplace (`/plugin`) mostrano in anteprima tutto cio' che il plugin portera' nell'ambiente:

- Slash command aggiunti
- Agenti definiti
- Skill disponibili
- Hook registrati
- Server MCP e LSP configurati

Questa visibilita' permette di valutare l'impatto di un plugin — permessi, tool, surface esposta — senza committere l'installazione.

```
/plugin              # apre UI tabbed
# → tab Discover: sfoglia marketplace con anteprima per ogni plugin
# → tab Browse: cerca plugin; click per vedere i dettagli prima di /plugin install
```

Il campo "Last updated" e' ora visibile anche nelle tab Browse/Discover.

<sub>Aggiornato 2026-05-20 via daily what's new. Fonte: [GitHub Releases v2.1.145](https://github.com/anthropics/claude-code/releases/tag/v2.1.145).</sub>

### Caricamento da archivio o URL (da v2.1.128–129)

Per testare un plugin senza aggiungerlo a un marketplace, o per distribuire plugin interni da un artifact store:

```bash
claude --plugin-dir ./my-plugin.zip                    # archivio .zip locale
claude --plugin-url https://example.com/my-plugin.zip  # scarica da URL (sessione corrente)
```

<sub>Aggiornato 2026-05-09 via daily what's new. Fonte: [code.claude.com/docs/en/whats-new/2026-w19](https://code.claude.com/docs/en/whats-new/2026-w19).</sub>

### Plugin locali: auto-loading e scaffolding (da v2.1.157)

Da v2.1.157, qualsiasi directory plugin posizionata in `.claude/skills/<nome>/` viene caricata automaticamente all'avvio della sessione, senza richiedere registrazione nel marketplace o comando `/plugin install`. E' sufficiente creare la struttura con il manifest e il plugin diventa attivo.

Per scaffoldare rapidamente un plugin con la struttura corretta:

```bash
claude plugin init my-plugin
# → crea .claude/skills/my-plugin/ con .claude-plugin/plugin.json e struttura base pronta
```

Casi d'uso tipici:
- Plugin interni al progetto non destinati alla distribuzione
- Prototipazione rapida di skill + hook + MCP bundle prima della pubblicazione
- Override locale di behavior con plugin personalizzati per il team

Il plugin auto-loadato appare nella tab **Installed** di `/plugin` e rispetta tutti gli scope (project vs user) in base alla directory di destinazione (`.claude/skills/` vs `~/.claude/skills/`).

<sub>Aggiornato 2026-05-30 via daily what's new. Fonte: [GitHub Releases v2.1.157](https://github.com/anthropics/claude-code/releases/tag/v2.1.157).</sub>

---

## 11.4 Scope di installazione

| Scope | Visibile a | Storage |
|---|---|---|
| User (default) | Tutti i progetti tuoi | `~/.claude/` |
| Project | Collaborators (versionato) | `.claude/settings.json` |
| Local | Solo te, in questo repo | `.claude/settings.local.json` (gitignore) |
| Managed | Org via admin | Managed settings |

---

## 11.5 Auto-update

Toggle per marketplace via UI:
- Official: enabled di default
- Third-party: disabled di default

```bash
DISABLE_AUTOUPDATER=1            # disabilita CC + plugin
FORCE_AUTOUPDATE_PLUGINS=1       # plugin auto-update anche con autoupdater off
```

---

## 11.6 Team / org marketplaces

```json
{
  "extraKnownMarketplaces": {
    "my-team-tools": {
      "source": { "source": "github", "repo": "your-org/claude-plugins" }
    }
  }
}
```

### Managed restrictions

```json
{
  "strictKnownMarketplaces": ["claude-plugins-official", "my-team-tools"],
  "blockedMarketplaces": ["random/marketplace"],
  "allowManagedMcpServersOnly": true,
  "pluginTrustMessage": "I plugin sono validati dal team Sec."
}
```

Da v2.1.117: `blockedMarketplaces`/`strictKnownMarketplaces` enforced anche con managed settings.

---

## 11.7 Plugin con monitor

`monitors/monitors.json` (da v2.1.106):
```json
[
  {
    "name": "error-log",
    "command": "tail -F ./logs/error.log",
    "description": "Application error log"
  }
]
```

Ogni stdout line → notifica nella sessione (vedi [14 Loop & Monitor](./14-loop-monitor.md)).

---

## 11.8 Plugin con LSP

`.lsp.json`:
```json
{
  "servers": {
    "typescript": {
      "command": "npx",
      "args": ["typescript-language-server", "--stdio"]
    }
  }
}
```

LSP ufficiali: `typescript-lsp`, `pyright-lsp`, `rust-analyzer-lsp`, `gopls-lsp`, ecc. Forniscono auto-diagnostics + code navigation a Claude.

---

## 11.9 Esempi marketplace community

| Marketplace | Cosa offre |
|---|---|
| `daymade/claude-code-skills` | Skill curate (productivity, code review) |
| `alirezarezvani/claude-skills` | 232+ skill |
| `dashed/claude-marketplace` | Locale, sysadmin tooling |
| `ooiyeefei/ccc` (`ccc-skills`) | Excalidraw architecture diagrams |
| `claudemarketplaces.com` | Aggregatore |

---

## 11.10 Tips operative

1. **Plugin > skill solo** quando vuoi distribuire piu' artifact insieme (skill + agent + hook + MCP).
2. **LSP plugin per ogni linguaggio principale**: enormous quality lift su navigazione codice.
3. **Monitor plugin** per sessioni lunghe: tail error log come notifica push.
4. **Custom team marketplace** in azienda: mantieni in `your-org/claude-plugins`, aggiungilo via `/plugin marketplace add`.
5. **`pluginTrustMessage`** in managed settings per spiegare al team la review process.

---

## 11.11 Annunci rilevanti

- **Customizability** (feb 2026): "hooks, plugins, LSPs, MCPs, skills, effort, custom agents, status lines, output styles" — [@bcherny](https://x.com/bcherny/status/2021699851499798911)
- Hidden features Boris (mar 2026) — [@bcherny](https://x.com/bcherny/status/2038454336355999749)
- Plugin executables sul `PATH` di Bash tool (Week 14, v2.1.94)
- Plugin auto-install deps (v2.1.117)
- Plugin da `.zip` e URL (Week 19, v2.1.128–129): `--plugin-dir` accetta `.zip`, `--plugin-url` scarica da URL

---

← [10 MCP](./10-mcp.md) · Successivo → [12 Agent Teams](./12-agent-teams.md)
