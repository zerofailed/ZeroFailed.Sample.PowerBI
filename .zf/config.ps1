<#
This example demonstrates a software build process using the 'ZeroFailed.Deploy.PowerBI' extension
to provide the features needed when building a .NET solutions.
#>

$zerofailedExtensions = @(
    @{
        # References the extension from its GitHub repository. If not already installed, use latest version from 'main' will be downloaded.
        Name = "ZeroFailed.Deploy.PowerBI"
        # GitRepository = "https://github.com/zerofailed/ZeroFailed.Deploy.PowerBI"
        # GitRef = "main"
        Path = "C:\Users\JessicaHill\Repos\ZeroFailed.Deploy.PowerBI\module"
    }
)

# Load the tasks and process
. ZeroFailed.tasks -ZfPath $here/.zf

# $cloudConnection = @(
#     @{
#         displayName = "My Shared Cloud Connection"
#         connectionType = "AzureBlobs"
#         parameters = {@(
#             @{
#                 dataType = "Text"
#                 name = "domain"
#                 value = "blob.core.windows.net"
#             }
#             @{
#                 dataType = "Text"
#                 name = "account"
#                 value = $DeploymentConfig.storageAccountName
#             }
#         )}
#         servicePrincipalClientId = {$DeploymentConfig.storageConnectionClientId}
#         servicePrincipalSecret = {$DeploymentConfig.storageConnectionCloudSecret}
#         tenantId = $TenantId
#     }
# )

# Customise the build process
task . PreInit, connect, readConfiguration, FullDeployment
task PreInit { 
    Install-PSResource -Name Corvus.Deployment -Repository "PSGallery" -Scope CurrentUser -TrustRepository | Out-Null
    Import-Module Corvus.Deployment
}

# task generateSecret {
#     $app = Get-AzADApplication -AppId "639dd748-ac2b-40d3-823d-ed831c79c98f"
#     # Simulate rotating secret
#     $app | Remove-AzADAppCredential
#     # Ordinarily, we would get the secret from the KeyVault, but for this demo, we'll just create a new one.
#     $cred = $app | New-AzADAppCredential
#     $env:STORAGE_CONNECTION_CLOUD_SECRET = $cred.SecretText
# }

task connect {
    Connect-CorvusAzure -SubscriptionId $SubscriptionId -AadTenantId $TenantId
}