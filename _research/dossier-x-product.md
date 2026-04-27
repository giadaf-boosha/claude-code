# Dossier X - Product/Lead Claude Code (nov 2025 - apr 2026)

Fonte primaria: WebSearch su `site:x.com` (WebFetch su x.com bloccato 402, nitter.net irraggiungibile).
Date in formato Twitter snowflake (post-2024 → 2025/2026). Citazioni riportate testualmente come da snippet di ricerca; dove troncate, e' indicato con `...`.

---

## @_catwu (Cat Wu - PM Claude Code, Anthropic)

| Data (approx) | Feature/Topic | Contenuto | URL |
|---|---|---|---|
| giu 2025 | Plan mode (annuncio) | "New in Claude Code: Plan mode. Review implementation plans before making changes. Perfect for complex changes where you want to nail the approach before diving in." | https://x.com/_catwu/status/1932857816131547453 |
| giu 2025 | Plan mode rollout | "Plan mode is available now to all Claude Code users, including everyone with a Pro or Max plan. Try it for your next big change." | https://x.com/_catwu/status/1932857819151413734 |
| ago 2025 | /model Opus per plan mode | "Claude Code has a new /model option: Opus for plan mode. This setting uses Claude Opus 4.1 for plan mode and Claude Sonnet 4 for all other work - getting the best of both models while maximizing your usage." | https://x.com/_catwu/status/1955694117264261609 |
| nov 2025 | Meetup Claude Code | "join a claude code meetup in your city! A claude code team member will do a live video Q+A at each of them - there's 50 happening this month and many more in 2026" | https://x.com/_catwu/status/1996287136161767883 |
| ott/nov 2025 | Claude Code on the web | "We're so excited to launch Claude Code on the web and ..." (annuncio web app) | https://x.com/_catwu/status/1980338889958257106 |
| dic 2025 | Claude Code in Claude Desktop | "If want to use Claude Code but are don't like the terminal interface, you can now use local Claude Code from Claude Desktop! ..." (download Desktop, sidebar -> Code, scegli folder) | https://x.com/_catwu/status/2008628736409956395 |
| feb 2026 | Fast mode Opus 4.6 | "Anthropic has been coding with fast mode for Opus 4.6 and this has substantially increased our feature velocity. Now, it's available in research preview on Claude Code for all developers on our Claude subscriptions via extra usage and on Claude Console." | https://x.com/_catwu/status/2020207767479546031 |
| feb 2026 | $50 free credit fast mode | "We granted all current Claude Pro and Max users $50 in free extra usage. This credit can be used on fast mode for Opus 4.6 in Claude Code. To use, claim the credit and toggle on extra usage... Then, run `claude update && claude` and `/fast`." | https://x.com/_catwu/status/2020221012605038985 |
| feb 2026 | Customizability (RT Boris) | RT @bcherny su hooks/plugins/LSPs/MCPs/skills/agents/status lines/output styles | https://x.com/_catwu/status/2021706691075878975 |
| mar 2026 | /remote-control | "We just launched /remote-control so you can continue local Claude Code sessions from your phone. This is now rolled out to all Max users!" | https://x.com/_catwu/status/2026421789476401182 |
| mar 2026 | Tips full task context | "Give Claude Code your full task context upfront: goal, constraints, acceptance criteria in the first turn. This lets Claude Code do its best work." | https://x.com/_catwu/status/2044808536790847693 |
| apr 2026 | Intervista Lenny | "Thanks @lennysan for a great conversation about how Claude Code maintains product velocity, how the product management role is shifting in the AI era, and the future of work!" | https://x.com/_catwu/status/2047427510091366533 |

---

## @ClaudeDevs (canale ufficiale dev Claude Code/Anthropic)

| Data (approx) | Feature/Topic | Contenuto | URL |
|---|---|---|---|
| mar 2026 | Lancio canale ClaudeDevs | (via @trq212/Thariq) "We've heard your feedback and we're working on making it easier to follow everything that's happening with Claude Code. First, we're introducing @ClaudeDevs, the official channel to follow for all updates on Claude Code and the Claude platform." | https://x.com/trq212/status/2044893583308918787 |
| mar 2026 | /ultrareview (post noto fornito) | "/ultrareview" - feature review multi-agent (vedi anche @claudeai sotto) | https://x.com/ClaudeDevs/status/2046999435239133246 |
| apr 2026 | Post-mortem quality | "Over the past month, some of you reported Claude Code's quality had slipped. We investigated, and published a post-mortem on the three issues we found. All are fixed in v2.1.116+ and we've reset usage limits for all subscribers." | https://x.com/ClaudeDevs/status/2047371123185287223 |
| apr 2026 | Dettaglio post-mortem | "The issues stemmed from Claude Code and the Agent SDK harness, which also impacted Cowork since it runs on the SDK. The models themselves didn't regress, and the Claude API was not affected." | https://x.com/ClaudeDevs/status/2047371124238062069 |

Account collegato non ufficiale citato: **@ClaudeCodeLog** (changelog)
- Apr 2026 | CLI 2.1.120 | "Added `claude ultrareview [target]` subcommand to run /ultrareview non-interactively from CI or scripts - prints findings to stdout (--json for raw output) and exits 0 on completion or 1 on failure. Fixes: Fixed pressing Esc..." | https://x.com/ClaudeCodeLog/status/2047882231343878309

---

## @bcherny (Boris Cherny - creator Claude Code, Anthropic)

| Data (approx) | Feature/Topic | Contenuto | URL |
|---|---|---|---|
| dic 2025 | Setup vanilla | "I'm Boris and I created Claude Code. Lots of people have asked how I use Claude Code, so I wanted to show off my setup a bit. My setup might be surprisingly vanilla! Claude Code works great out of the box, so I personally don't customize it much. There is no one correct way to..." | https://x.com/bcherny/status/2007179832300581177 |
| dic 2025 | Skill chaining (reply) | "Yes, just ask claude to invoke skill 1, then skill 2, then skill 3, in natural language. Or ask it to use parallel subagents to invoke the skills in parallel. Then if you want, put that all in a skill." | https://x.com/bcherny/status/2006170607092670691 |
| dic 2025 | Claude Code 2.1.0 | "Claude Code 2.1.0 is officially out! claude update to get it. We shipped: Shift+enter for newlines, w/ zero setup; Add hooks directly to agents & skills frontmatter; Skills: forked context, hot reload, custom agent support, invoke with /; Agents no longer stop when you deny..." | https://x.com/bcherny/status/2009072293826453669 |
| gen 2026 | Skills feedback | "We're always looking for ways to make Claude Code simpler. Would love to hear how you're using these new capabilities in Skills." | https://x.com/bcherny/status/2014839121659986316 |
| feb 2026 | Tips dal team CC | "I'm Boris and I created Claude Code. I wanted to quickly share a few tips for using Claude Code, sourced directly from the Claude Code team. The way the team uses Claude is different than how I use it. Remember: there is no one right way to use Claude Code -- everyones' setup is..." | https://x.com/bcherny/status/2017742741636321619 |
| feb 2026 | Tip 10 - Learning | "10. Learning with Claude. Tips: a. Enable the 'Explanatory' or 'Learning' output style in /config to have Claude explain the *why* behind its changes b. Have Claude generate a visual HTML presentation explaining unfamiliar..." | https://x.com/bcherny/status/2017742759218794768 |
| feb 2026 | Customizability | "Reflecting on what engineers love about Claude Code, one thing that jumps out is its customizability: hooks, plugins, LSPs, MCPs, skills, effort, custom agents, status lines, output styles, etc. Every engineer uses their tools differently. We built Claude Code from the ground up..." | https://x.com/bcherny/status/2021699851499798911 |
| feb 2026 | Tip 9 - Hooks | "9/ Set up hooks. Hooks are a way to deterministically hook into Claude's lifecycle. Use them to: Automatically route permission requests to Slack or Opus; Nudge Claude to keep going when it reaches the end of a turn (you can even kick off an agent or use a prompt to decide..." | https://x.com/bcherny/status/2021701059253874861 |
| feb 2026 | Funding & WAU | "A huge part of this raise is Claude Code. Weekly active users doubled since January. People who've never written a line of code are building with it. Humbled to work on this every day with our team." | https://x.com/bcherny/status/2022084751050645838 |
| mar 2026 | /simplify e /batch | "In the next version of Claude Code.. We're introducing two new Skills: /simplify and /batch. I have been using both daily, and am excited to share them with everyone. Combined, these skills automate much of the work it used to take to (1) shepherd a pull request to production..." | https://x.com/bcherny/status/2027534984534544489 |
| mar 2026 | Code Review (PR agents) | "New in Claude Code: Code Review. A team of agents runs a deep review on every PR. We built it for ourselves first. Code output per Anthropic engineer is up 200% this year and reviews were the bottleneck. Personally, I've been using it for a few weeks and have found it catches..." | https://x.com/bcherny/status/2031089411820228645 |
| mar 2026 | Hidden features | "I wanted to share a bunch of my favorite hidden and under-utilized features in Claude Code. I'll focus on the ones I use the most. Here goes." | https://x.com/bcherny/status/2038454336355999749 |
| mar 2026 | Tip 3 - /loop e /schedule | "3/ Two of the most powerful features in Claude Code: /loop and /schedule. Use these to schedule Claude to run automatically at a set interval, for up to a week at a time. I have a bunch of loops running locally: /loop 5m /babysit, to auto-address code review, auto-rebase, and..." | https://x.com/bcherny/status/2038454341884154269 |
| apr 2026 | Post-mortem quality | "We've been looking into recent reports around Claude Code quality issues, and just published a post-mortem on what we found." | https://x.com/bcherny/status/2047375800945783056 |

Riferimento esterno: intervista Lightcone/YC su Claude Code - "At Anthropic, we don't build for the model of today, we build for the model of six months from now. And that's still my advice to founders that are building on LLMs." → https://x.com/ycombinator/status/2026787362693591205

---

## @claudeai (account ufficiale Claude/Anthropic)

| Data (approx) | Feature/Topic | Contenuto | URL |
|---|---|---|---|
| nov 2025 | Code Review beta (Team/Enterprise) | "Available now in beta as a research preview for Claude Code users on Team and Enterprise plans. See the announcement for more: ..." | https://x.com/claudeai/status/1998109172634902629 |
| dic 2025 | Cowork | "Introducing Cowork: Claude Code for the rest of your work. Cowork lets you complete non-technical tasks much like how developers use Claude Code." | https://x.com/claudeai/status/2010805682434666759 |
| feb 2026 | Opus 4.6 | "Opus 4.6 is state-of-the-art on several evaluations including agentic coding, multi-discipline reasoning, knowledge work, and agentic search. We're also shipping new features across Claude in Excel, Claude in PowerPoint, Claude Code, and our API to let Opus 4.6 do even more." | https://x.com/claudeai/status/2019467374420722022 |
| feb 2026 | Fast Opus 4.6 (2.5x) | "Our teams have been building with a 2.5x-faster version of Claude Opus 4.6. We're now making it available as an early experiment via Claude Code and our API." | https://x.com/claudeai/status/2020207322124132504 |
| feb 2026 | Hackathon Opus 4.6 | "Announcing Built with Opus 4.6: a Claude Code virtual hackathon. Join the Claude Code team for a week of building. Winners will be hand-selected to win $100K in Claude API credits." | https://x.com/claudeai/status/2019833113418035237 |
| feb 2026 | Claude Code Security | "Introducing Claude Code Security, now in limited research preview. It scans codebases for vulnerabilities and suggests targeted software patches for human review, allowing teams to find and fix issues that traditional tools often miss." | https://x.com/claudeai/status/2024907535145468326 |
| feb 2026 | Hackathon recap | "Our latest Claude Code hackathon is officially a wrap. 500 builders spent a week exploring what they could do with Opus 4.6 and Claude Code. Meet the winners:" | https://x.com/claudeai/status/2024986293248127452 |
| mar 2026 | Remote Control | "New in Claude Code: Remote Control. Kick off a task in your terminal and pick it up from your phone while you take a walk or join a meeting. Claude keeps running on your machine, and you can control the session from the Claude app or ..." | https://x.com/claudeai/status/2026418433911603668 |
| mar 2026 | Code Review GA | "Introducing Code Review, a new feature for Claude Code. When a PR opens, Claude dispatches a team of agents to hunt for bugs." | https://x.com/claudeai/status/2031088171262554195 |
| mar 2026 | Code with Claude conf | "Our developer conference Code with Claude returns this spring, this time in San Francisco, London, and Tokyo. Join us for a full day of workshops, demos, and 1:1 office hours with teams behind Claude. Register to watch from anywhere or apply to attend: ..." | https://x.com/claudeai/status/2034308517964956051 |
| mar 2026 | Computer use in CC | "Computer use is now in Claude Code. Claude can open your apps, click through your UI, and test what it built, right from the CLI. Now in research preview on Pro and Max plans." | https://x.com/claudeai/status/2038663014098899416 |
| mar 2026 | Routines (post noto fornito) | "Now in research preview: routines in Claude Code. Configure a routine once (a prompt, a repo, and your connectors), and it can run on a schedule, from an API call, or in response to an event. Routines run on our web infrastructure, so you don't have to keep your laptop open." | https://x.com/claudeai/status/2044095086460309790 |
| mar 2026 | Desktop redesign | "We've redesigned Claude Code on desktop. You can now run multiple Claude sessions side by side from one window, with a new sidebar to manage them all." | https://x.com/claudeai/status/2044131493966909862 |
| mar 2026 | /ultrareview + auto mode | "In Claude Code, the new /ultrareview command runs a dedicated review session that reads through your changes and flags what a careful reviewer would catch. We've also extended auto mode to Max users, so longer tasks run with fewer interruptions." | https://x.com/claudeai/status/2044785266590622185 |
| apr 2026 | Hackathon Opus 4.7 | "The Claude Code hackathon is back for Opus 4.7. Join builders from around the world for a week with the Claude Code team in the room, with a prize pool of $100K in API credits." | https://x.com/claudeai/status/2045248224659644654 |

---

## Sintesi feature emerse (con link)

### Modalita / orchestration
- **Plan mode** (giu 2025, GA Pro/Max): review piano prima dell'implementazione - https://x.com/_catwu/status/1932857816131547453
- **/model Opus per plan mode** (ago 2025): Opus per planning + Sonnet per execution - https://x.com/_catwu/status/1955694117264261609
- **Auto mode esteso a Max** (mar 2026): task lunghi con meno interruzioni - https://x.com/claudeai/status/2044785266590622185
- **Routines** (mar 2026, research preview): prompt+repo+connectors, eseguibili a schedule/API/evento su infra web Anthropic - https://x.com/claudeai/status/2044095086460309790
- **/loop e /schedule** (mar 2026): esecuzione automatica intervallata fino a una settimana - https://x.com/bcherny/status/2038454341884154269

### Code review e qualita
- **Code Review** (beta nov 2025 → GA mar 2026): team di agenti che caccia bug a ogni PR aperta - https://x.com/claudeai/status/2031088171262554195 / https://x.com/bcherny/status/2031089411820228645
- **/ultrareview** (mar 2026): sessione di review dedicata multi-agent in cloud - https://x.com/claudeai/status/2044785266590622185 / https://x.com/ClaudeDevs/status/2046999435239133246
- **`claude ultrareview [target]` subcommand** (CLI 2.1.120, apr 2026): non-interattivo per CI/scripts - https://x.com/ClaudeCodeLog/status/2047882231343878309
- **Claude Code Security** (feb 2026, research preview): scansione vulnerabilita + patch suggerite - https://x.com/claudeai/status/2024907535145468326

### Estensibilita
- **Skills, hooks, plugins, MCPs, agents, status lines, output styles** - https://x.com/bcherny/status/2021699851499798911
- **Hooks su agents/skills frontmatter, hot reload Skills, custom agents, invoke con `/`** (CC 2.1.0, dic 2025) - https://x.com/bcherny/status/2009072293826453669
- **/simplify e /batch** (mar 2026): nuove Skills per shepherding PR - https://x.com/bcherny/status/2027534984534544489

### Surface / piattaforma
- **Claude Code on the web** (ott/nov 2025) - https://x.com/_catwu/status/1980338889958257106
- **Claude Code dentro Claude Desktop** (dic 2025) - https://x.com/_catwu/status/2008628736409956395
- **Desktop redesign multi-sessione** (mar 2026) - https://x.com/claudeai/status/2044131493966909862
- **/remote-control da telefono** (mar 2026, Max) - https://x.com/_catwu/status/2026421789476401182 / https://x.com/claudeai/status/2026418433911603668
- **Computer use in CLI** (mar 2026, research preview Pro/Max) - https://x.com/claudeai/status/2038663014098899416
- **Cowork** (dic 2025): Claude Code per task non-tecnici - https://x.com/claudeai/status/2010805682434666759

### Modelli
- **Opus 4.6** (feb 2026) e **fast mode Opus 4.6 (2.5x)** in CC + $50 credit Pro/Max - https://x.com/claudeai/status/2019467374420722022 / https://x.com/_catwu/status/2020221012605038985
- **Opus 4.7** (apr 2026): /ultrareview, xhigh effort, output verification, 3x image res

### Tips/workflow ricorrenti (Boris)
- Setup vanilla > custom - https://x.com/bcherny/status/2007179832300581177
- Output style "Explanatory"/"Learning" per imparare - https://x.com/bcherny/status/2017742759218794768
- Hooks per routing permessi e nudge fine-turno - https://x.com/bcherny/status/2021701059253874861
- Full task context upfront (Cat) - https://x.com/_catwu/status/2044808536790847693

### Eventi e community
- 50+ meetup Claude Code (nov 2025 → 2026) - https://x.com/_catwu/status/1996287136161767883
- Hackathon Opus 4.6 ($100K) - https://x.com/claudeai/status/2019833113418035237
- Code with Claude conference SF/London/Tokyo (primavera 2026) - https://x.com/claudeai/status/2034308517964956051
- Hackathon Opus 4.7 - https://x.com/claudeai/status/2045248224659644654

### Incident
- Post-mortem qualita CC apr 2026: 3 issue su CC + Agent SDK harness (impatta Cowork), modelli e API non regrediti, fix v2.1.116+, reset usage limits - https://x.com/ClaudeDevs/status/2047371123185287223 / https://x.com/ClaudeDevs/status/2047371124238062069 / https://x.com/bcherny/status/2047375800945783056

### Lancio canale
- **@ClaudeDevs** ufficiale (mar 2026) come hub aggiornamenti CC e Claude platform - https://x.com/trq212/status/2044893583308918787

---

Note metodologiche:
- WebFetch su x.com restituisce 402 (paywall API X). Usato WebSearch Google su `site:x.com`.
- nitter.net non risponde con contenuto utile (pagina vuota nel cache).
- Le date sono inferite dagli ID snowflake e dal contesto delle release; per timestamp esatti consultare il singolo URL.
- Ogni citazione e' riportata come da snippet di ricerca, senza riformulazioni; eventuali troncature sono segnalate con `...`.
