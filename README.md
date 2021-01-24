# AZ-204

## Utils

- Ubuntu
  - Install az CLI
  
    ```bash
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    ```

  - Remove Windows Characters from Bash scropt

    ```bash
    sed -i -e 's/\r$//' SCRIPT_NAME
    ```

## Capitolo 1 - Develop Azure Infrastructure as a service compute solution

### Introduzione

- Quando sviluppi una applicazione nel cloud, di solito crei o una IaaS oppure una PaaS
  - IaaS Infrastructure as a service: più granulare, ed hai più controllo, ma devi mantenere la infrastruttura a mano
  - PaaS Platform as a service: tu pensi solo alla tua applicazione
- Con IaaS di solito devi creare una VM

#### Sezioni

- [Provision VMs](./Chapter01/01_01_01_Provision_Vm/)
- [Azure Resource Manager (ARM)](./Chapter01/01_01_03_CreateVm_Arm/)
- [Docker: Azure Container Registry (ACR) & Azure Container Istance (ACI)](./Chapter01/01_01_05_Docker/)
- [Azure App Service - Azure App Service Plan](./Chapter01/01_02_01_Azure_App_Service_webapp/)
- [Enable diagnostics logging](./Chapter01/01_02_02_diagnostics_logging)

## Az CLI Comandi

| Comando | Descrizione |
|----|----|
| az account list --output table | Elenca le tue subscriptions |
| az account set --subscription "My Demos" | Imposta la sottoscrizione da usare |
| az resource list --output table | Elenca le risorse associate alla sottoscrizione corrente |
| az group list --output table | Elenca i gruppi associati alla sottoscrizione corrente |
