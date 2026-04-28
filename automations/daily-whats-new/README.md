# Automazione: Daily "What's new today"

> Ogni giorno alle **07:00 Europe/Rome** un agent legge changelog ufficiale Claude Code + post X dei team Anthropic, identifica novita' delle ultime 24h, aggiorna la sezione "What's new today" in cima al README e linka contestualmente i punti della repo dove le info sono integrate.

## Cosa fa

1. **Ricerca novita'** (ultime 24h):
   - Changelog ufficiale: https://code.claude.com/docs/en/changelog
   - Weekly recap: https://code.claude.com/docs/en/whats-new
   - Post X di: `@bcherny @_catwu @noahzweben @trq212 @claudeai @ClaudeDevs @alistaiir @ClaudeCodeLog`
   - Anthropic news blog: https://www.anthropic.com/news
2. **Cross-check** con stato repo (README, `docs/19-changelog.md`, `posts/`)
3. **Genera TLDR** (max 10 voci/giorno) con tipo (feature / fix / tip / annuncio / release / post X), sintesi 1 riga, fonte
4. **Aggiorna README.md** sezione `## 🆕 What's new today (YYYY-MM-DD)` in cima
5. **Linka contestualmente** ogni voce ai capitoli rilevanti della repo
6. **Archivia** la sezione del giorno precedente in [`docs/whats-new-archive.md`](../../docs/whats-new-archive.md) (mantiene 30 giorni)
7. **Aggiunge addendum** ai doc target se la novita' e' una feature concreta (callout, no rewrite)
8. **Crea branch `whats-new/YYYY-MM-DD` + apre PR** con label `automation,daily-whats-new` (NO push diretto su main per safety)

> **Nota safety**: l'automazione **non pusha mai direttamente su `main`**. Apre sempre una PR. Puoi abilitare auto-merge via `gh pr merge --auto --squash <num>` o via branch protection rule (Settings → Branches) se vuoi merge automatici.

## Due modalita' di setup

### Modalita' A — Routine cloud Claude Code (raccomandata)

Pro: nativo Claude Code, gestisce DST automaticamente, niente CI esterna.
Contro: richiede plan Pro/Max/Team/Enterprise + extra usage abilitato (vedi limiti in [docs/13](../../docs/13-routines-cloud.md)).

**Setup CLI**:
```bash
# Dalla root della repo claude-code
claude
```
Poi nella sessione:
```
/web-setup    # collega GitHub se non gia' fatto
/schedule daily 07:00 Europe/Rome
```
Quando Claude chiede il prompt, incolla il contenuto di [`routine-prompt.md`](./routine-prompt.md).

Verifica:
```
/schedule list
/schedule run <name>     # run-now per testare
```

> Limiti: Pro 5 routine scheduled/giorno, Max 15, Team/Enterprise 25. Webhook/API non contano.

### Modalita' B — GitHub Action (backup)

Pro: indipendente da plan Claude, riproducibile, log GitHub.
Contro: cron UTC only (DST drift di 1h tra estate/inverno), richiede secret `ANTHROPIC_API_KEY`.

**Setup**:
1. Aggiungi secret `ANTHROPIC_API_KEY` al repo: Settings → Secrets and variables → Actions
2. Il workflow [`whats-new.yml`](./whats-new.yml) e' gia' nel repo a [`.github/workflows/whats-new.yml`](../../.github/workflows/whats-new.yml)
3. Cron schedulato `0 5 * * *` UTC = 07:00 CEST (estate) o 06:00 CET (inverno)
4. Per allineare al fuso italiano sempre 07:00, usare la Modalita' A (Routines)

**Test manuale**:
- Vai a Actions tab → "Daily What's New" → Run workflow

## File in questa cartella

| File | Cosa |
|---|---|
| [`README.md`](./README.md) | Questo file |
| [`routine-prompt.md`](./routine-prompt.md) | Prompt completo per la routine cloud (incollare in `/schedule`) |
| [`whats-new.yml`](./whats-new.yml) | Workflow GitHub Action (backup) — copia in `.github/workflows/` |
| [`setup-routine.sh`](./setup-routine.sh) | Script bash che guida il setup CLI step-by-step |

## Boundary del prompt (importante)

Il prompt include guardrail espliciti:
- **Mai push diretto su `main`** — sempre branch `whats-new/YYYY-MM-DD` + PR
- Niente push `--force`
- Mai modificare `archive/`, `_research/`, `skills/`, `examples/`, `posts/`, `spec.md`, `implementation_plan.md`
- Solo addendum ai doc esistenti, mai rewrite
- Massimo 10 voci/giorno (filtro qualita')
- Se `git status` non clean prima del commit: abort + log
- Se nessuna novita' nelle 24h: scrivi "Nessuna novita' significativa nelle ultime 24h" senza forzare
- PR resta aperta in attesa di review umana (o auto-merge se attivato)

## Costo stimato

| Modalita' | Costo per run | Costo mese (30 giorni) |
|---|---|---|
| Routine cloud (Sonnet 4.6) | ~30K token in + 5K out | ~$10-15 (Max plan: incluso fino al cap) |
| GitHub Action (API key) | ~30K token in + 5K out | ~$3 fissi (API pay-per-use) |

Disabilitare con `/schedule pause <name>` o disabilitando il workflow GitHub.

## Troubleshooting

| Problema | Fix |
|---|---|
| Routine non gira | `/schedule list` per verificare attiva; `/extra-usage` per check budget |
| GitHub Action fallisce su token | Verifica secret `ANTHROPIC_API_KEY` in repo settings |
| Push branch fallisce | Token deve avere permission `contents:write` + `pull-requests:write` (configurato in `whats-new.yml`) |
| PR duplicate stesso giorno | Routine chiude la vecchia con `gh pr close` prima di aprire nuova |
| Auto-merge desiderato | `gh pr merge --auto --squash <num>` o branch protection rule con required reviews=0 |
| README ha duplicate "What's new today" | Il prompt sostituisce la sezione esistente; se vedi duplicati e' bug nel pattern matching — aprire issue |
| Sezione vuota / "no news" troppo spesso | Normale weekend / festivita' Anthropic. Frequency ok se cattura ~3-5 novita' /settimana |

## Disabilitare temporaneamente

```bash
# Routine cloud
/schedule pause whats-new-daily

# GitHub Action
gh workflow disable whats-new.yml
```

## Riferimenti

- [docs/13 — Routines cloud](../../docs/13-routines-cloud.md)
- [docs/16 — Headless & Agent SDK](../../docs/16-headless-agent-sdk.md) (per backup CI)
- [docs/19 — Changelog](../../docs/19-changelog.md) (target update giornaliero)
- [docs/QUICKSTART](../../docs/QUICKSTART.md)

← [examples/](../../examples/) · [README master](../../README.md)
