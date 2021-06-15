# Integrate caching and content delivery within solutions

- Content Delivery Network (CDN) è un gruppo di server distribuiti in posizioni diverse nel mondo che forniscono contenuti web agli utenti
- Siccome CDN sono distribuiti, CDN fornisce i contenuti dal server più vicino all'utente
- Per usare CDN nella mia soluzione devo configurare dei profili, i quali contengono gli endpoints che verranno inclusi nella CDN, il modo in cui i contenuti vengono forniti e accessi agli endpoint
- Quando configuri Azure CDN profile devi scegliere se usare Microsoft CDN, Verizon o Akamai
- Nella config della risorsa Azure CDN posso:
  - Usare un DNS personalizzato
  - Compressione di alcuni MIME type
  - Regole di caching, tipo quali paths o content type, expiration time etc. Caching ules è disponibile solo per i profili Verizon standard e Akamai standard
  - Geo-Fileterin per bloccare o meno il contenuto di una web app in certe parti del mondo
  - Optimization: per ottimizzare la consegna di contenuty diversi. In base al profilo creato posso ottimizzare enpoint per:
    - General web delivery
    - Dynamic site acceleration
    - General media streaming
    - Video-on-demand media streaming
    - Large file downloads
- Esiste una libreria .NET per creare CDN al volo
- Le cose cachate restano in cache per un certo tempo. Posso configurare il Time To Leave (TTL) usando un Cache-Controll HTTP Header:
  - Default CDN config: Se non configuri nulla si prende il valore di default 7gg
  - Caching Rules: Puoi configurare il TTL globalmente o con regole
  - Web.config files: usa web.config files per impostare la scadenza della cartella. Posso avere più config files
  
    ~~~~xml
    <configuration>
      <system.webServer>
        <staticContent>
          <clientCache cacheControlMode="UseMaxAge" cacheControlMaxAge= "3.00:00:00" />
        </staticContent>
      </system.webServer>
    </configuration>
    ~~~~

  - Programmaticamente: posso controllare il CDN caching impostando la proprietà: HttpResponse.Cache
  
    ~~~~c#
    // Set the caching parameters.
    Response.Cache.SetExpires(DateTime.Now.AddHours(5));
    Response.Cache.SetCacheability(HttpCacheability.Public);
    Response.Cache.SetLastModified(DateTime.Now);
    ~~~~

- Azure CDN non è l'unico servizio Microsoft per cachere i contenuti

## Azure Fron Door

- Questo servizio ti permette di "route" il traffico in modo efficiente alla posizione più vicina all'utente e ti permette di cachare i contenuti fornendo un CDN
- Come in Azure CDN puoi configuare la cache e il TTL degli elementi

## Redis

- Tre prezzi:
  - Basic: Basso throughput e alta latenza. Da usare soro per la fase di sviluppo. Non c'è un Service Level Agreement (SLA)
  - Standard: Offre due nodi, primario e secondario. Il SLA ha una disponibilità del 99.9%
  - Premium: Enterprise Redis cluster gestito da Microsod. Fornisce tutte le funzioni per high throughput e bassa latenza, deployato su hardware potente. SLA 99.9%
-