$PublicScripts = @( Get-ChildItem -Path "$($PSScriptRoot)\Public\*.ps1" -ErrorAction SilentlyContinue )

# Dot source the functions
foreach ($file in @($PublicScripts)) {

    try {
        . $file.FullName
    }
    catch {
        $exception = ([System.ArgumentException]"Function not found")
        $errorId = "Load.Function"
        $errorCategory = 'ObjectNotFound'
        $errorTarget = $file
        $errorItem = New-Object -TypeName System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $errorTarget
        $errorItem.ErrorDetails = "Failed to import function $($file.BaseName)"
        throw $errorItem
    }
}

Export-ModuleMember -Function $PublicScripts.BaseName -Alias *