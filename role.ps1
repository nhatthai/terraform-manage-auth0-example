# Authorize the operation to create the container - Signed in User (Storage Blob Data Contributor Role)
az ad signed-in-user show --query id -o tsv | foreach-object {
    az role assignment create `
        --role "Storage Blob Data Contributor" `
        --assignee "$_" `
        --scope "/subscriptions/$subcription_id/resourceGroups/LearningDeployment/providers/Microsoft.Storage/storageAccounts/tfdevopsstorage"
    }

# Assign additional RBAC role to Terraform Service Principal Subscription as Contributor and access to backend storage
az ad sp list --display-name tfserviceprincipal --query [].appId -o tsv | ForEach-Object {
    az role assignment create --assignee "$_" `
        --role "Contributor" `
        --subscription $subcription_id

    az role assignment create --assignee "$_" `
        --role "Storage Blob Data Contributor" `
        --scope "/subscriptions/$subcription_id/resourceGroups/LearningDeployment/providers/Microsoft.Storage/storageAccounts/tfdevopsstorage" `
}