# 21 — Guide per target user

> 📍 [README](../README.md) → [Riferimenti](../README.md#riferimenti) → **21 Guide per target user**
> 🚀 Workflow · 🟢 Beginner-friendly

> Percorsi autonomi per 8 profili: setup, comandi top, skill, workflow tipico, anti-pattern, casi d'uso flagship.
> Versione di riferimento: **CLI v2.1.119** (23 apr 2026). Modello default `claude-sonnet-4-6`, premium `claude-opus-4-7`.

## Cosa e' concettualmente

> Le guide per target user sono **harness configurations validate per persona**: ogni profilo ha una specifica combinazione di IMPACT (quale plan, quale Authority, quale Memory, quale Control flow). Servono come scorciatoia: non devi disegnare il tuo harness da zero, parti da uno standard e adattalo.

**Modello mentale**: come "Bento box" preconfezionati — ogni persona riceve un set coerente di feature, settings, comandi adatti al contesto.

**Componente harness IMPACT**: trasversale (ogni persona = stack IMPACT specifico).

**Per il deep-dive**: [00 — Harness overview](./00-harness-overview.md) per il framework, [22 — Compound engineering](./22-compound-engineering.md) per i pattern avanzati.

Indice profili:

1. [Beginner / Non-coder](#1-beginner--non-coder)
2. [Solo developer / Indie hacker](#2-solo-developer--indie-hacker)
3. [Senior backend developer (con team)](#3-senior-backend-developer-con-team)
4. [Frontend / Full-stack developer](#4-frontend--full-stack-developer)
5. [DevOps / SRE](#5-devops--sre)
6. [Tech lead / Architect](#6-tech-lead--architect)
7. [AI/ML engineer](#7-aiml-engineer)
8. [Legacy stack maintainer (RPG/AS400, COBOL, .NET classic, Java EE)](#8-legacy-stack-maintainer)

---

## 1. Beginner / Non-coder

### Profilo
Founder, product manager, vibe coder o creator senza esperienza di programmazione. Vuole prototipare landing page, micro-app, automazioni, o esplorare un'idea prima di assumere uno sviluppatore. Vincoli: budget limitato, paura di rompere qualcosa, nessuna confidenza con git/terminale.

### Plan consigliato
**Pro** — il piano d'ingresso copre Sonnet 4.6 + Opus 4.6, plan/auto mode, `/loop` e 5 routine al giorno. Sufficiente per esplorare senza spendere troppo. Upgrade a Max solo quando l'attivita' diventa quotidiana e serve fast mode / Opus 4.7.

### Setup raccomandato
- **Surface**: Desktop app (macOS / Windows) e/o **Web** (`claude.ai/code`). Evitare CLI all'inizio.
- **Sandbox**: ON (default su macOS). Vedi [`docs/04-modalita-permessi.md`](./04-modalita-permessi.md).
- **Fast mode**: NO (costo extra non giustificato).
- **Auto mode**: NO. Usare `acceptEdits` o **plan mode** per imparare cosa Claude sta per fare prima che lo faccia.

### Top 5 slash command
1. `/init` — genera CLAUDE.md base nel progetto
2. `/plan` — entra in plan mode prima di toccare file
3. `/clear` — reset sessione quando ci si perde
4. `/compact` — riassume sessioni lunghe
5. `/help` — esplora i comandi disponibili

### Top 3 skill / plugin
1. **frontend-design** — genera UI production-grade da prompt
2. **doc-coauthoring** — co-scrittura guidata di documenti / spec
3. **webapp-testing** (Playwright) — verifica visuale che la pagina funzioni

### CLAUDE.md template ridotto
```markdown
# Progetto: <nome>

## Obiettivo
Descrizione in 2 frasi di cosa stiamo costruendo e per chi.

## Stack
- HTML/CSS/JS statico (oppure Next.js, Astro, ecc.)
- Deploy: Vercel / Netlify

## Regole
- Spiega in italiano semplice cosa stai per fare prima di farlo
- Non installare dipendenze nuove senza chiedermi
- Mostrami sempre un'anteprima prima di salvare
- Niente codice "intelligente": preferisci leggibilita'
```

### Workflow tipico
1. **Mattina**: apri Desktop app, descrivi in italiano l'obiettivo della giornata
2. Lascia Claude entrare in plan mode (`/plan`) e leggi il piano
3. Approva step-by-step, accetta i diff uno alla volta
4. **Pomeriggio**: chiedi un'anteprima locale (`npm run dev` lanciato da Claude)
5. Verifica visuale con la skill `webapp-testing`
6. Chiedi a Claude di fare commit con messaggio descrittivo
7. Deploy tramite skill / MCP Vercel se configurato
8. `/compact` a fine giornata e chiusura sessione

### Caso d'uso flagship
**Landing page per validare un'idea.** Si parte da un prompt: "Voglio una landing in italiano per un servizio di consulenza X, con form di contatto, tre sezioni di benefit, hero con immagine". Claude genera struttura statica + Tailwind, anteprima locale, poi deploy su Vercel via MCP. Tempo: 1-2 ore.

### Cosa NON fare
1. Non usare `--dangerously-skip-permissions` "perche' i prompt fastidiosi"
2. Non installare MCP server senza capire cosa fanno (rischio data leak)
3. Non fare `git push --force` su consiglio dell'AI senza chiedere a un developer

### Risorse
- [`docs/04-modalita-permessi.md`](./04-modalita-permessi.md) — capire plan mode prima di tutto
- [`docs/17-ide-surface.md`](./17-ide-surface.md) — Desktop app e Web
- [`docs/06-claude-md-memory.md`](./06-claude-md-memory.md) — come funziona CLAUDE.md
- [`docs/20-tips-best-practices.md`](./20-tips-best-practices.md) — Boris: "setup vanilla > customization"

---

## 2. Solo developer / Indie hacker

### Profilo
Sviluppatore singolo che porta avanti uno o piu' SaaS in solitaria. Vuole massima velocita' di shipping, automazione di routine (PR review, CI fix, dependabot), basso overhead di processo. Vincoli: tempo > budget; nessun team con cui coordinarsi.

### Plan consigliato
**Max** — accesso a Opus 4.7 xhigh per i task ostici, fast mode con $50 credit, 15 routine/giorno, Remote Control da telefono. Il moltiplicatore di velocita' ripaga se si codifica >2h/giorno.

### Setup raccomandato
- **Surface**: CLI `claude` come primaria, VS Code extension come secondaria, Remote Control da iOS
- **Sandbox**: ON
- **Fast mode**: SI sui task lunghi e ben definiti (refactor, scaffolding)
- **Auto mode**: SI per maintenance loop; default mode per feature nuove

### Top 5 slash command
1. `/loop` — `loop 5m /babysit` per auto-rebase, fix CI, review comments
2. `/ultraplan` — design di feature complesse in cloud
3. `/ultrareview` — review pre-merge sulle PR
4. `/schedule` — routine notturne (deps update, security scan)
5. `/security-review` — check rapido sulla diff

### Top 3 skill / plugin
1. **ship** — workflow merge main + tests + CHANGELOG + PR
2. **simplify** — riduce ridondanza nelle modifiche recenti
3. **fewer-permission-prompts** — meno fatica dopo qualche giorno

### CLAUDE.md template ridotto
```markdown
# <Nome SaaS>

## Stack
- Frontend: Next.js 15 + Tailwind
- Backend: Node + Postgres (Supabase)
- Deploy: Vercel + GitHub Actions

## Convenzioni
- Conventional commits (feat:, fix:, chore:)
- Branch: feat/<short>, fix/<short>
- PR piccole (<300 LOC), una feature per PR
- Test E2E con Playwright, no unit test triviali

## Workflow
- Plan mode per ogni feature non triviale
- /security-review prima di merge
- /loop /babysit attivo durante il working time

## Boundary
- Non toccare migrations senza piano esplicito
- Non aggiungere dipendenze senza valutare bundle size
```

### Workflow tipico
1. **Mattina**: `claude` in repo, leggi PR comments / CI fail con `/loop /babysit`
2. Pick della feature del giorno -> `/ultraplan` se cross-file, altrimenti plan mode locale
3. Implementazione in auto mode su Sonnet 4.6
4. **Pranzo**: routine schedulata gira test di regressione
5. **Pomeriggio**: `/security-review` + `/ultrareview` sulla diff
6. PR + merge con skill `ship`
7. Remote Control da telefono per check deploy
8. Schedule notturna: dependency update + audit

### Caso d'uso flagship
**Da issue a PR mergiata in 2 ore.** Issue su GitHub -> `/ultraplan` la legge e produce piano -> CLI esegue il piano -> `/ultrareview` blocca o approva -> autore mergia. Vedi [`docs/15-ultraplan-ultrareview.md`](./15-ultraplan-ultrareview.md).

### Cosa NON fare
1. Non lasciare `/loop` senza idempotenza (vedi [`docs/14-loop-monitor.md`](./14-loop-monitor.md))
2. Non usare fast mode per task brevi: paghi senza guadagnare
3. Non skippare plan mode su refactor cross-file

### Risorse
- [`docs/14-loop-monitor.md`](./14-loop-monitor.md)
- [`docs/13-routines-cloud.md`](./13-routines-cloud.md)
- [`docs/15-ultraplan-ultrareview.md`](./15-ultraplan-ultrareview.md)
- [`docs/05-fast-mode-1m-context.md`](./05-fast-mode-1m-context.md)

---

## 3. Senior backend developer (con team)

### Profilo
Ingegnere backend in team da 5-30 persone, lavora su servizi in produzione (API, microservizi, batch). Obiettivi: qualita' del codice, copertura test, code review consistente, ridurre toil. Vincoli: standard del team, processi PR, compliance interna.

### Plan consigliato
**Team** — managed settings, code review GA su PR, 25 routine/giorno, billing centralizzato. Permette di imporre policy uniformi (sandbox, allowlist comandi, MCP scope).

### Setup raccomardato
- **Surface**: CLI + JetBrains/VS Code extension + GitHub Action per PR review
- **Sandbox**: ON sempre (managed)
- **Fast mode**: opzionale, on-demand
- **Auto mode**: SI con allowlist ristretta; default mode per cambi DB / migrations

### Top 5 slash command
1. `/ultrareview` — pre-merge su PR rilevanti
2. `/security-review`
3. `/plan` (Opus model option) — plan mode su Opus, execute su Sonnet
4. `/test` — generazione/aggiornamento test
5. `/init` con `CLAUDE_CODE_NEW_INIT=1` per onboarding nuovi servizi

### Top 3 skill / plugin
1. **engineering-code-review** — review strutturata
2. **engineering-testing-strategy** — test plan per nuovi moduli
3. **engineering-debug** — sessione debug ripetibile

### CLAUDE.md template ridotto
```markdown
# Servizio: <nome>

## Stack & layer
- Java 21 / Spring Boot 3.x — controller / service / repository
- Postgres con Flyway migrations
- Kafka per eventi async

## Regole non negoziabili
- Mai SQL concatenato: query parametrizzate / JPA
- Ogni endpoint protetto: auth check esplicito
- Modifiche a migrations: PR dedicata, mai mischiata con feature
- Test integration > unit con mock pesanti
- Conventional commits, PR <500 LOC

## Workflow
- Plan mode obbligatorio per cambi cross-package
- /ultrareview obbligatorio prima di merge su main
- Hooks PostToolUse: spotless + checkstyle automatici
```

### Workflow tipico
1. **Mattina**: standup -> pick ticket Jira
2. `/plan` su Opus (model option) per definire approccio
3. Implementazione + test in default mode con acceptEdits
4. Hook PostToolUse esegue formatter automaticamente
5. **Pomeriggio**: `/security-review` + `/ultrareview` sulla diff
6. PR -> GitHub Action Claude Code commenta automaticamente
7. Merge dopo 2 review (1 umana + 1 AI)
8. Routine notturna: regression test su staging

### Caso d'uso flagship
**Aggiungere un endpoint con full test coverage.** Plan mode -> implementazione service+repository+controller -> integration test con Testcontainers -> security-review -> PR. La GitHub Action gira ultrareview e commenta. Vedi [`docs/16-headless-agent-sdk.md`](./16-headless-agent-sdk.md).

### Cosa NON fare
1. Non auto-mergiare PR generate da AI senza human-in-the-loop
2. Non disattivare sandbox per "velocita'"
3. Non lasciare CLAUDE.md monolitico: usa `@import` per layer (vedi [`docs/06-claude-md-memory.md`](./06-claude-md-memory.md))

### Risorse
- [`docs/18-settings-auth.md`](./18-settings-auth.md) — managed settings Team
- [`docs/07-hooks.md`](./07-hooks.md) — formatter / linter automatici
- [`docs/15-ultraplan-ultrareview.md`](./15-ultraplan-ultrareview.md)
- [`docs/16-headless-agent-sdk.md`](./16-headless-agent-sdk.md) — GitHub Actions

---

## 4. Frontend / Full-stack developer

### Profilo
Sviluppatore che lavora su UI moderne (React/Next.js/Vue/Svelte) + backend leggero (API routes, edge functions). Obiettivi: design quality, accessibilita', performance, iterazione visuale rapida. Vincoli: design system, brand consistency, cross-browser.

### Plan consigliato
**Pro** o **Max** a seconda del volume. Max consigliato se si usano molto Computer use, fast mode su scaffolding e Remote Control per QA da telefono.

### Setup raccomandato
- **Surface**: VS Code extension (inline diff) + CLI; Computer use Desktop per QA visuale
- **Sandbox**: ON
- **Fast mode**: SI per scaffolding componenti / form lunghi
- **Auto mode**: SI per cambi UI iterativi con preview

### Top 5 slash command
1. `/plan`
2. `/ultraplan` — su redesign cross-page
3. `/loop` con Monitor tool — `start dev server and use MonitorTool to observe errors`
4. `/security-review`
5. `/compact`

### Top 3 skill / plugin
1. **frontend-design** — UI distinctive production-grade
2. **design-accessibility-review** — WCAG 2.1 AA audit
3. **webapp-testing** / **gstack** — Playwright E2E e diff visuali

### CLAUDE.md template ridotto
```markdown
# <App name>

## Stack
- Next.js 15 (App Router) + TypeScript strict
- Tailwind v4 + shadcn/ui
- tRPC + Drizzle + Postgres

## Design system
- Token in tokens.css (vedi @design/tokens.md)
- Componenti shadcn estesi in components/ui/*
- Mai hardcode colori: usa var(--*)
- Accessibility AA come baseline

## Convenzioni
- Server Components di default; "use client" solo dove serve
- Niente useEffect per data fetching: server actions o tRPC
- Test E2E Playwright per flussi critici
```

### Workflow tipico
1. **Mattina**: `claude` + dev server, `/loop` con Monitor tool
2. Implementazione componenti con frontend-design skill
3. Anteprima Computer use Desktop per check visuale
4. **Pomeriggio**: a11y review con design-accessibility-review
5. Playwright E2E con webapp-testing
6. `/security-review` su API routes / server actions
7. PR con screenshot allegati (Computer use)
8. Remote Control per QA preview deploy da telefono

### Caso d'uso flagship
**Nuova pagina di onboarding multi-step.** frontend-design skill genera markup + componenti, Monitor tool osserva console del dev server, design-accessibility-review valida AA, Playwright registra il flusso. Tempo: mezza giornata.

### Cosa NON fare
1. Non scrivere CSS inline a fianco del design system
2. Non saltare a11y review "tanto poi sistemo"
3. Non usare Computer use per task scriptabili (e' costoso)

### Risorse
- [`docs/17-ide-surface.md`](./17-ide-surface.md) — Computer use, VS Code, Remote Control
- [`docs/14-loop-monitor.md`](./14-loop-monitor.md) — Monitor tool con dev server
- [`docs/09-skills.md`](./09-skills.md)
- [`docs/05-fast-mode-1m-context.md`](./05-fast-mode-1m-context.md)

---

## 5. DevOps / SRE

### Profilo
Responsabile pipeline CI/CD, infrastruttura (Terraform/Pulumi/CDK), observability, on-call. Obiettivi: ridurre MTTR, automatizzare runbook, standardizzare deploy, audit compliance. Vincoli: blast radius alto, ambienti production, compliance (SOC2/ISO).

### Plan consigliato
**Team** o **Enterprise**. Enterprise se serve SSO/RBAC/Compliance API e Claude Code Security. Team altrimenti.

### Setup raccomandato
- **Surface**: CLI headless in CI/CD; Desktop per analisi incidenti; GitHub Actions / GitLab CI integration
- **Sandbox**: ON sempre; in CI usa `--bare` + `--strict-mcp-config`
- **Fast mode**: NO in CI (riproducibilita'); SI on-demand per analisi log voluminosi
- **Auto mode**: NO in produzione; SI in staging con boundary stretti

### Top 5 slash command
1. `/schedule` — routine per audit, drift detection, cost report
2. `/loop` — babysit pipeline durante deploy lunghi
3. `/security-review`
4. `/ultraplan` — refactor IaC cross-modulo
5. `/install-github-app` / `/install-slack-app` — integrazioni

### Top 3 skill / plugin
1. **engineering-incident-response** — triage + postmortem
2. **engineering-deploy-checklist** — verifica pre-release
3. **operations-runbook** — formalizzazione SOP

### CLAUDE.md template ridotto
```markdown
# Infra: <org>

## Stack
- Terraform (modules in modules/, env in envs/)
- AWS multi-account (dev, staging, prod) via SSO
- Kubernetes (EKS) + ArgoCD
- Datadog observability

## Regole production
- Mai apply su prod senza plan review umano
- PR su envs/prod: 2 reviewer obbligatori
- Mai hardcode credentials: AWS Secrets Manager / SSM
- Drift check schedulato giornaliero

## Boundary in routine/loop
- dry-run sempre
- max 5 file modificati per iter
- no commit diretti su main
```

### Workflow tipico
1. **Mattina**: leggi alert overnight, scheduled drift report
2. Triage con engineering-incident-response se incident aperto
3. Plan mode per change request -> Terraform plan -> review umano
4. Apply su staging, monitoraggio Datadog via MCP
5. **Pomeriggio**: postmortem incident di ieri (skill)
6. Aggiornamento runbook con operations-runbook
7. Routine notturna: cost report + security audit
8. Slack digest auto del giorno

### Caso d'uso flagship
**Postmortem semi-automatico.** Dopo un incident, sessione headless con accesso a logs Datadog (MCP) -> timeline ricostruita -> action items -> documento markdown firmato dal team. Vedi [`docs/13-routines-cloud.md`](./13-routines-cloud.md).

### Cosa NON fare
1. Non eseguire `terraform apply` in auto mode su account prod
2. Non skippare `--strict-mcp-config` in CI
3. Non lasciare routine schedulate senza boundary di blast radius

### Risorse
- [`docs/13-routines-cloud.md`](./13-routines-cloud.md)
- [`docs/16-headless-agent-sdk.md`](./16-headless-agent-sdk.md)
- [`docs/10-mcp.md`](./10-mcp.md) — MCP per Datadog/AWS/etc
- [`docs/18-settings-auth.md`](./18-settings-auth.md) — Enterprise auth

---

## 6. Tech lead / Architect

### Profilo
Tech lead o staff/principal engineer. Responsabile di scelte architetturali, code review trasversale, onboarding, governance dell'AI tooling nel team. Vincoli: deve scalare il proprio impatto via processo, non via ore di codice.

### Plan consigliato
**Team** (per il proprio team) o **Enterprise** (per multi-team). Enterprise abilita Claude Code Security, RBAC, compliance API.

### Setup raccomandato
- **Surface**: CLI + Desktop multi-session + GitHub App per PR review
- **Sandbox**: ON managed
- **Fast mode**: opzionale
- **Auto mode**: SI con allowlist team-wide

### Top 5 slash command
1. `/ultraplan` — design doc / ADR draft
2. `/ultrareview` — review trasversali su PR del team
3. `/team-onboarding` — onboarding nuovi joiner
4. `/autofix-pr` — auto-fix lint/format su PR del team
5. `/init` con `CLAUDE_CODE_NEW_INIT=1`

### Top 3 skill / plugin
1. **engineering-architecture** — ADR strutturati
2. **engineering-system-design**
3. **engineering-tech-debt** — prioritizzazione debito

### CLAUDE.md template ridotto
```markdown
# <Org/Team> — Engineering rules

## ADR
- Ogni decisione architetturale -> ADR in docs/adr/NNN-*.md
- Template: context / decision / consequences / alternatives

## Code review policy
- /ultrareview automatica su PR > 200 LOC
- 1 reviewer umano + AI obbligatori
- No merge venerdi' pomeriggio

## Tooling team
- Allowlist comandi in .claude/settings.json (managed)
- MCP scope: solo server in registry approvato
- Hooks: spotless, semgrep, license-check

## Onboarding
- /team-onboarding gira al primo `claude` in repo
- Skill custom in .claude/skills/<team>/
```

### Workflow tipico
1. **Mattina**: review weekly digest (routine)
2. ADR draft con engineering-architecture per decisione del trimestre
3. Sync con team: pair programming guided su feature critica
4. **Pomeriggio**: governance — review managed settings, MCP allowlist
5. PR review trasversali con `/ultrareview`
6. Aggiornamento CLAUDE.md root con nuove convenzioni
7. Sessione di mentoring: usa Output Style "Explanatory" per junior
8. Schedule weekly retro (skill `retro`)

### Caso d'uso flagship
**ADR + roll-out cross-team.** `/ultraplan` produce design doc -> ADR firmato -> `/team-onboarding` distribuisce le convenzioni -> hooks impongono linting -> `/ultrareview` enforce policy in PR.

### Cosa NON fare
1. Non centralizzare tutto in un CLAUDE.md gigante: spezza per dominio
2. Non imporre AI tooling senza opt-in del team (cultura)
3. Non saltare ADR per decisioni "ovvie": ovvio per chi?

### Risorse
- [`docs/06-claude-md-memory.md`](./06-claude-md-memory.md)
- [`docs/12-agent-teams.md`](./12-agent-teams.md)
- [`docs/18-settings-auth.md`](./18-settings-auth.md)
- [`docs/15-ultraplan-ultrareview.md`](./15-ultraplan-ultrareview.md)

---

## 7. AI/ML engineer

### Profilo
Ingegnere che integra LLM, costruisce RAG pipeline, fine-tuning, evals. Obiettivi: qualita' modello, latenza, costo, riproducibilita' degli esperimenti. Vincoli: dataset privati, compliance dati, costi token.

### Plan consigliato
**Max** o **Team**. Max per esperimenti individuali (Opus 4.7 xhigh per ragionamento), Team se in gruppo dati condiviso.

### Setup raccomandato
- **Surface**: CLI + Jupyter via NotebookEdit + Desktop per visualizzazioni
- **Sandbox**: ON; attenzione a path dataset (mount esplicito)
- **Fast mode**: SI su batch processing offline
- **Auto mode**: SI in sandbox con dataset di sviluppo

### Top 5 slash command
1. `/plan`
2. `/ultraplan` — pipeline design
3. `/loop` — eval automatici intra-sessione
4. `/effort xhigh` — task di reasoning
5. `/compact`

### Top 3 skill / plugin
1. **claude-api** — best practices SDK Anthropic + prompt caching
2. **rag-preparation** — pulizia documenti per RAG
3. **mcp-builder** — server MCP per tool custom

### CLAUDE.md template ridotto
```markdown
# <Progetto AI/ML>

## Stack
- Python 3.12, uv per env
- anthropic SDK + langchain (solo dove utile)
- Vector DB: pgvector / Qdrant
- Eval: promptfoo / custom harness

## Regole
- Prompt caching su system prompt > 1024 tok
- Mai loggare contenuto chiamate (PII)
- Eval suite gira prima di ogni cambio prompt
- Versionare prompt come asset (prompts/v<N>.md)

## Sicurezza dati
- Dataset in data/ (gitignored)
- No upload a servizi esterni senza review
- Sandbox mount esplicito su data/
```

### Workflow tipico
1. **Mattina**: review eval overnight (routine schedulata)
2. Hypothesis del giorno -> `/ultraplan` su pipeline change
3. Implementazione con skill claude-api (caching incluso)
4. Eval batch in fast mode
5. **Pomeriggio**: analisi risultati in notebook
6. RAG re-indexing con rag-preparation se serve
7. Aggiornamento prompt versionato + commit
8. Schedule eval di regressione

### Caso d'uso flagship
**RAG pipeline end-to-end.** rag-preparation pulisce PDF/HTML -> embedding + index su pgvector -> claude-api skill costruisce client con caching -> eval harness misura recall@k -> dashboard Chart.js.

### Cosa NON fare
1. Non hardcodare API key (`.env` + apiKeyHelper)
2. Non saltare prompt caching: bruci token
3. Non mischiare dataset prod e dev nello stesso path

### Risorse
- [`docs/05-fast-mode-1m-context.md`](./05-fast-mode-1m-context.md) — 1M context per RAG su contesti lunghi
- [`docs/10-mcp.md`](./10-mcp.md)
- [`docs/16-headless-agent-sdk.md`](./16-headless-agent-sdk.md) — SDK Python/TS
- [`docs/09-skills.md`](./09-skills.md) — skill claude-api

---

## 8. Legacy stack maintainer
*RPG/AS400, COBOL, .NET classic (Framework 4.x / WebForms), Java EE (EJB2, Struts).*

### Profilo
Sviluppatore o tech lead in azienda con sistemi mission-critical su stack legacy (IBM i / RPG, mainframe COBOL, .NET classic, Java EE). Obiettivi: comprensione codice ereditato senza autori originali, modernizzazione progressiva (strangler fig), documentazione, riduzione bus factor. Vincoli: niente test automatici, build proprietarie, dipendenze antiche, compliance regolamentare.

### Plan consigliato
**Team** o **Enterprise** — quasi sempre contesto enterprise con compliance. Enterprise per SSO + audit log + Claude Code Security. 1M context (incluso Max/Team/Enterprise) e' particolarmente prezioso qui: sorgenti legacy sono spesso file singoli da migliaia di righe.

### Setup raccomandato
- **Surface**: CLI in editor WSL/SSH per AS400; JetBrains plugin per Java EE / .NET; VS Code per esplorazione
- **Sandbox**: ON sempre. Mai eseguire codice legacy senza isolation
- **Fast mode**: NO (rischio: scrive codice plausibile ma sbagliato in dialetti rari)
- **Auto mode**: NO. Default mode + plan mode obbligatorio. Ogni modifica letta riga per riga.

### Top 5 slash command
1. `/plan` — sempre, senza eccezioni
2. `/ultraplan` — modernizzazione cross-modulo / strangler
3. `/init` con `CLAUDE_CODE_NEW_INIT=1` — produce CLAUDE.md ricco da codebase ignota
4. `/compact`
5. `/security-review`

### Top 3 skill / plugin
1. **doc-coauthoring** — produrre documentazione tecnica da codice non documentato
2. **engineering-architecture** — ADR per migrazioni
3. **operations-runbook** — formalizzare procedure operative tribali

> Output style **"Explanatory"** o **"Learning"** consigliato (vedi [`docs/20-tips-best-practices.md § 4`](./20-tips-best-practices.md)): Claude spiega *perche'* il codice legacy fa cio' che fa.

### CLAUDE.md template ridotto
```markdown
# Sistema: <nome legacy>

## Stack
- IBM i 7.5, RPGLE free + RPGLE fixed-form, CL programs
- DB2 for i, file fisici/logici + SQL
- Build: PDM / RDi
- (oppure: COBOL Enterprise + JCL + DB2 z/OS)
- (oppure: .NET Framework 4.8 WebForms + WCF)
- (oppure: Java 8 + Struts 1 + EJB 2.1 + WebLogic 10)

## Regole (anti-fallimento)
- LEGGI sempre il sorgente prima di proporre modifiche
- Non inventare opcode RPG / verbi COBOL: verifica nei manuali IBM
- Non assumere semantica di file logici: leggi DDS
- Cita sempre member:linea quando referenzi codice
- Modernizzazione = strangler fig, non rewrite

## Boundary
- Niente modifiche dirette su QGPL / produzione
- Output in libreria DEV; promozione manuale
- Backup membro prima di ogni edit
- Mai DROP / DELETE su tabelle senza approvazione DBA

## Documentazione
- Ogni programma esplorato -> docs/legacy/<NOME>.md
- Diagrammi flusso in mermaid
```

### Workflow tipico
1. **Mattina**: pick programma da analizzare; `/plan` per esplorazione
2. Lettura source + DDS + CL chiamanti; Claude produce summary in italiano
3. doc-coauthoring genera scheda tecnica del programma
4. Identificazione punti di estensione (exit point, trigger)
5. **Pomeriggio**: piano di modernizzazione (es. wrapper REST su RPG via IWS)
6. Implementazione modulo nuovo isolato + ADR
7. Test manuale guidato (no test automation legacy)
8. Aggiornamento runbook operativo

### Caso d'uso flagship
**Strangler fig su programma RPG monolitico.** Programma RPG di 4000 righe gestisce ordini. Workflow:
1. `/init` produce CLAUDE.md con stack rilevato
2. 1M context permette di caricare l'intero source + DDS + CL chiamanti
3. doc-coauthoring estrae responsabilita' in markdown
4. `/ultraplan` propone strangler: REST endpoint nuovo (Node/Java) che intercetta chiamate, delega a RPG per ora, sostituisce gradualmente
5. ADR firmato, primo endpoint estratto, regression manuale OK

Risultato: documentazione + primo step di modernizzazione, senza toccare il monolite.

### Cosa NON fare
1. Non chiedere a Claude di "riscrivere in Python" un sorgente RPG/COBOL alla cieca: traduzione plausibile != corretta su dialetti rari
2. Non far eseguire CL/JCL in auto mode: blast radius enorme su sistemi shared
3. Non saltare la verifica dei manuali ufficiali (IBM, Micro Focus, Microsoft) per opcode/verbi: rischio hallucination alto su stack poco rappresentati nel training

### Risorse
- [`docs/06-claude-md-memory.md`](./06-claude-md-memory.md) — `/init` ricco con `CLAUDE_CODE_NEW_INIT=1`
- [`docs/05-fast-mode-1m-context.md`](./05-fast-mode-1m-context.md) — 1M context per source legacy lunghi
- [`docs/04-modalita-permessi.md`](./04-modalita-permessi.md) — plan mode rigoroso
- [`docs/15-ultraplan-ultrareview.md`](./15-ultraplan-ultrareview.md) — design modernizzazione
- vedi `docs/10-mcp.md` per MCP custom verso DB2/IBM i / mainframe (placeholder: link a server MCP IBM i specifici quando disponibili)

---

## Tabella riassuntiva

| Target | Plan | Surface | Sandbox | Fast | Auto | Top command |
|---|---|---|---|---|---|---|
| Beginner | Pro | Desktop/Web | ON | NO | NO | `/plan` |
| Indie hacker | Max | CLI + Remote | ON | SI | SI | `/loop` |
| Senior backend | Team | CLI + IDE + GHA | ON | opt | SI ristretto | `/ultrareview` |
| Frontend/full-stack | Pro/Max | VS Code + Computer use | ON | SI | SI | Monitor + `/loop` |
| DevOps/SRE | Team/Enterprise | CLI headless + GHA | ON strict | NO in CI | NO prod | `/schedule` |
| Tech lead | Team/Enterprise | Multi-session Desktop | ON managed | opt | SI managed | `/ultraplan` + `/ultrareview` |
| AI/ML | Max/Team | CLI + Notebook | ON | SI offline | SI sandbox | `/effort xhigh` |
| Legacy | Team/Enterprise | CLI + JetBrains | ON | NO | NO | `/plan` + `/init` |

---

← [20 Tips & best practices](./20-tips-best-practices.md) · Torna al [README](../README.md)
