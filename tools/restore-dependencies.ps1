param (
    [string]$Path
)

if(-not (Test-Path -Path $Path)) {
    New-Item -Path $Path -ItemType Directory | Out-Null
}

Save-Module -Name InvokeBuild -Path $Path
Save-Module -Name Pester -Path $Path
Save-Module -Name PSScriptAnalyzer -Path $Path