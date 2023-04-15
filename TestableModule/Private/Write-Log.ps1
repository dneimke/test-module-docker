<#
    .Description
    Retrieves a JSON configuration file as a PSCustomObject from a designation
    filepath.
#>

function Write-Log {

    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Information','Warning','Error','Verbose','Debug')]
        [string]$Severity = 'Information'
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] started."
    }

    process {
        Write-Information $Message
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] completed."
    }
}