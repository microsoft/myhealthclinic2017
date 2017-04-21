[cmdletbinding()]
param (
    [Parameter(Mandatory=$true)]
    [string] $ResourceGroupName
)


# Get Websites/webapps
$websites = Get-AzureRmWebApp -ResourceGroupName "$ResourceGroupName" 

# Restart each website
Write-Output "Starting with the nap."

foreach ($website In $websites)
{
	Write-Output "Sleeping $($website.Name)"
    Start-AzureRmWebApp $website.Name -ResourceGroupName "$ResourceGroupName" 
}