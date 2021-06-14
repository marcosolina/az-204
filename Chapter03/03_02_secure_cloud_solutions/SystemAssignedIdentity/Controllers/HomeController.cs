using Microsoft.Azure.KeyVault;
using Microsoft.Azure.KeyVault.Models;
using Microsoft.Azure.Services.AppAuthentication;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace SystemAssignedIdentity.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            string keyVaultName = "az204marcokv";
            string secretName = "TEST-MARCO";

            //Get a token for accessing the Key Vault.
            AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();

            //Create a Key Vault client for accessing the items in the vault.
            KeyVaultClient keyVault = new KeyVaultClient(new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));
            SecretBundle secret = Task.Run(async () => await keyVault.GetSecretAsync($"https://{keyVaultName}.vault.azure.net/secrets/{secretName}")).GetAwaiter().GetResult();

            ViewBag.KeyVaultName = keyVaultName;
            ViewBag.keyName = secretName;
            ViewBag.secret = secret.Value;

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}