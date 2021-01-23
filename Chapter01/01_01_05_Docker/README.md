# Docker

## Docker: Azure Container Registry (ACR)

- &egrave; il registro di Microsoft dove posso salvare in modo sicuro le mie immagini Docker.
- Per caricare le immagini devo taggarle: <acr_name>.azurecr.io/[repository_name][:version]
  - acr_name: nome del mio registro
  - repository_name: nome del repository all'interno del mio registro (opzionale)
  - version: versione della immagine
- Le immagini Docker vendono deployate nell' Azure Container Istance (ACI):
  - Per il deploy mi serve un ACR Service principal
  - Il ACR SP fa il pull e crea un container
