# Persona 2 — Solo developer / Indie hacker

> Sviluppatore singolo, SaaS in solitaria, max velocita' di shipping, basso overhead.

## Setup

| Aspetto | Valore | Perche' |
|---|---|---|
| **Plan** | Max | Opus 4.7 xhigh, fast mode con $50 credit, 15 routine/giorno, Remote Control |
| **Surface** | CLI + VS Code + Remote Control iOS | Velocita' assoluta |
| **Sandbox** | ON | Sempre |
| **Fast mode** | SI | Su task lunghi e ben definiti |
| **Auto mode** | SI | Per maintenance loop; default per feature nuove |
| **Default permission** | `auto` (con allowlist) | Friction minima |

## File inclusi

- [`CLAUDE.md`](./CLAUDE.md) — convenzioni indie SaaS Next.js + Postgres
- [`.claude/settings.json`](./.claude/settings.json) — permissions auto + sandbox network ristretta
- [`.claude/agents/code-simplifier.md`](./.claude/agents/code-simplifier.md) — subagent ricorrente Boris-style
- [`.claude/skills/ship/SKILL.md`](./.claude/skills/ship/SKILL.md) — workflow merge + tests + CHANGELOG + PR

## Approfondimenti

- [docs/21 § 2 Indie hacker](../../../docs/21-guide-target-user.md#2-solo-developer--indie-hacker)
- [docs/14 — `/loop` & Monitor](../../../docs/14-loop-monitor.md)
- [docs/13 — Routines](../../../docs/13-routines-cloud.md)

← [examples/personas](../README.md)
