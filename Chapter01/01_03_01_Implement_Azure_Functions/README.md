# Implement Azure Functions

- Le Azure Functions sono basate sull'Azure App Service
- Con le function paghi solo se il codice sta girando, a differenza App Service che paghi anche se non girano
- Siccome le functions si basano sull'app service, può scegliere di farle giare all'interno di un app service plan esistente.
- Il modo in cui dichiaro i bindings dipende dal linguaggio:
  - C#: decoro i metodi
  - Altri: modifico il file di configurazione function.json definendo:
    - **type**: Stringa che rappresenta il tipo do binding
    - **direction**: input, output o inout bindings
    - **name**: La function usa questo attributo per associare i dati nella funzione. Per esempio in Javascript, la chiave in un key-value list
- Per poter usare un binding lo devo prima registrare. In C# lo faccio isntallando un NuGet, per gli altri installo un pacchetto usando una utility CLI
- Ci sono tre modi per configurare i trigger:
  - **data operation**: Inviato quando dei dati sono creati, modificati o aggiunti al sistema. Code supoprtate: CosmosDB, Event Grid, Event Hub, Blob Storage, Queue Storage e Service Bus
  - **timers**: esecuzioni programmate
  - **webhooks**: HTTP request
- Quando uso trigger di tipo "Timer" e "Webhook" non devo installare l'extension package
- HTTP function, possono essere protette con delle keys:
  - **host**: queste chiavi sono condivise tra tutte le funzioni
  - **function**: queste chiavi proteggono la singola funzione
- Le funzioni quando girano hanno dei limiti, tipo lunghezza della request, lunghezza URL, tempo di esecuzione.

## Durable functions

- Le function sono stateless, le durable functions sono una estensione delle functions che forniscono uno stateful workflow in un ambiente serveless
- **Cosa posso fare**:
  - chiamare altre funzioni mantenendo lo stato tra le chiamate (sincrone e non)
  - Definire il workflow via codice, non via JSON
  - Essere sicuro che lo stato sia consistente
- Ci sono diversi tipi di durable functions
  - Activity: eseguono il lavoro
  - Orchetrator: chiamano le activity quando e nell'ordine necessario
  - Client: L'entry point. Il trigger può essere HTTP, queue event etc
- Le durable aggiungono due trigger in più. Orchestration trigger e Activity trigger
