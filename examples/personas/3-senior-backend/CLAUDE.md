# Servizio: <nome>

## Stack & layer
- Java 21 / Spring Boot 3.x: controller / service / repository
- Postgres con Flyway migrations
- Kafka per eventi async

## Regole non negoziabili
- Mai SQL concatenato: query parametrizzate / JPA
- Ogni endpoint protetto: auth check esplicito (no security by obscurity)
- Modifiche a migrations: PR dedicata, mai mischiata con feature
- Test integration > unit con mock pesanti
- Conventional commits, PR <500 LOC

## Workflow
- Plan mode obbligatorio per cambi cross-package
- /ultrareview obbligatorio prima di merge su main
- Hooks PostToolUse: spotless + checkstyle automatici

## Boundary
- No auto-merge PR generate da AI senza human review
- 2 reviewer obbligatori (1 umano + 1 AI tramite GitHub Action)
- No deploy venerdi pomeriggio
