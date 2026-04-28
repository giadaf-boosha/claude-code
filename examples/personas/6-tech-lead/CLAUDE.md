# <Org/Team> Engineering rules

## ADR
- Ogni decisione architetturale: ADR in docs/adr/NNN-*.md
- Template: context / decision / consequences / alternatives
- /adr per generare scheletro

## Code review policy
- /ultrareview automatica su PR > 200 LOC
- 1 reviewer umano + AI obbligatori
- No merge venerdi pomeriggio
- /security-review prima di merge feature

## Tooling team
- Allowlist comandi in .claude/settings.json (managed)
- MCP scope: solo server in registry approvato
- Hooks: spotless, semgrep, license-check

## Onboarding
- /team-onboarding gira al primo `claude` in repo
- Skill custom in .claude/skills/<team>/

## Anti-pattern
- Centralizzare tutto in un CLAUDE.md gigante: spezza per dominio
- Imporre AI tooling senza opt-in del team
- Saltare ADR per decisioni "ovvie"
