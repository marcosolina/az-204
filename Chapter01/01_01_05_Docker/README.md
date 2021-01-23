# Docker

## Docker: Azure Container Registry (ACR)

- &egrave; il registro di Microsoft dove posso salvare in modo sicuro le mie immagini Docker.
- Per caricare le immagini devo taggarle: <acr_name>.azurecr.io/[repository_name][:version]
  - acr_name: nome del mio registro
  - repository_name: nome del repository all'interno del mio registro (opzionale)
  - version: versione della immagine
- Quando voglio istanziare una immagine nell' Azure Container Istance (ACI) usando le immagini del mio Azure Container Registry (ACR) devo prima authenticarmi come admin:
  - Login nella azure shell [https://shell.azure.com](https://shell.azure.com)
  - Copiare nella bash shell lo script "publishImage.sh"
  - Eseguire lo script
