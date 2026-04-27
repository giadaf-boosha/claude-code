# Claude Code — Guida ragionata (aprile 2026)

> Reference completa di Claude Code (CLI, IDE, Web, Desktop, SDK) curata da [Boosha AI](https://boosha.ai).
> Aggiornata al **27 aprile 2026** integrando tutti gli aggiornamenti dal 15 febbraio in poi.
> Versione CLI di riferimento: **v2.1.119**.

---

## Cos'e' Claude Code

Strumento di sviluppo AI di Anthropic che opera come agente autonomo: legge, scrive, modifica codice, esegue comandi, naviga il filesystem, parla con tool esterni via [MCP](./docs/10-mcp.md).

Disponibile su:
- **Terminal CLI** (`claude`)
- **Desktop app** (macOS, Windows, Windows ARM64) — multi-session redesign mar 2026
- **VS Code / Cursor** (estensione)
- **JetBrains** (plugin marketplace)
- **Web** ([claude.ai/code](https://claude.ai/code))
- **Slack** (`/install-slack-app`)
- **Mobile** (iOS app + Remote Control)
- **GitHub Actions / GitLab CI/CD**

Modello default: `claude-sonnet-4-6`. Premium: `claude-opus-4-7` con effort `xhigh` su Max plan (da v2.1.111).

---

## Indice della guida

### Fondamenta
1. [Snapshot prodotto aprile 2026](./docs/01-snapshot.md) — versione, modelli, surface, pricing, roadmap
2. [CLI: installazione, comandi, flag](./docs/02-cli-installazione.md) — install, comandi, env vars, diagnostica
3. [Slash commands](./docs/03-slash-commands.md) — 60+ comandi built-in e bundled skills

### Workflow e modalita'
4. [Modalita' permessi, Sandbox, Checkpoints](./docs/04-modalita-permessi.md) — default/acceptEdits/plan/auto/sandbox/bypass + rewind
5. [Fast mode, 1M context, Opus 4.7](./docs/05-fast-mode-1m-context.md) — velocita', context window, modello premium
6. [CLAUDE.md, rules, auto-memory](./docs/06-claude-md-memory.md) — gerarchia memoria, import, rules path-specific

### Estensibilita'
7. [Hooks](./docs/07-hooks.md) — 28 eventi, 5 handler, conditional `if`, esempi
8. [Subagents](./docs/08-subagents.md) — Explore, Plan, custom, forking
9. [Skills](./docs/09-skills.md) — SKILL.md, allowed-tools, paths, marketplace skill
10. [MCP — Model Context Protocol](./docs/10-mcp.md) — server, transports, channels, registry
11. [Plugins & Marketplace](./docs/11-plugins-marketplace.md) — struttura, ufficiale + community
12. [Agent Teams](./docs/12-agent-teams.md) — sperimentale, task list, mailbox

### Cloud e automazione
13. [Routines (cloud)](./docs/13-routines-cloud.md) — schedule + API + GitHub triggers
14. [`/loop` e Monitor tool](./docs/14-loop-monitor.md) — automazione intra-sessione
15. [Ultraplan & Ultrareview](./docs/15-ultraplan-ultrareview.md) — planning e review multi-agent in cloud

### Integrazione e produzione
16. [Headless & Agent SDK](./docs/16-headless-agent-sdk.md) — CLI `-p`, SDK Python/TS, GitHub Actions
17. [IDE e altre surface](./docs/17-ide-surface.md) — VS Code, JetBrains, Desktop, Web, Slack, Remote Control, Computer use
18. [Settings & Authentication](./docs/18-settings-auth.md) — gerarchia, permission syntax, Teams/Enterprise

### Riferimenti
19. [Changelog feb → apr 2026](./docs/19-changelog.md) — versione per versione + post-mortem qualita'
20. [Tips & best practices](./docs/20-tips-best-practices.md) — pattern operativi e tip dal team Anthropic

---

## Highlights post-15 febbraio 2026

| Data | Novita' | Documento |
|---|---|---|
| 7 feb 2026 | Fast mode Opus 4.6 (research preview) | [05](./docs/05-fast-mode-1m-context.md) |
| 13 mar 2026 | 1M context GA Opus/Sonnet 4.6 | [05](./docs/05-fast-mode-1m-context.md) |
| 24 mar 2026 (w13) | **Auto mode** + Computer use Desktop + PowerShell tool | [04](./docs/04-modalita-permessi.md) |
| 30 mar 2026 (w14) | **`/ultrareview`** + Computer use CLI | [15](./docs/15-ultraplan-ultrareview.md) |
| 6-10 apr 2026 (w15) | **`/ultraplan`** + **Monitor tool** + `/loop` self-pacing + `/team-onboarding` + `/autofix-pr` | [14](./docs/14-loop-monitor.md), [15](./docs/15-ultraplan-ultrareview.md) |
| 14 apr 2026 | **Routines** GA in research preview + Desktop redesign multi-session | [13](./docs/13-routines-cloud.md) |
| 16 apr 2026 | **Opus 4.7 + xhigh effort** + `/effort` slider + `/ultrareview` GA | [05](./docs/05-fast-mode-1m-context.md), [15](./docs/15-ultraplan-ultrareview.md) |
| 23 apr 2026 | v2.1.119 — Vim visual mode, custom themes, hooks `mcp_tool` | [19](./docs/19-changelog.md) |

---

## Post X di riferimento

[posts/](./posts/) raccoglie i post X principali del team Claude Code (Boris Cherny, Cat Wu, Noah Zweben, Thariq, account ufficiali) che documentano feature, tips e annunci. Ogni post e' citato con URL originale e contesto.

- [posts/bcherny.md](./posts/bcherny.md) — Boris Cherny, creator Claude Code
- [posts/catwu.md](./posts/catwu.md) — Cat Wu, PM Claude Code
- [posts/noahzweben.md](./posts/noahzweben.md) — Noah Zweben, PM Claude Code (drop tecnici)
- [posts/trq212.md](./posts/trq212.md) — Thariq, engineer Claude Code
- [posts/claudeai-claudedevs.md](./posts/claudeai-claudedevs.md) — account ufficiali

---

## Skills curate

[skills/](./skills/) contiene 76 skill curate (raccolta originale del 15 febbraio 2026, ancora valide). Categorie: bio-research, customer-support, data, doc-coauthoring, enterprise-search, finance, ecc.

> Per skill aggiornate aprile 2026, vedi [marketplace community](./docs/11-plugins-marketplace.md).

---

## Risorse di ricerca

[`_research/`](./_research/) contiene i dossier di ricerca generati durante la riscrittura aprile 2026:
- `dossier-docs.md` (~64KB) — documentazione ufficiale code.claude.com
- `dossier-x-engineers.md` — post X di @noahzweben + @trq212
- `dossier-x-product.md` — post X di @_catwu + @ClaudeDevs + @bcherny + @claudeai
- `dossier-features.md` — feature specifiche post-15 feb (Routines, /loop, Monitor, /ultraplan, /ultrareview, Excalidraw skill)

---

## Archive

[`archive/docs-pre-feb2026/`](./archive/docs-pre-feb2026/) contiene la struttura precedente della repo (snapshot 15 feb 2026), preservata per riferimento storico.

---

## Risorse ufficiali

- Sito: https://claude.com/claude-code
- Docs: https://code.claude.com/docs/
- Changelog: https://code.claude.com/docs/en/changelog
- Weekly what's new: https://code.claude.com/docs/en/whats-new
- GitHub: https://github.com/anthropics/claude-code
- Plugin marketplace ufficiale: https://claude.com/plugins

---

## Licenza & contributi

Questa repo e' una **guida didattica** mantenuta da [Boosha AI](https://boosha.ai) per i corsi di formazione AI. I contenuti citano ogni fonte (docs ufficiali, post X) per consentire deep-dive autonomo.

Per segnalazioni / aggiornamenti / aggiunte, apri una issue o PR.

> Originale Notion (snapshot feb 2026): https://giadaf.notion.site/Claude-Code-23da6050b48780b596cdf17df630d43a
