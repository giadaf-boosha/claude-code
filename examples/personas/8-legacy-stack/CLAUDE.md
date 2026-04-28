# Sistema: <nome legacy>

## Stack (esempio RPG; adatta al tuo)
- IBM i 7.5, RPGLE free + RPGLE fixed-form, CL programs
- DB2 for i, file fisici/logici + SQL
- Build: PDM / RDi
- (Alternativa COBOL: COBOL Enterprise + JCL + DB2 z/OS)
- (Alternativa .NET: .NET Framework 4.8 WebForms + WCF)
- (Alternativa Java EE: Java 8 + Struts 1 + EJB 2.1 + WebLogic 10)

## Regole anti-fallimento (rigide)
- LEGGI sempre il sorgente prima di proporre modifiche
- Non inventare opcode RPG / verbi COBOL: verifica nei manuali IBM/Microsoft
- Non assumere semantica di file logici: leggi DDS
- Cita sempre member:linea quando referenzi codice
- Modernizzazione = strangler fig, non rewrite

## Boundary
- Niente modifiche dirette su QGPL / produzione
- Output in libreria DEV; promozione manuale
- Backup membro prima di ogni edit
- Mai DROP / DELETE su tabelle senza approvazione DBA

## Documentazione
- Ogni programma esplorato → docs/legacy/<NOME>.md
- Diagrammi flusso in mermaid

## Output style
- "Explanatory" attivo: spiega il *perche'* del codice legacy
- 1M context per caricare interi sorgenti (4000+ righe)
