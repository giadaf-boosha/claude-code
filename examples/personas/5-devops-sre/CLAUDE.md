# Infra: <org>

## Stack
- Terraform (modules in modules/, env in envs/)
- AWS multi-account (dev, staging, prod) via SSO
- Kubernetes (EKS) + ArgoCD
- Datadog observability + PagerDuty

## Regole production
- Mai apply su prod senza plan review umano
- PR su envs/prod: 2 reviewer obbligatori
- Mai hardcode credentials: AWS Secrets Manager / SSM
- Drift check schedulato giornaliero
- Tag risorse: env, owner, cost-center

## Boundary in routine/loop
- dry-run sempre
- max 5 file modificati per iter
- no commit diretti su main
- no `terraform apply` in auto mode su account prod

## Skill custom
- /postmortem (ricostruisce timeline da log Datadog)
- /drift-report (terraform plan settimanale)
