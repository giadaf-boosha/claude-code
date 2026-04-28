# Persona 5 — DevOps / SRE

> CI/CD, infra Terraform/Pulumi, observability, on-call. Blast radius alto.

## Setup

| Aspetto | Valore |
|---|---|
| Plan | Team o Enterprise |
| Surface | CLI headless in CI/CD; Desktop per analisi incidenti |
| Sandbox | ON sempre; CI: `--bare` + `--strict-mcp-config` |
| Fast mode | NO in CI; SI per analisi log voluminosi |
| Auto mode | NO in produzione; SI in staging con boundary |

## File inclusi
- [`CLAUDE.md`](./CLAUDE.md) — IaC + Kubernetes + Datadog
- [`.claude/settings.json`](./.claude/settings.json) — boundary stretti per prod

## Approfondimenti
- [docs/21 § 5](../../../docs/21-guide-target-user.md#5-devops--sre)
- [docs/13 — Routines](../../../docs/13-routines-cloud.md)
- [docs/16 — Headless](../../../docs/16-headless-agent-sdk.md)

← [examples/personas](../README.md)
