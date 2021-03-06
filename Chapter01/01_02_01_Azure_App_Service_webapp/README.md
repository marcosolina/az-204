# Azure App Service Web Apps

- Azure App Service è una piattaforma a servizio (PaaS)
- è un servizio che aiuta a sviluppare le tue applicazioni, web, app back end, REST APIs senza pensare all'infrastuttura sottostante
- Poui usare i principali linguaggi di programmazione
- La piattaforma può essere Win o Linux
- Fornisce capacità enterprise, come load balancing, security, autoscaling e gestione automatica
- Come tutte le Web App, le Azure App Service devono anchesse girare su una VM. Queste VM sono gestite **App Service Plan**.
- Quando definisci l'app service plan, non ti devi preoccupare dei dettagli come quando crei una vera VM, devi solo fornire delle info di alto livello
- Puoi deployare più App Service nello stesso App Service Plan
- Quando creo un App Service Plan devo fornire:
  - **Region**: La regione dove deployare l'ASP (App Service Plan)
  - **Number of istances**: Il numero di VM da aggiungere all'ASP
  - **Size of the instances**: La dimensione della VM usata dall'ASP
  - **Operating system platform**: Il sistema sul quale la web app girerà, Linux o Windows VMs. Il costo cambia in base alla scelta, e l'OS non può essere cambiato una volta fatto l'ASP
  - **Pricing tier**: Specifica il set di funzionalità e capacità disponibile per l'APS. Per le Win VMs, due livelli base di prezzo usano VM condiivse (F1 e D1).
  - Quando eseguo una App Service in un ASP, tutte le istanze configurate nel ASP faranno girare la mia App. Quasto significa che se io ho più VM nell'ASP, tutte quante faranno girare la mia App
  - Se la mia Web App richiede accesso a risorse nella mia infrastruttura locale (Ufficio o casa), l'App Service fornisce due metodi:
    - **Vnet integration**: Disponibile solo per pacchetti Standard, Premium o Premium V2. Permette alla tua Web App ti accedere alle risorse nella tua VPN
    - **Hybrid connections**: Questa opzione dipende dall'Azure Service Bus Relay e crea una connessione di rete tra l'App Service e l'end point dell'applicazione. Significa che abilita traffico TCP tra uno specifico HOST e combinazione di porte
