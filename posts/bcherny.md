# @bcherny — Boris Cherny

Boris Cherny, creator di Claude Code (Anthropic). Profilo: https://x.com/bcherny.

I post coprono setup vanilla, thread di tip dettagliati ("Hidden features", "Tips dal team CC"), drop di feature, considerazioni di prodotto.

---

## Cronologia per macro-tema

### Setup e workflow personale (dic 2025)

**Setup vanilla**
"I'm Boris and I created Claude Code. Lots of people have asked how I use Claude Code, so I wanted to show off my setup a bit. My setup might be surprisingly vanilla! Claude Code works great out of the box, so I personally don't customize it much. There is no one correct way to..."
URL: https://x.com/bcherny/status/2007179832300581177

**Tip 5 — `@claude` su PR per CLAUDE.md**
"5/ During code review, I will often tag @.claude on my coworkers' PRs to add something to the CLAUDE.md as part of the PR. We use the Claude Code Github action (/install-github-action) for this. It's our version of @danshipper's Compounding Engineering"
URL: https://x.com/bcherny/status/2007179842928947333

**Tip 8 — Subagent ricorrenti**
"8/ I use a few subagents regularly: code-simplifier simplifies the code after Claude is done working, verify-app has detailed instructions for testing Claude Code end to end, and so on. Similar to slash commands, I think of subagents as automating the most common workflows..."
URL: https://x.com/bcherny/status/2007179850139000872

**Tip 11 — Strumenti via MCP/CLI**
"11/ Claude Code uses all my tools for me. It often searches and posts to Slack (via the MCP server), runs BigQuery queries to answer analytics questions (using bq CLI), grabs error logs from Sentry, etc. The Slack MCP configuration is checked into our .mcp.json..."
URL: https://x.com/bcherny/status/2007179856266789204

**Tip 12 — Long-running con verifica**
"12/ For very long-running tasks, I will either (a) prompt Claude to verify its work with a background agent when it's done, (b) use an agent Stop hook to do that more deterministically, or (c) use the ralph-wiggum plugin (originally dreamt up by @GeoffreyHuntley)."
URL: https://x.com/bcherny/status/2007179858435281082

**Tip 13 — Feedback loop di verifica**
"13/ A final tip: probably the most important thing to get great results out of Claude Code -- give Claude a way to verify its work. If Claude has that feedback loop, it will 2-3x the quality of the final result."
URL: https://x.com/bcherny/status/2007179861115511237

**Skill chaining (reply)**
"Yes, just ask claude to invoke skill 1, then skill 2, then skill 3, in natural language. Or ask it to use parallel subagents to invoke the skills in parallel. Then if you want, put that all in a skill."
URL: https://x.com/bcherny/status/2006170607092670691

### Claude Code 2.1 (dic 2025)

**Claude Code 2.1.0 release**
"Claude Code 2.1.0 is officially out! claude update to get it. We shipped: Shift+enter for newlines, w/ zero setup; Add hooks directly to agents & skills frontmatter; Skills: forked context, hot reload, custom agent support, invoke with /; Agents no longer stop when you deny..."
URL: https://x.com/bcherny/status/2009072293826453669

**code-simplifier open source**
"We just open sourced the code-simplifier agent we use on the Claude Code team. Try it: claude plugin install code-simplifier... Ask Claude to use the code simplifier"
URL: https://x.com/bcherny/status/2009450715081789767

**Async hooks**
"Hooks can now run in the background without blocking Claude Code's execution. Just add async: true to your hook config. Great for logging, notifications, or any side-effect that shouldn't slow things down."
URL: https://x.com/bcherny/status/2015524460481388760

### Tip thread "Tips dal team CC" (gen-feb 2026)

**Apertura thread**
"I'm Boris and I created Claude Code. I wanted to quickly share a few tips for using Claude Code, sourced directly from the Claude Code team. The way the team uses Claude is different than how I use it. Remember: there is no one right way to use Claude Code -- everyones' setup is..."
URL: https://x.com/bcherny/status/2017742741636321619

**Tip 1 — Parallel worktrees**
"1. Do more in parallel. Spin up 3–5 git worktrees at once, each running its own Claude session in parallel. It's the single biggest productivity unlock, and the top tip from the team."
URL: https://x.com/bcherny/status/2017742743125299476

**Tip 9 — Claude per analytics**
"9. Use Claude for data and analytics. Ask Claude Code to use the bq CLI to pull and analyze metrics on the fly. We have a BigQuery skill checked into the codebase, and everyone on the team uses it for analytics queries directly in Claude Code."
URL: https://x.com/bcherny/status/2017742757666902374

**Tip 10 — Output style "Explanatory"/"Learning"**
"10. Learning with Claude. Tips: a. Enable the 'Explanatory' or 'Learning' output style in /config to have Claude explain the *why* behind its changes b. Have Claude generate a visual HTML presentation explaining unfamiliar..."
URL: https://x.com/bcherny/status/2017742759218794768

**Reply a Karpathy — generalisti**
"I think the Claude Code team itself might be an indicator of where things are headed. We have directional answers for some (not all) of the prompts: 1. We hire mostly generalists. We have a mix of senior..."
URL: https://x.com/bcherny/status/2015979257038831967

### Customizability + Hidden tips (feb 2026)

**Customizability**
"Reflecting on what engineers love about Claude Code, one thing that jumps out is its customizability: hooks, plugins, LSPs, MCPs, skills, effort, custom agents, status lines, output styles, etc. Every engineer uses their tools differently."
URL: https://x.com/bcherny/status/2021699851499798911

**Tip 4 — Custom agents**
"4/ Create custom agents. To create custom agents, drop .md files in .claude/agents. Each agent can have a custom name, color, tool set, pre-allowed and pre-disallowed tools, permission mode, and model."
URL: https://x.com/bcherny/status/2021700144039903699

**Tip 7 — Status line custom**
"7/ Add a status line. Custom status lines show up right below the composer, and let you show model, directory, remaining context, cost, and pretty much anything else you want to see while you work. Everyone on the Claude Code team has a different statusline. Use /statusline..."
URL: https://x.com/bcherny/status/2021700784019452195

**Tip 8 — Keybindings custom**
"8/ Customize your keybindings. Did you know every key binding in Claude Code is customizable? /keybindings to re-map any key. Settings live reload so you can see how it feels immediately"
URL: https://x.com/bcherny/status/2021700883873165435

**Tip 9 — Hooks (Slack/Opus routing)**
"9/ Set up hooks. Hooks are a way to deterministically hook into Claude's lifecycle. Use them to: Automatically route permission requests to Slack or Opus; Nudge Claude to keep going when it reaches the end of a turn..."
URL: https://x.com/bcherny/status/2021701059253874861

**Tip 12 — settings.json in git**
"12/ Customize all the things! Claude Code is built to work great out of the box. When you do customize, check your settings.json into git so your team can benefit, too. We support configuring for your codebase, for a sub-folder, for just yourself, or via enterprise-wide..."
URL: https://x.com/bcherny/status/2021701636075458648

**Funding & WAU**
"A huge part of this raise is Claude Code. Weekly active users doubled since January. People who've never written a line of code are building with it. Humbled to work on this every day with our team."
URL: https://x.com/bcherny/status/2022084751050645838

**Engineering vs commodity**
"Someone has to prompt the Claudes, talk to customers, coordinate with other teams, decide what to build next. Engineering is changing and great engineers are more important than ever."
URL: https://x.com/bcherny/status/2022762422302576970

### Worktree e Teams (feb 2026)

**Built-in worktree support**
"Introducing: built-in git worktree support for Claude Code. Now, agents can run in parallel without interfering with one other. Each agent gets its own worktree and can work independently."
URL: https://x.com/bcherny/status/2025007393290272904

**`claude --worktree`**
"1/ Use claude --worktree for isolation. To run Claude Code in its own git worktree, just start it with the --worktree option. You can also name your worktree, or have Claude name it for you."
URL: https://x.com/bcherny/status/2025007394967957720

**Subagent worktrees**
"3/ Subagents now support worktrees. Subagents can also use worktree isolation to do more work in parallel. This is especially powerful for large batched changes and code migrations. To use it, ask Claude to use worktrees for its agents."
URL: https://x.com/bcherny/status/2025007398537380028

**Teams / Agent Swarms**
"Out now: Teams, aka. Agent Swarms in Claude Code. Team are experimental, and use a lot of tokens. See the docs for how to enable, and let us know what you think!"
URL: https://x.com/bcherny/status/2019472394696683904

**Lancio fast mode Opus 4.6**
"We just launched an experimental new fast mode for Opus 4.6. The team has been building with it for the last few weeks. It's been a huge unlock for me personally, especially when going back and forth with Claude on a tricky problem."
URL: https://x.com/bcherny/status/2020223254297031110

### Skills, /simplify, /batch (mar 2026)

**Skills feedback request**
"We're always looking for ways to make Claude Code simpler. Would love to hear how you're using these new capabilities in Skills."
URL: https://x.com/bcherny/status/2014839121659986316

**`/simplify` e `/batch`**
"In the next version of Claude Code.. We're introducing two new Skills: /simplify and /batch. I have been using both daily, and am excited to share them with everyone. Combined, these skills automate much of the work it used to take to (1) shepherd a pull request to production..."
URL: https://x.com/bcherny/status/2027534984534544489

**`/simplify` uso**
"/simplify Use parallel agents to improve code quality, tune code efficiency, and ensure CLAUDE.md compliance. Usage: hey claude make this code change then run /simplify"
URL: https://x.com/bcherny/status/2027534986178662573

**Code Review (PR agents)**
"New in Claude Code: Code Review. A team of agents runs a deep review on every PR. We built it for ourselves first. Code output per Anthropic engineer is up 200% this year and reviews were the bottleneck. Personally, I've been using it for a few weeks and have found it catches..."
URL: https://x.com/bcherny/status/2031089411820228645

**Phone-to-laptop session launch**
"You can now launch Claude Code sessions on your laptop from your phone. This blew my mind the first time I tried it"
URL: https://x.com/bcherny/status/2032578639276159438

**Ultrathink vs `/effort max`**
"Ultrathink == max effort for one turn. /effort max == claude --effort=max == max effort for the rest of the conversation"
URL: https://x.com/bcherny/status/2032672929733861501

**Skills uso interno**
"We've been using skills in Claude Code extensively..." (riflessione su Skills come asset condivisi del team)
URL: https://x.com/bcherny/status/2033950823248429176

### Hidden features thread (mar 2026)

**Apertura thread**
"I wanted to share a bunch of my favorite hidden and under-utilized features in Claude Code. I'll focus on the ones I use the most. Here goes."
URL: https://x.com/bcherny/status/2038454336355999749

**Tip 3 — `/loop` e `/schedule`**
"3/ Two of the most powerful features in Claude Code: /loop and /schedule. Use these to schedule Claude to run automatically at a set interval, for up to a week at a time. I have a bunch of loops running locally: /loop 5m /babysit, to auto-address code review, auto-rebase, and..."
URL: https://x.com/bcherny/status/2038454341884154269

**Tip 6 — Chrome ext per frontend**
"6/ Use the Chrome extension for frontend work. The most important tip for using Claude Code is: give Claude a way to verify its output. Once you do that, Claude will iterate until the result is great."
URL: https://x.com/bcherny/status/2038454347156398333

**Tip 9 — `/btw` side queries**
"9/ Use /btw for side queries. I use this all the time to answer quick questions while the agent works"
URL: https://x.com/bcherny/status/2038454351849787485

**Tip 10 — Git worktrees deep**
"10/ Use git worktrees. Claude Code ships with deep support for git worktrees. Worktrees are essential for doing lots of parallel work in the same repository. I have dozens of Claudes running at all times... Use claude -w to start a new session..."
URL: https://x.com/bcherny/status/2038454353787519164

**Tip 11 — `/batch` fan-out**
"11/ Use /batch to fan out massive changesets. /batch interviews you, then has Claude fan out the work to as many worktree agents as it takes (dozens, hundreds, even thousands) to get it done. Use it for large code migrations and others kinds of parallelizable work."
URL: https://x.com/bcherny/status/2038454355469484142

**Tip 13 — `--add-dir` cross-repo**
"13/ Use --add-dir to give Claude access to more folders. When working across multiple repositories, I usually start Claude in one repo and use --add-dir (or /add-dir) to let Claude see the other repo."
URL: https://x.com/bcherny/status/2038454359047156203

**Tip 14 — `--agent` custom system prompt**
"14/ Use --agent to give Claude Code a custom system prompt and tools. Custom agents are a powerful primitive that often gets overlooked. To use it, just define a new agent in .claude/agents, then run claude --agent=<your agent's name>"
URL: https://x.com/bcherny/status/2038454360418787764

### Opus 4.7 + post-mortem (apr 2026)

**Opus 4.7 in Claude Code**
"Opus 4.7 is in Claude Code today. It's more agentic, more precise, and a lot better at long-running work. It carries context across sessions and handles ambiguity much better."
URL: https://x.com/bcherny/status/2044802532388774313

**Opus 4.7 — riflessione**
"Opus 4.7 feels more intelligent, agentic, and precise than 4.6. It took a few days for me to learn how to work with it effectively, to fully take advantage of its new capabilities."
URL: https://x.com/bcherny/status/2044822408826380440

**Tip 5 — Adaptive thinking & `/effort`**
"5/ Configure your effort level. Opus 4.7 uses adaptive thinking instead of thinking budgets. To tune the model to think more/less, we recommend tuning effort. Use lower effort for faster responses and lower token usage. Use higher effort for the most intelligence and capability."
URL: https://x.com/bcherny/status/2044847856872546639

**Post-mortem qualita'**
"We've been looking into recent reports around Claude Code quality issues, and just published a post-mortem on what we found."
URL: https://x.com/bcherny/status/2047375800945783056

---

## Riferimento esterno

Intervista Lightcone/YC su Claude Code — "At Anthropic, we don't build for the model of today, we build for the model of six months from now. And that's still my advice to founders that are building on LLMs."
URL: https://x.com/ycombinator/status/2026787362693591205
