# Ecosistema developer + changelog non ufficiale

Post di figure dell'ecosistema developer (Vercel, latent.space, community) e del changelog non ufficiale @ClaudeCodeLog che traccia ogni release CC.

---

## @rauchg — Guillermo Rauch (Vercel CEO)

Profilo: https://x.com/rauchg

**CC su Vercel AI Gateway (dic 2025)**
"I've got Claude Code running through @vercel AI Gateway. This not only gives me failover (e.g.: to @awscloud Bedrock), but also means your company can manage all models and spend in one place. How? Set ANTHROPIC_BASE_URL and..."
URL: https://x.com/rauchg/status/2007556249437778419

**Claude Code Max su Vercel AI Gateway (feb 2026)**
"Claude Code Max support on @vercel AI Gateway"
URL: https://x.com/rauchg/status/2016146382932083160

**`npx plugins add` Vercel (mar 2026)**
"Install the Vercel plugin for your favorite coding agent. There's no step two. You just gave Claude Code and Cursor production deployment superpowers. Running npx plugins add gets you every Skill and keeps them updated."
URL: https://x.com/rauchg/status/2034095862406901772

**Agentic Infrastructure (apr 2026)**
"Agentic Infrastructure is the future of the cloud. For coding agents: if you use Claude Code, Codex, Cursor, you need infra that clicks for your agents, not just devs. To deploy agents Pages -> Agents. Long-running compute, sandboxes..."
URL: https://x.com/rauchg/status/2042358253510963384

---

## @swyx — Shawn Wang (latent.space)

Profilo: https://x.com/swyx

**CC come base di Cowork (feb 2026)**
"Terminals : LaTex :: AI for Coding : AI for Science. when Claude Code started it was just a humble CLI side project. today it forms the basis for Claude Cowork, a general purpose non-coding desktop agent."
URL: https://x.com/swyx/status/2016258918297829719

**Cowork = harness su CC su Opus**
"CLAUDE COWORK IS A HARNESS ON TOP OF CLAUDE CODE IS A HARNESS ON TOP OF CLAUDE OPUS. i'm working on the @aidotengineer website today. need to go Figma -> Website in 1 easy step."
URL: https://x.com/swyx/status/2017482739285684708

**CC anniversario (feb 2026)**
"Guys - it's Claude Code's actual first birthday today - Feb 24 2025 was the launch... am i crazy or is @latentspacepod the only one doing a retrospective + anniversary pod today? did everyone just forget the most consequential AI product since ChatGPT?"
URL: https://x.com/swyx/status/2026462001933988094

---

## @transitive_bs — Travis Fischer

Profilo: https://x.com/transitive_bs

**Setup Boris: 5 git clones (dic 2025)**
"creator of claude code uses 5 separate git clones to work in parallel (separate directory checkouts, not git worktrees)"
URL: https://x.com/transitive_bs/status/2007687241636987373

---

## @ClaudeCodeLog — Changelog non ufficiale

Profilo: https://x.com/ClaudeCodeLog. Account che traccia ogni release CC con diff dettagliato (CLI, system prompt, config). Riferimento per cambiamenti del system prompt non documentati altrove.

### Febbraio 2026

**v2.1.39**
"Claude Code 2.1.39 is out. 5 CLI and 1 prompt changes, no flag changes. Details in thread"
URL: https://x.com/ClaudeCodeLog/status/2021362954864648607

### Marzo 2026

**v2.1.75 — 1M context default su Max/Team/Enterprise**
"Opus 4.6 uses a 1M context window by default on Max, Team, and Enterprise plans. Tool permission denials prompt for a reason when intent is unclear instead of guessing."
URL: https://x.com/ClaudeCodeLog/status/2032507412297425056

**v2.1.79 — system prompt memory tightening**
"Claude is instructed to enforce memory do-not-save rules even when explicitly asked. If asked to save PR lists or activity summaries, Claude should ask what was surprising/non-obvious and store only that durable..."
URL: https://x.com/ClaudeCodeLog/status/2034402575634612594

**v2.1.80 — memory staleness check**
"Claude's memory guidance is tightened: stored memories can go stale, so Claude should treat them as historical context and verify key details by checking current files/resources before answering or assuming anything."
URL: https://x.com/ClaudeCodeLog/status/2034759402796818648

**v2.1.87 — Cowork Dispatch reliability**
"Cowork Dispatch messages deliver reliably, ensuring dispatched communications reach recipients"
URL: https://x.com/ClaudeCodeLog/status/2038082397401387083

**v2.1.88 — agent guidance + StructuredOutput fix**
"Agent guidance adds never delegate understanding: agents must verify comprehension to avoid misdelegation. Fixed StructuredOutput schema cache bug causing ~50% failures..."
URL: https://x.com/ClaudeCodeLog/status/2038773096379748786

**v2.1.88 (CLI) — `CLAUDE_CODE_NO_FLICKER=1` + PermissionDenied hook**
"CLAUDE_CODE_NO_FLICKER=1 env var to opt into flicker-free alt-screen rendering with virtualized scrollback. Added PermissionDenied hook that fires after auto mode classifier denials — return {retry: true} to..."
URL: https://x.com/ClaudeCodeLog/status/2038773107129749617

### Aprile 2026

**v2.1.94 — default effort medium → high**
"Default effort medium-to-high for API-key, Bedrock/Vertex/Foundry, Team and Enterprise; gives deeper results. Ignore-memory no longer treats MEMORY.md as empty..."
URL: https://x.com/ClaudeCodeLog/status/2041633784836038757

**v2.1.100 — Monitor tool deferred**
"Claude gains the deferred Monitor tool and is told to stream stdout events from background processes via Monitor instead of sleeping/polling. The prompt also blocks starting a Bash command with sleep N when N is greater or equal to 2..."
URL: https://x.com/ClaudeCodeLog/status/2042508019397746800

**v2.1.100 (CLI) — sleep blocking**
"Monitor tool added; sleep-first delays >=2s are blocked to improve streaming responsiveness."
URL: https://x.com/ClaudeCodeLog/status/2042508004378001787

**v2.1.104 — explicit approval per tool blocked**
"Tool calls require explicit approval if blocked by permission mode, preventing unintended external actions. System reminder prompts..."
URL: https://x.com/ClaudeCodeLog/status/2043203791185387922

**v2.1.107 — thinking hints sooner**
"Show thinking hints sooner during long operations"
URL: https://x.com/ClaudeCodeLog/status/2043940851651408267

**v2.1.117 — model selection persist + plugin deps**
"Model selection now persists despite project pins; startup shows active model and source for clarity. plugin install on already-installed plugins now installs missing dependencies, avoiding manual fixes. Forked subagents via env var. Resume offers to summarize large sessions."
URL: https://x.com/ClaudeCodeLog/status/2046745562507071790

**v2.1.120 — `claude ultrareview` subcommand**
"Added `claude ultrareview [target]` subcommand to run /ultrareview non-interactively from CI or scripts - prints findings to stdout (--json for raw output) and exits 0 on completion or 1 on failure. Fixes: Fixed pressing Esc..."
URL: https://x.com/ClaudeCodeLog/status/2047882231343878309

---

## Tip ricorrenti dall'ecosistema

1. **CC dietro Vercel AI Gateway** via `ANTHROPIC_BASE_URL` per failover su Bedrock e governance spend (rauchg, dic 2025)
2. **`npx plugins add`** per installare skill + tenerli aggiornati (rauchg, mar 2026)
3. **5 git clones invece di worktrees** — Boris usa questo setup vanilla (transitive_bs, dic 2025)
4. **Mental model "game engine"** — CC come small game engine (Thariq, gen 2026)
