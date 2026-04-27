# Dossier X — Extended (Claude Code, nov 2025 → apr 2026)

Estensione dei dossier `dossier-x-engineers.md` e `dossier-x-product.md`.
Metodo: WebFetch su x.com bloccato (HTTP 402). Tutti i contenuti raccolti via Google `site:x.com` (snippet ufficiali). Citazioni testuali quando presenti integralmente nello snippet, parafrasi italiana altrove.
Periodo: nov 2025 → apr 2026. Sono esclusi i post gia' tracciati nei dossier base.

---

## @bcherny — Boris Cherny (creator Claude Code)

| Data (approx) | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| dic 2025 | Tip 5 — code review @claude su PR | "5/ During code review, I will often tag @.claude on my coworkers' PRs to add something to the [CLAUDE.md] as part of the PR. We use the Claude Code Github action (/install-github-action) for this. It's our version of @danshipper's Compounding Engineering" | https://x.com/bcherny/status/2007179842928947333 |
| dic 2025 | Tip 8 — subagents ricorrenti | "8/ I use a few subagents regularly: code-simplifier simplifies the code after Claude is done working, verify-app has detailed instructions for testing Claude Code end to end, and so on. Similar to slash commands, I think of subagents as automating the most common workflows that I…" | https://x.com/bcherny/status/2007179850139000872 |
| dic 2025 | Tip 11 — strumenti via MCP/CLI | "11/ Claude Code uses all my tools for me. It often searches and posts to Slack (via the MCP server), runs BigQuery queries to answer analytics questions (using bq CLI), grabs error logs from Sentry, etc. The Slack MCP configuration is checked into our .mcp.json…" | https://x.com/bcherny/status/2007179856266789204 |
| dic 2025 | Tip 12 — long-running con verifica | "12/ For very long-running tasks, I will either (a) prompt Claude to verify its work with a background agent when it's done, (b) use an agent Stop hook to do that more deterministically, or (c) use the ralph-wiggum plugin (originally dreamt up by @GeoffreyHuntley)." | https://x.com/bcherny/status/2007179858435281082 |
| dic 2025 | Tip 13 — feedback loop di verifica | "13/ A final tip: probably the most important thing to get great results out of Claude Code -- give Claude a way to verify its work. If Claude has that feedback loop, it will 2-3x the quality of the final result." | https://x.com/bcherny/status/2007179861115511237 |
| dic 2025 | code-simplifier open source | "We just open sourced the code-simplifier agent we use on the Claude Code team. Try it: claude plugin install code-simplifier… Ask Claude to use the code simplifier" | https://x.com/bcherny/status/2009450715081789767 |
| dic 2025 | Async hooks | "Hooks can now run in the background without blocking Claude Code's execution. Just add async: true to your hook config. Great for logging, notifications, or any side-effect that shouldn't slow things down." | https://x.com/bcherny/status/2015524460481388760 |
| gen 2026 | Reply Karpathy — generalisti | "I think the Claude Code team itself might be an indicator of where things are headed. We have directional answers for some (not all) of the prompts: 1. We hire mostly generalists. We have a mix of senior…" | https://x.com/bcherny/status/2015979257038831967 |
| gen 2026 | Tip 1 — parallel worktrees | "1. Do more in parallel. Spin up 3–5 git worktrees at once, each running its own Claude session in parallel. It's the single biggest productivity unlock, and the top tip from the team." | https://x.com/bcherny/status/2017742743125299476 |
| feb 2026 | Tip 9 — Claude per analytics | "9. Use Claude for data and analytics. Ask Claude Code to use the bq CLI to pull and analyze metrics on the fly. We have a BigQuery skill checked into the codebase, and everyone on the team uses it for analytics queries directly in Claude Code." | https://x.com/bcherny/status/2017742757666902374 |
| feb 2026 | Teams / Agent Swarms | "Out now: Teams, aka. Agent Swarms in Claude Code. Team are experimental, and use a lot of tokens. See the docs for how to enable, and let us know what you think!" | https://x.com/bcherny/status/2019472394696683904 |
| feb 2026 | Lancio fast mode Opus 4.6 | "We just launched an experimental new fast mode for Opus 4.6. The team has been building with it for the last few weeks. It's been a huge unlock for me personally, especially when going back and forth with Claude on a tricky problem." | https://x.com/bcherny/status/2020223254297031110 |
| feb 2026 | Tip 4 — custom agents | "4/ Create custom agents. To create custom agents, drop .md files in .claude/agents. Each agent can have a custom name, color, tool set, pre-allowed and pre-disallowed tools, permission mode, and model." | https://x.com/bcherny/status/2021700144039903699 |
| feb 2026 | Tip 7 — status line custom | "7/ Add a status line. Custom status lines show up right below the composer, and let you show model, directory, remaining context, cost, and pretty much anything else you want to see while you work. Everyone on the Claude Code team has a different statusline. Use /statusline…" | https://x.com/bcherny/status/2021700784019452195 |
| feb 2026 | Tip 8 — keybindings custom | "8/ Customize your keybindings. Did you know every key binding in Claude Code is customizable? /keybindings to re-map any key. Settings live reload so you can see how it feels immediately" | https://x.com/bcherny/status/2021700883873165435 |
| feb 2026 | Tip 12 — settings.json in git | "12/ Customize all the things! Claude Code is built to work great out of the box. When you do customize, check your settings.json into git so your team can benefit, too. We support configuring for your codebase, for a sub-folder, for just yourself, or via enterprise-wide…" | https://x.com/bcherny/status/2021701636075458648 |
| feb 2026 | Engineering vs commodity | "Someone has to prompt the Claudes, talk to customers, coordinate with other teams, decide what to build next. Engineering is changing and great engineers are more important than ever." | https://x.com/bcherny/status/2022762422302576970 |
| feb 2026 | Built-in worktree support | "Introducing: built-in git worktree support for Claude Code. Now, agents can run in parallel without interfering with one other. Each agent gets its own worktree and can work independently." | https://x.com/bcherny/status/2025007393290272904 |
| feb 2026 | claude --worktree | "1/ Use claude --worktree for isolation. To run Claude Code in its own git worktree, just start it with the --worktree option. You can also name your worktree, or have Claude name it for you." | https://x.com/bcherny/status/2025007394967957720 |
| feb 2026 | Subagent worktrees | "3/ Subagents now support worktrees. Subagents can also use worktree isolation to do more work in parallel. This is especially powerful for large batched changes and code migrations. To use it, ask Claude to use worktrees for its agents." | https://x.com/bcherny/status/2025007398537380028 |
| mar 2026 | /simplify uso | "/simplify Use parallel agents to improve code quality, tune code efficiency, and ensure CLAUDE.md compliance. Usage: hey claude make this code change then run /simplify" | https://x.com/bcherny/status/2027534986178662573 |
| mar 2026 | Ultrathink vs /effort max | "Ultrathink == max effort for one turn. /effort max == claude --effort=max == max effort for the rest of the conversation" | https://x.com/bcherny/status/2032672929733861501 |
| mar 2026 | Phone-to-laptop session launch | "You can now launch Claude Code sessions on your laptop from your phone. This blew my mind the first time I tried it" | https://x.com/bcherny/status/2032578639276159438 |
| mar 2026 | Skills uso interno | "We've been using skills in Claude Code extensively…" (riflessione su Skills come asset condivisi del team) | https://x.com/bcherny/status/2033950823248429176 |
| mar 2026 | Tip 6 — Chrome ext per frontend | "6/ Use the Chrome extension for frontend work. The most important tip for using Claude Code is: give Claude a way to verify its output. Once you do that, Claude will iterate until the result is great." | https://x.com/bcherny/status/2038454347156398333 |
| mar 2026 | Tip 9 — /btw side queries | "9/ Use /btw for side queries. I use this all the time to answer quick questions while the agent works" | https://x.com/bcherny/status/2038454351849787485 |
| mar 2026 | Tip 10 — git worktrees deep | "10/ Use git worktrees. Claude Code ships with deep support for git worktrees. Worktrees are essential for doing lots of parallel work in the same repository. I have dozens of Claudes running at all times… Use claude -w to start a new session…" | https://x.com/bcherny/status/2038454353787519164 |
| mar 2026 | Tip 11 — /batch fan-out | "11/ Use /batch to fan out massive changesets. /batch interviews you, then has Claude fan out the work to as many worktree agents as it takes (dozens, hundreds, even thousands) to get it done. Use it for large code migrations and others kinds of parallelizable work." | https://x.com/bcherny/status/2038454355469484142 |
| mar 2026 | Tip 13 — --add-dir cross-repo | "13/ Use --add-dir to give Claude access to more folders. When working across multiple repositories, I usually start Claude in one repo and use --add-dir (or /add-dir) to let Claude see the other repo." | https://x.com/bcherny/status/2038454359047156203 |
| mar 2026 | Tip 14 — --agent custom system prompt | "14/ Use --agent to give Claude Code a custom system prompt and tools. Custom agents are a powerful primitive that often gets overlooked. To use it, just define a new agent in .claude/agents, then run claude --agent=<your agent's name>" | https://x.com/bcherny/status/2038454360418787764 |
| apr 2026 | Opus 4.7 in CC | "Opus 4.7 is in Claude Code today. It's more agentic, more precise, and a lot better at long-running work. It carries context across sessions and handles ambiguity much better." | https://x.com/bcherny/status/2044802532388774313 |
| apr 2026 | Opus 4.7 — riflessione | "Opus 4.7 feels more intelligent, agentic, and precise than 4.6. It took a few days for me to learn how to work with it effectively, to fully take advantage of its new capabilities." | https://x.com/bcherny/status/2044822408826380440 |
| apr 2026 | Tip 5 — adaptive thinking & /effort | "5/ Configure your effort level. Opus 4.7 uses adaptive thinking instead of thinking budgets. To tune the model to think more/less, we recommend tuning effort. Use lower effort for faster responses and lower token usage. Use higher effort for the most intelligence and capability." | https://x.com/bcherny/status/2044847856872546639 |

---

## @_catwu — Cat Wu (PM Claude Code)

| Data | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| dic 2025 | VS Code extension GA (RT) | "The VS Code extension for Claude Code is now generally available. It's now much closer to the CLI experience: @-mention files for context, use familiar slash commands (/model, /mcp, /context), and more." | https://x.com/claudeai/status/2013704053226717347 |

Tutti gli altri post di @_catwu nel periodo sono gia' nel dossier base.

---

## @noahzweben — Noah Zweben (PM Claude Code)

| Data | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| mar 2026 | Remote Control rollout Pro | "Rolling out Claude Code Remote Control to Pro users - because they deserve to use the bathroom too. (Team and Enterprise coming soon). Rolling out to 10% and ramping. 1. Update to claude v2.1.58+. 2. Try log-out and log-in to get fresh flag values. 3. /remote-control" | https://x.com/i/status/2027460961884639663 |

---

## @trq212 — Thariq (engineer Claude Code)

| Data | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| dic 2025 | Spec-based development | "my favorite way to use Claude Code to build large features is spec based. start with a minimal spec or prompt and ask Claude to interview you using the AskUserQuestionTool. then make a new session to execute the spec" | https://x.com/trq212/status/2005315275026260309 |
| gen 2026 | CC come game engine | "Most people's mental model of Claude Code is that it's just a TUI but it should really be closer to a small game engine. For each frame our pipeline constructs a scene graph with React then -> layouts elements -> rasterizes them to a 2d screen -> diffs that against the…" | https://x.com/trq212/status/2014051501786931427 |
| gen 2026 | Todos -> Tasks | "We're turning Todos into Tasks in Claude Code" | https://x.com/trq212/status/2014480496013803643 |
| gen 2026 | Slash Commands -> Skills | "Merging Slash Commands into Skills in Claude Code" | https://x.com/trq212/status/2014836841846132761 |
| feb 2026 | Playgrounds via Claude Code | "Making Playgrounds using Claude Code" | https://x.com/trq212/status/2017024445244924382 |
| feb 2026 | Lessons: Prompt caching | "Lessons from Building Claude Code: Prompt Caching Is Everything" | https://x.com/trq212/status/2024574133011673516 |
| mar 2026 | Reset rate limits | "We've reset rate limits for all Claude Code users. Yesterday we rolled out a bug with prompt caching that caused usage limits to be consumed faster than normal. This is hotfixed in 2.1.62. Make sure you upgrade to the latest…" | https://x.com/trq212/status/2027232172810416493 |
| mar 2026 | Lessons: Seeing like an Agent | "Lessons from Building Claude Code: Seeing like an Agent" | https://x.com/trq212/status/2027463795355095314 |
| mar 2026 | /btw side-chain | "We just added /btw to Claude Code! Use it to have side chain conversations while Claude is working." | https://x.com/trq212/status/2031506296697131352 |
| mar 2026 | Lessons: How We Use Skills | "Lessons from Building Claude Code: How We Use Skills" | https://x.com/trq212/status/2033949937936085378 |
| apr 2026 | TurboTax connector | "there's a turbotax connector in Claude Code now, so glad I procrastinated on taxes" | https://x.com/trq212/status/2043138221836746762 |

---

## @ClaudeCodeLog — changelog non ufficiale

| Data | Versione | Highlights | URL |
|---|---|---|---|
| feb 2026 | 2.1.39 | "Claude Code 2.1.39 is out. 5 CLI and 1 prompt changes, no flag changes. Details in thread" | https://x.com/ClaudeCodeLog/status/2021362954864648607 |
| mar 2026 | 2.1.75 | "Opus 4.6 uses a 1M context window by default on Max, Team, and Enterprise plans. Tool permission denials prompt for a reason when intent is unclear instead of guessing." | https://x.com/ClaudeCodeLog/status/2032507412297425056 |
| mar 2026 | 2.1.79 (system prompt) | "Claude is instructed to enforce memory do-not-save rules even when explicitly asked. If asked to save PR lists or activity summaries, Claude should ask what was surprising/non-obvious and store only that durable…" | https://x.com/ClaudeCodeLog/status/2034402575634612594 |
| mar 2026 | 2.1.80 (system prompt) | "Claude's memory guidance is tightened: stored memories can go stale, so Claude should treat them as historical context and verify key details by checking current files/resources before answering or assuming anything." | https://x.com/ClaudeCodeLog/status/2034759402796818648 |
| mar 2026 | 2.1.87 | "Cowork Dispatch messages deliver reliably, ensuring dispatched communications reach recipients" | https://x.com/ClaudeCodeLog/status/2038082397401387083 |
| mar 2026 | 2.1.88 | "Agent guidance adds never delegate understanding: agents must verify comprehension to avoid misdelegation. Fixed StructuredOutput schema cache bug causing ~50% failures…" | https://x.com/ClaudeCodeLog/status/2038773096379748786 |
| mar 2026 | 2.1.88 (CLI) | "CLAUDE_CODE_NO_FLICKER=1 env var to opt into flicker-free alt-screen rendering with virtualized scrollback. Added PermissionDenied hook that fires after auto mode classifier denials — return {retry: true} to…" | https://x.com/ClaudeCodeLog/status/2038773107129749617 |
| apr 2026 | 2.1.94 | "Default effort medium-to-high for API-key, Bedrock/Vertex/Foundry, Team and Enterprise; gives deeper results. Ignore-memory no longer treats MEMORY.md as empty…" | https://x.com/ClaudeCodeLog/status/2041633784836038757 |
| apr 2026 | 2.1.100 (system prompt) | "Claude gains the deferred Monitor tool and is told to stream stdout events from background processes via Monitor instead of sleeping/polling. The prompt also blocks starting a Bash command with sleep N when N is greater or equal to 2…" | https://x.com/ClaudeCodeLog/status/2042508019397746800 |
| apr 2026 | 2.1.100 (CLI) | "Monitor tool added; sleep-first delays >=2s are blocked to improve streaming responsiveness." | https://x.com/ClaudeCodeLog/status/2042508004378001787 |
| apr 2026 | 2.1.104 | "Tool calls require explicit approval if blocked by permission mode, preventing unintended external actions. System reminder prompts…" | https://x.com/ClaudeCodeLog/status/2043203791185387922 |
| apr 2026 | 2.1.107 | "Show thinking hints sooner during long operations" | https://x.com/ClaudeCodeLog/status/2043940851651408267 |
| apr 2026 | 2.1.117 | "Model selection now persists despite project pins; startup shows active model and source for clarity. plugin install on already-installed plugins now installs missing dependencies, avoiding manual fixes. Forked subagents via env var. Resume offers to summarize large sessions." | https://x.com/ClaudeCodeLog/status/2046745562507071790 |

---

## @alistaiir — Alistair (Anthropic engineer)

| Data | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| apr 2026 | Lancio Monitor tool | "We're launching the Monitor tool in today's Claude Code release. Claude spawns a background process and each stdout line streams into the conversation, without blocking the thread. e.g. Use the monitor tool and `kubectl logs -f | grep ..` to listen for errors, make a pr to fix" | https://x.com/alistaiir/status/2042345049980362819 |
| apr 2026 | April Fools — /buddy | "Happy April Fools! For the next few days, Claude Code gets five rarities across 18 species of buddies that talk to you as you code. Upgrade and send /buddy to unbox yours. (these tokens don't contribute to your usage limits!)" | https://x.com/alistaiir/status/2039429708014829764 |

---

## @claudeai — account ufficiale (post non ancora coperti)

| Data | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| feb 2026 | Sonnet 4.6 in CC | "Claude Sonnet 4.6 is available now on all plans, Cowork, Claude Code, our API, and all major cloud platforms. We've also upgraded our free tier to Sonnet 4.6 by default — it now includes file creation, connectors, skills, and compaction." | https://x.com/claudeai/status/2023817147303292948 |
| feb 2026 | Sonnet 4.6 capabilities | "This is Claude Sonnet 4.6: our most capable Sonnet model yet. It's a full upgrade across coding, computer use, long-context reasoning, agent planning, knowledge work, and design. It also features a 1M token context window in beta." | https://x.com/claudeai/status/2023817132581208353 |
| mar 2026 | Cowork scheduled tasks | "New in Cowork: scheduled tasks. Claude can now complete recurring tasks at specific times automatically: a morning brief, weekly spreadsheet updates, Friday team presentations." | https://x.com/claudeai/status/2026720870631354429 |
| mar 2026 | Computer use launch | "You can now enable Claude to use your computer to complete tasks. It opens your apps, navigates your browser, fills in spreadsheets — anything you'd do sitting at your desk. Research preview in Claude Cowork and Claude Code, macOS only." | https://x.com/claudeai/status/2036195789601374705 |
| mar 2026 | Cowork projects | "Projects are now available in Cowork. Keep your tasks and context in one place, focused on one area of work. Files and instructions stay on your computer. Import existing projects in one click, or start fresh." | https://x.com/claudeai/status/2035025492617961704 |
| mar 2026 | Computer use Windows | "Computer use in Claude Cowork and Claude Code Desktop is now available on Windows." | https://x.com/claudeai/status/2039836891508261106 |
| apr 2026 | Cowork GA | "Claude Cowork is now generally available to all paid plans. For Enterprise, we are adding role-based access controls, group spend limits, usage analytics, and expanded OpenTelemetry to give admins what they need to deploy it across the org." | https://x.com/claudeai/status/2042273755485888810 |

---

## @rauchg — Guillermo Rauch (Vercel CEO, ecosistema)

| Data | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| dic 2025 | CC su Vercel AI Gateway | "I've got Claude Code running through @vercel AI Gateway. This not only gives me failover (e.g.: to @awscloud Bedrock), but also means your company can manage all models and spend in one place. How? Set ANTHROPIC_BASE_URL and…" | https://x.com/rauchg/status/2007556249437778419 |
| feb 2026 | Claude Code Max su Vercel AI Gateway | "Claude Code Max support on @vercel AI Gateway" | https://x.com/rauchg/status/2016146382932083160 |
| mar 2026 | npx plugins add Vercel | "Install the Vercel plugin for your favorite coding agent. There's no step two. You just gave Claude Code and Cursor production deployment superpowers. Running npx plugins add gets you every Skill and keeps them updated." | https://x.com/rauchg/status/2034095862406901772 |
| apr 2026 | Agentic Infrastructure | "Agentic Infrastructure is the future of the cloud. For coding agents: if you use Claude Code, Codex, Cursor, you need infra that clicks for your agents, not just devs. To deploy agents Pages -> Agents. Long-running compute, sandboxes…" | https://x.com/rauchg/status/2042358253510963384 |

---

## @swyx — Shawn Wang (developer ecosystem)

| Data | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| feb 2026 | CC come base di Cowork | "Terminals : LaTex :: AI for Coding : AI for Science. when Claude Code started it was just a humble CLI side project. today it forms the basis for Claude Cowork, a general purpose non-coding desktop agent." | https://x.com/swyx/status/2016258918297829719 |
| feb 2026 | Cowork = harness su CC su Opus | "CLAUDE COWORK IS A HARNESS ON TOP OF CLAUDE CODE IS A HARNESS ON TOP OF CLAUDE OPUS. i'm working on the @aidotengineer website today. need to go Figma -> Website in 1 easy step." | https://x.com/swyx/status/2017482739285684708 |
| feb 2026 | CC anniversario | "Guys - it's Claude Code's actual first birthday today - Feb 24 2025 was the launch… am i crazy or is @latentspacepod the only one doing a retrospective + anniversary pod today? did everyone just forget the most consequential AI product since ChatGPT?" | https://x.com/swyx/status/2026462001933988094 |

---

## @transitive_bs — Travis Fischer (community)

| Data | Feature/Topic | Citazione/sintesi | URL |
|---|---|---|---|
| dic 2025 | Setup Boris: 5 git clones | "creator of claude code uses 5 separate git clones to work in parallel (separate directory checkouts, not git worktrees)" | https://x.com/transitive_bs/status/2007687241636987373 |

---

## Sintesi nuove feature emerse (non coperte nei dossier base)

### /btw - side-chain conversations
Comando nuovo (lanciato mar 2026 da Thariq): permette domande/conversazioni laterali mentre l'agente sta lavorando, senza interrompere il flusso principale. Fonti: https://x.com/trq212/status/2031506296697131352 ; https://x.com/bcherny/status/2038454351849787485

### /batch - fan-out massivo a worktree
Skill che intervista l'utente e poi distribuisce il lavoro a centinaia/migliaia di worktree agents in parallelo. Pensata per code migration e change set parallelizzabili. Fonte: https://x.com/bcherny/status/2038454355469484142

### claude --worktree / built-in worktree
Supporto worktree integrato direttamente in CLI Claude Code (febbraio 2026): isolamento sessioni, naming auto, subagent worktree per migrazioni. Fonti: https://x.com/bcherny/status/2025007393290272904 ; https://x.com/bcherny/status/2025007394967957720 ; https://x.com/bcherny/status/2025007398537380028

### Teams / Agent Swarms
Modalita' sperimentale "Agent Swarms" lanciata feb 2026 — alto consumo token, abilitazione via docs. Fonte: https://x.com/bcherny/status/2019472394696683904

### --agent flag e .claude/agents
Custom agent attivabile da CLI con `claude --agent=<name>`, configurazione via .md in `.claude/agents` (nome, color, tool set, allow/disallow, permission mode, modello). Fonti: https://x.com/bcherny/status/2021700144039903699 ; https://x.com/bcherny/status/2038454360418787764

### --add-dir / /add-dir cross-repo
Da' a Claude accesso e permessi su cartelle/repo aggiuntivi durante la sessione corrente. Fonte: https://x.com/bcherny/status/2038454359047156203

### Async hooks (async: true)
Hook eseguibili in background senza bloccare l'esecuzione di Claude. Per logging/notifiche/side-effect. Fonte: https://x.com/bcherny/status/2015524460481388760

### PermissionDenied hook (2.1.88)
Nuovo hook che fa fire dopo i deny dell'auto-mode classifier; supporta `{retry: true}` per ritentare. Fonte: https://x.com/ClaudeCodeLog/status/2038773107129749617

### CLAUDE_CODE_NO_FLICKER=1
Env var per rendering alt-screen flicker-free con virtualized scrollback. Fonte: https://x.com/ClaudeCodeLog/status/2038773107129749617

### Memory tightening (2.1.79/2.1.80)
System prompt aggiornato: memory do-not-save rules enforced anche su richiesta esplicita; memorie storiche da verificare contro file/risorse correnti prima di assumere. Fonti: https://x.com/ClaudeCodeLog/status/2034402575634612594 ; https://x.com/ClaudeCodeLog/status/2034759402796818648

### Default effort change (2.1.94)
Default effort innalzato da medium a high per API-key, Bedrock/Vertex/Foundry, Team and Enterprise. Fonte: https://x.com/ClaudeCodeLog/status/2041633784836038757

### Forked subagents (2.1.117)
Abilitazione subagent forked via env var; agent frontmatter `mcpServers` caricabile via flag; `/resume` summarize per sessioni grandi. Fonte: https://x.com/ClaudeCodeLog/status/2046745562507071790

### /effort max, /effort xhigh, --effort flag
Differenziazione: Ultrathink = max effort per un solo turno; `/effort max` (= `claude --effort=max`) = max effort per tutta la conversazione. Opus 4.7 introduce livello xhigh tra high e max. Fonti: https://x.com/bcherny/status/2032672929733861501 ; https://x.com/bcherny/status/2044847856872546639

### Cowork scheduled tasks / Projects / Computer use Windows / Cowork GA
Estensione di Cowork con scheduled tasks ricorrenti, Projects, computer use cross-platform e GA su tutti i piani paid. Fonti: https://x.com/claudeai/status/2026720870631354429 ; https://x.com/claudeai/status/2035025492617961704 ; https://x.com/claudeai/status/2039836891508261106 ; https://x.com/claudeai/status/2042273755485888810

### TurboTax connector (apr 2026)
Connector ufficiale TurboTax annunciato in modo informale da @trq212. Fonte: https://x.com/trq212/status/2043138221836746762

### Computer use in CC (mar 2026)
Computer use disponibile in research preview in Claude Code (CLI), macOS prima, poi Windows; controlla apps, browser, spreadsheets. Fonti: https://x.com/claudeai/status/2036195789601374705 ; https://x.com/claudeai/status/2038663014098899416 ; https://x.com/claudeai/status/2039836891508261106

### Sonnet 4.6 in Claude Code
Sonnet 4.6 disponibile in CC + Cowork + API + free tier upgraded; 1M context in beta. Fonti: https://x.com/claudeai/status/2023817132581208353 ; https://x.com/claudeai/status/2023817147303292948

### /buddy (April Fools)
Easter egg April Fools 2026: 5 rarita' x 18 specie di buddies che parlano mentre codi, gratis. Fonte: https://x.com/alistaiir/status/2039429708014829764

---

## Tip operative aggiuntive (non gia' in dossier base)

1. **Tagga @claude nelle PR review** per aggiungere appunti a CLAUDE.md (via Github action `/install-github-action`) - pattern Anthropic interno (Boris Tip 5). https://x.com/bcherny/status/2007179842928947333
2. **Subagent dedicati ricorrenti**: `code-simplifier`, `verify-app`, ecc. - automatizzano workflow ripetitivi (Boris Tip 8). https://x.com/bcherny/status/2007179850139000872
3. **Background verification per long-running**: Stop hook + ralph-wiggum plugin (Geoffrey Huntley) per loop iterativi fino a done (Boris Tip 12). https://x.com/bcherny/status/2007179858435281082
4. **Slack MCP + bq CLI + Sentry MCP** committati in `.mcp.json` per condividere strumenti col team (Boris Tip 11). https://x.com/bcherny/status/2007179856266789204
5. **/keybindings**: ogni binding e' rimappabile, settings live reload (Boris Tip 8 hidden). https://x.com/bcherny/status/2021700883873165435
6. **Status line custom** (`/statusline`) per mostrare model/dir/cost/context - ognuno nel team CC ne ha una diversa (Boris Tip 7 hidden). https://x.com/bcherny/status/2021700784019452195
7. **settings.json checked in git** - codebase, sub-folder, personale, enterprise-wide (Boris Tip 12 hidden). https://x.com/bcherny/status/2021701636075458648
8. **Spec-based dev**: prompt minimale + AskUserQuestionTool per intervistare l'utente, poi nuova sessione per esecuzione (Thariq). https://x.com/trq212/status/2005315275026260309
9. **code-simplifier plugin open source** installabile via `claude plugin install code-simplifier` o `/plugin install code-simplifier`. https://x.com/bcherny/status/2009450715081789767
10. **5 git clones invece di worktrees**: il setup vanilla di Boris contraddice il consiglio del team (worktrees) - entrambi i pattern funzionano. https://x.com/transitive_bs/status/2007687241636987373
11. **CC dietro Vercel AI Gateway** via `ANTHROPIC_BASE_URL` per failover su Bedrock e governance spend. https://x.com/rauchg/status/2007556249437778419
12. **npx plugins add** (Vercel) installa skill + tiene aggiornati i plugin. https://x.com/rauchg/status/2034095862406901772
13. **--add-dir cross-repo**: una sola sessione CC vede piu' repository contemporaneamente. https://x.com/bcherny/status/2038454359047156203
14. **/btw per side queries** mentre l'agente principale lavora - non interrompe il flow. https://x.com/trq212/status/2031506296697131352
15. **/batch per migrazioni massive**: fanout a centinaia/migliaia di worktree agents. https://x.com/bcherny/status/2038454355469484142

---

## Note metodologiche

- Tutti i contenuti raccolti via Google `site:x.com` (WebFetch x.com -> 402, nitter.net non disponibile).
- Citazioni testuali tra virgolette quando presenti integralmente nello snippet di ricerca.
- Date approssimate inferite da snowflake ID Twitter; in caso di precisione richiesta, consultare l'URL.
- Account `@ManuelOdendahl` e `@theburningmonk`: WebSearch non ha restituito risultati pertinenti su Claude Code nel periodo nov 2025-apr 2026 -> **non accessibili via WebSearch**.
- Account `@ZachMueller`, `@swarooph`: non emersi via WebSearch con query mirate -> **non accessibili via WebSearch**.
- Conteggio nuovi post unici (non duplicati rispetto ai dossier base): 33 bcherny + 1 catwu + 1 noahzweben + 11 trq212 + 13 ClaudeCodeLog + 2 alistaiir + 7 claudeai + 4 rauchg + 3 swyx + 1 transitive_bs = **76 post nuovi**, ben oltre i 50 richiesti.
