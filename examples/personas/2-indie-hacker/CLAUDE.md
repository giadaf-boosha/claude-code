# <Nome SaaS>

## Stack

- Frontend: Next.js 15 + Tailwind + shadcn/ui
- Backend: Node + Postgres (Supabase)
- Deploy: Vercel + GitHub Actions
- Test E2E: Playwright

## Convenzioni

- Conventional commits (feat:, fix:, chore:)
- Branch: feat/<short>, fix/<short>
- PR piccole (<300 LOC), una feature per PR
- Test E2E Playwright per flussi critici, no unit test triviali

## Workflow

- Plan mode per ogni feature non triviale
- /security-review prima di merge
- /loop /babysit attivo durante working time

## Boundary

- Non toccare migrations senza piano esplicito
- Non aggiungere dipendenze senza valutare bundle size
- Niente force push su main
- /ultrareview obbligatorio per PR sopra 200 LOC

## Subagent ricorrenti

- code-simplifier: dopo ogni implementazione importante
- verify-app: prima di ogni release

## Tip personali

- @import @docs/architecture.md per ADR
- @import @docs/security.md per regole specifiche
