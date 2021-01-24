# Provision a VM

- Quando creo un VM posso scegliere diverse configurazioni hardware.
- Ogni subscription ha un limite max di 20 VM per regione. Se me ne servono di più devo contattare l&#39;Azure support Service
- Le VM extensions mi permettono di automatizzare delle attivtà dopo il deploy della VM. Per esempio eseguire degli scripts, deploy di configurazione o acquisire dati diagnostici
- Il deploy della VM lo posso fare in divesi modi:
  - Azure Portal
  - Powershell
  - Azure CLI
  - REST API or C#
- Se la VM usa un load balancer è meglio metterla in un &quot;availability set&quot;. Questo mi garantisce the le VM che ospitano la mia app non stanno tutte sullo stesso hardware
- Per accedere ad una VM da remoto mi server:
  - Public IP (Statico o dinamico)
  - Network security group
  - Security rule
