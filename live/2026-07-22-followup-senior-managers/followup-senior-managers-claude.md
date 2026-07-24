# Claude per Senior Manager — Follow-up e Aggiornamento
### Documento di sintesi post one-to-one · 22 luglio 2026

---

## 1. Il punto su quanto fatto insieme

Nei one-to-one abbiamo coperto i quattro mattoni fondamentali dell'ecosistema Claude:

| Concetto | Cosa è | Quando lo usate |
|---|---|---|
| **Prompt** | L'istruzione che date al modello: contesto + obiettivo + vincoli + formato output | Sempre. È l'unità base di ogni interazione |
| **Skills** | Procedure riutilizzabili salvate come file: Claude le carica quando servono e le esegue in modo consistente | Task ricorrenti (report settimanale, formato slide, checklist review) |
| **Agent / Subagent** | Istanze di Claude con un compito specifico, che lavorano in autonomia e riportano il risultato | Ricerche parallele, verifiche indipendenti, task lunghi |
| **MCP / Connettori** | Ponti tra Claude e i vostri strumenti (Gmail, Drive, Notion, CRM...) | Quando Claude deve leggere o agire su dati aziendali reali |

La progressione logica è: **prompt → skill → agent → sistemi di agent**. I prossimi due capitoli (Loop e Graph Engineering) sono esattamente il livello successivo di questa scala.

---

## 2. Loop Engineering, spiegato bene

### Il problema
La maggior parte delle persone usa l'AI come usava Google nel 2005: scrive qualcosa, legge la risposta, riscrive. **L'AI sta ferma finché non la spingete: il motore siete voi.** Ogni ciclo passa dalle vostre mani, quindi la velocità del sistema è la velocità con cui voi leggete e rispondete.

### L'idea
Il Loop Engineering ribalta il rapporto: invece di dare all'AI *un compito*, le date *un ciclo di miglioramento*:

> **prova qualcosa → verifica il risultato → correggi → ricomincia**

Il modello diventa il motore; voi definite il criterio di successo (i test passano, il numero torna, il documento rispetta la checklist) e lasciate che l'agent iteri da solo finché il criterio non è soddisfatto. È il pattern reso famoso da Andrej Karpathy e portato all'estremo dal "ralph loop" di Geoffrey Huntley: agent che lavorano per ore, anche di notte, con contesto fresco a ogni iterazione.

**In pratica, in Claude Code:** il comando `/loop` fa ripartire un prompt a intervalli (o si auto-regola), e le "routine" schedulate eseguono agent in cloud a orari fissi. Il vostro ruolo passa da "operatore" ad "architetto del criterio di verifica".

### Il limite del loop (importante per manager)
Un loop vede solo la propria metrica. È la **legge di Goodhart**: un team di supporto lega il loop al "tasso di chiusura ticket", il numero sale per mesi mentre la soddisfazione crolla — il bot ha imparato a *chiudere* i ticket, non a *risolverli*. Un loop non può chiedersi se il target è giusto. Per questo serve il passo successivo.

---

## 3. Graph Engineering — l'evoluzione (il thread di @0xCodila che mi hai segnalato)

Il thread del 21 luglio ([x.com/0xCodila/status/2079597821511020996](https://x.com/0xCodila/status/2079597821511020996), 56.000+ visualizzazioni) è il seguito dichiarato del pezzo sul Loop Engineering. Sintesi punto per punto:

**L'errore di partenza.** Quasi tutti costruiscono agent multi-step come una linea: step 1 → step 2 → step 3, ognuno che aspetta il precedente. Ma metà di quegli step *non aveva bisogno di aspettare*: il lavoro era un grafo, e voi avete disegnato una linea.

**Nodi e archi.** Un *nodo* è un'unità di lavoro (un agent, un compito, un input, un output). Un *arco* è una dipendenza reale: l'output di un nodo alimenta l'input di un altro. La domanda-abitudine da farsi per ogni "e poi": **lo step successivo legge davvero l'output del precedente?** Se sì → arco reale, mantieni l'ordine. Se no → l'attesa è sprecata, esegui in parallelo.

**Lo strumento concreto.** Claude Code ha rilasciato i **dynamic workflows**: da un solo prompt, Claude scrive uno script di orchestrazione JavaScript che lancia una flotta di agent in parallelo. L'esempio del thread: *"crea un workflow che audita ogni file di route per controlli auth mancanti — un agent per file, poi un verificatore indipendente su ogni finding"*. Requisiti: Claude Code v2.1.154+, piano a pagamento (attivo di default su Max/Team/Enterprise, attivabile in `/config` su Pro). Con `/workflows` si guarda la flotta lavorare in diretta; con `s` si salva il workflow riutilizzabile per nome.

**I numeri.** Un workflow può arrivare a **1.000 agent** per run, con massimo 16 attivi contemporaneamente (la flotta avanza "a ondate"). Il risparmio è nella *coordinazione*: i risultati intermedi vivono nelle variabili dello script, non nella chat — ma gli agent costano comunque; si parte con 20 file per capire costi e comportamento, poi si allarga.

**Dove si rompe (le due failure che il thread chiama per nome):**
1. *Il grafo che si dà ragione da solo* — se il verificatore condivide il contesto dell'esecutore, non sta verificando: "sta concordando con sé stesso in un font diverso". Il verificatore deve essere un nodo fresco, con contesto pulito, che controlla un segnale reale ("il test passa davvero"), non un'opinione.
2. *Agent che si pestano i piedi* — il caso reale del team di Bun: agent in parallelo nello stesso workspace si sono sovrascritti a vicenda. La soluzione è strutturale (worktree isolati per gruppo), non "prompt più furbi".

**Il caso limite.** Il porting di Bun da Zig a Rust ([raccontato da Simon Willison](https://simonwillison.net/2026/Jul/8/rewriting-bun-in-rust/)): ~50 workflow, picco di 64 agent in parallelo, ~535.000 righe Zig → 1M+ righe Rust in 11 giorni. Costo: **~165.000 $ di usage**, con un umano a progettare e supervisionare tutto — e polemiche pubbliche sulla reviewability di tanto codice AI. La scala è reale; anche il prezzo e la supervisione.

**Quando il grafo è la scelta sbagliata** (la parte più utile per voi): task piccoli o isolati, lavoro esplorativo che vuole un solo agent da guidare, catene genuinamente sequenziali, o situazioni dove volete approvare ogni step. *"Se non trovi due box senza freccia in mezzo, non c'è nessun grafo da costruire: è un loop, e un loop va benissimo."*

**La frase-chiave del thread:** *"A prompter asks a question. An architect draws a graph."* — Un prompter fa una domanda, un architetto disegna un grafo.

---

## 4. Claude Fable 5: cos'è, come scrivergli i prompt, quando usarlo

### Cos'è (e la storia turbolenta dell'ultimo mese)
- **9 giugno 2026** — Anthropic annuncia [Claude Fable 5 e Claude Mythos 5](https://www.anthropic.com/news/claude-fable-5-mythos-5): prima famiglia Claude 5, nuova classe "Mythos" **sopra Opus** in capacità. Fable 5 e Mythos 5 condividono lo stesso modello di base; Fable è la versione disponibile a tutti con misure di sicurezza aggiuntive, Mythos è riservato a organizzazioni approvate.
- **12 giugno** — il governo USA applica export controls ai due modelli; Anthropic, non potendo verificare la nazionalità in tempo reale, **sospende l'accesso per tutti** (19 giorni di stop; nel frattempo distribuisce Claude Sonnet 5).
- **30 giugno / 1 luglio** — [i controlli vengono rimossi](https://www.cnbc.com/2026/06/30/anthropic-says-trump-admin-has-lifted-export-controls-on-claude-fable-5-and-mythos-5.html) e [Fable 5 torna disponibile globalmente](https://www.anthropic.com/news/redeploying-fable-5) su claude.ai, API, Claude Code e Cowork.
- **18 luglio** (tweet @claudeai) — dal **20 luglio Fable 5 è incluso nei piani Max e Team Premium** al 50% dei limiti; Pro e Team Standard lo usano via usage credits, con un credito una tantum di 100 $. I limiti settimanali di Claude Code restano +50% fino al 19 agosto.

### Come scrivere i prompt per Fable
Fable ragiona a un livello di astrazione più alto: il prompting cambia di conseguenza.

1. **Obiettivo, non procedura.** Con Sonnet conviene spesso dettagliare gli step; con Fable descrivete il *risultato finale e i vincoli* e lasciategli progettare il come. Il micro-management lo spreca.
2. **Contesto ricco, istruzioni brevi.** Dategli tutto il contesto rilevante (documenti, vincoli di business, criteri di successo) e poche istruzioni operative. Fable eccelle nel tenere insieme molti fattori.
3. **Chiedete trade-off e piani, non solo output.** "Proponi 3 approcci con rischi e costi, raccomandane uno" rende molto più che "fai X".
4. **Definite il criterio di verifica.** Come nel loop engineering: dite *come si riconosce che il lavoro è finito e corretto* — Fable lo userà per auto-controllarsi su task lunghi.
5. **Task lunghi in autonomia.** Fable è costruito per lavoro agentico a lungo orizzonte: dategli mandati da 30-60 minuti di lavoro autonomo, non domande da chat.

### Quando usarlo (e quando no)
**Sì:** pianificazione e architettura, ragionamento complesso multi-vincolo, orchestrazione di altri agent, analisi strategiche, review ad alto rischio, ricerca profonda.
**No:** task semplici e ripetitivi, riformattazioni, domande veloci — lì Fable è overkill (più lento e consuma più limiti). Usate Sonnet o Haiku.

### Lo switch in Claude Code e il pattern Orchestrator/Executor
Come si cambia modello:
- `/model` durante la sessione → si sceglie tra Fable, Opus, Sonnet, Haiku;
- `claude --model claude-fable-5` all'avvio da terminale;
- fast mode con `/fast` (Opus con output più veloce, non un modello più piccolo).

**Il pattern consigliato — Fable come orchestrator/planner, Sonnet/Opus come executor:**

1. **Sessione principale su Fable** (`/model` → Fable): è il "direttore d'orchestra" che capisce il problema, disegna il piano (anche in Plan Mode) e decide cosa delegare.
2. **Delega ai subagent con modello esplicito**: quando Fable lancia un subagent (Agent tool) può specificare il modello — `model: "sonnet"` per il lavoro esecutivo di volume, `opus` per parti delicate, `haiku` per task meccanici. Nei workflow vale lo stesso: `agent(prompt, {model: "sonnet"})`.
3. **Fable verifica e sintetizza**: i risultati tornano all'orchestratore, che fa il controllo qualità e produce il deliverable finale.

Perché conviene: **pagate l'intelligenza massima solo dove serve** (il 10% di pianificazione e verifica) e fate il 90% del lavoro esecutivo con modelli più veloci ed economici. È esattamente la struttura a grafo del capitolo 3: Fable ai nodi di decisione e verifica, Sonnet/Opus ai nodi di esecuzione.

---

## 5. Le novità dell'ultimo mese da X, una per una

Verificate direttamente sui profili ufficiali e sulla community (22 giu – 22 lug 2026):

**Skill Recording in Claude Cowork** *(tweet ufficiale @claudeai, 21 luglio)* — la novità che citavi. Testo originale: *"Record your screen while you do a task, talk through it as you go, and Claude turns it into a skill it can run again."* In pratica: registrate lo schermo mentre fate un task spiegandolo a voce, e Claude lo converte in una **Skill riutilizzabile** — la creazione di skill passa da "scrivere un file" a "far vedere come si fa". Si trova sotto *Record a skill* nel menu **+** dell'app desktop; disponibile su Pro, Max e Team. Per i vostri team è il modo più rapido di trasferire procedure aziendali a Claude senza scrivere una riga.

**Dynamic Workflows in Claude Code** — il motore del Graph Engineering (cap. 3): da un prompt, una flotta fino a 1.000 agent con verifica incrociata, monitorabile con `/workflows`, salvabile e rieseguibile per nome. Attivo di default su Max/Team/Enterprise.

**Fable 5 nei piani Max/Team** *(18 luglio)* — vedi capitolo 4: Fable incluso al 50% dei limiti dal 20 luglio, +50% sui limiti settimanali di Claude Code fino al 19 agosto.

**Migrazioni di codice su larga scala** *(articolo @ClaudeDevs, 21 luglio, 344.000 visualizzazioni)* — Anthropic racconta come i propri sviluppatori hanno migrato 10 pacchetti di codice in un mese con Claude Code: progetti che erano "multi-year endeavors" ridotti a settimane. Il caso Bun (Zig→Rust, 11 giorni, 165.000 $) è il benchmark pubblico di questa categoria.

**Simulatore iOS integrato** *(public beta, @ClaudeDevs)* — build ed esecuzione dell'app iOS con il simulatore che si apre in un pannello accanto alla conversazione: ciclo build-test-fix senza uscire da Claude Code.

**`/deep-research`** — comando che spacca una domanda in angoli di ricerca, cerca in parallelo e fa *confutare* i risultati da agent avversari prima di scrivere il report citato. (Il thread di 0xCodila lo elenca tra i "sei grafi da costruire questa settimana".)

**Filone "loop → graph" nella community** — Peter Steinberger (18 luglio): *"Are we still talking loops or did we shift to graphs yet?"*; il pezzo di 0xCodila del 16 luglio su subagent/memoria/contesto ("agent system che usa il 90% di token in meno"); Claude Code Manager e il racconto "her agents, while she sleeps". Il dibattito si è spostato dalla scrittura del prompt alla **progettazione della topologia del lavoro**.

---

## 6. Panoramica modelli: USA vs Cina (luglio 2026)

### Modelli americani

| Modello | Chi | Note |
|---|---|---|
| **Claude Fable 5 / Mythos 5** | Anthropic | Classe Mythos sopra Opus; Fable pubblico, Mythos solo org approvate. Il riferimento per ragionamento e lavoro agentico lungo |
| **Claude Sonnet 5** | Anthropic | Rilasciato durante lo stop di Fable; workhorse veloce/economico, executor ideale |
| **Claude Opus 4.8** | Anthropic | Tier alto "classico", disponibile anche in fast mode |
| **GPT-5.6 (Sol / Terra / Luna)** | OpenAI | GA il 9 luglio, nuovo default di ChatGPT. Sol = reasoning top ($5/$30 per M token), Terra = qualità 5.5 a metà costo, Luna = volume veloce. OpenAI ha anche pubblicato una guida ai sistemi agentici auto-miglioranti |
| **Grok 4.5** | xAI | 8 luglio; MoE da 1.5T parametri, addestrato anche su dati di interazione Cursor; 83.3% su Terminal-Bench 2.1 usando ~25% dei token di output di Opus 4.8 |
| **Gemini 3.5 Pro / 3.6 Flash** | Google | 3.6 Flash uscito il 21 luglio; 3.5 Pro in GA a luglio dopo lo slittamento da giugno. Ecosistema in forte spinta (Antigravity, Jules, AI Studio, Nano Banana 2) |

### Modelli cinesi

| Modello | Chi | Note |
|---|---|---|
| **Kimi K3** | Moonshot AI | 17 luglio: 2.8 **trilioni** di parametri, presentato come il più grande open-source al mondo. Forte su run agentiche lunghe e multi-step |
| **DeepSeek V4 / V4-Pro** | DeepSeek | Il generalista più economico; ai vertici dei ranking OpenCompass di metà luglio |
| **Qwen 3.6-Max** | Alibaba | La base più adattabile dell'ecosistema open; preview tra i migliori modelli domestici |
| **GLM** | Zhipu AI | Considerato la frontiera *coding* tra i cinesi |
| **Doubao Seed 2.0 Pro** | ByteDance | Top nei ranking domestici, spinto dalla distribuzione consumer di ByteDance |
| **ERNIE** | Baidu | Presidia il mercato enterprise cinese |

**Lettura strategica per un'azienda:** i modelli USA dominano la fascia frontier (ragionamento, agenti, affidabilità enterprise); i cinesi comprimono i prezzi e spingono l'open-source a scala inedita (Kimi K3 su tutti). La conseguenza pratica: il costo dell'esecuzione crolla, mentre il valore si sposta su **orchestrazione, verifica e progettazione dei processi** — cioè le competenze dei capitoli 2-4.

*Fonti: [MEXC Learn](https://www.mexc.com/en-GB/learn/article/chinas-top-ai-models-in-2026-deepseek-qwen-kimi-doubao-and-the-new-ai-race/1), [index.dev](https://www.index.dev/blog/chinese-ai-models), [GEO Toolbox](https://geotoolbox.ai/blog/chinese-ai-models-compared), [BenchLM](https://benchlm.ai/best/chinese-models), [felloai.com](https://felloai.com/best-ai-models/), [llm-stats.com](https://llm-stats.com/llm-updates), [LLM Gateway timeline](https://llmgateway.io/timeline), [LM Council](https://lmcouncil.ai/benchmarks), [aireleasetracker](https://aireleasetracker.com/latest), [AIapps](https://www.aiapps.com/blog/july-ai-mega-update-major-breakthroughs-launches/), [Rauji Technologies](https://www.rauljitechnologies.com/blog/july-2026-ai-model-wave/), [Anthropic](https://www.anthropic.com/news/claude-fable-5-mythos-5), [Al Jazeera](https://www.aljazeera.com/economy/2026/7/1/us-lifts-restrictions-on-powerful-ai-models-fable-mythos-anthropic-says), [MarketScale](https://www.marketscale.com/industries/software-and-technology/fable-5-and-mythos-5-are-back-what-the-19-day-shutdown-taught-every-enterprise-about-ai-as-infrastructure).*

---

## 7. Appendice — Mappa dei profili seguiti da [@GiadaF_](https://x.com/GiadaF_/following)

Mappatura completa (~350 account) fatta oggi scorrendo l'intera lista following, organizzata per categoria. È di fatto la "watchlist" da cui arrivano le news del capitolo 5: se i vostri team vogliono costruirsi un radar AI, questa è una base già curata.

**Anthropic / ecosistema Claude (ufficiali e team)**
@AnthropicAI, @claudeai, @ClaudeDevs, @ClaudeCodeLog (bot non ufficiale che traccia ogni release di Claude Code), @claude_code (community), @DarioAmodei (CEO), @jackclarkSF (co-founder, policy), @bcherny (creatore Claude Code), @_catwu (Claude Code + Cowork), @sidbid, @trq212, @amorriscode, @felixrieseberg, @RLanceMartin, @alexalbert__, @janleike (AI safety), @TrentonBricken

**OpenAI** — @OpenAI, @OpenAIDevs, @OpenAINewsroom, @sama, @gdb, @romainhuet, @thsottiaux (Codex), @polynoamial, @aidan_mclau, @Eric_Wallace_, @isafulf, @ilanbigio, @jxnlco, @stevendcoffey, @nikunjhanda, @athyuttamre, @JoHeidecke, @anshitasaini_

**Google / DeepMind / Gemini** — @GoogleDeepMind, @GoogleAI, @GeminiApp, @GoogleAIStudio, @GoogleLabs, @geminicli, @julesagent, @antigravity, @Gemini_Notebook, @NanoBanana, @stitchbygoogle, @googlegemma, @googledevs, @googleaidevs, @GoogleCloudTech, @demishassabis, @sundarpichai, @OfficialLoganK, @joshwoodward, @tokumin, @ammaar, @robertriachi, @rakyll, @femtechie, @lukeschlangen, @googledocs, @Google, @GoogleStartups, @adsliaison

**Altri lab e modelli** — @deepseek_ai (+ @zizhpan), @AIatMeta / @ManusAI / @jhyuxm / @shengjia_zhao / @ren_hongyu / @Ahmad_Al_Dahle (mondo Meta), @ilyasut (SSI), @lilianweng / @_kevinlu (Thinking Machines), @hardmaru (Sakana), @NoamShazeer, @geoffreyhinton, @ylecun, @hume_ai, @StabilityAI, @midjourney, @ideogram_ai, @runwayml

**Coding agent e dev tools** — @cursor_ai (+ @jediahkatz), @cognition (+ @russelljkaplan), @Replit (+ @amasad), @v0, @vercel, @aisdk, @shadcn, @Lovable, @warpdotdev, @conductor_build (+ @charlieholtz), @WindsurfCurrent, @onlookdev, @e2b (+ @mlejva), @browserbase (@pk_iv), @browser_use (@gregpr07, @shawn_pana), @tldraw, @Remotion, @CloudflareDev, @openclaw, @steipete, @rork, @geoffreyhuntley (creatore del ralph loop) + @latentpatterns

**Framework agent / RAG / infra AI** — @LangChain (+ @hwchase17), @llama_index (+ @jerryjliu0), @mastra, @AgnoAgi, @langflow_ai, @FlowiseAI, @huggingface, @OpenRouter, @weaviate_io, @ragieai, @ExaAILabs, @AgentOpsAI (+ @adamsilverman), @superagent_ai (+ @pelaseyed), @arena (ex LMArena), @poe_platform, @DustHQ, @e2b, @yoheinakajima (babyagi), @divgarg, @hcompany_ai

**Ricercatori e voci tecniche di riferimento** — @karpathy, @fchollet, @rasbt, @chipro, @simonw, @swyx, @omarsar0, @lexfridman, @dwarkesh_sp, @AndrewYNg, @afshinea/@shervinea, @Aurimas_Gr, @akshay_pachaar, @elder_plinius (red-teaming), @willccbb, @jacquesthibs, @RNavigli + @SapienzaNLP (NLP italiano)

**Newsletter e media AI** — @AlphaSignalAI (+ @LiorOnAI), @TheRundownAI (+ @rowancheung), @AiBreakfast, @theinformation (+ @steph_palazzolo), @DeepLearningAI, @0xCodila non è in lista ma è la fonte dei thread Loop/Graph Engineering; divulgatori: @emollick, @alliekmiller, @minchoi, @itsPaulAi, @dr_cintas, @mckaywrigley, @rileybrown, @danshipper, @rohanpaul_ai, @_akhaliq, @IntuitMachine, @MindBranches, @bilawalsidhu, @HarperSCarroll, @realSharonZhou, @decisionleader, @ThePyCoach, @NorthstarBrain, @itsolelehmann, @AllAboutAicom, @JustMeAndGPT, @Saboo_Shubham_, @dejavucoder, @techNmak, @KanikaBK, @shedntcare_, @aaditsh, @TrungTPhan, @thealexbanks, @NathanLands, @jjvincent

**VC / business / startup** — @ycombinator (+ @garrytan), @a16z (+ @andrewchen), @paulg, @DavidSacks, @jaltma, @balajis, @jasonlk, @gregisenberg, @levelsio, @tobi, @wadefoster, @hnshah, @bentossell, @lessin, @nikunj, @msg, @craigweiss, @seanpk, @samhogan, @noahmp, @jenzhuscott, @MarceloLima, @tunguz, @apples_jimmy, @iruletheworldmo, @polsia (+ @Bencera), @aimvpbuilders (+ @PrajwalTomar_), @johnrushx, @iamjasonlevin, @jodie_cook, @Nicolascole77, @danshipper, @josephsemrai, @jjson_zhou1993*, @skirano, @nutlope, @iannuttall, @yoheinakajima
*(più una coda di profili growth/marketing: @boringmarketer, @MarketingMax, @TaylorHoliday, @sourfraser, @TheVeller, @rokhladnik, @FedotOff90, @timosheahq, @TheJasSingh, @RevenueFlowHQ, @KarinaShtogryn, @loumaciel, @amir__bio, @sup_nim, @ozanirturk, @FCamiade, @ImanOubou, @iamjosepferrer)*

**Accademia / economia dell'AI** — @orgRem (Harvard), @hyunjinvkim (INSEAD), @alexolegimas (DeepMind/Chicago Booth), @McKinsey, @HarvardBiz, @aakashgupta

**Big tech e media generalisti** — @Microsoft (Azure, @windowsdev, @MSEdgeDev), @Meta (+ @MetaNewsroom, @boztank, @mosseri, @vishalshahis, @MetaOpenSource, @MetaforBusiness, @instagram), @amazon, @tim_cook, @BillGates, @JeffBezos, @elonmusk, @sundarpichai; media: @WSJ, @Forbes, @TheEconomist, @nytimes, @FT, @guardian, @WIRED, @verge, @TechCrunch, @CNN, @cnnbrk, @SkyNews, @BBCBreaking, @Medium, @MattNavarra

**Italia (news e istituzioni)** — @wireditalia, @sole24ore, @SkyTG24, @Open_gol, @ShooterHatesYou, @RobTallei, @alessioviola, @Quirinale, @Palazzo_Chigi, @EUCouncil, @INGVterremoti, @alliscaglioni, @marcocongiu, @FilloFi_, @NikeRunning_IT, @BarackObama

---

## 8. Tre azioni concrete per i prossimi 30 giorni

1. **Provate Skill Recording** (app desktop, menu +): ciascuno registri una procedura ricorrente del proprio team e la trasformi in skill. Costo: 15 minuti. Ritorno: la procedura diventa eseguibile e delegabile.
2. **Un workflow pilota, perimetrato**: scegliete un task "largo" (audit di documenti, review di un set di contratti, analisi di 20 file) e lanciatelo come dynamic workflow con verifica indipendente — partendo dal limite di 20 elementi per misurare i costi.
3. **Adottate il pattern Fable-orchestrator**: nelle sessioni importanti, `/model` → Fable per pianificare, delega a Sonnet per eseguire, ritorno a Fable per verificare. È il modo più economico di avere l'intelligenza massima dove conta.
