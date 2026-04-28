# <App name>

## Stack
- Next.js 15 (App Router) + TypeScript strict
- Tailwind v4 + shadcn/ui
- tRPC + Drizzle + Postgres
- Playwright per E2E

## Design system
- Token in tokens.css (vedi @design/tokens.md)
- Componenti shadcn estesi in components/ui/*
- Mai hardcode colori: usa var(--*)
- Accessibility AA come baseline

## Convenzioni
- Server Components di default; "use client" solo dove serve
- Niente useEffect per data fetching: server actions o tRPC
- Test E2E Playwright per flussi critici

## Workflow
- /loop con Monitor tool su dev server
- design-accessibility-review prima di PR
- Computer use Desktop per QA visuale
