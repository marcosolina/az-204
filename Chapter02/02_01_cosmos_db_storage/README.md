# Develop solutions that use Cosmos DB storage

- Cosmos fornisce API multiple
- Puoi salvare i dati usnado gli approcci:
  - Key-Value
  - Column-Family
  - Documents
  - Graph
- APIs:
  - **SQL**: Usato per i documenti JSON. Il motore converte la SQL in in sintassi Javascript
  - **Table**: è una sorta di evoluzione  delle Azure Table Storage. Puoi aggiungere indici alle tabelle, e ti permette di usare una struttura basata su documenti
  - **Cassandra**: è l'implementazione da usare se migri un'Apache Cassandra database, è basato su DB a colonne e le informazioni sono salvate con un approccio Key-Value
  - **MongoDB**: ti permette di usare accedere al DB in "NoSQL" style
  - **Gremlin** Basato su Apache TinkerPop, questa API ti pemetter si salvare le informazioni usando una struttura Graph
- Quando crei il DB devi scegliere quale APi usare, e non la puoi più cambiare
- **Partizioni**: Azure salva i dati su diversi server, in modo tale da offrire migliori performance. I dati vengono quindi partizionati, esistono due tipi di partizioni:
  - **Logical** Tu puoi dividere il container in piccoli pezzi basati su un tuo criterio. Ognuno di questi piccoli pezzi è una partizione logica, condivino la stessa partition key
  - **Physical** Queste partizioni sono un gruppo di repliche dei tuoi dati che sono fisicamente salvate sul server. Azure gestisce in modo automatico questi gruppi. Una partizione fisica può contenere una o più partizioni logiche.
- Di default ogni partizione logica ha un limite di 20GB
- Se necessario posso creare "synthetic partion key", sarebbe la concatenazione di due proprietà concatenate