# <Progetto AI/ML>

## Stack
- Python 3.12, uv per env
- anthropic SDK + langchain (solo dove utile)
- Vector DB: pgvector / Qdrant
- Eval: promptfoo / custom harness

## Regole
- Prompt caching su system prompt > 1024 tok (1h TTL)
- Mai loggare contenuto chiamate (PII)
- Eval suite gira prima di ogni cambio prompt
- Versionare prompt come asset (prompts/v<N>.md)

## Sicurezza dati
- Dataset in data/ (gitignored)
- No upload a servizi esterni senza review
- Sandbox mount esplicito su data/
- API key via apiKeyHelper o env (mai in repo)

## Workflow
- /effort xhigh per task di reasoning complesso
- Prompt caching attivo (ENABLE_PROMPT_CACHING_1H=1)
- Subagent Explore per ricerca codebase (Haiku, cheap)
