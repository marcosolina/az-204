# Deploy Code to a Web App

- Azure App Service fornisce dei deployments slots. Questi slots sono i deployments della mia web app che risiede nello stesso App service
- Un deployment slot possiede la sua configurazione ed hostname.
- Puoi usare questi slot per testare il codice prima di passare allo slot di produzione
- Il benefit è che poi scambiare questi slot senza downtime
- Quando voglio fare il deploy della mia app Azure offre:
  - **ZIP or WAR files**: Vengono deployati utilizzando il servizio Kudu
  - **FTP**: Puoi copiare i file della tua app direttamente nell'App Service tramite FTP/S
  - **Cloud Synchronization**: Utilizza Kudu, ti permettere di tenere i file su OneDrive o Dropbox
  - **Continuous deployment**: Azure si integra con GitHub, BitBucket o Azure Repos per eseguire il deploy. In base al servizio, puoi usare Kudo build server o Azure Pipelines per implementare CI. Puoi anche configurare le integrazioni manualmente con altri cloud repo come GitLab
  - **Your local Git repository**: Puoi configurare il tuo App Service come repository remoto del tuo repo locale, e fai il push del codice ad Azure. Kudo poi compila e fa il deploy nell'App Service
  - **ARM Template**: Puoi usare VS e ARM per fare il deploy
- Al lavoro ci siamo creati noi le CI e CD pipeline. Il libro mi ha mostrato un modo per creare le pipeline direttamente dalla web app. Nel portale, apro la webapp, a sinistra o la sezione "Deployment", scelgo "Deployment Center" e seguo le isruzioni a video
