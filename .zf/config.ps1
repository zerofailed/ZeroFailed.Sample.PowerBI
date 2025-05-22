<#
This example demonstrates a software build process using the 'ZeroFailed.Deploy.PowerBI' extension
to provide the features needed when building a .NET solutions.
#>

$zerofailedExtensions = @(
    @{
        # References the extension from its GitHub repository. If not already installed, use latest version from 'main' will be downloaded.
        Name = "ZeroFailed.Deploy.PowerBI"
        GitRepository = "https://github.com/zerofailed/ZeroFailed.Deploy.PowerBI"
        GitRef = "main"
    }
)

# Load the tasks and process
. ZeroFailed.tasks -ZfPath $here/.zf

#
# Build process configuration
#
#
# Build process control options
#
$SkipInit = $false
$SkipVersion = $false
$SkipBuild = $false
$CleanBuild = $Clean
$SkipTest = $false
$SkipTestReport = $false
$SkipAnalysis = $false
$SkipPackage = $false

$SolutionToBuild = (Resolve-Path (Join-Path $here "./src/SampleDotNet.sln")).Path
$IncludeAssembliesInCodeCoverage = "SampleDotNet*"
$TargetFrameworkMoniker = "net8.0" # prevent GHA trying to run tests under .NET Framework 4.5 - Linux agents now lack mono
$ProjectsToPublish = @(
    # simple syntax for basic publishing features
    "$here/src/SampleDotNet.Web/SampleDotNet.Web.csproj"
    "$here/src/SamplePlugin/SamplePlugin.csproj"

    # richer syntax to support multi-target publishing and AOT features
    @{
        Project = "$here/src/SampleDotNet.Cli/SampleDotNet.Cli.csproj"
        RuntimeIdentifiers = @("win-x64", "linux-x64")
        SelfContained = $false
        SingleFile = $false
        Trimmed = $false
        ReadyToRun = $false
    }
)
$NuSpecFilesToPackage = @(
    "src/SamplePlugin/SamplePlugin.nuspec"
)


# Customise the build process
task . FullBuild

#
# Build Process Extensibility Points - uncomment and implement as required
#

# task RunFirst {}
# task PreInit {}
# task PostInit {}
# task PreVersion {}
# task PostVersion {}
# task PreBuild {}
# task PostBuild {}
# task PreTest {}
# task PostTest {}
# task PreTestReport {}
# task PostTestReport {}
# task PreAnalysis {}
# task PostAnalysis {}
# task PrePackage {}
# task PostPackage {}
# task PrePublish {}
# task PostPublish {}
# task RunLast {}
