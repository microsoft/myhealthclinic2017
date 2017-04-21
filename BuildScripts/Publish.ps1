

# load up the global.json so we can find the DNX version
$globalJson = Get-Content -Path $PSScriptRoot\..\global.json -Raw -ErrorAction Ignore | ConvertFrom-Json -ErrorAction Ignore

$runtime = "dnx-clr-win-x86.$($globalJson.sdk.version)"
$dnu = "$($env:USERPROFILE)\.dnx\runtimes\$($runtime)\bin\dnu"

 # Incude 2>1 to redirect stderr to stdout for badly behaved tools
& $dnu publish --runtime $runtime 2>1 