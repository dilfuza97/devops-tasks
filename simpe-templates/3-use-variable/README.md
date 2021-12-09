The parameter for the storage account name is hard-to-use because you have to provide a unique name. If you've completed the earlier tutorials in this series, you're probably tired of guessing a unique name. You solve this problem by adding a variable that constructs a unique name for the storage account.

Use variable
The following example highlights the changes to add a variable to your template that creates a unique storage account name. Copy the whole file and replace your template with its contents.

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "storagePrefix": {
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
    "variables": {
        "uniqueStorageName": "[concat(parameters('storagePrefix'), uniqueString(resourceGroup().id))]"
    },
    "resources": [
        {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2021-04-01",
            "name": "[variables('uniqueStorageName')]",
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


az deployment group create --name addnamevariable --resource-group cloud-shell-storage-westeurope --template-file file.json --parameters storagePrefix=store storageSKU=Standard_LRS