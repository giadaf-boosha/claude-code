# What's new — Archivio storico

> 📍 [README](../README.md) → **Archivio "What's new today"**
> 📚 Riferimento

Archivio degli aggiornamenti giornalieri "What's new today" generati dall'[automazione daily](../automations/daily-whats-new/).

Il README master mostra **solo l'aggiornamento del giorno corrente**. Quando ne arriva uno nuovo, il precedente viene archiviato qui.

**Politica di retention**: ultimi 30 giorni. Le entry piu' vecchie sono cancellate (per evitare crescita illimitata del file). La storia completa resta comunque tracciabile via `git log README.md`.

---

## 2026-04-28

- **PostToolUse output override universale** (v2.1.121): i PostToolUse hook possono ora sostituire l'output di qualsiasi tool tramite `hookSpecificOutput.updatedToolOutput`, non solo MCP — abilita trasformazioni inline prima che Claude legga il risultato. Doc: [07 Hooks](../docs/07-hooks.md).
- **MCP `alwaysLoad`** (v2.1.121): il campo `alwaysLoad: true` su un server MCP bypassa la tool-search deferral, rendendo tutti i tool del server sempre disponibili senza ricerca preventiva. Doc: [10 MCP](../docs/10-mcp.md).

---

## Come consultare la storia completa

```bash
# Tutte le entry "What's new today" mai pubblicate
git log --all --oneline --grep="what's new" -- README.md

# Diff di una giornata specifica
git log --all --grep="what's new YYYY-MM-DD" -p -- README.md
```

---

## Riferimenti

- [Automazione daily](../automations/daily-whats-new/) — README, prompt, setup
- [docs/19 — Changelog completo](./19-changelog.md) — versione per versione
- [docs/13 — Routines cloud](./13-routines-cloud.md) — come funziona la routine

← [README master](../README.md)
