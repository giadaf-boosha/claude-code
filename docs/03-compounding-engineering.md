# Compounding Engineering con AI e Claude Code

## Il Concetto Centrale: Compounding Engineering

### Definizione Esatta di Kieran

> Compounding engineering significa che con ogni pezzo di lavoro che fai, stai rendendo più facile fare il prossimo pezzo di lavoro.

Questo non è un concetto teorico ma una realtà pratica che il team Kora (2 persone) sta vivendo:

> Feels like there's 15 coding.

Il loro output equivale a quello di 15 sviluppatori.

### Come si Manifesta Praticamente

Il compounding si realizza attraverso la creazione di meta-sistemi:

- Invece di risolvere singoli problemi, creano sistemi che risolvono classi di problemi
- Ogni prompt diventa un template riutilizzabile
- La ricerca fatta una volta diventa automatica per tutte le feature successive

> Having an idea that has a lot of outcome.

Un singolo investimento genera benefici multipli.

---

## La Realizzazione Chiave: "Coding with AI is More Than Just the Coding Part"

### La Rivoluzione del Mindset

> Coding with AI is more than just the coding part, utilizing it for research, for workflows, it should be used for everything.
> — Kieran

**Breakdown della Realizzazione:**

- **Prima:** Focus su Cursor, Windsurf per "vibe coding"
- **Ora:** AI per tutto il processo di engineering

> Most of the work is maybe coding but maybe it's actually 20%, maybe 80% of the work is figuring out what to do next.

### Il Momento di Svolta

> We're now at a point where the agents are good enough that they can actually do everything, so we need to rethink again... it's a realization oh actually we can just give a task and it will do it.

---

## Claude Code: Lo Strumento Rivoluzionario

### Caratteristiche Tecniche Specifiche

> Claude Code è the coding agent version from Anthropic that uses Claude under the hood and it runs in your terminal as a CLI tool.

### Capabilities Dimostrate nel Video

- **File system access:** "it can look through files on my computer"
- **Execution capability:** "it can run things on my computer"
- **Screenshot capability:** "it can take screenshots of websites"
- **Web search:** "it can search the web"
- **GitHub integration:** Accesso completo a repository, issue tracking, CI pipeline

### Esempi Pratici Mostrati

#### Esempio 1: Weekly Shipping Report

**Input:** "What did we ship in the last week?"

**Processo Automatico:**

1. Claude Code analizza automaticamente il git log
2. Identifica merge su main branch
3. Genera report strutturato con:
   - 6 major features
   - 5 important bug fixes
   - 3 infrastructure updates
   - Technical write-up leggibile

> That's a lot for two people.
> — Tom

#### Esempio 2: Bug Investigation

**Scenario:** Form di feedback non riceveva risposte da 14 giorni.

**Processo Risolutivo:**

- **Query:** "14 days ago something went wrong, can you see what went wrong?"
- **AI Actions:**
  1. Fetching recent log changes
  2. Searching codebase for relevant changes
  3. Analyzing controller modifications
- **Discovery:** "We removed a piece of code that adds people"
- **Solution:** "Hey actually you just need to add this"
- **Implementation:** "Do it for me, create a pull request"
- **Bonus:** Script automatico per migrare utenti mancati

> It didn't cost me any energy, it was as easy as me writing it down in GitHub to look at later, I don't need to, I just ask it and it does it immediately.

### Confronto con Cursor/Windsurf

> Claude just takes it one step further by simplifying it by a factor of 10.
> — Natasha

**Differenze Chiave:**

- **Cursor/Windsurf:** "Command K, shortcuts, accept, reject, remove - there's nothing"
- **Claude Code:** "Nothing except text box here... just a text box and it works because the model, the underlying Claude model, is so much more capable now"

---

## Il Workflow Dettagliato: Dal Brainstorming alla Produzione

### Preparazione Pre-Claude 4

> One day before the Claude live stream was scheduled, we were like okay tomorrow coding is going to change.
> — Natasha

**Azioni Concrete:**

1. 2-hour jamming call per preparare il sistema
2. Creazione di 20 issues anticipate
3. Prompt a ChatGPT: "Tomorrow we have reached AGI, can you help us come up with everything we need to do?"
4. Utilizzo Anthropic Prompt Improver per ottimizzare
5. Preparazione dell'AGI per risolvere tutto

### Il Sistema di Custom Commands

#### Il Comando "CC" (Claude Code)

**Funzionamento Mostrato:**

- Voice input tramite Monologue (tool interno Every)
- Esempio reale: "I want infinite scroll in Kora where if I am at the end of a brief it should load the next brief and it should go until every brief that's unread is read"

**Processo automatico:**

1. Inserisce descrizione nel feature template
2. **Research phase:** "grounding itself in the codebase"
3. **Best practices research:** "searching the web, finding open-source patterns"
4. **Plan presentation:** "present a plan"
5. **Human review:** "human in the loop for the plan"
6. **GitHub integration:** "creates the GitHub issue and put it in the right lane"

### Struttura del Template Automatico

Ogni GitHub issue generato contiene:

- Problem statement
- Solution vision
- Requirements (technical e non)
- Implementation steps con timeline
- Best practices research integrata

---

## L'Aspetto "Social Coding"

### Coding Durante Conversazioni

> I shipped a feature that went to prod while we were talking, which I'm not in the codebase at all, so it's kind of crazy that that actually happened.
> — Tom

**Implicazioni:**

- **Development diventa sociale:** "It's a kind of more social way to code"
- **Parallel processing:** "We're coding right now, building stuff which was not possible before"
- **Zero context switching:** Conversazione e sviluppo avvengono simultaneamente

### Parallel Execution Strategy

> I think six or seven running at the same time because we were just like 'New idea let's go, new idea let's go.'
> — Kieran

**Processo di Brainstorming:**

- Multiple AI agents lavorano contemporaneamente
- Ogni idea genera immediatamente research e documentazione
- Human review selettivo dei risultati

> Really fun because if you're in this brainstorming place you can just kick off agents and see what comes up.

---

## Principi di Quality Control e Best Practices

### "Fix Problems at Lowest Value Stage"

Natasha cita **"High Output Management"** di Andy Grove (Intel CEO).

**Applicazione Pratica:**

> When we see that when we are using the workflow that Kieran just showed to create a very detailed GitHub issue, then it's very tempting to start another Claude Code to ask it to just hey go now work on this GitHub issue and fix it, but that's actually going to be a problem because there are chances that the plan that Claude was able to in that issue it wasn't the direction that you wanted to go and you want to catch that before you ask Claude to go and implement the solution.

### Human Review Points Strategici

> Most of the time it's right, then I say 'Yep sounds good.' And then it creates the GitHub issue.
> — Kieran

**Checkpoint necessari:**

1. Plan review prima dell'implementazione
2. Architecture validation per direction checking
3. Taste and intuition: "There is still like a human touch of intuition"

### Esempio di Debugging Guidato

**Kieran vs Natasha, stesso bug:**

- **Kieran:** Aggiunge "look at the history" → AI trova soluzione corretta
- **Natasha:** Senza hint → AI dice "everything works fine"

> There is still like intuition and it's still a skill.

---

## Testing e Validation Automatici

### Traditional Tests Evolution

> Boring traditional tests and evals are very important as well... just bare minimum smoke tests are great where you just see does it kind of work, because otherwise it does way too much but it's a very good way to have it iterate and fix things by itself.
> — Kieran

### Advanced Testing Patterns

**Esempi Concreti:**

- **Figma MCP integration:** "Implement this from Figma and then now there's like you can have Puppeteer take a screenshot for a mobile version and then say compare the two"
- **Prompt Evals:** "I kind of think of an eval as like writing a test for code, an eval is a test for a prompt"

### Iterative Quality Improvement

**Processo Mostrato:**

1. Run prompt 10 times: "Does it always pass? No, four times it doesn't"
2. Failure analysis: "Look at the output, why didn't it call that tool"
3. Auto-improvement: "Change the prompt until it's passing consistently all the time"
4. Autonomous execution: "I just walked downstairs, got a coffee, walked up and that was it"

---

## Multi-Agent Specialization Strategy

### Tool Portfolio Explained

> I'm thinking about it more is like you're interviewing for a role and you find a developer to solve a certain problem. I think it's similar with coding agents.
> — Kieran

**Specialization Mapping:**

- **Friday:** "Good at doing UI now, so if I need UI work I will go to Friday"
- **Claude Code:** "If I need to do research I go to Claude"
- **Charlie:** "If I want a code review I use Charlie"

> Charlie works in GitHub so you can just CC Charlie and Charlie will do the code review on the PR.

### Ecosystem Integration

> We use GitHub and pull requests and normal developer flows so humans can hook in, so we can hire someone that's very good at specific thing and review code.

> It's very powerful because it is just an ecosystem that we refined over like 20 years or whatever, and it works, so let's lean into that.

---

## Ranking Dettagliato degli Strumenti

| Tier | Strumento | Note |
|------|-----------|------|
| **S** | **Claude Code** | "Obviously S tier baby" |
| **S** | **AMP** | "S tier under Claude Code... It's very good at just getting work done, the ergonomics are pretty good, good tools already... you can feel from Claude Code and AMP they're developers that love agents and they're just building the best thing" |
| **A** | **Friday** | "I put Friday higher than cursor, maybe between S and A... they don't even use Claude 4 yet, they're still... it's 3.5 but why I like it there it's definitely different than Claude Code but Friday has a very opinionated way of working and I love their opinions" |
| **A** | **Cursor** | "With Claude... all right cursor is very good with Claude" |
| **A** | **Charlie** | "A as a code reviewer... I really like the code reviews it does" |
| **B** | **Devon** | "It's like it's not as integrated, it's a little bit hard to set up and the code quality is like it's not as well-rounded" |
| **B** | **CodeX** | "This is B for me" |
| **B** | **Factory** | "It's interesting, factory with certain things is like better than any others but it's not my style... for more enterprisey people that are very nerdy and want absolute bangers of code" |
| **C** | **Windsurf** | "C because they don't have Claude 4. It's ridiculous because three weeks ago they would be A and now they're not" |
| **D** | **GitHub Copilot** | "I tried it maybe a half a year ago and after one second I stopped using it" |

---

## Esempi di Advanced Workflows

### Infrastructure Consulting Integration

**Processo Hybrid Human-AI:**

- **Setup:** "There was no issue yet but we wanted more visibility in delivery of the most important things... let's bring in someone"

**Execution:**

1. 2-hour recorded call con infrastructure expert
2. AI processing: "I just fed that into Claude and say okay can you make two issues from this"
3. Expert review: "10 minutes later I said okay here are the issues, can you review them"
4. Expert reaction: "Holy what... he's not an AI skeptic but he's very good at what he does and normally what he does AI is not good at yet... but he was very impressed"
5. Implementation: "I said the next day when he did the human review, let's go, I just use Claude Code to implement it"

> What would have taken 2 weeks maybe is now in like a few hours.

### 25-Minute Autonomous Execution

> Me and Kieran have like a fun thing going on where we're trying to see who can have Claude Code running for the maximum amount of time and Kieran is stopping the rest right now, he ran it for 25 minutes.

**How:** "A very very long plan... includes a lot of tests and just make sure that it runs all the tests and fixes all the tests"

---

## Voice-First Development in Dettaglio

### Monologue Integration

> Kieran almost never types anything and does all voice text, so he was just doing voice to text into his terminal, into Claude Code with I believe an internal as of yet unreleased internal Every incubation called Monologue which he is the number four biggest user of.
> — Tom

### Workflow Dimostrato

Durante l'episodio, Kieran:

1. **Voice input:** Descrive infinite scroll feature
2. **Zero typing:** Tutto tramite voice-to-text
3. **Immediate execution:** AI inizia research mentre parlano
4. **Parallel conversation:** Development continua durante podcast

---

## Problemi e Limitazioni Identificati

### Skill Requirement Reale

> There are no magic prompts that does everything, like it is about using it the right way and using it to its strengths for sure.
> — Kieran

> There is still like a human touch of intuition... it's still a skill, it is a skill for sure.
> — Natasha

### Quality Control Challenges

> Do we see any red flags, do we need more stuff to be added, because it will save so much time.
> — Kieran

> It's kind of boring to read most of the time but you can make it more fun... but then the thing is then it misses things again so it's actually important.

### Tool Landscape Volatility

> The entire coding landscape just changes completely every 3 months and you realize like nobody's at the forefront.
> — Natasha

> There is always more but it's really about practice, like you should practice using AI, you should push yourself every day if you don't like you'll miss very cool stuff.
> — Kieran

---

## Raccomandazioni Finali dall'Episodio

### Per Sviluppatori

> Everyone should use Claude Code or try it out even if you're not technical, subscribe for their max or pro plan, it's only $100 per month, you have unlimited access if you're skeptical about being technical that it's very easy.
> — Kieran

### Testimonianza Concreta

> A friend of mine he used cursor and I said just use Claude Code is better, like how much better can it be and he said yes it's better and he rebuilt everything he did with cursor vibe coded into Claude Code and he's like yeah this is great, he felt that next step.
> — Kieran

### Business Application

> Be sure to check the AI's work at the lowest value stage, you want to catch those problems early.
> — Natasha

---

## Conclusione

Kora rappresenta un case study reale di come il Compounding Engineering non sia teoria ma pratica implementabile oggi. Il team di 2 persone produce output equivalente a 15 sviluppatori attraverso una combinazione di:

- **Claude Code** come orchestratore primario
- **Workflow voice-first**
- **Multi-agent specialization**
- **Checkpoint umani strategici** per quality control

Il loro successo deriva non dall'utilizzo di un singolo tool, ma dalla architettura sistemica di prompt, processi e agent coordination che genera valore composto nel tempo.
