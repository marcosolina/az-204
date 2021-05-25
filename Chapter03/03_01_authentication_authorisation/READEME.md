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

