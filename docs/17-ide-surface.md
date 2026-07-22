# 17 — IDE e altre surface

> 📍 [README](../README.md) → [Integrazione](../README.md#integrazione) → **17 IDE & surface**
> 🔧 Operational · 🟢 Beginner-friendly

VS Code, JetBrains, Desktop, Web, Slack, Channels, Remote Control. Tutti i modi di parlare a Claude Code oltre al terminale.

## Cosa e' concettualmente

> Le surface sono **viste differenti dello stesso harness**. CLAUDE.md, settings, skill, plugin, MCP funzionano cross-surface (configura una volta, vale ovunque). Cambia solo l'UI: terminale (CLI), inline diff (VS Code), multi-session sidebar (Desktop), cloud (Web), sincronizzazione cross-device (Remote Control).

**Modello mentale**: come Gmail web vs Gmail mobile vs Mail.app — stessa mailbox, UI diverse, scelte secondo contesto.

**Componente harness IMPACT**: trasversale (l'harness sta sotto tutte le surface).

**Per il deep-dive**: [01 — Snapshot § 1.2 Surface](./01-snapshot.md#12-surface---dove-si-usa-claude-code).

---

## 17.1 VS Code

Estensione: `vscode:extension/anthropic.claude-code`. Requires VS Code 1.98.0+.

### Features GUI

- Inline diff con permission prompt
- @-mentions con file:line ranges (`Option+K` / `Alt+K`)
- Plan review (markdown editor con inline comments)
- Conversation history (Local + Remote tabs per claude.ai web sessions)
- Multiple tabs / windows
- Spark icon in Editor Toolbar / Activity Bar / Status Bar
- Drag panel su Sidebar / Secondary sidebar / Editor area
- `/plugins` UI graphical
- `@browser` con [Claude in Chrome extension](https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn) (v1.0.36+)
- Built-in `ide` MCP server (`mcp__ide__getDiagnostics`, `mcp__ide__executeCode` con Quick Pick confirmation per Jupyter)

### Permission modes UI

- **Ask before edits** (`default`)
- **Edit automatically** (`acceptEdits`)
- **Plan mode** (`plan`)
- **Auto mode** (`auto`) — richiede `allowDangerouslySkipPermissions`
- **Bypass permissions** (`bypassPermissions`)

### Settings (Extensions → Claude Code)

| Setting | Default | Note |
|---|---|---|
| `useTerminal` | false | Run in integrated terminal |
| `initialPermissionMode` | default | Permission mode all'apertura |
| `preferredLocation` | sidebar | sidebar / panel |
| `autosave` | true | |
| `useCtrlEnterToSend` | false | Send con Ctrl/Cmd+Enter invece di Enter |
| `enableNewConversationShortcut` | true | Cmd+N |
| `hideOnboarding` | false | |
| `respectGitIgnore` | true | |
| `usePythonEnvironment` | true | |
| `environmentVariables` | {} | |
| `disableLoginPrompt` | false | |
| `allowDangerouslySkipPermissions` | false | |
| `claudeProcessWrapper` | "" | Script che wrappa il process |

### URI handler

```
vscode://anthropic.claude-code/open?prompt=<urlencoded>&session=<id>
```
Per launch da scripts/bookmarklet.

### Limitations vs CLI

| Feature | CLI | VS Code |
|---|---|---|
| Commands/skills | All | Subset |
| MCP config | Yes | Partial (add via CLI) |
| Checkpoints | Yes | Yes |
| `!` bash shortcut | Yes | No |
| Tab completion | Yes | No |

> Fonte: [`/en/vs-code`](https://code.claude.com/docs/en/vs-code).

---

## 17.2 JetBrains

[Plugin marketplace](https://plugins.jetbrains.com/plugin/27310-claude-code-beta-). IntelliJ, PyCharm, WebStorm, GoLand, RubyMine, ecc.

Runs in IDE terminal: switching modes uguale al CLI. `Cmd+Esc` quick toggle.

---

## 17.3 Desktop app (`/en/desktop`)

Standalone macOS / Windows / Windows ARM64. Visual diff review, parallel sessions, scheduled tasks, cloud kick-off.

### Redesign mar 2026
> "We've redesigned Claude Code on desktop. You can now run multiple Claude sessions side by side from one window, with a new sidebar to manage them all." — [@claudeai](https://x.com/claudeai/status/2044131493966909862)

Features:
- Multi-session sidebar
- Terminal integrato
- File editing
- HTML/PDF preview
- Drag-and-drop layout

### Auth
Richiede paid subscription. **Sessions from Dispatch**: messaggia da phone, apri Desktop session.

### Computer use in Desktop
Da Week 13: Claude apre app native, click UI, verifica. Vedi [17.7 Computer use](#computer-use).

> Annuncio Claude Code in Desktop: [@_catwu](https://x.com/_catwu/status/2008628736409956395)

### Browser in-app (10 lug 2026)

Claude Code su Desktop include ora un browser integrato, sandboxato: Claude apre documentazione, design o qualsiasi sito esterno, legge la pagina, clicca ed interagisce — stesso modello gia' usato per i dev server locali, ma esteso al web pubblico. Elimina il copia-incolla di link tra browser esterno e sessione.

- **Attivazione**: `Ctrl+Shift+B` (Windows) / `Cmd+Shift+B` (macOS)
- **Sessioni**: persistenza configurabile — utile per login (incluso OAuth Google) che devono sopravvivere tra un task e l'altro
- **Permessi per-sito**: al primo accesso a un dominio, Claude chiede `Allow once` / `Always allow` / `Deny`, coerente col resto del modello di permission
- **Isolamento**: il browser gira sandboxato, separato dal browser di sistema dell'utente

Nome MCP server riservato lato client: `Claude Browser` (insieme a `Claude Preview`) — i server MCP configurati dall'utente non possono registrarsi sotto questi nomi.

> Annuncio: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2075635283211772279)

<sub>Aggiornato 2026-07-12 via daily what's new. Fonte: [@ClaudeDevs](https://x.com/ClaudeDevs/status/2075635283211772279).</sub>

### iOS Simulator pane (beta, 21 lug 2026)

Claude Code Desktop apre un pannello **iOS Simulator** accanto alla conversazione ogni volta che Claude builda, installa, lancia o verifica un'app iOS — nessun comando o setting da attivare, si apre da solo quando serve. Ogni sessione ha un simulator indipendente (fino a 4 device per sessione), e la vista segue la sessione attiva nella sidebar.

- **Come funziona**: il pannello pilota il simulator direttamente (non serve computer use, ne' i permessi macOS Accessibility/Screen Recording) — Claude installa l'app, ci tocca dentro e legge lo schermo per verificare da solo le modifiche fatte
- **Controllo condiviso**: tap/swipe cliccando sullo schermo, tasti hardware (`Cmd+Shift+H` Home, `Cmd+L` Lock, rotazione con `Cmd+Right Arrow`), screenshot (`Cmd+S`) e screen recording (`Cmd+R`) salvati sul Desktop
- **Permessi**: consenso one-time per device (non per sessione) al primo utilizzo; l'apertura di URL sul device e la build (`xcodebuild`) seguono invece il permission mode della sessione. Disattivabile via `disableMobileSimulatorTools` managed setting
- **Requisiti**: Claude Desktop v1.24012.0+, macOS, Xcode con piattaforma iOS installata. Solo sessioni locali (non disponibile in cloud/SSH session, che girano su una macchina senza accesso ai simulator del tuo Mac)
- **Piani**: Pro, Max, Team (non disponibile su Enterprise). Supporto Android simulator annunciato come "in lavorazione"

Da CLI (non Desktop), Claude raggiunge invece l'iOS Simulator via [computer use](#computer-use) tradizionale, pilotando lo schermo come farebbe un utente con mouse e tastiera.

> Fonte: [docs ufficiali](https://code.claude.com/docs/en/desktop-ios-simulator) · [@ClaudeDevs](https://x.com/ClaudeDevs/status/2079674432038248611)

<sub>Aggiornato 2026-07-22 via daily what's new. Fonte: [docs ufficiali](https://code.claude.com/docs/en/desktop-ios-simulator) · [@ClaudeDevs](https://x.com/ClaudeDevs/status/2079674432038248611).</sub>

---

## 17.4 Web (`/en/claude-code-on-the-web`)

URL: [claude.ai/code](https://claude.ai/code). Cloud session (fresh repo clone). Mobile via iOS app.

### Comandi correlati
- `--remote "<task>"` per kick-off cloud session da CLI
- `--teleport` per pull session locale
- `/web-setup` per connect GitHub
- `/ultraplan` e `/ultrareview` lanciano cloud session

### Cosa gira in cloud
- Routines (vedi [13](./13-routines-cloud.md))
- Ultraplan (vedi [15](./15-ultraplan-ultrareview.md))
- Ultrareview (vedi [15](./15-ultraplan-ultrareview.md))
- Cloud Auto-Fix PR (vedi [13](./13-routines-cloud.md#13.10-esempi-pratici))
- Code Review (PR agents) GA

### Annuncio Claude Code on the web
- [@_catwu](https://x.com/_catwu/status/1980338889958257106): ott/nov 2025

---

## 17.5 Slack (`/en/slack`)

Setup: `/install-slack-app`.

Mention `@Claude` in canale o thread con bug report → Claude apre PR. Integrazione con `/install-github-app`.

---

## 17.6 Remote Control {#remote-control}

> "Continue local Claude Code sessions from your phone."

Lanciato **feb 2026** (research preview Max), GA mar 2026 ([@_catwu](https://x.com/_catwu/status/2026421789476401182)).

### Cosa fa
Collega la sessione locale a `claude.ai/code`, app iOS e Android. Conversazione sincronizzata cross-device.

### Trigger
```bash
/remote-control                      # in sessione (CLI)
claude --remote-control [name]       # CLI flag
claude --rc [name]                   # alias
```

### Comandi attivi anche da remoto
`/context`, `/exit`, `/reload-plugins`, `/extra-usage`, `/color`. Push notification opzionali (v2.1.110).

### Limiti
- 1 sola connessione remota per istanza
- Terminale deve restare aperto
- Timeout di rete 10 min
- Solo Pro/Max

### Architettura
- Outbound HTTPS only
- Nessuna porta aperta in entrata
- Auth tramite claude.ai

### Remote Control in VSCode
[@noahzweben](https://x.com/noahzweben/status/2034452278971932695): "Remote Control in VSCode" + drop VSCode (mar 2026).

> Fonte: [`/en/remote-control`](https://code.claude.com/docs/en/remote-control).

---

## 17.7 Computer use {#computer-use}

> "Computer use is now in Claude Code. Claude can open your apps, click through your UI, and test what it built, right from the CLI." — [@claudeai](https://x.com/claudeai/status/2038663014098899416)

### Lancio
- Desktop: Week 13 (24 mar 2026)
- CLI: Week 14 (30 mar – 3 apr 2026), v2.1.85+

### Use case
- Validare menu bar app
- End-to-end test su Electron
- Test UI native macOS dopo refactor

### Prerequisiti
- macOS only
- Pro o Max
- Sessione interattiva (no `-p`)

### Setup
Server computer-use va abilitato. Al primo accesso a un'app, prompt nel terminal con permessi richiesti (clipboard, app hidden) — Allow per sessione / Deny.

> Fonte: [`/en/whats-new/2026-w14`](https://code.claude.com/docs/en/whats-new/2026-w14).

---

## 17.8 Channels (research preview)

MCP server pushano eventi nella sessione attiva (notifications real-time invece di polling). Sorgenti tipiche: Telegram, Discord, iMessage, webhook custom.

Vedi [10 MCP § 10.8 Channels](./10-mcp.md#10.8-channels-research-preview).

---

## 17.9 GitHub Actions / GitLab CI/CD

`/install-github-app` per setup. Vedi anche [16 Headless](./16-headless-agent-sdk.md#16.3-github-actions-ci) per pipeline esempi.

---

## 17.10 Mobile (iOS app + Android via web)

- iOS app: download da App Store
- Android: via mobile web (claude.ai/code)
- `/mobile` (alias `/ios`, `/android`) → QR code per setup app
- Funzioni mobile: Remote Control, Routines control, push notifications, brief mode

---

## 17.11 Claude in Chrome (GA, da v2.1.198)

**Claude in Chrome** diventa generally available con v2.1.198: accesso browser-native alle sessioni e agli agenti Claude Code, senza installazione di estensioni aggiuntive o configurazione MCP manuale.

### Cosa offre

- Apri qualsiasi sessione Claude Code attiva direttamente dal browser
- Interagisci con gli agenti in Agent View senza aprire il terminale
- Usa `@browser` in VS Code per far leggere a Claude la pagina web corrente (da v1.0.36+, ora GA)
- Accesso a Remote Control cross-device via browser su dispositivi senza app iOS/Android

### Come si attiva

```bash
# In una sessione Claude Code attiva
/remote-control          # attiva il canale Remote Control
# poi apri claude.ai/code dal browser — la sessione appare automaticamente
```

La Chrome extension ([chromewebstore.google.com](https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn)) era gia' disponibile come `@browser` mention in VS Code; con il GA diventa surface ufficiale di prima classe con Agent View completa.

### Differenza rispetto a Remote Control

Remote Control (17.6) sincronizza la sessione CLI verso dispositivi mobili. Claude in Chrome e' la versione browser-first: nessun terminale aperto necessario, nessuna app da installare.

> Fonte: [GitHub Releases v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198) · [@ClaudeCodeLog](https://x.com/ClaudeCodeLog/status/2072425697629343845).

<sub>Aggiornato 2026-07-02 via daily what's new. Fonte: [GitHub Releases v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198).</sub>

---

## 17.12 Ecosystem: tool esterni e GUI di terze parti

Oltre alle surface ufficiali Anthropic (CLI, Desktop, VS Code, JetBrains, Web, Slack, Mobile), esistono **tool esterni** che integrano Claude Code in modi specifici. Non sono parte del core ma vale la pena conoscerli.

> ⚠️ Disclaimer: questi sono prodotti di terze parti, non maintained da Anthropic. Funzionalita' e roadmap possono cambiare.

### 17.12.1 Conductor — GUI per Claude Code paralleli

[Conductor](https://conductor.build) e' un'app desktop macOS che permette di eseguire **piu' istanze di Claude Code in parallelo**, ciascuna in un workspace isolato (git worktree).

**Caratteristiche**:
- **Workspace isolati**: ogni Claude Code ottiene un ambiente separato basato su git worktrees
- **Gestione visuale**: vedi a colpo d'occhio chi sta lavorando, chi e' bloccato, cosa e' cambiato
- **Integrazione GitHub**: lavora su issue con un click, aggiunta repo privati semplificata
- **Sessioni persistenti**: terminali persistono quando navighi tra workspace
- **Coda messaggi**: invia piu' messaggi che vengono processati in ordine

**Come funziona**:
1. Aggiungi il tuo repo: Conductor lo clona localmente sul Mac
2. Distribuisci agenti: ogni Claude Code che avvii ottiene un workspace isolato
3. Conduci: vedi chi lavora, cosa richiede attenzione, rivedi il codice

**Auth**: Conductor riusa la tua sessione esistente Claude Code (API key, Pro o Max).

**Quando usarlo**: se gestisci 5+ agenti paralleli quotidianamente e l'overhead di tmux/terminale ti costa tempo. La CLI nativa con `claude --worktree` (vedi [02 § flag worktree](./02-cli-installazione.md)) e' sufficiente per la maggior parte degli usi.

### 17.12.2 Altri tool community

| Tool | Cosa fa | Status |
|---|---|---|
| `ralph-wiggum` plugin | Loop autonomo overnight (originally dreamt up by [@GeoffreyHuntley](https://github.com/GeoffreyHuntley)) | Citato da [@bcherny](https://x.com/bcherny/status/2007179858435281082) come pattern community |
| `claude-code-skills` (daymade) | Marketplace community skill | Vedi [11 § marketplace community](./11-plugins-marketplace.md) |
| `claude-skills` (alirezarezvani) | 232+ skill community | Vedi [11 § marketplace community](./11-plugins-marketplace.md) |
| `ccc-skills` (ooiyeefei) | Skill custom Excalidraw architecture diagrams | Vedi [09 § esempio Excalidraw](./09-skills.md) |

> Per skill ufficiali vedi [11 § marketplace ufficiale](./11-plugins-marketplace.md). Per il pattern community piu' generale, vedi [22 § community patterns](./22-compound-engineering.md).

---

## 17.11 Fonti aggregate

- VS Code: [`/en/vs-code`](https://code.claude.com/docs/en/vs-code)
- JetBrains: [`/en/jetbrains`](https://code.claude.com/docs/en/jetbrains)
- Desktop: [`/en/desktop`](https://code.claude.com/docs/en/desktop)
- Web: [`/en/claude-code-on-the-web`](https://code.claude.com/docs/en/claude-code-on-the-web)
- Slack: [`/en/slack`](https://code.claude.com/docs/en/slack)
- Remote Control: [`/en/remote-control`](https://code.claude.com/docs/en/remote-control)
- Channels: [`/en/channels`](https://code.claude.com/docs/en/channels)
- GitHub Actions: [`/en/github-actions`](https://code.claude.com/docs/en/github-actions)

---

← [16 Headless & Agent SDK](./16-headless-agent-sdk.md) · Successivo → [18 Settings & Auth](./18-settings-auth.md)
