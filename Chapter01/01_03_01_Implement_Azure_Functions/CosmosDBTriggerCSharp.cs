// C# ASP.NET Core
using System.Collections.Generic;
using Microsoft.Azure.Documents;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;
namespace Company.Function
{
    public static class CosmosDBTriggerCSharp
    {
        /*
        * Esempio di una funzione con DB trigger
        */
        [FunctionName("CosmosDBTriggerCSharp")]
        public static void Run([CosmosDBTrigger(
                                    databaseName: "databaseName",
                                    collectionName: "collectionName",
                                    ConnectionStringSetting = "AzureWebJobsStorage",
                                    LeaseCollectionName = "leases",
                                    CreateLeaseCollectionIfNotExists = true)]
                                    IReadOnlyList<Document> input, 
                                ILogger log)
        {
            if (input != null && input.Count > 0)
            {
                log.LogInformation("Documents modified " + input.Count);
                log.LogInformation("First document Id " + input[0].Id);
                log.LogInformation("Modified document: " + input[0]);
            }
        }
    }
}