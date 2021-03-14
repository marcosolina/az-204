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
- 