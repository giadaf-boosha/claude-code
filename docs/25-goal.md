# 25 — /goal (lavoro autonomo verso una condizione)

> Capitolo della guida Claude Code. Vedi [README](../README.md).

Il comando `/goal` imposta una **condizione di completamento** e Claude continua a lavorare attraverso i turni finche' la condizione non e' soddisfatta, senza che tu lo prompti ad ogni step.

## Cosa e' concettualmente

> `/goal` e' un wrapper attorno a uno [Stop hook prompt-based](./07-hooks.md) scoped alla sessione. Dopo ogni turno, la condizione e la conversazione finora vengono mandate a un **small fast model** (default Haiku), che ritorna un si'/no + una breve motivazione. Un "no" dice a Claude di continuare (e passa la motivazione come guida per il prossimo turno); un "si'" pulisce il goal. E' il modo di trasformare "lavora fino a che X e' vero" in un loop verificato da un modello terzo, fresco, non quello che fa il lavoro.

**Modello mentale**: come un `while (!condizione) { lavora() }` dove la condizione e' valutata in linguaggio naturale da un giudice indipendente leggendo cio' che Claude ha gia' mostrato.

**Componente harness IMPACT**: Control flow (loop turn-based con evaluator) + Memory (goal restored on resume).

**Per il deep-dive**: [14 — `/loop` & Monitor](./14-loop-monitor.md) (loop a intervallo di tempo) e [07 — Hooks](./07-hooks.md) (Stop hook custom).

Introdotto in **Claude Code v2.1.139** (11 maggio 2026).

> Fonti: [`/en/goal`](https://code.claude.com/docs/en/goal), [changelog v2.1.139](https://code.claude.com/docs/en/changelog).

---

## 25.1 Quando usarlo

Per lavoro sostanziale con uno **stato finale verificabile**:
- Migrare un modulo a una nuova API finche' ogni call site compila e i test passano
- Implementare un design doc finche' tutti gli acceptance criteria reggono
- Spezzare un file grosso in moduli finche' ognuno e' sotto un budget di dimensione
- Smaltire un backlog di issue etichettate finche' la coda e' vuota

---

## 25.2 `/goal` vs `/loop` vs Stop hook vs auto mode

Tre approcci tengono in vita la sessione tra i prompt. Scegli in base a **cosa avvia il turno successivo**.

| Approccio | Il prossimo turno parte quando | Si ferma quando |
|---|---|---|
| `/goal` | Il turno precedente finisce | Un modello conferma che la condizione e' soddisfatta |
| [`/loop`](./14-loop-monitor.md) | Passa un intervallo di tempo | Lo fermi tu, o Claude decide che il lavoro e' fatto |
| [Stop hook](./07-hooks.md) | Il turno precedente finisce | Lo decide il tuo script o prompt |

`/goal` e uno Stop hook scattano entrambi dopo ogni turno. `/goal` e' una **shortcut scoped alla sessione** (digiti una condizione, attiva solo per la sessione corrente); uno Stop hook vive nel file di settings, vale per ogni sessione nel suo scope, e puo' eseguire uno script (check deterministici) o un prompt (check model-evaluated).

[Auto mode](./04-modalita-permessi.md) da solo approva le tool call **dentro** un turno ma non ne avvia uno nuovo. Sono **complementari**: auto mode toglie i prompt per-tool, `/goal` toglie i prompt per-turno.

---

## 25.3 Uso

Un solo goal attivo per sessione. Lo stesso comando setta, controlla e pulisce a seconda dell'argomento.

### Settare un goal
```text
/goal all tests in test/auth pass and the lint step is clean
```
Settare un goal **avvia subito un turno**, con la condizione stessa come direttiva — non serve un prompt separato. Se un goal e' gia' attivo, il nuovo lo rimpiazza. Mentre e' attivo, un indicatore `◎ /goal active` mostra da quanto sta girando.

Dopo ogni turno l'evaluator ritorna una breve motivazione del perche' la condizione e' o non e' soddisfatta. L'ultima motivazione appare nella status view e nel transcript.

### Scrivere una condizione efficace
L'evaluator giudica la condizione **contro cio' che Claude ha mostrato nella conversazione**. Non esegue comandi ne' legge file in autonomia → scrivi la condizione come qualcosa che l'output stesso di Claude puo' dimostrare. "All tests in `test/auth` pass" funziona perche' Claude esegue i test e il risultato finisce nel transcript.

Una buona condizione ha:
- **Uno stato finale misurabile**: un risultato di test, un exit code di build, un conteggio file, una coda vuota
- **Un check dichiarato**: come Claude deve provarlo, es. "`npm test` exits 0" o "`git status` is clean"
- **Vincoli che contano**: cio' che non deve cambiare strada facendo, es. "no other test file is modified"

Massimo **4.000 caratteri**. Per limitare la durata, includi una clausola di turni/tempo: `or stop after 20 turns`.

### Controllare lo stato
```text
/goal
```
Senza argomenti mostra: la condizione, da quanto gira, quanti turni valutati, lo spend di token corrente, l'ultima motivazione dell'evaluator. Se nessun goal e' attivo ma uno e' stato raggiunto prima nella sessione, mostra la condizione raggiunta con durata, turni e token.

### Pulire un goal
```text
/goal clear
```
Alias accettati: `stop`, `off`, `reset`, `none`, `cancel`. Anche `/clear` (nuova conversazione) rimuove un goal attivo.

### Resume con goal attivo
Un goal ancora attivo a fine sessione viene **ripristinato** al resume con `--resume` o `--continue`. La condizione si porta dietro, ma turni, timer e baseline token si **resettano** al resume. Un goal gia' raggiunto o pulito non viene ripristinato.

### Non-interactive (`-p`)
`/goal` funziona in [non-interactive mode](./16-headless-agent-sdk.md), nella [desktop app](https://code.claude.com/docs/en/desktop) e via [Remote Control](https://code.claude.com/docs/en/remote-control). Con `-p` il loop gira fino a completamento in una singola invocazione:
```bash
claude -p "/goal CHANGELOG.md has an entry for every PR merged this week"
```
Interrompi con `Ctrl+C` per fermarlo prima della condizione.

---

## 25.4 Come funziona la valutazione

Dopo ogni turno, condizione + conversazione finora → [small fast model](https://code.claude.com/docs/en/model-config) (default **Haiku**). Ritorna decisione si'/no + breve motivazione. "No" → Claude continua (la motivazione e' guida per il prossimo turno). "Si'" → pulisce il goal e registra un'entry *achieved* nel transcript. L'evaluator gira sullo stesso provider della sessione e **non chiama tool**: giudica solo cio' che Claude ha gia' mostrato.

> I token di valutazione sono fatturati sullo small fast model del provider e sono tipicamente trascurabili rispetto allo spend dei turni principali.

---

## 25.5 Requisiti e limitazioni

- Solo in workspace dove hai **accettato il trust dialog** (l'evaluator e' parte del sistema hooks)
- Non disponibile se [`disableAllHooks`](https://code.claude.com/docs/en/hooks#disable-or-remove-hooks) e' settato a qualsiasi livello, o se [`allowManagedHooksOnly`](https://code.claude.com/docs/en/settings#hook-configuration) e' nelle managed settings — in entrambi i casi il comando ti dice perche', invece di non fare nulla silenziosamente
- Un solo goal attivo per sessione
- L'evaluator non esegue comandi: condizioni come "il sito e' deployato" non funzionano se Claude non lo dimostra nel transcript

---

## 25.6 Pattern operativo consigliato

1. **Auto mode + `/goal`**: combina i due per run completamente unattended (niente prompt per-tool, niente prompt per-turno).
2. **Bound sempre la durata**: aggiungi `or stop after N turns` per evitare loop costosi su condizioni mal scritte.
3. **Condizione dimostrabile**: includi il comando di prova esplicito (`npm test exits 0`, `git status clean`).
4. **Vincoli espliciti**: dichiara cosa non deve cambiare, per evitare che Claude "bari" sulla condizione.
5. **`/goal` per intra-sessione, routine per cross-sessione**: per lavoro che gira senza sessione aperta usa [Routines cloud](./13-routines-cloud.md) o desktop scheduled, non `/goal`.

---

← [24 Dynamic Workflows](./24-workflows.md) · Successivo → [01 Snapshot](./01-snapshot.md)
