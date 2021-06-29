using Microsoft.Azure.WebJobs;
using Microsoft.Azure.EventGrid.Models;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;

namespace EventSubscriberFunctionApp
{
    public static class Function1
    {
        [FunctionName("EventGridTrigger")]
        public static void Run([EventGridTrigger]EventGridEvent eventGridEvent, ILogger log)
        {
            log.LogInformation("C# Event Grid trriger handling EventGrid Events.");
            log.LogInformation($"New event received: {eventGridEvent.Data}");
            if (eventGridEvent.Data is StorageBlobCreatedEventData)
            {
                StorageBlobCreatedEventData eventData = (StorageBlobCreatedEventData)eventGridEvent.Data;
                log.LogInformation($"Got BlobCreated event data, blob URI {eventData.Url}");
            }
            else if (eventGridEvent.EventType.Equals("MyCompany.Items.NewItemCreated"))
            {
                NewItemCreatedEventData eventData = ((JObject)eventGridEvent.Data).ToObject<NewItemCreatedEventData>();
                log.LogInformation($"New Item Custom Event, Name {eventData.itemName}");
            }
        }
    }
}