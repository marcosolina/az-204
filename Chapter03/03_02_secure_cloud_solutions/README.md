# Implement secure cloud solutions

- Azure App Configuration: mi permette di salvare tutta la configurazione necessario per la mia app cloud in un unico repository. Ci sono altri servizi Azure che mi permettono di gestire la config della mia app, ma hanno delle differenze:
  - **Azure App Service settings**: Posso definire i settings nell'app service, ma questi settings sono solo per la singola istanza. Azure App Configuration service è centralizzato e mi permette di condividere la stessa configurazione con diverse istanze di Azure App Service
  - **Azure Key Vault**: ti permette di salvare in modo sicuro passwords ed altre impostazioni che io possa usare. Offre un livello di sicurezza più elevato
- Quando uso Azure App Configuration, devo lavorare con due componenti, App Configuration store e SDK
- Lo store è dove salvo la config. C'è la versione free e quella a pagamento. Posso passare dalla free alla pagamento senza problemi ma non viceversa