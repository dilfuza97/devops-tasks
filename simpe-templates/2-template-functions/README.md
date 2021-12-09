Add template functions to your ARM template

The location of the storage account is hard-coded to eastus. However, you may need to deploy the storage account to other regions. You're again facing an issue of your template lacking flexibility. You could add a parameter for location, but it would be great if its default value made more sense than just a hard-coded value.

Functions add flexibility to your template by dynamically getting values during deployment. In this tutorial, you use a function to get the location of the resource group you're using for deployment.

The following example highlights the changes to add a parameter called location. The parameter default value calls the resourceGroup function. This function returns an object with information about the resource group being used for deployment. One of the properties on the object is a location property. When you use the default value, the storage account location has the same location as the resource group. The resources inside a resource group don't have to share the same location. You can also provide a different location when needed.

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "storageName": {
            "type": "string",
            "minLength": 3,
            "maxLength": 24
        },
        "storageSKU": {
            "type": "string",
            "defaultValue": "Standard_LRS",
            "allowedValues": [
                "Standard_LRS",
                "Standard_GRS",
                "Standard_RAGRS",
                "Standard_ZRS",
                "Premium_LRS",
                "Premium_ZRS",
                "Standard_GZRS",
                "Standard_RAGZRS"
            ]
        },
        "location": {
            "type": "string",
            "defaultValue": "[resourceGroup().location]"
        }
    },
    "resources": [
        {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2021-04-01",
            "name": "[parameters('storageName')]",
            "location": "[parameters('location')]",
            "sku": {
                "name": "[parameters('storageSKU')]"
            },
            "kind": "StorageV2",
            "properties": {
                "supportsHttpsTrafficOnly": true
            }
        }
    ]
}
```
az deployment group create --name addlocationparameter --resource-group cloud-shell-storage-westeurope --template-file file.json --parameters storageName=storagetempfunc123321