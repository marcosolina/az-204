using Newtonsoft.Json;

namespace PublishCustomEventsApp
{
    class NewItemCreatedEvent
    {
        [JsonProperty(PropertyName = "name")]
        public string itemName;
    }
}
