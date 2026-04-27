# Dossier X — Engineers Claude Code (@noahzweben, @trq212)

Periodo coperto: novembre 2025 → aprile 2026.
Metodo: WebFetch diretto su x.com bloccato (HTTP 402) e nitter.net non popolato. I contenuti sono stati ricostruiti via WebSearch (snippet ufficiali da risultati X.com). Citazioni testuali quando lo snippet le riporta integralmente; parafrasi italiana per il resto. Tutti i link puntano ai post originali x.com.

---

## @noahzweben (Anthropic — PM Claude Code)

- **Post 1** | 2026-02 (research preview) | **Remote Control**
  Testo (citazione): "Announcing a new Claude Code feature: Remote Control. It's rolling out now to Max users in research preview. Try it with /remote-control. Start local sessions from the terminal, then continue them from your phone. Take a walk, see the sun, walk your dog without losing your flow."
  URL: https://x.com/noahzweben/status/2026371260805271615

- **Post 2** | marzo 2026 | **Remote Control in VSCode + drop VSCode**
  Testo (citazione): "A few 🔥 Claude Code VSCode drops — 1. Remote Control in VSCode …"
  URL: https://x.com/noahzweben/status/2034452278971932695

- **Post 3** | marzo 2026 | **Scheduled cloud tasks (precursore Routines)**
  Testo (citazione): "You can now schedule recurring cloud-based tasks on Claude Code. Set a repo (or repos), a schedule, and a prompt. Claude runs it via cloud infra on your schedule, so you don't need to keep Claude Code running on your local machine."
  URL: https://x.com/noahzweben/status/2035122989533163971

- **Post 4** | marzo 2026 | **Claude Code Auto-Fix in cloud**
  Testo (citazione): "Thrilled to announce Claude Code auto-fix – in the cloud. Web/Mobile sessions can now automatically follow PRs - fixing CI failures and addressing comments so that your PR is always green. This happens remotely so you can fully walk away and come back to a ready-to-go PR."
  URL: https://x.com/noahzweben/status/2037219115002405076

- **Post 5** | 2026-04-09 | **Monitor tool** (post noto)
  Testo (citazione): "Thrilled to announce the Monitor tool which lets Claude create background scripts that wake the agent up when needed. Big token saver and great way to move away from polling in the agent loop. Claude can now: * Follow logs for errors * Poll PRs via script * and more!"
  URL: https://x.com/noahzweben/status/2042332268450963774

- **Post 6** | 2026-04-09/10 | **/loop dinamico** (post noto)
  Testo (citazione): "Claude now supports dynamic looping. If you run /loop without passing an interval, Claude will dynamically schedule the next tick based on your task. It also may directly use the Monitor tool to bypass polling altogether. /loop check CI on my PR"
  URL: https://x.com/noahzweben/status/2042670949003153647

- **Post 7** | 2026-04-14 | **Claude Code Routines GA**
  Testo (citazione): "Claude Code Routines are here! In addition to a schedule, you can now trigger templated agents via GitHub event or API – with our infra & your MCP+repos. They've changed how we do docs, backlog maintenance and more internally at Anthropic. Get started at …"
  URL: https://x.com/noahzweben/status/2044093913376706655

- **Post 8** | 2026-04 | **Claude Desktop redesign (retweet/commento)**
  Testo (citazione): "Been incredible watching this labor of love from a incredibly talented, kind, and thoughtful human being. He's channeled weeks of feedback into an amazing redesign of the Claude Desktop app!"
  URL: https://x.com/noahzweben/status/2044135997894734132

---

## @trq212 — Thariq (Anthropic — engineer Claude Code)

- **Post 1** | 2025 (pre-finestra ma di contesto, citato per filo conduttore) | **"Claude Code is All You Need"**
  Testo (citazione): "Claude Code is All You Need. When I first joined Anthropic I was surprised to learn that lots of the team used Claude Code as a general agent, not just for code. I've since become a convert! I use Claude Code to help me with almost all the work I do now, here's how: …"
  URL: https://x.com/trq212/status/1944877527044120655

- **Post 2** | 2026-04-09 | **Tip: Monitor tool + dev server**
  Testo (citazione): "you'll need to explicitly prompt Claude Code to use it, but the Monitor Tool is super powerful. e.g. \"start my dev server and use the MonitorTool to observe for errors\""
  URL: https://x.com/trq212/status/2042335178388103559

- **Post 3** | 2026-04-09/10 | **/ultraplan** (post noto)
  Testo (citazione): "New in Claude Code: /ultraplan. Claude builds an implementation plan for you on the web. You can read it and edit it, then run the plan on the web or back in your terminal. Available now in preview for all users with CC on the web enabled."
  URL: https://x.com/trq212/status/2042671370186973589

- Ulteriori post di @trq212 nel periodo nov 2025 – apr 2026 non sono direttamente accessibili via WebFetch (status 402) e non sono emersi via WebSearch oltre quelli sopra. Annotato: **non accessibile via WebFetch**. Da rifinire con accesso autenticato a X.

---

## Sintesi feature emerse

### /loop (dynamic looping)
- Cosa fa: esegue ripetutamente un prompt/slash command. Senza intervallo, Claude pianifica dinamicamente il prossimo tick in base al task; può usare direttamente Monitor per evitare polling.
- Esempio: `/loop check CI on my PR` — `/loop 5m /foo` per cadenza fissa.
- Fonte: https://x.com/noahzweben/status/2042670949003153647

### Monitor tool
- Cosa fa: Claude lancia uno script di background; ogni riga stdout diventa un evento che "sveglia" l'agente nel thread principale, senza bloccare. Sostituisce il polling time-driven con eventi.
- Casi d'uso: follow log per errori, poll PR via script, watch dev server (Next.js/Vite) per build error, watch GitHub PR per nuovi commenti / status checks.
- Esempio (Thariq): "start my dev server and use the MonitorTool to observe for errors".
- Esempio (Alistair, lancio): `Use the monitor tool and \`kubectl logs -f | grep ..\` to listen for errors, make a pr to fix`.
- Lancio: 2026-04-09 (Week 15 changelog).
- Fonti: https://x.com/noahzweben/status/2042332268450963774 ; https://x.com/trq212/status/2042335178388103559 ; https://x.com/alistaiir/status/2042345049980362819

### /ultraplan
- Cosa fa: delega la fase di planning complesso da CLI locale a una sessione Claude Code on the web in plan mode. Claude analizza il codice nel cloud e genera un piano completo; puoi rivedere/commentare/iterare nel browser e poi eseguire il piano sul web o tornando in terminale.
- Disponibilità: research preview, richiede Claude Code v2.1.91+ e CC on the web abilitato.
- Lanci: `/ultraplan <prompt>`, parola chiave `ultraplan` in un prompt normale, o "refine with Ultraplan" da plan mode locale.
- Fonti: https://x.com/trq212/status/2042671370186973589 ; https://code.claude.com/docs/en/ultraplan

### Remote Control
- Cosa fa: collega la sessione locale Claude Code a claude.ai/code, app iOS e Android. Conversazione sincronizzata cross-device (terminale, browser, mobile). Outbound HTTPS only, nessuna porta aperta in entrata.
- Comandi attivi anche da remoto: `/context`, `/exit`, `/reload-plugins`. Push notification opzionali.
- Limiti: 1 sola connessione remota per istanza, terminale deve restare aperto, timeout di rete 10 min. Solo Pro/Max.
- Trigger: `/remote-control`.
- Fonte: https://x.com/noahzweben/status/2026371260805271615

### Cloud Auto-Fix (PR follow)
- Cosa fa: una sessione web/mobile segue un PR e fixa automaticamente CI failure e commenti review nel cloud, così il PR resta sempre verde anche se chiudi il laptop.
- Fonte: https://x.com/noahzweben/status/2037219115002405076

### Scheduled cloud tasks (precursore di Routines)
- Cosa fa: scheduling di task ricorrenti su Claude Code lato cloud — set di repo + cron + prompt. L'agente gira sull'infra Anthropic, niente CC locale acceso.
- Fonte: https://x.com/noahzweben/status/2035122989533163971

### Claude Code Routines (GA del precedente)
- Cosa fa: oltre allo schedule, trigger via evento GitHub o chiamata API. Usa MCP e repo dell'utente sull'infra Anthropic. Internamente in Anthropic usate per docs e backlog maintenance.
- Lancio: 2026-04-14. Limiti: Pro 5 schedule trigger/giorno, Team/Enterprise 25/giorno.
- Fonte: https://x.com/noahzweben/status/2044093913376706655 ; https://code.claude.com/docs/en/whats-new

### Remote Control in VSCode
- Cosa fa: porta il flusso Remote Control dentro l'estensione VSCode.
- Fonte: https://x.com/noahzweben/status/2034452278971932695

---

## Note metodologiche
- WebFetch su x.com → HTTP 402 (auth wall). nitter.net pagine vuote.
- Tutti i contenuti dei post sono stati ricavati da snippet ufficiali di risultati di ricerca che riportano titolo X (`username on X: "<full text>"`).
- Per @trq212 la timeline completa nel periodo non è stata ricostruibile esaustivamente: integrare con accesso autenticato in una passata successiva.
