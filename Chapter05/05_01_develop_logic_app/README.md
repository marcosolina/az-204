# Develop an App Service Logic App

- App Service Logic App ti permette di creare workflows per interconnettere sistemi diversi basati su "condizioni" o "regole" permettendo di scambiarsi informazioni
- Logic Apps ti permette di creare interconnessioni complesse usando alcuni elementi:
  - **Worflow**: Definisce sorgente e destinazione. Definisce i passi o azioni che l'informazioni deve compiere per essere conseganta. Si usa un linguaggio grafico per visualizzare, progetttare, costruire, automatizzare e deploy il processo
  - **Managed Connectors**: è un oggetto che permette al tuo workflow di accedere ai dati, servizi, sistema
  - **Triggers**: Puoi usare i triggers come pulsante di accensione di un workflow
  - **Actions**: Una action è uno singolo step definito nel workflow
  - **Enterprise Integration Pack**: Per eseguire iterazioni più avanzate, mette a disposizione capacità server BizTalk
- Tigger e Action sono messi insieme in connectors. I connectors si usano per accedere ai dati, eventi e azioni di altri servizi o applicazioni
- Ci sono migliaia di connectors
- Un custom connector è praticamente un wrapper per una REST o SOAP API
- Posso esportare le logic app in ARM template. Posso farlo da browser, vistual studio e CLI
- Per esportare le lodic app con visual studio devo installare [questo tool](https://marketplace.visualstudio.com/items?itemName=VinaySinghMSFT.AzureLogicAppsToolsForVS2019)
- 