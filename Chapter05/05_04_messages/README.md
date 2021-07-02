# Develop message-based solutions

- Un messaggio è in generale un tipo di dato grezzo, che viene generato da un servizio e processato o salvato da un'altra parte
- Il publisher si aspetta che un'altro sistema o un subscriber processi il messaggio e quindi che venga noticato una volta che il messagio è stato processato

## Azure Service Bus

- è un enterprise level message broker che permette ad applicazioni differenti di comunicare tra loro
- il messagio sono i dati grezzi che vengono scambiati, possono contenere json, xml o testo
- concetti:
  - **Namespace**: container di tutti i componenti, un singolo namespace può contenere più code e topics
  - **Queue**: Container dei messaggi, la coda funziona in FIFO
  - **Topic**: usa i topic per inviare - ricevere messaggi. La differenza tra queue e topic è che i topic possono avere parecchie applicazioni che ricevono i messaggi utilizzati in scenario publish/subscribe

## Azure Queue Storage

- Funziona in modo simile a Azure Service bus, ma è più appropriato se l'app deve salvare più di 80GB di messaggi in una coda
- Cosa imporatnte, in service bus si ha un ordine FIFO, in queue storage l'ordine non è garantito
- Dimensione massima di un messaggio 64KB
- Posso accedere a Azure Queue solo con REST API o .NET SDK