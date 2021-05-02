using Microsoft.WindowsAzure.Storage.Blob;
using System;

namespace MetadataApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Getting System properties Demo!");
            AppSettings appSettings = AppSettings.LoadAppSettings();

            //Create a CloudBlobClient for working with the Storage Account
            CloudBlobClient blobClient = Common.CreateBlobClientStorageFromSAS(appSettings.SASToken, appSettings.AccountName);

            //Get a container reference for the new container.
            CloudBlobContainer container = blobClient.GetContainerReference(appSettings.ContainerName);

            //Create the container if not already exists
            var result = container.CreateIfNotExistsAsync().Result;

            //You need to fetch the container properties before getting their values
            container.FetchAttributesAsync().Wait();
            Console.WriteLine($"Properties for container {container.StorageUri.PrimaryUri.ToString()}");
            System.Console.WriteLine($"ETag: { container.Properties.ETag}");
            System.Console.WriteLine($"LastModifiedUTC: {container.Properties.LastModified.ToString()}");
            System.Console.WriteLine($"Lease status: {container.Properties.LeaseStatus.ToString()}");
            System.Console.WriteLine();

            //Add some metadata to the container that we created before
            container.Metadata.Add("department", "Technical");
            container.Metadata["category"] = "Knowledge Base";
            container.Metadata.Add("docType", "pdfDocuments");

            //Save the containers metadata in Azure
            container.SetMetadataAsync().Wait();

            //List newly added metadata. We need to fetch all attributes before being
            //able to read if not, we could get nulls or weird values
            container.FetchAttributesAsync().Wait();
            System.Console.WriteLine("Container's metadata:");
            foreach (var item in container.Metadata)
            {
                System.Console.Write($"\tKey: {item.Key}\t");
                System.Console.WriteLine($"\tValue: {item.Value}");
            }
        }
    }
}
