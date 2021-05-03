# Blob Storage

- Blob storage lo usi per salvare cose che non rientrano nelle caratteristiche dell' SQL o NoSQL DB. (Foto, file, video etc.)
- Costa di meno rispetto a Cosmos
- Gestire i file: ci sono diversi modi per fare operazioni con i blob:
  - Azure Storage Explorer: Ui via browser
  - AzCopy: command line
  - Python: usare script
  - SSIS: SQL Server Integration Service Feature Pack tool che ti permette di trasferire i dati tra il tuo storage locale ed azure storage account
- Non esiste la "move" solo copy e delete
- I file nel blob storage possono avera metadata. Alcuni corrispondono a HTTP headers e sono gestiti da azure, altri sono personalizzabili. Una sorta di EXIF data nelle foto
- Quando accedo ad un Blob via codice, posso settare un "lease" + un ID che mi "locca" il file. Il lock può durare da 15 a 60 secondi o per sempre.
- Stati del "lease":
  - **Available**: blob non loccato
  - **Leased**: Un lease è impostato. Puoi prendere un nuovo "lease" se usi lo stesso ID. Puoi inoltre rilasciare, cambiare, rinnovare o rompere il lease in questo stato
  - **Expired**: Il lease è scaduto, puoi acquisirlo, rinnovarlo, rilasciarlo o romperlo
  - **Breaking**: Hai rotto il lease, ma continua ad essere loccato fino a quando il periodo di "break" scade. In questo stato puoi rilasciare o romprere il lease
  - **Broken**: Il periodo di break è scaduto ed il lease è stato rotto. In questo stato puoi acquisire, rilasciare e rompere il lease. Il break lo fai quando è successo qualcosa che ha impedito il corretto rilascio. Tipo problema di rete, do ci sono lease orfani che vuoi rimuore
