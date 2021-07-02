# Develop event-based solutions

## Azure Event Grid

- Mi permette di creare applicazioni usando una architterttura serverless fornendomi una piattaforma per gestire gli eventi
- Concetti:
  - **Event**: questo è il cambio di stato in una risorsa. Per esempio nei blob storage un evento viene creato quando si aggiunge un file al blob storage
  - **Event source**: Indica il servizio o applicazion che ha generato l'evento
  - **Event handler**: Servizio o App che reagisce all'evento
  - **Topics**: Enpoints dove l'event source può inviare gli eventi
  - **Event subscriptions**: è il meccanismo che per distribuire gli eventi. Può anche filtrare gli eventi in arrivo
  
## Azure Notification Hub

- Ogni piattaforma mobile ha il suo modo per inviare le notifiche. Per iOS devi usare l'Apple Push Notification Service (APNS), Big G ha il Google Firebase Cloud Messaginng (FCM) ed in Win c'è il Windows Notification Service (WNS). E questi sono quelli usati dai principali produttori
- Azure Notification Hub fornishe un livello di astrazione, che ti permette di inviare notifica a tutti i "mondi"
- Si possono usare template per utilizzo in multi piattaforma
- Quando sviluppi una app mobile e vuoi manadare notifica a chi non ha la app aperta usi le push notification. Queste notifiche ti permettono di interagire con chi è "offline"
- Per permettere questa iterazione asincrona ci sono tre parti chiave:
  - **The Mobile app client**: La tua app che gira sul dispositivo utente. L'utente si deve registrare con il Platform Notification System (PNS) per ricevere le notifiche. Questo crea un PNS handler che viene salvato nella app mobile backend per inviare notifiche
  - **The mobile app back end**: Il back end della tua app che salva il PNS handler che riceve dal PNS, e lo usa nei servizi di backend per inviare notifiche a tutti gli utenti registrati
  - **A Platform Notification System (PNS)**: Queste piattaforme inviano le notifiche al dispositivi degli utenti.PNS dipendono dalla piattaforma, e i vari produttori hanno ognuno il proprio (Apple, Google, Microsoft)

## Azure Event Hub

- Azure Event hub funziona come Event Grid, ma può gestire milioni di richieste al secondo
- Quando publichi un evento hai un limite max di 1MB di dati per pubblicazione
- Gli eventi sono salvati in partition key, e sono consegnati in ordine alla stessa partizione
- Non posso cancellare eventi che arrivano nella partizione, devo aspettare che scadano per rimuoverli
- Posso creare da 2 a 32 partizioni, una volta create non le posso modificare, quindi considera il massimo numero di downstream paralleli
- I receiver li collego all'hub usando consumer groups