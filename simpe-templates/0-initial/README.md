
`az account show --subscription MySubscriptionName <az subscription name>`

`az account show --output table`

### Create resource group

When you deploy a template, you specify a resource group that will contain the resources. Before running the deployment command, create the resource group with either Azure CLI or Azure PowerShell.

`az group create --name arm-group --location westus`

`az group show --resource-group arm-group`


### Deploy template

To deploy the template, use either Azure CLI or Azure PowerShell. Use the resource group you created. Give a name to the deployment so you can easily identify it in the deployment history. For convenience, also create a variable that stores the path to the template file. This variable makes it easier for you to run the deployment commands because you don't have to retype the path every time you deploy. Replace {provide-the-path-to-the-template-file} and the curly braces {} with the path to your template file.


```shell
az deployment group create --name blanktemplate --resource-group arm-group --template-file deployment.yml
```