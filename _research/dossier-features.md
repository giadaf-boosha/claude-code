# Dossier Feature Claude Code (15 febbraio - 27 aprile 2026)

> Ricerca svolta il 27 aprile 2026. Fonti: blog ufficiale Anthropic, docs `code.claude.com`, post X (alcuni inaccessibili a causa di paywall, ricostruiti via copertura terza).

---

## Routines

- **Cosa fa**: automazioni Claude Code configurate una volta (prompt + repo + connettori) ed eseguite su schedule, via API o reagendo a eventi GitHub. Girano sull'infrastruttura cloud di Anthropic, quindi non serve tenere il laptop aperto. Sostituiscono cron + agenti orchestrati custom.
- **Come si usa**:
  - Si crea via `/schedule` da CLI oppure dalla dashboard `claude.ai/code`.
  - Tre tipi di trigger: `Scheduled` (hourly/daily/nightly/weekdays/weekly), `API` (HTTP POST con bearer token su endpoint dedicato), `GitHub` (`pull_request.opened`, `push`, `issues`, `releases`, `check_runs`...).
  - Esempio scheduled: "Ogni notte alle 02:00 prendi il top bug da Linear, tenta una fix e apri una draft PR".
  - Esempio webhook: una routine si attiva su ogni nuova PR e commenta findings, reagendo anche a commenti CI successivi.
- **Quando usarla**: backlog triage notturno, doc-drift detection, alert triage da PagerDuty (via API), porting di librerie su molte repo, code review automatica su PR.
- **Tips/best practices**:
  - Il limite giornaliero per piano si applica solo ai trigger `Scheduled`. I trigger `Webhook`/`API` non sono contati: usali per volume alto.
  - Sempre testare con "Run now" prima di mettere in schedule.
  - Inserire boundary esplicite nel prompt (`do not merge`, `do not modify more than X files`).
  - Routine focalizzate su un task: prompt complessi consumano molti token.
- **Limiti**: Pro 5/giorno, Max 15/giorno, Team/Enterprise 25/giorno. Extra usage disponibile.
- **Annunciata**: 14 aprile 2026 (https://claude.com/blog/introducing-routines-in-claude-code). Lancio in research preview con redesign desktop app (multi-session sidebar).
- **Documentazione**: https://code.claude.com/docs/en/web-scheduled-tasks

---

## /loop

- **Cosa fa**: comando slash che esegue un prompt o uno slash command su intervallo ricorrente all'interno della sessione corrente di Claude Code (non in cloud, vive con la sessione). Se l'intervallo viene omesso, il modello si auto-paginate tra le iterazioni.
- **Come si usa**:
  - Forma base: `/loop <interval> <prompt>` oppure `/loop "<prompt>" --interval 5m`.
  - Forma cron: `/loop "<prompt>" --cron "0 8 * * 1-5"`.
  - Self-pacing: `/loop <prompt>` senza intervallo (introdotto in Week 15, aprile 2026).
  - Cancel: `/loop --cancel`.
  - Unità supportate: `s`, `m`, `h`, `d`.
- **Quando usarla**: polling di stato CI (`/loop 5m make sure this PR passes CI`), tail di test runner, audit periodico di vulnerabilita', digest commit giornaliero, run di `/babysit-prs`.
- **Tips/best practices** (dai post X di Noah Zweben e tutorial):
  - La sessione muore se chiudi il terminale: usare `tmux`/`screen` per persistenza.
  - Stimare costo per ciclo prima di intervalli brevi.
  - Richiedere output strutturati (JSON) per renderli machine-readable.
  - Lanciare `/compact` periodicamente in loop lunghi.
  - Garantire idempotenza del task.
  - Per scheduling robusto multi-user, preferire Routines.
- **Annunciata**: marzo 2026, evidenziato nei tip di Noah Zweben (Anthropic). Post X non accessibile direttamente (paywall). Riferimento: https://x.com/noahzweben/status/2042670949003153647
- **Documentazione**: https://code.claude.com/docs/en/scheduled-tasks

---

## /ultraplan

- **Cosa fa**: scarica il task di pianificazione dalla CLI locale verso una sessione Claude Code on the web in plan mode. Claude redige il piano nel cloud mentre il terminale resta libero.
- **Come si usa**:
  - `/ultraplan <prompt>` da CLI, oppure scrivere "ultraplan" in un prompt normale, oppure rifinire un piano locale esistente nel cloud.
  - Il piano si apre in browser per commenti/revisioni inline.
  - Due modalita' di esecuzione: cloud execution (genera direttamente PR) o "teleport back to terminal" (riporta il piano approvato in locale).
- **Quando usarla**: progettazione di feature complesse multi-file, refactoring grandi, pianificazione che richiederebbe esplorazione lunga in repo grossi.
- **Tips/best practices**:
  - Auto-crea cloud env al primo run (Week 15, aprile 2026).
  - Usare in coppia con `/ultrareview`: ultraplan davanti, ultrareview dietro (pre-merge).
  - Si puo' interrompere il lavoro CLI durante la pianificazione cloud.
- **Prerequisiti**: Claude Code v2.1.91+, account Claude Code on the web, repo GitHub.
- **Annunciata**: aprile 2026 (Week 15: 6-10 aprile). Post X riferimento: https://x.com/trq212/status/2042671370186973589 (paywall).
- **Documentazione**: https://code.claude.com/docs/en/ultraplan

---

## /ultrareview

- **Cosa fa**: lancia una code review multi-agente nel cloud su branch corrente o su PR GitHub. Una flotta di agenti specialisti (security, correctness, architecture, tests, performance, style) analizza la diff in parallelo. Ogni finding e' riprodotto da un agente di verifica indipendente prima di essere riportato in CLI: solo bug verificati, non rumore stilistico.
- **Come si usa**:
  - `/ultrareview` (review della diff fra branch corrente e default branch, include uncommitted/staged).
  - `/ultrareview <PR-number>` (clona PR direttamente da GitHub, richiede remote `github.com`).
  - Prima del lancio: dialog di conferma con scope, run gratuiti rimasti, costo stimato.
  - Tracking: `/tasks` per vedere review attive/completate.
  - User-triggered: nessun subagent o routine puo' lanciarlo per te.
- **Quando usarla**: pre-merge su change sostanziale; non per micro-feedback iterativo (per quello c'e' `/review`).
- **Tips/best practices**:
  - Tipica durata 5-10 minuti, fleet default 5 agenti (provisioning ~90s).
  - La sessione resta libera durante la review.
  - Se la repo e' troppo grossa per il bundle, push branch + open draft PR e usa PR mode.
  - Non disponibile su Bedrock, Vertex AI, Microsoft Foundry, ne' per org con Zero Data Retention.
  - Richiede login Claude.ai (non solo API key).
- **Pricing**: Pro/Max 3 run gratuiti (one-time, scadono 5 maggio 2026); poi billing extra usage ($5-$20/run a seconda della size). Team/Enterprise: solo extra usage. Serve `extra usage` abilitato (`/extra-usage` per controllare).
- **Annunciata**: aprile 2026 (Week 15). Post X riferimento: https://x.com/ClaudeDevs/status/2046999435239133246 (paywall). Disponibile in v2.1.86+.
- **Documentazione**: https://code.claude.com/docs/en/ultrareview

---

## Monitor tool

- **Cosa fa**: tool built-in che spawna un processo background; ogni linea stdout viene streamata nella conversazione come notifica, senza bloccare il main thread. Sostituisce il polling con interrupt push-based.
- **Come si usa**:
  - Esempio canonico (Alistair, Anthropic): `Use the monitor tool and `kubectl logs -f | grep ..` to listen for errors, make a pr to fix`.
  - Pattern "until-condition": `until <check>; do sleep 2; done` per attendere stato e ricevere notifica al completamento.
  - Si puo' aggiungere a Bash con `run_in_background: true` per one-shot wait.
- **Quando usarla**: tail di logs durante coding, watch test runner, watch dev server per errori di compile/runtime, monitor commenti/CI status su PR GitHub, watch deploy.
- **Tips/best practices**:
  - Risparmia token (no polling).
  - Non usare per task one-shot brevi: meglio Bash sync.
  - Lascia che il processo stesso emetta segnale di fine (file/stdout) invece di interrogarlo.
- **Annunciata**: 9 aprile 2026 in Claude Code v2.1.98. Post X: https://x.com/alistaiir/status/2042345049980362819 e https://x.com/noahzweben/status/2042332268450963774 (entrambi paywall).
- **Documentazione**: https://code.claude.com/docs/en/tools-reference

---

## Custom Skill: Excalidraw architecture diagrams

- **Cosa fa**: skill custom (di Yee Fei) che insegna a Claude Code a generare/aggiornare diagrammi di architettura `.excalidraw` analizzando il codebase, con export PNG/SVG via Playwright. Frecce a 90 gradi (no curve), componenti color-coded per tipo (DB, API, storage), label dinamiche.
- **Come si usa**:
  - Install: `/plugin install ccc-skills@ccc` (pacchetto ccc-skills).
  - Trigger naturale: "Genera un diagramma di architettura per questo progetto", "Crea un diagramma excalidraw del sistema", "Esporta in PNG".
  - Funziona su qualsiasi stack (Node.js, Python, Java, Go, Terraform...).
- **Quando usarla**: documentazione living, onboarding, infra Terraform GCP/AWS (testato su EKS+Karpenter+GPU+Rafay con 15+ risorse), refresh automatico quando l'architettura cambia.
- **Tips/best practices**:
  - Two-file pattern: `README.md` come quick start, `SKILL.md` come istruzioni dettagliate per Claude.
  - Approccio "skill-only" senza MCP server: piu' semplice di un MCP custom.
  - Buon esempio di skill markdown-only che insegna un task complesso a Claude.
- **Annunciata**: articolo 11 dicembre 2025 (Yee Fei, Medium). Skill aggiornata e curata nel 2026.
- **Risorse**:
  - Articolo: https://medium.com/@ooi_yee_fei/custom-claude-code-skill-auto-generating-updating-architecture-diagrams-with-excalidraw-431022f75a13
  - Skill repo: https://github.com/ooiyeefei/ccc
  - Esempio: https://github.com/ooiyeefei/rafay-templates
  - Writeup: https://yeefei.beehiiv.com

---

## Skill / Plugin Marketplace

- **Cosa fa**: directory ufficiale e community di plugin (skill + agent + hook + MCP server) installabili via `/plugin install <pkg>@<marketplace>`. Marketplace ufficiale Anthropic: `claude-plugins-official` (~101 plugin a marzo 2026).
- **Come si usa**:
  - `/plugin marketplace list`, `/plugin install <name>`.
  - Marketplace community: `daymade/claude-code-skills`, `alirezarezvani/claude-skills` (232+ skill), `dashed/claude-marketplace` (locale).
- **Quando usarla**: estendere Claude Code senza scrivere codice; condivisione skill in team.
- **Tips/best practices**:
  - Skill = trigger via slash command, run-then-stop. Hook = background event-driven (file write, session start, commit).
  - 770+ MCP server disponibili per integrazione tool/API.
  - Per use case team-specifici, creare marketplace organizzativo.
- **Annunciata**: piattaforma piena pubblica nel Q1 2026. Riferimenti: https://claudemarketplaces.com, https://code.claude.com/docs/en/discover-plugins
- **Documentazione**: https://code.claude.com/docs/en/discover-plugins

---

## Auto Mode

- **Cosa fa**: alternativa piu' sicura a `--dangerously-skip-permissions`. Un classifier decide quali azioni Claude puo' fare senza chiedere e quali bloccare. Esecuzione autonoma "course-correctable".
- **Come si usa**: toggle dalla CLI / settings. In auto mode Claude esegue immediatamente, fa assunzioni ragionevoli su decisioni low-risk, evita di entrare in plan mode.
- **Tips/best practices**: chiede comunque conferma per delete/force-push/reset, non per build/test/edit. Niente data exfiltration verso chat platform senza autorizzazione esplicita.
- **Annunciata**: 24 marzo 2026, Week 13 (https://code.claude.com/docs/en/whats-new). Research preview, ora GA su Max/Team/Enterprise.

---

## Computer use in CLI

- **Cosa fa**: Claude apre app native macOS, clicca UI, testa quello che ha appena scritto direttamente da CLI. Chiude il loop su task che hanno solo GUI (es. validare menu bar app, end-to-end test su Electron).
- **Come si usa**: server computer-use va abilitato. Al primo accesso a un'app, prompt nel terminal con permessi richiesti (clipboard, app hidden) - Allow per sessione/Deny.
- **Prerequisiti**: macOS, Pro o Max, v2.1.85+, sessione interattiva (no `-p`).
- **Annunciata**: Week 14 (30 marzo - 3 aprile 2026). Post X: https://x.com/claudeai/status/2038663014098899416
- **Documentazione**: https://code.claude.com/docs/en/whats-new/2026-w14

---

## /fast (Opus 4.6 Fast Mode)

- **Cosa fa**: routing della richiesta su un serving path piu' rapido di Opus 4.6 (~2.5x). Stesso modello, stessi pesi, stessa qualita': solo latenza ridotta. Non e' downgrade su Haiku/Sonnet.
- **Come si usa**: digitare `/fast` in sessione e premere Tab; appare un'icona fulmine.
- **Pricing**: $30/$150 per MTok (vs base $15/$75). Disponibile su Pro/Max/Team/Enterprise + Console.
- **Limiti**: solo Opus 4.6 (non disponibile su Opus 4.7 e altri modelli).
- **Prerequisiti**: Claude Code v2.1.36+.
- **Annunciata**: 7 febbraio 2026 (preview pubblica anche su GitHub Copilot).
- **Documentazione**: https://code.claude.com/docs/en/fast-mode

---

## 1M Context Window (GA)

- **Cosa fa**: contesto da 1M token GA per Opus 4.6 e Sonnet 4.6 a pricing standard (no multiplier). Sonnet 4.6 a $3/$15 per MTok anche su 900K-token request.
- **Come si usa**: su Max/Team/Enterprise con Opus 4.6, upgrade automatico a 1M senza configurazione. Su Pro va abilitato esplicitamente.
- **Quando usarla**: codebase intero in single request, contratti lunghi, decine di paper, sessioni con cronologia massiva.
- **Annunciata**: 13 marzo 2026. https://claude.com/blog/1m-context-ga
- **Documentazione**: https://platform.claude.com/docs/en/build-with-claude/context-windows

---

## /team-onboarding

- **Cosa fa**: scansiona gli ultimi 30 giorni di uso Claude Code (workflow, comandi, pattern) e genera una guida di onboarding strutturata e replayable per nuovi membri del team.
- **Come si usa**: `/team-onboarding` in sessione.
- **Quando usarla**: onboarding nuovi developer, audit interno dei workflow, knowledge transfer.
- **Annunciata**: aprile 2026 (Week 15).

---

## /autofix-pr

- **Cosa fa**: dopo aver lavorato a una PR localmente, lancia `/autofix-pr` e tutta la sessione (history, edit, reasoning) viene shippata al cloud, che continua a fixare la PR (pattern: "plan locally, execute remotely, monitor from your phone").
- **Come si usa**: `/autofix-pr` in CLI dopo aver finito la prima passata locale.
- **Annunciata**: aprile 2026 (Week 15) da Noah Zweben.
- **Documentazione**: https://code.claude.com/docs/en/whats-new

---

## Sandbox mode update

- **Cosa fa**: enforcement OS-level su Bash e child processes. Filesystem isolation (Claude vede solo dir whitelisted) + network isolation (solo host approvati). Riduce permission prompt dell'84% in uso interno.
- **Modalita'**: auto-allow (Bash dentro sandbox passa senza prompt; cmd non sandboxabili tornano al permission flow normale) + explicit deny rules per `rm`/`rmdir` su path critici.
- **Aggiornamenti aprile 2026**: v2.1.113-v2.1.117 (17-22 aprile) hanno tightening su bash sandbox + security checks. Possibili leggermente piu' prompt su edge case.
- **Documentazione**: https://code.claude.com/docs/en/sandboxing
- **Background**: https://www.anthropic.com/engineering/claude-code-sandboxing

---

## Altre feature minori (Week 13-15)

- **PR auto-fix on Web** (Week 13).
- **Transcript search** con `/` (Week 13).
- **Native PowerShell tool** per Windows (Week 13).
- **Conditional `if` hooks** (Week 13).
- **Computer use in Desktop app** (Week 13).
- **`/powerup`** lezioni interattive (Week 14).
- **Flicker-free alt-screen rendering** (Week 14).
- **Per-tool MCP result-size override** fino a 500K (Week 14).
- **Plugin executables sul `PATH` di Bash tool** (Week 14).
- **Desktop redesign** con multi-session sidebar, terminal integrato, file editing, HTML/PDF preview, drag-and-drop layout (lanciato con Routines, 14 aprile).

---

## ScheduleWakeup tool / Agent harness Hashimoto

Non trovata documentazione ufficiale di un tool con nome esatto `ScheduleWakeup` su `code.claude.com` o blog Anthropic ad aprile 2026. Riferimenti su scheduling sono coperti da Routines + `/loop` + Desktop scheduled tasks. Il riferimento a "Hashimoto Feb 2026" / "agent harness" non risulta direttamente reperibile come post pubblico ufficiale: potrebbe essere internal o in una cerchia di accesso ristretto. **Da verificare** con il team-lead se ha link diretto.

---

## Tips trasversali (dai thread X e tutorial)

1. **Pattern "plan locally, execute remotely"**: usa CLI per la parte creativa (capire problema, decidere approccio), poi shippa tutto al cloud con `/ultraplan` o `/autofix-pr`. Monitora da telefono.
2. **Cloud + locale combinati**: `/ultraplan` per design + `/ultrareview` pre-merge + `Routines` per ricorrenze + `/loop` per check intra-sessione.
3. **Triggers GitHub > Schedule** (Pro plan): il quota giornaliero e' solo sugli scheduled, webhook e API non contano.
4. **Sempre testare con "Run now"** prima di mettere in schedule una routine.
5. **Boundary esplicite nel prompt** delle routine: `do not merge`, `do not modify > N files`, `dry run`.
6. **Self-pacing `/loop`** (no interval): il modello decide quando ri-eseguire, utile per task non strettamente periodici.
7. **Monitor tool > polling**: risparmia token e reagisce in tempo reale.
8. **Skill markdown-only > MCP custom** quando il task e' istruzionale e non richiede tool nuovi (es. Excalidraw skill di Yee Fei).
9. **`/extra-usage` check obbligatorio** prima di lanciare ultrareview a pagamento.
10. **`/compact` periodico** in sessioni `/loop` lunghe.
11. **`tmux`/`screen`** per loop persistenti (la sessione muore col terminale).
12. **`/fast` per Opus 4.6** quando vuoi velocita' senza sacrificare qualita': stesso modello, 2.5x piu' veloce.
13. **1M context su Max/Team/Enterprise e' automatico**: non serve flag.
14. **Auto mode > `--dangerously-skip-permissions`**: sicurezza con velocita' simile.
15. **Output strutturato** in routine/loop: chiedi JSON per machine-readability.

---

## Fonti principali

- Blog Routines: https://claude.com/blog/introducing-routines-in-claude-code
- Docs What's new: https://code.claude.com/docs/en/whats-new
- Docs ultrareview: https://code.claude.com/docs/en/ultrareview
- Docs ultraplan: https://code.claude.com/docs/en/ultraplan
- Docs scheduled tasks: https://code.claude.com/docs/en/scheduled-tasks
- Docs web routines: https://code.claude.com/docs/en/web-scheduled-tasks
- Docs sandboxing: https://code.claude.com/docs/en/sandboxing
- Docs fast mode: https://code.claude.com/docs/en/fast-mode
- Blog 1M context GA: https://claude.com/blog/1m-context-ga
- Computer use post X: https://x.com/claudeai/status/2038663014098899416
- Monitor tool post X (Alistair): https://x.com/alistaiir/status/2042345049980362819
- Articolo Excalidraw skill: https://medium.com/@ooi_yee_fei/custom-claude-code-skill-auto-generating-updating-architecture-diagrams-with-excalidraw-431022f75a13
- Skill repo Excalidraw: https://github.com/ooiyeefei/ccc
- Marketplace plugins: https://claudemarketplaces.com
- 9to5Mac coverage Routines: https://9to5mac.com/2026/04/14/anthropic-adds-repeatable-routines-feature-to-claude-code-heres-how-it-works/
- Auto mode guide: https://claudefa.st/blog/guide/development/auto-mode

> Nota: i post X originali (claudeai, noahzweben, trq212, ClaudeDevs) sono dietro paywall/auth e non sono stati raggiunti con WebFetch (HTTP 402). Le informazioni sono state ricostruite da copertura terza affidabile (docs ufficiali, 9to5Mac, SiliconANGLE, Medium, MindStudio, Verdent, ClaudeDirectory, claudefa.st).
