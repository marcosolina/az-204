using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Blob;
using System;

namespace MetadataApp
{
    public class Common
    {
        public static CloudBlobClient CreateBlobClientStorageFromSAS(string SAStoken, string accountName)
        {
            CloudStorageAccount storageAccount;
            CloudBlobClient blobClient;
            try
            {
                bool useHttps = true;
                StorageCredentials storageCredentials = new StorageCredentials(SAStoken);
                storageAccount = new CloudStorageAccount(storageCredentials, accountName, null, useHttps);
                blobClient = storageAccount.CreateCloudBlobClient();
            }
            catch (System.Exception)
            {
                throw;
            }
            return blobClient;
        }
    }
}
