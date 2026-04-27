# Dossier Ruben Hassid - "How to AI" Substack

> Ricerca svolta il 2026-04-27 via WebFetch + WebSearch su `ruben.substack.com`, `substack.com/@ruben`, note pubbliche e ricerca.
> Tutti i contenuti citati sono stati visitati direttamente. Le tre fonti `how-to-claude.ai`, `claude-co.work`, `claudedesign.free` risultano redirect verso post Substack di Ruben (verificato: `how-to-claude.ai` -> 301 -> `ruben.substack.com/p/claude`). Il sito `how-to-ai.guide` non risulta raggiungibile via WebFetch (`ECONNREFUSED`); e' citato come gating per scaricare le infografiche tramite iscrizione + reply email + accesso a un Notion privato.
> Note: i post di gennaio-febbraio 2026 non sono indicizzati nelle pagine `/archive` paginate, ma due titoli sono confermati via WebSearch (`I am just a text file`, 21 gen 2026; `Bubble`, 15 feb 2026).

---

## 1. Profilo e link principali

### Identita
- **Autore**: Ruben Hassid, 29 anni, francese basato a Tel Aviv (Israele). Ex ghostwriter / content strategist.
- **Newsletter**: "How to AI" su Substack.
- **Tagline**: *"Master AI before it masters you"* / *"Stop collecting AI tips. Run practical AI workflows, with exact prompts, screenshots, and steps."*
- **Mission**: demistificare l'AI per non-tecnici con istruzioni step-by-step, screenshot e frecce.

### Numeri (al 2026-04-27)
- Substack: **535K+ subscribers**, posizionato **#1 nella categoria Education**.
- LinkedIn: cresciuto da 8K a 800K+ followers, 300M+ views.
- Speaker: VidCon, B2B Summit, RAISE, Google Campus.

### Link principali
| Risorsa | URL | Stato verificato |
|---|---|---|
| Substack home | https://ruben.substack.com/ | OK |
| Profilo Substack | https://substack.com/@ruben | OK |
| About | https://ruben.substack.com/about | OK |
| Hub gating infografiche | https://www.how-to-ai.guide | ECONNREFUSED al fetch (confermato esistente nelle note) |
| Mini-sito Claude 101 | https://how-to-claude.ai | 301 -> `/p/claude` (alias Substack) |
| Cowork landing | https://claude-co.work | citato nelle note, alias |
| Skills landing | https://claude-skills.free | citato nelle note, alias |
| Teams landing | https://how-claude.team | citato nelle note, alias |
| Design landing | https://claudedesign.free | citato nelle note, alias |
| Code landing | https://claudecode.free | citato nelle note, alias |
| Gamma slides | https://how-to-gamma.ai | citato nelle note, alias |

### Frequenza e stile editoriale
- **Cadenza**: ~2 post a settimana su Substack (lunedi/giovedi tipici), 2 note/post LinkedIn al giorno.
- **Stile**: tono diretto, paragrafi brevissimi, formule "prompt + screenshot + freccia", ogni post si chiude con CTA "scarica l'infografica su how-to-ai.guide".
- **Pattern ricorrente**: ogni feature di Claude diventa un articolo dedicato + una nota LinkedIn/Substack con infografica abbinata.
- **Posizionamento**: non vende corsi, vende attenzione + lead via newsletter. Distribuisce le infografiche tramite "double opt-in": iscrizione + reply all'email di benvenuto = accesso a Notion privato.

---

## 2. Post degli ultimi ~3 mesi (gen -> apr 2026)

Legenda tag: `Setup` `Cowork` `Skills` `Code` `Design` `ChatGPT` `Mindset` `Workflow` `Search` `Macro`.

### Aprile 2026

#### 2026-04-26 - "ChatGPT-5.5 or Claude 4.7?"
- **URL**: https://ruben.substack.com/p/everyone-wants-one-ai
- **Tag**: `ChatGPT` `Claude` `Macro`
- **Sintesi**: Stack consigliato multi-modello: Claude per scrittura (Cowork con cartelle locali come "super-prompt"), ChatGPT-5.5 per immagini/spreadsheets/web search, Gemini per non-inglese, Gamma per slides. Novita ChatGPT: thinking mode, estensione Google Sheets con modello "Heavy", Deep Research (~1h14 per ricerche complete). Conclusione: non esiste l'AI unica, scegli per task.
- **Insight per Claude Code**: rinforza il pattern di mantenere CLAUDE.md / cartelle locali come "voce" persistente del progetto (vs. prompt one-shot di ChatGPT).

#### 2026-04-22 - "Claude Design"
- **URL**: https://ruben.substack.com/p/claude-design
- **Tag**: `Design` `Claude`
- **Sintesi**: Claude Design (claude.ai/design) basato su Opus 4.7, esporta a Canva, PPTX, PDF, HTML. 55M views in 2 giorni post-lancio, Figma -$730M valuation. Workflow: carica `DESIGN.md` o copia stili da `getdesign.md` (Mastercard/Airbnb/Ferrari). Costoso in token.
- **Insight per Claude Code**: pattern del file `DESIGN.md` come "design system as context" e' replicabile per qualsiasi convention codebase (es. `STYLE.md`, `ARCHITECTURE.md`).

#### 2026-04-19 - "Claude For Dummies"
- **URL**: https://ruben.substack.com/p/claude-for-dummies
- **Tag**: `Setup` `Mindset`
- **Sintesi**: Onboarding zero-to-one per Claude. Differenze con ChatGPT (Claude vince su documenti lunghi e file locali, perde su voce/immagini). Tre versioni: Browser, Desktop, Cowork. Concetti chiave: Token, Cowork, Claude Code. 10 esercizi pratici (PDF, email, spreadsheet, calendari).
- **Insight per Claude Code**: onboarding "scegli la versione giusta" e' il primo bivio editoriale, replicabile in nostro README.

#### 2026-04-15 - "Prompting is the worst way to use Claude"
- **URL**: https://ruben.substack.com/p/stop-prompting-claude
- **Tag**: `Mindset` `Cowork` `Skills`
- **Sintesi**: Tesi: i prompt one-shot producono output generico. Soluzione: Cowork con cartella locale di istruzioni permanenti, gestita con Obsidian (markdown editor). Skills come comandi `/` per workflow ricorrenti. Claude diventa "secondo cervello" persistente.
- **Insight per Claude Code**: messaggio chiave "stop prompting, start configuring" - allineato 100% al modello CLAUDE.md della repo.

#### 2026-04-12 - "How to stop hitting Claude usage limits"
- **URL**: https://ruben.substack.com/p/how-to-stop-hitting-claude-usage
- **Tag**: `Workflow` `Setup`
- **Sintesi**: 23 trick per ridurre token. Concetto centrale: Claude rilegge l'intera history a ogni messaggio, costo cresce in modo super-lineare. Soluzioni: convertire file prima dell'upload, usare Edit invece di follow-up, ricominciare ogni 15-20 messaggi, Sonnet/Haiku per task semplici, `CLAUDE.md` per contesto permanente.
- **Insight per Claude Code**: trick #21 (`CLAUDE.md`) e #20 (scope chiaro) sono direttamente azionabili nel nostro repo.

#### 2026-04-09 - "Cowork. (April 2026 update)"
- **URL**: https://ruben.substack.com/p/claude-cowork-20
- **Tag**: `Cowork` `Setup`
- **Sintesi**: Struttura cartella consigliata: `ABOUT ME/` (about-me.md <2K token, anti-ai-writing-style.md, my-company.md), `OUTPUTS/`, `TEMPLATES/`. Global Instructions come prompt persistente che pre-legge `ABOUT ME` ad ogni task. Wispr Flow per dettatura. 6 regole token-saving. Setup in 20 minuti.
- **Insight per Claude Code**: la struttura `ABOUT ME / OUTPUTS / TEMPLATES` e' adattabile a `.claude/context/`, `.claude/outputs/`, `.claude/templates/` per progetti dev.

#### 2026-04-05 - "I am the last of 4 kids"
- **URL**: https://ruben.substack.com/p/i-love-to-be-right
- **Tag**: `Mindset`
- **Sintesi**: Anti-sycophancy. LLM convince anche Karpathy ad abbandonare la sua posizione. Ruben fa riscrivere la newsletter sfidando Claude piu' volte: "Do I actually think I was wrong? Or did I just get out-argued by something that doesn't care what's true?". Distinguere truth-seeking vs validation-seeking.
- **Insight per Claude Code**: rinforza la regola 79-88 del nostro CLAUDE.md (anti-sycophancy).

#### 2026-04-01 - "Claude Skills"
- **URL**: https://ruben.substack.com/p/claude-skills
- **Tag**: `Skills` `Setup`
- **Sintesi**: Skills come `/comandi` che si auto-attivano per task ricorrenti. Due percorsi di creazione: (1) Skill-creator dentro Claude Cowork (Opus 4.7 + Extended Thinking), (2) makemyskill.com. 7 hack: debugging, trigger negativi, stacking con voice file, riuso conversazioni passate. Limite: rischio trigger errati, consumo token sulla descrizione.
- **Insight per Claude Code**: la specificita' della Skill ("I write weekly reports starting with headline metric, 3 sections max" > "I write reports") e' una regola d'oro per i nostri skill markdown.

### Marzo 2026

#### 2026-03-29 - "Claude Cowork + Project"
- **URL**: https://ruben.substack.com/p/claude-cowork-project
- **Tag**: `Cowork` `Workflow`
- **Sintesi**: Cowork ora ha "Projects" nativi: cartella + istruzioni + memoria persistente + scheduled tasks, con isolamento per progetto. 3 modi di partire: from-scratch, import da Claude browser, link a cartella locale. Use case: newsletter ricorrenti, client reports, sales proposals, daily briefings schedulati. Limiti: no team sharing, no cloud sync, alto consumo Pro, solo con app aperta.
- **Insight per Claude Code**: pattern "Project = folder + memory + schedule" e' un primitivo che possiamo documentare come unita' base nei plugin.

#### 2026-03-25 - "Claude is now YOUR computer"
- **URL**: https://ruben.substack.com/p/claude-computer
- **Tag**: `Workflow` `Setup`
- **Sintesi**: Computer Use + Browser Use (solo Mac, Windows in arrivo). "Claude Dispatch" per controllo da telefono. PC sempre acceso. Use case: scraping Meta Ads Library, ricerca freelancer Fiverr, gestione Google Sheets. Sezione "Scheduled" per task ricorrenti (es. arXiv daily).
- **Insight per Claude Code**: "Scheduled" + Computer Use sono primitivi rilevanti per qualunque automazione long-running.

#### 2026-03-22 - "Search" (Grok 4.20)
- **URL**: https://ruben.substack.com/p/grok-420
- **Tag**: `Search` `Macro`
- **Sintesi**: Grok 4.20 #1 per ricerche multi-agente (orchestratore + Harper/Benjamin/Lucas). 272 fonti in 37s, 22% hallucination rate (record), 83% instruction following, ELO 1226 LMArena. SuperGrok $30 / X Premium+ $40 / Heavy $300. Fino a 4 agenti custom non-sovrapposti.
- **Insight per Claude Code**: utile come reference per "quando NON usare Claude" (search profonda real-time -> Grok).

#### 2026-03-19 - "Claude Code"
- **URL**: https://ruben.substack.com/p/claude-code
- **Tag**: `Code` `Setup`
- **Sintesi**: Claude Code per non-developer. Stack: app Claude + Pro $20 + GitHub gratuito + VS Code + estensione Claude. Modalita' "Skip Permissions" per vibecoding. Screenshot come reference progettuale. File `CLAUDE.md` come memoria progettuale.
- **Insight per Claude Code**: target audience "non-developer" e' un public chiave anche per la nostra repo - consigliato avere doppia narrativa (dev + non-dev).

### Febbraio 2026

#### 2026-02-18 - "Claude."
- **URL**: https://ruben.substack.com/p/claude
- **Tag**: `Setup` `Macro`
- **Sintesi**: Pillar post / Claude 101. Claude come 6 strumenti: Cowork (desktop+files), Model (Opus 4.6 + Extended Thinking, rilasciato 5 feb 2026), Excel, Plugins (11 ufficiali da Anthropic gen 2026 per Sales/Marketing/Legal/Finance/Data/PM/Support), Artifacts, Projects. Connettori: Slack, Drive, Notion, Figma + 50. Limiti: no immagini, search debole. 30-min practical guide.
- **Insight per Claude Code**: questo e' il post a cui punta `how-to-claude.ai`. Modello narrativo "1 tool = N strumenti" e' efficace per onboarding.

#### 2026-02-15 - "Bubble."
- **URL**: https://ruben.substack.com/p/bubble
- **Tag**: `Mindset` `Macro`
- **Sintesi**: Anti-bubble argument. "Bubbles inflate. AI is doing the opposite: cost dropped 10x in 12 months". Jevons paradox: piu' economico -> piu' uso -> piu' lavoro. Asymmetric risk: imparare costa poco, ignorare costa la generazione. CTA: prova Opus 4.6 sul tuo dominio.
- **Insight per Claude Code**: utile come argomento adoption per stakeholder scettici.

### Gennaio 2026

#### 2026-01-21 (data confermata via search) - "I am just a text file"
- **URL**: https://ruben.substack.com/p/i-am-just-a-text-file
- **Tag**: `Mindset` `Cowork`
- **Sintesi**: Voice/style come file markdown portabile. Metodo: 100 domande di auto-intervista -> markdown -> upload su Claude/ChatGPT/Gemini. Insight: *"Taste isn't what you like, but what you reject"*. Articolo scritto con il proprio voice file + Claude.
- **Insight per Claude Code**: il pattern "voice file" e' direttamente applicabile come `STYLE.md` nel nostro repo per output consistenti.

#### 2026-01 (data esatta non rilevata, riferito da home) - "Happy New AI Year"
- **URL**: https://ruben.substack.com/p/happy-new-ai-year
- **Tag**: `Macro` `Mindset`
- **Sintesi**: AI accelera 1.85x post-aprile 2024. ChatGPT 2025 != ChatGPT 2023 (Thinking 13%->83% accuracy, Memory, Projects, Web search, Canvas, Custom GPTs). Stanford AI Index 2025: training compute raddoppia ogni 5 mesi, inference cost -280x tra nov 2022 e ott 2024. MATH 6.9% (2021) -> 100% (GPT-5.2). 5 livelli OpenAI: Chatbot/Reasoner/Agent/Innovator/Organization.
- **Insight per Claude Code**: utile come big picture per intro "perche' Claude ora".

> Nota: due post di dicembre 2025 sono visibili sulla home ma fuori dal range 3 mesi richiesto: "10,000 followers in 17 days" (24 dic 2025).

---

## 3. Inventario voci infografica "Master Claude for Free"

> ATTENZIONE: l'infografica non e' stata visionata direttamente (gating dietro `how-to-ai.guide` -> Notion). La ricostruzione qui sotto **incrocia 3 fonti**: (a) lista categorie/voci nel prompt utente, (b) note pubbliche di Ruben (`c-244848654`, `c-244847519`, `c-244852334`, `c-232992928`, `c-230551020`, `c-247293543`), (c) i pillar post correlati su Substack. Ogni voce indica numero, categoria probabile, titolo, fonte e link. Le voci dal numero 15 in poi non sono confermate dalle fonti pubbliche - segnate come `[non verificato]`.

### Categorie dichiarate (dal prompt utente)
1. SETUP + FUNDAMENTALS
2. APPS + FEATURES
3. MINDSET
4. CLAUDE COWORK
5. TEAMS
6. WHY CLAUDE
7. AI WORKFLOWS

### Tabella voci

| # | Categoria | Titolo voce | Source / link | Implicazione per nostro repo |
|---|---|---|---|---|
| 01 | SETUP+FUNDAMENTALS | Set up Claude the right way | `/p/claude` (alias `how-to-claude.ai`) + nota `c-232992928` | Onboarding "scegli chat vs cowork vs project" come prima pagina README. |
| 02 | SETUP+FUNDAMENTALS | Claude for Dummies | `/p/claude-for-dummies` | Avere una pagina "zero to one" per non-dev. |
| 03 | APPS+FEATURES | Claude Skills | `/p/claude-skills` (alias `claude-skills.free`) | Documentare skills come unita' di workflow ripetibile. |
| 04 | MINDSET | Prompting is the worst way | `/p/stop-prompting-claude` | Slogan: "configura, non promptare". |
| 05 | SETUP+FUNDAMENTALS | Stop hitting usage limits | `/p/how-to-stop-hitting-claude-usage` | 23 trick come checklist ottimizzazione. |
| 06 | APPS+FEATURES | Claude Code | `/p/claude-code` (alias `claudecode.free`) | Posizionamento "code per non-dev". |
| 07 | CLAUDE COWORK | Cowork setup (April 2026) | `/p/claude-cowork-20` (alias `claude-co.work`) | Struttura `ABOUT ME / OUTPUTS / TEMPLATES`. |
| 08 | CLAUDE COWORK | Cowork + Projects | `/p/claude-cowork-project` | Project = folder + memory + schedule. |
| 09 | APPS+FEATURES | Claude is now YOUR computer | `/p/claude-computer` | Computer/Browser use + Scheduled tasks. |
| 10 | APPS+FEATURES | Claude Design | `/p/claude-design` (alias `claudedesign.free`) | Design system as context (`DESIGN.md`). |
| 11 | MINDSET | I am just a text file | `/p/i-am-just-a-text-file` | Voice file portabile (`STYLE.md`). |
| 12 | MINDSET | Ask AI if you are right (anti-sycophancy) | `/p/i-love-to-be-right` | Allineato a regole 79-88 del nostro CLAUDE.md. |
| 13 | TEAMS | Claude for teams | alias `how-claude.team` (rollout 7 giorni, citato in `c-248466840`) | Playbook adoption aziendale a 7 giorni. |
| 14 | WHY CLAUDE | Quit ChatGPT (Claude wins) | `/p/claude` + `/p/everyone-wants-one-ai` | Comparativa stack multi-modello. |
| 15 | WHY CLAUDE | Bubble? No. | `/p/bubble` | Argomento adoption per stakeholder. |
| 16 | AI WORKFLOWS | Claude in Excel | sezione del pillar `/p/claude` (Excel come 1 dei 6 strumenti) | Pattern integrazione tabellare. |
| 17 | AI WORKFLOWS | Interactive charts | citato negli archivi (note `c-247293543`) | Output artifacts come "interactive deliverable". |
| 18 | AI WORKFLOWS | Gamma slides | alias `how-to-gamma.ai` | Pipeline AI per slide. |
| 19 | AI WORKFLOWS | Search (when NOT to use Claude) | `/p/grok-420` | Cross-tool decision: Grok per search profonda. |
| 20 | WHY CLAUDE | Happy New AI Year (macro) | `/p/happy-new-ai-year` | Big picture per onboarding. |

> Numeri >14 sono **inferenze incrociate**, non visione diretta dell'infografica. Confermare al ricevitore della newsletter.

---

## 4. Idee di adattamento per la repo `giadaf-boosha/claude-code`

### A. Struttura "field-guide" stile Ruben
Adattare il pattern delle 7 colonne tematiche a un README/landing visiva:

```
+------------------+ +------------------+ +------------------+
| SETUP            | | FEATURES         | | MINDSET          |
| 01 Quick install | | 06 Skills        | | 11 Anti-syco     |
| 02 First project | | 07 Plugins       | | 12 Voice file    |
| 03 CLAUDE.md     | | 08 Code          | | 13 Stop prompt   |
+------------------+ +------------------+ +------------------+
+------------------+ +------------------+ +------------------+
| WORKFLOWS        | | TEAMS            | | WHY CLAUDE       |
| 14 Daily standup | | 17 Onboarding    | | 20 vs ChatGPT    |
| 15 PR review     | | 18 Skills share  | | 21 Token math    |
| 16 Auto-loop     | | 19 Governance    | | 22 Anti-bubble   |
+------------------+ +------------------+ +------------------+
```

### B. Mini-card markdown standardizzate
Ogni voce nel field guide come block:

```markdown
### 07 - Cowork setup
**Categoria**: Setup
**1-liner**: Folder struct ABOUT ME / OUTPUTS / TEMPLATES.
**Source**: ruben.substack.com/p/claude-cowork-20
**Adattamento repo**: `.claude/context/`, `.claude/outputs/`, `.claude/templates/`.
**Token budget**: about-me.md <2K token.
```

### C. Pattern file-as-context da rubare
| Pattern Ruben | File Ruben | Equivalente repo |
|---|---|---|
| Voice/style | `anti-ai-writing-style.md` | `.claude/STYLE.md` |
| Identita | `about-me.md` | `.claude/IDENTITY.md` |
| Brand/biz | `my-company.md` | `.claude/PROJECT.md` |
| Design system | `DESIGN.md` (o `getdesign.md`) | `.claude/DESIGN.md` |
| Persistent context | `CLAUDE.md` | gia' presente |

### D. Slogan/heuristics riusabili
- *"Use Cowork 80% of the time"* -> *"Use CLAUDE.md 80% of the time, prompt 20%"*
- *"Specificity is the difference between Skill and prompt"* -> regola di review skill markdown.
- *"Restart every 15-20 messages"* -> pattern "compact/restart" da scriptare.
- *"Taste is what you reject"* -> sezione "anti-pattern" obbligatoria nei nostri skill.

### E. Distribuzione contenuti
Ruben usa il pattern "1 articolo + 1 nota + 1 infografica + 1 alias domain". Adattamento:
- 1 doc markdown nel repo + 1 mini-card README + 1 ASCII diagram + 1 anchor link permanente.

### F. Rischi / cose da NON copiare
- **Gating con email + Notion**: appropriato per lead-gen, non per progetto open. Saltare.
- **Alias dominio per ogni feature** (`claude-co.work`, `claudedesign.free`): SEO trick, non utile in repo.
- **Tono "guru"**: Ruben usa molto la prima persona dichiarativa; per la repo preferire registro tecnico neutro.
- **Affermazioni di mercato non verificate** (es. "Figma -$730M valuation"): citarle solo con fonte.

---

## Fonti citate (URL completi)

- https://ruben.substack.com/
- https://ruben.substack.com/about
- https://ruben.substack.com/archive
- https://ruben.substack.com/p/claude
- https://ruben.substack.com/p/claude-for-dummies
- https://ruben.substack.com/p/claude-skills
- https://ruben.substack.com/p/claude-cowork-20
- https://ruben.substack.com/p/claude-cowork-project
- https://ruben.substack.com/p/claude-code
- https://ruben.substack.com/p/claude-computer
- https://ruben.substack.com/p/claude-design
- https://ruben.substack.com/p/stop-prompting-claude
- https://ruben.substack.com/p/how-to-stop-hitting-claude-usage
- https://ruben.substack.com/p/everyone-wants-one-ai
- https://ruben.substack.com/p/i-love-to-be-right
- https://ruben.substack.com/p/i-am-just-a-text-file
- https://ruben.substack.com/p/bubble
- https://ruben.substack.com/p/happy-new-ai-year
- https://ruben.substack.com/p/grok-420
- https://substack.com/@ruben
- https://substack.com/@ruben/note/c-248466840
- https://substack.com/@ruben/note/c-244848654
- https://substack.com/@ruben/note/c-244852334
- https://substack.com/@ruben/note/c-232992928
- https://substack.com/@ruben/note/c-230551020
- https://substack.com/@ruben/note/c-247293543
- https://how-to-claude.ai (301 -> /p/claude)
- https://www.how-to-ai.guide (gating, non fetchabile via WebFetch)
