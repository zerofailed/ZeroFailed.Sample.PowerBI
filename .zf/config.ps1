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

$cloudConnection = @(
    @{
        displayName = "My Shared Cloud Connection"
        connectionType = "AzureBlobs"
        parameters = {@(
            @{
                dataType = "Text"
                name = "domain"
                value = "blob.core.windows.net"
            }
            @{
                dataType = "Text"
                name = "account"
                value = $DeploymentConfig.storageAccountName
            }
        )}
        # servicePrincipalClientId = $app.AppId
        servicePrincipalSecret = {$DeploymentConfig.storageConnectionCloudSecret | ConvertTo-SecureString -AsPlainText}
        tenantId = "0f621c67-98a0-4ed5-b5bd-31a35be41e29"
    }
)

# Customise the build process
task . PreInit, readConfiguration, FullDeployment
task PreInit { 
    Install-PSResource -Name Corvus.Deployment -Repository "PSGallery" -Scope CurrentUser -TrustRepository | Out-Null
    Import-Module Corvus.Deployment
}