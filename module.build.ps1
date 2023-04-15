#requires -modules InvokeBuild

param (
    $Configuration = "Release"
)

Set-StrictMode -Version Latest

Add-BuildTask . Clean, Build

Enter-Build {
    $script:moduleName = "TestableModule"
    $script:moduleSourcePath = Join-Path -Path $BuildRoot -ChildPath $moduleName
    $script:modulesFolder = ($env:PSModulePath -split ';')[0]
    $script:buildOutputPath = Join-Path -Path $BuildRoot -ChildPath "build"
    $script:consumerSourcePath = Join-Path -Path $BuildRoot -ChildPath "Consumers"
    $script:analyzerSettingsPath = "$BuildRoot\script-analyzer-settings.psd1"
}

Add-BuildTask Analyze {
    Invoke-ScriptAnalyzer -Path $appScriptsPath -Settings $analyzerSettingsPath -Recurse -Severity Warning
}

Add-BuildTask Test {
    $PesterConfig = @{
        Run = @{
            Path = $moduleSourcePath
            Exit = $true
        }
        TestResult = @{
            OutputPath = "$buildOutputPath\pester-tests.xml"
            OutputFormat = "NUnitXml"
            OutputEncoding = "UTF8"
            Enabled = $true
        }
        Output = @{
            Verbosity = "Detailed"
        }
        CodeCoverage = @{
            OutputFormat = "JaCoCo"
            OutputEncoding = "UTF8"
            OutputPath = "$buildOutputPath\pester-coverage.xml"
            Enabled = $true
        }
    }

    # Additional parameters on Azure Pipelines agents to generate test results
    # https://github.com/andrewmatveychuk/powershell.sample-module/blob/master/SampleModule.build.ps1
    if ($env:TF_BUILD) {
        if (-not (Test-Path -Path $buildOutputPath -ErrorAction SilentlyContinue)) {
            New-Item -Path $buildOutputPath -ItemType Directory
        }
        $Timestamp = Get-date -UFormat "%Y%m%d-%H%M%S"
        $PSVersion = $PSVersionTable.PSVersion.Major
        $TestResultFile = "AnalysisResults_PS$PSVersion`_$TimeStamp.xml"
        $Config.TestResult.OutputPath = "$buildOutputPath\$TestResultFile"
    }

    Invoke-Pester -Configuration $PesterConfig
}

Add-BuildTask Build {
    Copy-Item $moduleSourcePath -Destination "$buildOutputPath\$moduleName" -Recurse -Exclude "*.Tests.ps1"
}

Add-BuildTask LocalPublish {

    if(Test-Path "$modulesFolder\$moduleName") {
        Write-Host "Removing $modulesFolder\$moduleName"
        Remove-Item "$modulesFolder\$moduleName" -Recurse -Force
    }

    Copy-Item $moduleSourcePath -Destination "$modulesFolder\$moduleName" -Recurse -Exclude "*.Tests.ps1"
}

Add-BuildTask Clean {
    if(Test-Path $buildOutputPath) {
        Remove-Item -Path $buildOutputPath -Recurse
    }
}