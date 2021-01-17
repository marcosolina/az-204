# AZ-204

## Utils

- Ubuntu
  - Install az CLI
  
    ```bash
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    ```

## Capitolo 1

### Develop Azure Infrastructure as a service compute solution

- Quando sviluppi una applicazione nel cloud, di solito crei o una IaaS oppure una PaaS
  - IaaS Infrastructure as a service: più granulare, ed hai più controllo, ma devi mantenere la infrastruttura a mano
  - PaaS Platform as a service: tu pensi solo alla tua applicazione
- Con IaaS di solito devi creare una VM

#### Provision a VM

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

#### Azure Resource Manager (ARM)

- Alcuni termini da capire:
  - Resource: la &quot;cosa&quot; che creo in Azure
  - Resource Group: il contenitore delle mie risorse
  - Resource Provider: L&#39;utilità che mi crea la risorsa: Microsoft.Compute per le VM, Microsoft.Storage per lo storage account, Microsoft.Network per le risorse di rete e così via
  - Resource Manager template: JSON file che definisce la mia risorsa e viene dato in pasto all&#39;ARM API
- Esempio base ti ARM template:
  
  ```javascript
  {
    "$schema":"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion":"1.0.0", // Obbligatorio, il tuo numero di version
    "parameters":{
        // Opzionale, usato per impostare i parametri da passare al Resource Manager
    },
    "variables":{
        // Opzionale, variabili che tu usi all'interno del template
    },
    "functions":[
        // Opzionale, definisci le funzioni da usare
    ],
    "resources":[
        // Obbligatorio, le risorse da "deployare" or aggiornare con questo template
    ],
    "outputs":{
        // Opzionale, i valori che il Resource Manager deve ritornare al termine del deploy
    }
  }
  ```

- Negli arm template posso definire varaiblili, quando definisco una variabile devo fornire tre propriet&agrave;: "parameterName", "defaultValue" e "type".
  - Type pu&ograve; essere: string, securestring, int, bool, object, secureObject, array



## Az CLI Comandi

| Comando | Descrizione |
|----|----|
| az account list --output table | Elenca le tue subscriptions |
| az account set --subscription "My Demos" | Imposta la sottoscrizione da usare |
| az resource list --output table | Elenca le risorse associate alla sottoscrizione corrente |
| az group list --output table | Elenca i gruppi associati alla sottoscrizione corrente |
