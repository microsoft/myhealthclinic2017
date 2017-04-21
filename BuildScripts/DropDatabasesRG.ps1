[cmdletbinding()]
param (
    [string]$resourcegroup
)

Write-Host "Drop databases"

$servers = Get-AzureRmSqlServer -ResourceGroupName $resourcegroup 

foreach ($sqlServerName in $servers){

    Write-Host $sqlServerName.ServerName

    $databases = Get-AzureRmSqlDatabase -ResourceGroupName $resourcegroup -ServerName $sqlServerName.ServerName

    foreach ($databasename in $databases){

        Write-Host $databasename.DatabaseName

        if (-Not ($databasename.DatabaseName = 'master')) {
            Remove-AzureRMSqlDatabase -ResourceGroupName $resourcegroup –DatabaseName $databasename.DatabaseName -ServerName $sqlServerName.ServerName -Force
        }
	
    }


}


