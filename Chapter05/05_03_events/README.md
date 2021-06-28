# Develop event-based solutions

## Azure Event Grid

- Mi permette di creare applicazioni usando una architterttura serverless fornendomi una piattaforma per gestire gli eventi
- Concetti:
  - **Event**: questo è il cambio di stato in una risorsa. Per esempio nei blob storage un evento viene creato quando si aggiunge un file al blob storage
  - **Event source**: Indica il servizio o applicazion che ha generato l'evento
  - **Event handler**: Servizio o App che reagisce all'evento
  - **Topics**: Enpoints dove l'event source può inviare gli eventi
  - **Event subscriptions**: è il meccanismo che per distribuire gli eventi. Può anche filtrare gli eventi in arrivo