using System.Threading.Tasks;
using System;
using Azure.Storage.Blobs;

namespace AppUsingAZAppConfig
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Copy items between Containers Demo!");
            Task.Run(async () => await StartContainersDemo()).Wait();
        }

        public static async Task StartContainersDemo()
        {
            string sourceBlobFileName = "Testing.zip";
            AppSettings appSettings = AppSettings.LoadAppSettings();

            //Get a cloud client for the source Storage Account
            BlobServiceClient sourceClient = Common.CreateBlobClientStorageFromSAS(appSettings.SourceSASConnectionString);
            BlobServiceClient destinationClient = Common.CreateBlobClientStorageFromSAS(appSettings.DestinationSASConnectionString);

            //Get a reference for each container
            BlobContainerClient sourceContainerReference = sourceClient.GetBlobContainerClient(appSettings.SourceContainerName);
            BlobContainerClient destinationContainerReference = destinationClient.GetBlobContainerClient(appSettings.DestinationContainerName);

            //Get a reference for the source blob
            BlobClient sourceBlobReference = sourceContainerReference.GetBlobClient(sourceBlobFileName);
            BlobClient destinationBlobReference = destinationContainerReference.GetBlobClient(sourceBlobFileName);

            //Move the blob from the source container to the destination container
            await destinationBlobReference.StartCopyFromUriAsync(sourceBlobReference.Uri);
        }
    }
}
