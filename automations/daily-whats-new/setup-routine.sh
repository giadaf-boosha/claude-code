#!/usr/bin/env bash
#
# Setup interattivo per la routine "Daily What's New" via CLI Claude Code.
# Equivalente CLI di andare su claude.ai/code/routines.
#
# Prerequisiti:
# - Claude Code installato (claude --version)
# - Login Pro/Max/Team/Enterprise (vedi docs/18 § 18.5)
# - Repo giadaf-boosha/claude-code clonata localmente
# - GitHub App "Claude" autorizzata sul repo (https://claude.ai/settings/apps)
#
# Uso:
#   chmod +x setup-routine.sh
#   ./setup-routine.sh

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
PROMPT_FILE="$REPO_ROOT/automations/daily-whats-new/routine-prompt.md"

if [ ! -f "$PROMPT_FILE" ]; then
  echo "Errore: prompt file non trovato in $PROMPT_FILE"
  echo "Esegui dalla root della repo claude-code."
  exit 1
fi

cat <<'EOF'
========================================================================
Setup Routine: Daily What's New (07:00 Europe/Rome)
========================================================================

Questo script ti guida nel setup. Tutti i comandi reali andranno eseguiti
dentro la sessione interattiva di Claude Code (apre tra un attimo).

Step da eseguire dopo l'avvio di `claude`:

1. /web-setup
   (collega GitHub se non gia' fatto)

2. /schedule
   (apre wizard interattivo)

3. Quando il wizard chiede "What should this routine do?",
   incolla il contenuto di:

   automations/daily-whats-new/routine-prompt.md

   Apri il file in editor, copia tutto, incolla nella sessione.

4. Quando chiede schedule, inserisci:
   "Every day at 07:00 in Europe/Rome timezone"

5. Quando chiede repo, conferma giadaf-boosha/claude-code (il repo corrente)

6. Verifica con:
   /schedule list

7. Test manuale (run-now):
   /schedule run whats-new-daily

EOF

read -p "Premi INVIO per aprire Claude Code (o Ctrl+C per annullare)..."

cd "$REPO_ROOT"
claude
