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
- [Enable diagnostics logging](./Chapter01/01_02_02_diagnostic_logging/)
- [Deploy code to a web app](./Chapter01/01_02_03_deploy_code_webapp/)
- [Implement Azure Functions](./Chapter01/01_03_01_Implement_Azure_Functions/)

## Capitolo 2 - Develop for Azure Storage

#### Sezioni

- [Cosmos DB storage](./Chapter02/02_01_cosmos_db_storage/)
- [Blob storage](./Chapter02/02_02_blob_storage/)

## Capitolo 3 - Impelment Azure security

#### Sezioni

- [Implement user authentication and authorisation](./Chapter03/03_01_authentication_authorisation/)
- [Implement secure cloud solutions](./Chapter03/03_02_secure_cloud_solutions/)

## Capitolo 4 - Monitor, troubleshooting, and optimize Azure solutions

#### Sezioni

- [Integrate caching and content delivery within solution](./Chapter04/04_01_integrate_caching_and_content_delivery/)
  - Not able to complete exercise 1:
    - ![No access](./Chapter04/04_01_integrate_caching_and_content_delivery/cdnIssue1.png)
    - ![No access](./Chapter04/04_01_integrate_caching_and_content_delivery/cdnIssue1.png)
- [Instruments solutions to support monitoring and loggin](./Chapter04/04_02_monitor_and_logging/)

## Capitolo 5 - Connect to and consume Azure services and thirdparty services

#### Sezioni

- [Develop an App Service Logic App](./Chapter05/05_01_develop_logic_app/)
- [Implement API Management](./Chapter05/05_02_apim/)
- [Develop event-based solutions](./Chapter05/05_03_events/)
- [Develop message-based solutions](./Chapter05/05_04_messages/)

## Az CLI Comandi

| Comando | Descrizione |
|----|----|
| az account list --output table | Elenca le tue subscriptions |
| az account set --subscription "My Demos" | Imposta la sottoscrizione da usare |
| az resource list --output table | Elenca le risorse associate alla sottoscrizione corrente |
| az group list --output table | Elenca i gruppi associati alla sottoscrizione corrente |
