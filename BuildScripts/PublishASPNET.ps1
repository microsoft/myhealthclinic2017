
param(
	[parameter(Mandatory=$TRUE)]
    [String] $ResourceGroupName,
	[parameter(Mandatory=$TRUE)]
    [String] $webAppName,
    [parameter(Mandatory=$TRUE)]
    [String] $webPackage 
)

$webApp = Get-AzureRMWebApp -ResourceGroupName $ResourceGroupName -Name $webAppName

$publishProfile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, "profile.xml"))
$pp = Get-AzureRMWebAppPublishingProfile -WebApp $webApp -OutputFile $publishProfile

[xml]$ppXml = Get-Content $publishProfile
$deployIisAppPath = "$webAppName/wwwroot"
$publishProperties = @{'WebPublishMethod'='MSDeploy';
						'MSDeployServiceUrl'=$ppXml.publishData.FirstChild.publishUrl;
						'DeployIisAppPath'=$deployIisAppPath;
						'Username'=$ppXml.publishData.FirstChild.userName;
						'Password'=$ppXml.publishData.FirstChild.userPWD}

$publishScript = "$PSScriptRoot\default-publish.ps1"
$webPackageFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $webPackage))
$webPackagePath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, "temp"))

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($webPackageFile, $webPackagePath)

. $publishScript -publishProperties $publishProperties  -packOutput $webPackagePath

Remove-Item $publishProfile
Remove-Item $webPackagePath -recurse



