# Implement secure cloud solutions

- Azure App Configuration: mi permette di salvare tutta la configurazione necessario per la mia app cloud in un unico repository. Ci sono altri servizi Azure che mi permettono di gestire la config della mia app, ma hanno delle differenze:
  - **Azure App Service settings**: Posso definire i settings nell'app service, ma questi settings sono solo per la singola istanza. Azure App Configuration service è centralizzato e mi permette di condividere la stessa configurazione con diverse istanze di Azure App Service
  - **Azure Key Vault**: ti permette di salvare in modo sicuro passwords ed altre impostazioni che io possa usare. Offre un livello di sicurezza più elevato
- Quando uso Azure App Configuration, devo lavorare con due componenti, App Configuration store e SDK
- Lo store è dove salvo la config. C'è la versione free e quella a pagamento. Posso passare dalla free alla pagamento senza problemi ma non viceversa

## Azure Active Direcotry

- Managed Identities for Azure Resources: elimina la necessità di usare credenziali per autenticare le applicazioni che supportano Azure AD authentication. Elimina praticamente la necessità di salvare le credenziali.
- Ci sono due tipi di managed identities:
  - System assigned managed identities: Identità attivate automaticamente quando crei il servizio Azure, come VM o Azure data lake store. Azure crea una identità associata alla risorsa e la salva nel AD tenant associato alla subscription. Quando elimini la risorsa, azure elimina anche l'identità
  - User-assigned managed identities: Puoi creare queste identita e associarle a uno o più servizi. Queste identità sono indipendenti dal servizio, vuol dire che se elimi il servizio l'identità non viene eliminata
- Quando lavoro con le managed identites ci sono tre concetti importanti:
  - **Client ID**: ID univiquo creato da AD
  - **Principal ID**: ID del service principal associato con la managed identity. Servici Principal e managed identity sono strettamente legati ma differenti. L'SP è l'oggetto che usi per assegnare role-based access ad una risorsa Azure
  - **Azure Istance Metadata Service (IMDS)**: Quando usi managed identities in una VM, puoi usare IMDS per richiedere OAuth token per l'app deploiata sulla VM. IMDS è un endpoint REST che puoi usare per accedere dalla tua VM. Non è un IP routable