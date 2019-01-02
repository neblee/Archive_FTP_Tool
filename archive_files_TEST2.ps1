Param
(
    [string]$sourcePath,
    [string]$destinationPath

)

# Make sure the destinationPath exists
if(![System.IO.File]::Exists($destinationPath))
{
    Write-Error "Re-Type your destination Path."
    Write-Error "The path provided was $destinationPath"
    exit
}

# Check to see if the time is appropriate to perform a migration
If ( (Get-Date).Hour -ge 0 -and (Get-Date).Hour -le 6 )
{
    Write-Host "The time is appropriate to perform a copy"
}
else
{
    Write-Error "This script must be executed between 12:00 AM and 6:00 AM."
    exit
}


Process 
{
    #$children = get-childitem -Path "c:\source"
    $sourcePath = "C:\Users\benja\OneDrive\Documents\PowerShell_practice\Source_TEST\"

    $children = get-childitem -Path $sourcePath -Recurse | 
        where-object {$_.LastWriteTime -gt (get-date).AddDays(-31) -and $_.PSIsContainer -eq $True}


    #for each statment: look in the FTP customers directory and for each and every customer folder; 
    #query the folder for data that is older than one month

     foreach ($child in $children)
     {
        $childArchivePath = "C:\Users\benja\OneDrive\Documents\PowerShell_practice\Archive_TEST\" + $child.Name
         Move-Item $child -Destination $childArchivePath
         #Write-Host $child
     }

    #$childArchivePath = $child.FullName + "\archive"
    #Move-Item $child -Destination $childArchivePath

    #if file is older than 1 month, archive the folder
    #e-mail ben and lou when data has been copied over

    #else don't archive the folder

}