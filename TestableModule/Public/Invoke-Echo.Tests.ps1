BeforeAll {
    Get-Module TestableModule | Remove-Module -Force
    Import-Module TestableModule -Force

    $SourcePath = "TestDrive:\$([Guid]::NewGuid())"
    New-Item -Path $SourcePath -ItemType Directory
}

Describe "Invoke-Echo" {
    BeforeAll {
        $Message = "Test message"
        $Expected = "[PROCESSED] $Message"
    }

    Context "When called" {

        It "Given a message is passed by parameter name, it shall return with [PROCESSED] prepended" {

            $result = Invoke-Echo -Message $Message
            $result | Should -Be $Expected
        }

        It "Given a message is passed by position, it shall return with [PROCESSED] prepended" {

            $result = Invoke-Echo $Message
            $result | Should -Be $Expected
        }

        It "Given no message is passed, an exception shall be thrown" {

            { Invoke-Echo } | Should -Throw "Message is required, please provide a value."
        }
    }
}