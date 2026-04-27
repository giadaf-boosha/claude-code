# 01 — Snapshot prodotto Claude Code (aprile 2026)

> Versione di riferimento: **CLI v2.1.119** (23 aprile 2026). Questo documento e' uno snapshot dello stato attuale: cosa esiste, su quali modelli gira, come ci si accede.

---

## 1.1 Versioni e modelli

| Item | Valore |
|---|---|
| Versione CLI corrente | `v2.1.119` (23 apr 2026), range coperto 2.1.83 → 2.1.119 |
| Modello di default | `claude-sonnet-4-6` |
| Modello premium | `claude-opus-4-7` con effort `xhigh` (Max plan, da v2.1.111) |
| Effort levels | `low`, `medium`, `high`, `xhigh`, `max` |
| Default effort Pro/Max | `high` su Opus 4.6 e Sonnet 4.6 (da v2.1.117) |
| Fast mode | 2.5x piu' veloce di **Opus 4.6** (NON disponibile su 4.7) — $30/$150 per MTok |

Fonti: [`/en/overview`](https://code.claude.com/docs/en/overview), [`/en/quickstart`](https://code.claude.com/docs/en/quickstart), [`/en/fast-mode`](https://code.claude.com/docs/en/fast-mode), [`/en/changelog`](https://code.claude.com/docs/en/changelog).

---

## 1.2 Surface — dove si usa Claude Code

| Surface | URL/comando | Note |
|---|---|---|
| Terminal CLI | `claude` | Native install raccomandato; auto-update in background |
| Desktop app | macOS / Windows / Windows ARM64 | [claude.com/download](https://claude.com/download). Multi-session sidebar (mar 2026) |
| VS Code / Cursor | `vscode:extension/anthropic.claude-code` | Inline diff, plan review, @-mentions |
| JetBrains | [Plugin marketplace](https://plugins.jetbrains.com/plugin/27310-claude-code-beta-) | IntelliJ, PyCharm, WebStorm |
| Web | [claude.ai/code](https://claude.ai/code) | Cloud sessions, repo cloning |
| Slack | `/install-slack-app` | Mention `@Claude` per task |
| Mobile | Claude iOS app + [Remote Control](./17-ide-surface.md#remote-control) | Android via mobile web |
| GitHub Actions / GitLab CI/CD | `/install-github-app` | PR review, issue triage |

Annunci recenti rilevanti:
- **Claude Code on the web** (ott/nov 2025) — [@_catwu](https://x.com/_catwu/status/1980338889958257106)
- **Claude Code in Claude Desktop** (dic 2025) — [@_catwu](https://x.com/_catwu/status/2008628736409956395)
- **Desktop redesign multi-session** (mar 2026) — [@claudeai](https://x.com/claudeai/status/2044131493966909862)
- **Remote Control** (feb 2026, GA mar 2026) — [@claudeai](https://x.com/claudeai/status/2026418433911603668)

---

## 1.3 Provider supportati

| Provider | Variabile | Note |
|---|---|---|
| Anthropic API (default) | — | Tutte le feature |
| Amazon Bedrock | `CLAUDE_CODE_USE_BEDROCK=1` | Niente fast mode, niente ultrareview/ultraplan, niente Monitor |
| Google Vertex AI | `CLAUDE_CODE_USE_VERTEX=1` | Stesse limitazioni |
| Microsoft Foundry | `CLAUDE_CODE_USE_FOUNDRY=1` | Stesse limitazioni |

> Le feature cloud (Routines, Ultraplan, Ultrareview, Computer use, Monitor) richiedono Anthropic provider.

---

## 1.4 Pricing (semplificato)

| Plan | Cosa offre |
|---|---|
| Pro | Sonnet 4.6 + Opus 4.6, plan/auto mode, `/loop`, 5 routine scheduled/giorno, 3 free `/ultrareview` (entro 5 mag 2026) |
| Max | Tutto di Pro + Opus 4.7 xhigh, fast mode con $50 credit, 15 routine/giorno, Remote Control |
| Team | 25 routine/giorno, Code Review GA su PR, managed settings |
| Enterprise | SSO, RBAC, compliance API, Claude Code Security |

Fast mode bills sempre come **extra usage** (anche con plan rimanente). 1M context GA su Opus 4.6 / Sonnet 4.6 senza multiplier (Max/Team/Enterprise automatico, Pro abilitabile). Annunciato il [13 marzo 2026](https://claude.com/blog/1m-context-ga).

---

## 1.5 Roadmap visibile (post-15 feb 2026)

Cronologia compatta (per dettaglio vedi [19-changelog.md](./19-changelog.md)):

| Data | Evento |
|---|---|
| 7 feb 2026 | `/fast` Opus 4.6 (research preview) — [@claudeai](https://x.com/claudeai/status/2020207322124132504) |
| 13 mar 2026 | 1M context GA Opus/Sonnet 4.6 — [blog](https://claude.com/blog/1m-context-ga) |
| 24 mar 2026 (w13) | Auto mode + Computer use Desktop + PowerShell tool |
| 30 mar 2026 (w14) | `/ultrareview` (v2.1.86) + Computer use CLI |
| 6-10 apr 2026 (w15) | `/ultraplan` + Monitor tool + `/loop` self-pacing + `/team-onboarding` + `/autofix-pr` |
| 14 apr 2026 | **Routines** GA in research preview + Desktop redesign multi-session — [blog](https://claude.com/blog/introducing-routines-in-claude-code) |
| 16 apr 2026 | Opus 4.7 + xhigh effort + `/effort` slider + `/ultrareview` GA |
| 23 apr 2026 | v2.1.119 — Vim visual mode, custom themes, hooks `mcp_tool` |

---

## 1.6 Risorse ufficiali

- Sito: https://claude.com/claude-code
- Docs: https://code.claude.com/docs/
- Changelog: https://code.claude.com/docs/en/changelog
- Weekly what's new: https://code.claude.com/docs/en/whats-new
- GitHub: https://github.com/anthropics/claude-code
- Plugins ufficiali: https://github.com/anthropics/claude-code/tree/main/plugins
- Sandbox runtime open source: https://github.com/anthropic-experimental/sandbox-runtime
- Agent SDK demos: https://github.com/anthropics/claude-agent-sdk-demos

---

← Torna al [README](../README.md) · Successivo → [02 — CLI e installazione](./02-cli-installazione.md)
