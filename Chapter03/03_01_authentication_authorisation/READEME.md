# Implement user authentication and authorization

- Gli steps del libro non sono più validi. Google ha cambiato le schermate per registare una app. Sono riuscito comunque a registrare una app ed usare l'esempio del libro
- Ho replicato il secondo esercizio

## Shared Access Sgnatures

- Quando lavoro con Azure Storage, devo avere più controllo su chi/come/per quanto tempo un client può accedere i dati, AZ Storage fornisce più livelli di sicurezza:
  - **Shared Key Authorization**: Puoi usare una delle due chiavi per accedere AZ Storage. Viene passata nell'Authirization header. Le chiavi danno accesso a tutto, blobl files queue e tabelle.
  - **Shared Access Signatures**: SAS ti permette di ridurre gli accessi fino a specifici container. Non devi condividere le access keys e sei più granulare
- SAS può essere configurato con diversi livelli di accesso ad:
  - **Services**: puoi configuare accessi solo a ciò che ti server tipo blob, file, queue or tabelle
  - **Resource types**: Configuri l'accesso ad un servizio, container o oggetto. Per i Blob, configuri gli accessi alle API al service level, come la lista dei container. Se configuri SAS al container level puoi settare i metadata del container o creare nuovi blob. Se setto SAS ad object level posso creare e modificare i blob del container
  - **Permissions**: Configuri le azione che l'utente può eseguire sulla risorsa e servizi
  - **Date expiration**: configuri il periodo in cui il SAS può accedere ai dati
  - **IP addresses**: dai accesso in base all'IP
  - **Protocols**: Specifichi come accedere i dati, HTTP/s
- Posso configurare tre tipi di SAS:
  - **User delegation SAS**: si applica solo a Blob Storage, usi un AZ AD user account per proteggere il SAS token
  - **Account SAS**: contolla l'accesso all'intero Storage Account. Devi usare lo storage account key per questo tipo di SAS
  - **Service SAS**: Delega l'accesso a specifici servizi all'interno dello Storage Account. Devi usare lo storage account key per questo tipo di SAS
- Negli esercizi per impostare diversi livelli di sicurezza, dovevo sempre condividere un link per dare accesso allo storage. Condividere un link non è il massimo in termini di sicurezza. Per migliorare quest aspetto esistono le "Stored Access Policy", le quali sono definite e salvate con la tabella che vuoi proteggere.
- Quando definisco una policy, le do un ID, che dovrà poi essere usatp quando genero il token SAS (l'ID diventa parte del token SAS)
- I vantaggi sono che posso controllare la validatà e scadenza delle policy senza modificare il SAS token. Il SAS token normale ha una sfilza di query param nell'URL. Qui ho l'ID, e la definizione è nelle policy
- Posso associare fino a 5 policy

## Azure Active Directory

- Punti da considerare quando registro la mia app:
  - **Supported account types**: Devo considerare se gli utenti della app saranno:
    - **Users from your organization only** Ogni persona che ha un account nel mio tenant potra usare l'app
    - **Users from any organization** Usare questa opzione quando voglio che qualsiasi utente con un AD account, professional o educationl, possa fare la log in nella mia app
    - **Users from any organization or Microsoft accounts** usa questa opzione se vuoi che ogni professional, educational o chiunque abbia un Microsoft account possa accedere alla app
- **Platform** L'OAuth2 non è solo limitato ad applicazioni web, puoi usarlo anche per piattaforme mobile, iOS, Android o desktop, macOS, Console, IoT Windows, UWP

## RBAC

Role-based access controls (RBAC).
Concetti:

- **Security principal**: L'entità che richiede i permessi per compiere una azione. Un sec principal può essere uno di questi:
  - **User**: un individuo che ha un profilo in Azure AD tenant
  - **Group**: Un grouppo di utenti
  - **Service Principal**: Simile all'"Utente" per una applicazione. Il SP rappresenta una applicazione all'interno del tenant
  - **Managed identity**: Questo tipo di identità rappresenta le app cloud che hanno bisogno di accedere al mio AD Tenant. Azure gestisce automaticamente queste identità
- **Permission**: Le azioni che puoi fare con una risorsa. Es: richedere una delegation key per creare un SAS token, elencare il contenuto di un container etc. Non puoi assegnare una permission ad un SP, devi usare una role o role definition
- **Role Definition**: Nota come semplicemente "Role", è un gruppo di permissions. Tu assegni una role as un SP. Ci sono molte role predefinite che posso usare per gestire le risorse, ce ne sono 4 fondamentali:
  - **Owner**: Da accesso completo a tutte le risorse in scope
  - **Contributor**: Da accesso in modifica a tutte le risorse, puoi fare tutte le modifiche, inclusa la delete delle risorse in scope. Non puoi assegnare role ad altri SP
  - **Reader**: Accesso in sola lettura a tutte le risorse in scope
  - **User Access Administrator**: Utile solo per getire gli accessi degli utenti alle risorse Azure
- **Scope**: Il gruppo di risorse dove assegno le role. 4 livelli: management group (gruppo di subscriptions), subscription, resource group, resource, Questi livelli sono organizzati in parent/child, con MG al top e R in basso.
- **Role assignement**: Questo è la ginzione tra i pezzi differenti del RBAC. Una role assignment si connette all'SP con una role ed uno scope 