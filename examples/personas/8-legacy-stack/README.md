# Persona 8 — Legacy stack maintainer

> RPG/AS400, COBOL, .NET classic, Java EE. Mission-critical, niente test automatici, dialetti rari.

## Setup

| Aspetto | Valore |
|---|---|
| Plan | Team o Enterprise |
| Surface | CLI in WSL/SSH (AS400); JetBrains (Java EE / .NET); VS Code esplorazione |
| Sandbox | ON sempre |
| Fast mode | NO (rischio: scrive plausibile ma sbagliato su dialetti rari) |
| Auto mode | NO. Default + plan mode obbligatorio |

## File inclusi
- [`CLAUDE.md`](./CLAUDE.md) — anti-hallucination rigoroso per legacy
- [`.claude/settings.json`](./.claude/settings.json) — boundary strict, plan-only

## Approfondimenti
- [docs/21 § 8](../../../docs/21-guide-target-user.md#8-legacy-stack-maintainer)
- [docs/05 — 1M context per source legacy lunghi](../../../docs/05-fast-mode-1m-context.md)
- [docs/04 — Plan mode rigoroso](../../../docs/04-modalita-permessi.md)

← [examples/personas](../README.md)
