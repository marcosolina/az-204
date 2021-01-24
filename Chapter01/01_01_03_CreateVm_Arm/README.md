# Azure Resource Manager (ARM)

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