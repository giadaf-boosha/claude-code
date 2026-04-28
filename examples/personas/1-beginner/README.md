# Persona 1 — Beginner / Non-coder

> Founder, product manager, vibe coder, creator senza esperienza di programmazione.

## Setup di questo template

| Aspetto | Valore | Perche' |
|---|---|---|
| **Plan** | Pro ($20/mese) | Sufficiente per esplorare; upgrade Max quando l'uso supera 2h/giorno |
| **Surface** | Desktop app + Web (`claude.ai/code`) | UX visiva, niente terminale |
| **Sandbox** | ON (default macOS) | Protezione filesystem |
| **Fast mode** | NO | Costo extra non giustificato |
| **Auto mode** | NO | Plan mode obbligatorio: imparare cosa fa Claude prima |
| **Default permission** | `ask` | Approvazione esplicita |

## File inclusi

- [`CLAUDE.md`](./CLAUDE.md) — regole base in italiano semplice
- [`.claude/settings.json`](./.claude/settings.json) — permission rules safe
- [`.claude/skills/spiega-prima/SKILL.md`](./.claude/skills/spiega-prima/SKILL.md) — skill che chiede a Claude di spiegare prima di agire

## Come applicare al tuo progetto

```bash
cp CLAUDE.md /tuo/progetto/
cp -r .claude /tuo/progetto/
cd /tuo/progetto/
claude
```

Edita `CLAUDE.md`: sostituisci `<NOME PROGETTO>` e `<DESCRIZIONE>` con i tuoi dati.

## Cosa NON fare (anti-pattern Beginner)

1. **Non disabilitare permission prompt "perche' fastidiosi"** — sono la tua rete di sicurezza
2. **Non installare MCP server casuali** — rischio data leak. Solo da [marketplace ufficiale](https://claude.com/plugins)
3. **Non chiedere `git push --force` senza un dev di fianco** — rollback complesso

## Approfondimenti

- [docs/21 § 1 Beginner](../../../docs/21-guide-target-user.md#1-beginner--non-coder)
- [docs/04 — Modalita' permessi](../../../docs/04-modalita-permessi.md)
- [docs/06 — CLAUDE.md & memory](../../../docs/06-claude-md-memory.md)
- [docs/QUICKSTART](../../../docs/QUICKSTART.md) — primi 60 minuti

← Torna a [examples/personas](../README.md)
