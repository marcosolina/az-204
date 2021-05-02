# Blob Storage

- Blob storage lo usi per salvare cose che non rientrano nelle caratteristiche dell' SQL o NoSQL DB. (Foto, file, video etc.)
- Costa di meno rispetto a Cosmos
- Gestire i file: ci sono diversi modi per fare operazioni con i blob:
  - Azure Storage Explorer: Ui via browser
  - AzCopy: command line
  - Python: usare script
  - SSIS: SQL Server Integration Service Feature Pack tool che ti permette di trasferire i dati tra il tuo storage locale ed azure storage account
- Non esiste la "move" solo copy e delete