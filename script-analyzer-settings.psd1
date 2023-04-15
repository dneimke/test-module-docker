# https://github.com/PowerShell/PSScriptAnalyzer
# https://learn.microsoft.com/en-gb/powershell/utility-modules/psscriptanalyzer/rules-recommendations?view=ps-modules
# https://learn.microsoft.com/en-us/powershell/utility-modules/psscriptanalyzer/using-scriptanalyzer?view=ps-modules
@{
    IncludeRules=@('PSAvoidUsingPlainTextForPassword',
                'PSAvoidUsingConvertToSecureStringWithPlainText')
}