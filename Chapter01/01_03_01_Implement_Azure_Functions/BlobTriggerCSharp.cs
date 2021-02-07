// C# ASP.NET Core
using System;
using System.IO;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.WebJobs.Extensions.SignalRService;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Azure.EventGrid.Models;
using System.Threading.Tasks;
namespace Company.Functions
{
    public static class BlobTriggerCSharp
    {
        /*
        * Esempio di una funzione con Event grid trigger trigger,
        * Blob input, cosmos DB output e SignalIR output
        */
        [FunctionName("BlobTriggerCSharp")]
        public static Task Run(
            [EventGridTrigger]EventGridEvent eventGridEvent,
            [Blob("{data.url}", 
                FileAccess.Read, 
                Connection = "ImagesBlobStorage")] 
                Stream imageBlob,
            [CosmosDB(
                databaseName: "GIS",
                collectionName: "Processed_images",
                ConnectionStringSetting = "CosmosDBConnection")]
                out dynamic document,
            [SignalR(HubName = "notifications")] IAsyncCollector<SignalRMessage> signalRMessages,
            ILogger log)
        {
            document = new { Description = eventGridEvent.Topic, id = Guid.NewGuid() };

            log.LogInformation($"C# Blob trigger function Processed event\n
                Topic: {eventGridEvent.Topic} \n
                Subject: {eventGridEvent.Subject} ");

            return signalRMessages.AddAsync(new SignalRMessage
            {
                Target = "newMessage",
                Arguments = new [] { eventGridEvent.Subject }
            });
        }
    }
}