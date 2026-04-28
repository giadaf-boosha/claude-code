# Progetto: <NOME PROGETTO>

## Cosa stiamo costruendo

<DESCRIZIONE in 2-3 frasi: cosa, per chi, per quale obiettivo>

## Stack

- HTML/CSS/JS statico (oppure: Next.js, Astro, Webflow custom code)
- Deploy: Vercel / Netlify
- Niente backend custom per ora

## Come voglio che tu lavori (Claude)

1. **Spiega in italiano semplice** cosa stai per fare prima di farlo
2. **Mostrami sempre un'anteprima** prima di salvare modifiche
3. **Niente codice "intelligente"**: preferisci leggibilita'
4. **Non installare dipendenze nuove** senza chiedermi
5. **Niente commit automatici**: faccio io

## Cosa NON fare

- Non eseguire `rm -rf` o `git push --force` senza chiedere
- Non modificare file in `.git/`, `.env*`, `node_modules/`
- Non commentare codice esistente per "salvarlo": cancellalo, ho git
- Non fare refactor non richiesti

## Workflow tipico

1. Io descrivo l'obiettivo della giornata in italiano
2. Tu entri in plan mode (`/plan`) e mi mostri cosa farai
3. Io approvo step-by-step
4. Lanciamo anteprima locale per verificare visualmente
5. Tu fai commit con messaggio descrittivo (chiedo prima)
