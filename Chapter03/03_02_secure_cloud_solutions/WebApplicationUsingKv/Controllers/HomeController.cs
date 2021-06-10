using System;
using Microsoft.Azure.KeyVault;
using Microsoft.Azure.KeyVault.Models;
using Microsoft.Azure.Services.AppAuthentication;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace WebApplicationUsingKv.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            string keyVaultName = "az204marcokv";
            string vaultBaseURL = $"https://{keyVaultName}.vault.azure.net";

            //Get a token for accessing the Key Vault.
            AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();

            //Create a Key Vault client for accessing the items in the vault;
            KeyVaultClient keyVaultClient = new KeyVaultClient(new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));
            
            // Manage secrets in the Key Vault.
            // Create a new secret
            string secretName = "secret-az204";
            
            Task.Run(async () => await keyVaultClient.SetSecretAsync(vaultBaseURL, secretName, "This is a secret testing value")).Wait();
            SecretBundle secretBundle = Task.Run(async () => await keyVaultClient.GetSecretAsync($"{vaultBaseURL}/secrets/{secretName}")).GetAwaiter().GetResult();

            // Update an existing secret
            Task.Run(async () => await keyVaultClient.SetSecretAsync(vaultBaseURL, secretName, "Updated the secret testing value")).Wait();
            secretBundle = Task.Run(async () => await keyVaultClient.GetSecretAsync($"{vaultBaseURL}/secrets/{secretName}")).GetAwaiter().GetResult();

            // Delete the secret
            Task.Run(async () => await keyVaultClient.DeleteSecretAsync(vaultBaseURL, secretName)).Wait();
            
            // Manage certificates in the Key Vault
            string certName = "cert-az204";

            // Create a new self-signed certificate
            CertificatePolicy policy = new CertificatePolicy
            {
                IssuerParameters = new IssuerParameters
                {
                    Name = "Self",
                },
                KeyProperties = new KeyProperties
                {
                    Exportable = true,
                    KeySize = 2048,
                    KeyType = "RSA"
                },
                SecretProperties = new SecretProperties
                {
                    ContentType = "application/x-pkcs12"
                },
                X509CertificateProperties = new X509CertificateProperties
                {
                    Subject = "CN=AZ204KEYVAULTDEMO"
                }
            };

            Task.Run(async () => await keyVaultClient.CreateCertificateAsync(vaultBaseURL, certName, policy, new CertificateAttributes
            {
                Enabled = true
            })).Wait();
            
            // When you create a new certificate in the Key Vault it takes some time
            // before it's ready.
            // We added some wait time here for the sake of simplicity.
            Thread.Sleep(10000);
            CertificateBundle certificateBundle = Task.Run(async () => await keyVaultClient.GetCertificateAsync(vaultBaseURL, certName)).GetAwaiter().GetResult();
            
            // Update properties associated with the certificate.
            CertificatePolicy updatePolicy = new CertificatePolicy
            {
                X509CertificateProperties = new X509CertificateProperties
                {
                    SubjectAlternativeNames = new SubjectAlternativeNames
                    {
                        DnsNames = new[] { "az204.examref.testing" }
                    }
                }
            };

            Task.Run(async () => await keyVaultClient.UpdateCertificatePolicyAsync(vaultBaseURL, certName, updatePolicy)).Wait();
            Task.Run(async () => await keyVaultClient.CreateCertificateAsync(vaultBaseURL, certName)).Wait();
            Thread.Sleep(10000);
            certificateBundle = Task.Run(async () => await keyVaultClient.GetCertificateAsync(vaultBaseURL, certName)).GetAwaiter().GetResult();
            Task.Run(async () => await keyVaultClient.UpdateCertificateAsync(certificateBundle.CertificateIdentifier.Identifier, null, new CertificateAttributes
            {
                Enabled = false
            })).Wait();
            Thread.Sleep(10000);

            // Delete the self-signed certificate.
            Task.Run(async () => await keyVaultClient.DeleteCertificateAsync(vaultBaseURL, certName)).Wait();
            
            // Manage keys in the Key Vault
            string keyName = "key-az204";
            NewKeyParameters keyParameters = new NewKeyParameters
            {
                Kty = "EC",
                CurveName = "SECP256K1",
                KeyOps = new[] { "sign", "verify" }
            };

            Task.Run(async () => await keyVaultClient.CreateKeyAsync(vaultBaseURL, keyName, keyParameters)).Wait();
            KeyBundle keyBundle = Task.Run(async () => await keyVaultClient.GetKeyAsync(vaultBaseURL, keyName)).GetAwaiter().GetResult();
            
            // Update keys in the Key Vault
            Task.Run(async () => await keyVaultClient.UpdateKeyAsync(vaultBaseURL, keyName, null, new KeyAttributes
            {
                Expires = DateTime.UtcNow.AddYears(1)
            })).Wait();
            keyBundle = Task.Run(async () => await keyVaultClient.GetKeyAsync(vaultBaseURL, keyName)).GetAwaiter().GetResult();

            // Delete keys from the Key Vault
            Task.Run(async () => await keyVaultClient.DeleteKeyAsync(vaultBaseURL, keyName)).Wait();
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