using System;
using Microsoft.Azure.Management.Compute.Fluent;
using Microsoft.Azure.Management.Compute.Fluent.Models;
using Microsoft.Azure.Management.Fluent;
using Microsoft.Azure.Management.Network.Fluent;
using Microsoft.Azure.Management.ResourceManager.Fluent;
using Microsoft.Azure.Management.ResourceManager.Fluent.Authentication;
using Microsoft.Azure.Management.ResourceManager.Fluent.Core;

namespace _01_01_01_CreateVm
{
    class Program
    {
        static void Main(string[] args)
        {
            /*
             * Create the management client. This will be used for all the oprations
             */
            AzureCredentials azCredentials = SdkContext.AzureCredentialsFactory.FromFile("./azureauth.properties");

            IAzure azure = Azure.Configure().WithLogLevel(HttpLoggingDelegatingHandler.Level.Basic).Authenticate(azCredentials).WithDefaultSubscription();

            /*
             * First of all, we need to create a resource group where we will add all the 
             * resources need for the virtual machine
             */
            string groupName = "az204-ResourceGroup";
            string vmName = "az204VMTesting";
            Region region = Region.UKSouth;
            string vNetNAme = "az204VNET";
            string vNetAddress = "172.16.0.0/16";
            string subnetName = "az204Subnet";
            string subnetAddress = "172.16.0.0/24";
            string nicName = "az204NIC";
            string adminUser = "azureadminuser";
            string adminPassword = "Pa$$w0rd!2020";

            Console.WriteLine($"Creating resource group {groupName}");

            IResourceGroup resourceGroup = azure.ResourceGroups.Define(groupName).WithRegion(region).Create();

            /*
             * Every virtual machine needs to be connected to a virtual network
             */
            Console.WriteLine($"Creating virtual network {vNetNAme}");

            INetwork network = azure.Networks.Define(vNetNAme)
                                        .WithRegion(region)
                                        .WithExistingResourceGroup(groupName)
                                        .WithAddressSpace(vNetAddress)
                                        .WithSubnet(subnetName, subnetAddress)
                                        .Create();

            /*
             * Any virtual machine need a network interface for connecting
             * to the virtual netwok
             */
            Console.WriteLine($"Creating network interface {nicName}");

            INetworkInterface nic = azure.NetworkInterfaces.Define(nicName)
                                            .WithRegion(region)
                                            .WithExistingResourceGroup(resourceGroup)
                                            .WithExistingPrimaryNetwork(network)
                                            .WithSubnet(subnetName)
                                            .WithPrimaryPrivateIPAddressDynamic()
                                            .Create();

            /*
             * Create the virtual machine
             */
            Console.WriteLine($"Creating virtual machine {vmName}");

            azure.VirtualMachines.Define(vmName)
                                .WithRegion(region)
                                .WithExistingResourceGroup(groupName)
                                .WithExistingPrimaryNetworkInterface(nic)
                                .WithLatestWindowsImage("MicrosoftWindowsServer", "WindowsServer", "2012-R2-Datacenter")
                                .WithAdminUsername(adminUser)
                                .WithAdminPassword(adminPassword)
                                .WithComputerName(vmName)
                                .WithSize(VirtualMachineSizeTypes.StandardDS2V2)
                                .Create();

            Console.WriteLine("END");
        }
    }
}
