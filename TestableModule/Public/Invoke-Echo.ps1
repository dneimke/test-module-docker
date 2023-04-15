<#
    .Description
    Retrieves a JSON configuration file as a PSCustomObject from a designation
    filepath.
#>

function Invoke-Echo {

    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Position=0)]
        [string] $Message = $(throw "Message is required, please provide a value.")
    )

    begin {
        Write-Log -Message "[$($MyInvocation.MyCommand.Name)] started." -Severity "Verbose"
    }

    process {
        return "[PROCESSED] $Message"
    }

    end {
        Write-Log -Message "[$($MyInvocation.MyCommand.Name)] completed." -Severity "Verbose"
    }
}