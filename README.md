# ZeroFailed.Sample.DotNet

A sample repository demonstrating how to use the [ZeroFailed.Build.DotNet extension](https://github.com/zerofailed/ZeroFailed.Build.DotNet) to easily setup a fully-featured build process for .NET solutions.

The current features of this extension can be found [here]().

## Example Projects

* `SampleDotNet.Cli` - a console app that gets packaged via `dotnet publish` and leverages [AOT](https://learn.microsoft.com/en-us/dotnet/core/deploying/native-aot) features
* `SampleDotNet.Lib` - a class library that is packaged for NuGet via `dotnet pack`
* `SampleDotNet.Tests` - an NUnit test project demonstrating the testing-related features (e.g. execution, code coverage, reports)
* `SampleDotNet.Web` - a web app that get packaged for deployment via `dotnet publish`
* `SamplePlugin` - demonstrates building NuGet packages via a `.nuspec` file that references the output from `dotnet publish`

