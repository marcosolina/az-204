using Newtonsoft.Json;

namespace EventSubscriberFunctionApp
{
    class NewItemCreatedEventData
    {
        [JsonProperty(PropertyName = "name")]
        public string itemName;
    }
}
