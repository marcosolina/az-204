// C# ASP.NET Core
using System.Security.Claims;
using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
namespace Company.Function
{
    public static class HttpTriggerCSharp
    {
        /*
        * Esempio di una funzione con HTTP trigger
        */
        [FunctionName("HttpTriggerCSharp")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, 
                "get",
                "post", 
                Route = "devices/ {id:int?}")
            ] HttpRequest req, 
            int? id,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");
            //We access to the parameter in the address by adding a function parameter 
            //with the same name
            log.LogInformation($"Requesting information for device {id}");
            //If you enable Authentication / Authorization at Function App level,
            //information
            //about the authenticated user is automatically provided in the
            //HttpContext
            ClaimsPrincipal identities = req.HttpContext.User;
            string username = identities.Identity?.Name;

            log.LogInformation($"Request made by user {username}");
            string name = req.Query["name"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);

            name = name ?? data?.name;
            //We customize the output binding
            return name != null ? 
                (ActionResult)new JsonResult(new { message = $"Hello, {name}", username = username, device = id}) 
                : new BadRequestObjectResult("Please pass a name on the query string or in the request body");
        }
    }
}