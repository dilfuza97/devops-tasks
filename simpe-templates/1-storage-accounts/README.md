```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "storageName": {
            "type": "string",
            "minLength": 3,
            "maxLength": 24
        }
    },
    "resources": [
        {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2021-04-01",
            "name": "[parameters('storageName')]",
            "location": "West Europe",
            "sku": {
                "name": "Standard_LRS"
            },
            "kind": "StorageV2",
            "properties": {
                "suportsHttpsTraffucOnly": true
            }
        }
    ]
}
```
```shell
az deployment group create \
  --name addskuparameter \
  --resource-group myResourceGroup \
  --template-file $templateFile \
  --parameters storageName={your-unique-name}
```

You may have noticed that there's a problem with this template.
The storage account name is hard-coded. You can only use this template to deploy the same storage account every time. 
To deploy a storage account with a different name, you would have to create a new template, 
which obviously isn't a practical way to automate your deployments.

The previous template always deployed a Standard_LRS storage account. You might want the flexibility to deploy different SKUs depending on the environment. The following example shows the changes to add a parameter for SKU. Copy the whole file and paste over your template.

