# Post X — riferimento

Questa cartella raccoglie i post X (Twitter) principali del team Claude Code dal 15 febbraio 2026 in poi (con qualche riferimento di contesto pre-finestra). Ogni post e' citato con URL originale e una nota di contesto.

> **Metodo di raccolta**: WebFetch su x.com restituisce HTTP 402 (paywall API X). I contenuti sono stati ricostruiti via WebSearch sui snippet ufficiali di Google (`site:x.com`). Citazioni testuali quando lo snippet le riporta integralmente; parafrasi italiane per il resto. Tutti gli URL puntano ai post originali.

---

## Indice

- [bcherny.md](./bcherny.md) — Boris Cherny, creator Claude Code (~46 post: tip thread, hidden features, drop di feature)
- [catwu.md](./catwu.md) — Cat Wu, PM Claude Code (~13 post: annunci di prodotto)
- [noahzweben.md](./noahzweben.md) — Noah Zweben, PM Claude Code engineer (~9 post: drop tecnici)
- [trq212.md](./trq212.md) — Thariq, engineer Claude Code (~14 post: lessons + nuove feature)
- [claudeai-claudedevs.md](./claudeai-claudedevs.md) — account ufficiali Anthropic (~22 post)
- [alistaiir.md](./alistaiir.md) — Alistair, Anthropic engineer (Monitor tool + easter eggs)
- [ecosistema.md](./ecosistema.md) — @rauchg (Vercel), @swyx (latent.space), @transitive_bs, @ClaudeCodeLog (changelog non ufficiale)

---

## Sintesi feature emerse dai post

### Modalita' / orchestration
- **Plan mode** (giu 2025, GA Pro/Max) — [@_catwu](https://x.com/_catwu/status/1932857816131547453)
- **/model Opus per plan mode** (ago 2025) — [@_catwu](https://x.com/_catwu/status/1955694117264261609)
- **Auto mode esteso a Max** (mar 2026) — [@claudeai](https://x.com/claudeai/status/2044785266590622185)
- **Routines** (mar 2026) — [@claudeai](https://x.com/claudeai/status/2044095086460309790)
- **/loop e /schedule** (mar 2026) — [@bcherny](https://x.com/bcherny/status/2038454341884154269)

### Code review e qualita'
- **Code Review (PR agents)** (beta nov 2025 → GA mar 2026) — [@claudeai](https://x.com/claudeai/status/2031088171262554195)
- **/ultrareview** (mar 2026) — [@ClaudeDevs](https://x.com/ClaudeDevs/status/2046999435239133246)
- **`claude ultrareview` subcommand** (apr 2026, CLI 2.1.120) — [@ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2047882231343878309)
- **Claude Code Security** (feb 2026) — [@claudeai](https://x.com/claudeai/status/2024907535145468326)

### Estensibilita'
- **Hooks su skill/agent frontmatter, hot reload Skills, custom agents** (CC 2.1.0, dic 2025) — [@bcherny](https://x.com/bcherny/status/2009072293826453669)
- **/simplify e /batch** (mar 2026) — [@bcherny](https://x.com/bcherny/status/2027534984534544489)

### Surface / piattaforma
- **Claude Code on the web** (ott/nov 2025) — [@_catwu](https://x.com/_catwu/status/1980338889958257106)
- **Claude Code dentro Claude Desktop** (dic 2025) — [@_catwu](https://x.com/_catwu/status/2008628736409956395)
- **Desktop redesign multi-sessione** (mar 2026) — [@claudeai](https://x.com/claudeai/status/2044131493966909862)
- **/remote-control da telefono** (feb 2026, GA mar 2026) — [@_catwu](https://x.com/_catwu/status/2026421789476401182)
- **Computer use in CLI** (mar 2026) — [@claudeai](https://x.com/claudeai/status/2038663014098899416)
- **Cowork** (dic 2025) — [@claudeai](https://x.com/claudeai/status/2010805682434666759)

### Modelli
- **Opus 4.6 + fast mode (2.5x)** (feb 2026) — [@claudeai](https://x.com/claudeai/status/2019467374420722022)
- **$50 free credit fast mode** (feb 2026) — [@_catwu](https://x.com/_catwu/status/2020221012605038985)

### Tips/workflow
- **Setup vanilla > customizzazione** — [@bcherny](https://x.com/bcherny/status/2007179832300581177)
- **Output style "Explanatory"/"Learning"** — [@bcherny](https://x.com/bcherny/status/2017742759218794768)
- **Hooks per routing permessi e nudge fine-turno** — [@bcherny](https://x.com/bcherny/status/2021701059253874861)
- **Full task context upfront** — [@_catwu](https://x.com/_catwu/status/2044808536790847693)
- **Monitor tool + dev server** — [@trq212](https://x.com/trq212/status/2042335178388103559)

### Eventi e community
- 50+ meetup Claude Code (nov 2025 → 2026) — [@_catwu](https://x.com/_catwu/status/1996287136161767883)
- Hackathon Opus 4.6 ($100K) — [@claudeai](https://x.com/claudeai/status/2019833113418035237)
- Code with Claude conference SF/London/Tokyo (primavera 2026) — [@claudeai](https://x.com/claudeai/status/2034308517964956051)
- Hackathon Opus 4.7 — [@claudeai](https://x.com/claudeai/status/2045248224659644654)

### Incident: post-mortem qualita' apr 2026
- 3 issue su CC + Agent SDK harness (impatta Cowork), modelli e API non regrediti, fix v2.1.116+, reset usage limits — [@ClaudeDevs](https://x.com/ClaudeDevs/status/2047371123185287223), [@bcherny](https://x.com/bcherny/status/2047375800945783056)

---

## Lancio canale ufficiale developer
**@ClaudeDevs** ufficiale (mar 2026) come hub aggiornamenti CC e Claude platform — [@trq212](https://x.com/trq212/status/2044893583308918787).
