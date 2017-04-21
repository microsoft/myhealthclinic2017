
$globalJson = Get-Content -Path $PSScriptRoot\..\global.json -Raw -ErrorAction Ignore | ConvertFrom-Json -ErrorAction Ignore

dnvm use $globalJson.sdk.version

dnx -p $PSScriptRoot\..\test\MyHealth.API.IntegrationTests testxml 2>1

