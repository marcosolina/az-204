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

#### [Azure Resource Manager (ARM)](./Chapter01/01_01_04_CreateVm_Arm/)

#### [Docker: Azure Container Registry (ACR)](./Chapter01/01_01_05_Docker/)

## Az CLI Comandi

| Comando | Descrizione |
|----|----|
| az account list --output table | Elenca le tue subscriptions |
| az account set --subscription "My Demos" | Imposta la sottoscrizione da usare |
| az resource list --output table | Elenca le risorse associate alla sottoscrizione corrente |
| az group list --output table | Elenca i gruppi associati alla sottoscrizione corrente |
