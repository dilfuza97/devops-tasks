### Add resource
To add a storage account definition to the existing template, look at the highlighted JSON in the following example. Instead of trying to copy sections of the template, copy the whole file and replace your template with its contents.

Replace {provide-unique-name} and the curly braces {} with a unique storage account name.

### Resource properties

You may be wondering how to find the properties to use for each resource type. You can use the ARM template reference to find the resource types you want to deploy.

**Every resource you deploy has at least the following three properties:**

- **type:** Type of the resource. This value is a combination of the namespace of the resource provider and the resource type such as `Microsoft.Storage/storageAccounts`.

- **apiVersion:** Version of the REST API to use for creating the resource. Each resource provider publishes its own API versions, so this value is specific to the type.

- **name:** Name of the resource.

Most resources also have a **location** property, which sets the region where the resource is deployed.

The other properties vary by resource type and API version. It's important to understand the connection between the API version and the available properties, so let's jump into more detail.

In this tutorial, you added a storage account to the template. You can see that API version at storageAccounts 2021-04-01. Notice that you didn't add all of the properties to your template. Many of the properties are optional. The Microsoft.Storage resource provider could release a new API version, but the version you're deploying doesn't have to change. You can continue using that version and know that the results of your deployment will be consistent.

If you view an older API version, such as storageAccounts 2016-05-01, you'll see that a smaller set of properties are available.

If you decide to change the API version for a resource, make sure you evaluate the properties for that version and adjust your template appropriately.


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
`az deployment group create --name arm-storage --resource-group arm-group --template-file 1-storage-accounts/storage.json`


### Add parameters 

You may have noticed that there's a problem with this template.
The storage account name is hard-coded. You can only use this template to deploy the same storage account every time. 
To deploy a storage account with a different name, you would have to create a new template, 
which obviously isn't a practical way to automate your deployments.

**Make template reusable**

To make your template reusable, let's add a parameter that you can use to pass in a storage account name. The highlighted JSON in the following example shows what changed in your template. The storageName parameter is identified as a string. The maximum length is set to 24 characters to prevent any names that are too long.

Copy the whole file and replace your template with its contents.

`az deployment group create --name addnameparameter --resource-group arm-group --template-file 1-storage-accounts/storage-with-parametr.json --parameters storageName=armstorage0123454`

**Customize by environment**

Parameters enable you to customize the deployment by providing values that are tailored for a particular environment. For example, you can pass different values based on whether you're deploying to an environment for development, test, and production.

The previous template always deployed a Standard_LRS storage account. You might want the flexibility to deploy different SKUs depending on the environment. The following example shows the changes to add a parameter for SKU. Copy the whole file and paste over your template.


```shell


```