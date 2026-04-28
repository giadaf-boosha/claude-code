# Examples / Personas — Template `.claude/` pronti

> 8 cartelle template `.claude/` (con CLAUDE.md + settings + skill + hook) configurate per le 8 persona di [docs/21-guide-target-user.md](../../docs/21-guide-target-user.md).

## Come usare

1. **Identifica la tua persona** leggendo [docs/21](../../docs/21-guide-target-user.md) o [README-NAVIGATION](../../README-NAVIGATION.md#-indice-per-persona)
2. **Copia la cartella** nella root del tuo progetto:
   ```bash
   cp -r examples/personas/2-indie-hacker/.claude /percorso/al/tuo/repo/
   cp examples/personas/2-indie-hacker/CLAUDE.md /percorso/al/tuo/repo/
   ```
3. **Adatta CLAUDE.md** al tuo stack/progetto (sostituisci `<placeholder>`)
4. **Verifica settings.json** contro le tue policy (rimuovi `disableAutoMode` se non sei in compliance strict)
5. **Lancia `claude`** dalla root del progetto

## Indice persone

| # | Cartella | Per chi | Plan consigliato |
|---|---|---|---|
| 1 | [`1-beginner/`](./1-beginner/) | Founder, PM, vibe coder, non-coder | Pro |
| 2 | [`2-indie-hacker/`](./2-indie-hacker/) | Solo dev, indie SaaS | Max |
| 3 | [`3-senior-backend/`](./3-senior-backend/) | Backend dev in team | Team |
| 4 | [`4-frontend-fullstack/`](./4-frontend-fullstack/) | UI dev, full-stack moderno | Pro/Max |
| 5 | [`5-devops-sre/`](./5-devops-sre/) | CI/CD, infra, on-call | Team/Enterprise |
| 6 | [`6-tech-lead/`](./6-tech-lead/) | Tech lead, staff/principal eng | Team/Enterprise |
| 7 | [`7-ai-ml-engineer/`](./7-ai-ml-engineer/) | LLM, RAG, eval | Max/Team |
| 8 | [`8-legacy-stack/`](./8-legacy-stack/) | RPG/AS400, COBOL, .NET classic, Java EE | Team/Enterprise |

> Ogni cartella ha un `README.md` proprio che spiega le scelte (perche' sandbox on, perche' fast mode no, ecc.).

## Disclaimer

Questi sono **template di partenza**, non configurazioni finali. Adatta:
- CLAUDE.md: aggiungi convenzioni del tuo team
- settings.json: rivedi permission rules in base al tuo blast radius
- skills: testa prima di committare
- hooks: profila tempi di esecuzione

## Anti-pattern comuni

- **Copiare e non leggere**: ogni persona ha trade-off documentati nel suo README. Leggi prima.
- **Mescolare persone**: un repo = una persona dominante. Se sei tech lead di un team frontend, scegli la persona piu' rilevante e adatta.
- **Auto mode senza sandbox**: pericoloso. Tutti i template `.claude/settings.json` hanno sandbox abilitata.
- **Hook senza profiling**: se il hook tarda >10s, blocca il flow. `/doctor` per check.

← Torna alla [docs](../../docs/21-guide-target-user.md) · [README](../../README.md)
