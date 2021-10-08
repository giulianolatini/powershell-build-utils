BeforeAll {
    $ModuleManifestName = 'Get-ServiceInfo.psm1'
    Import-Module $PSScriptRoot\$ModuleManifestName
}

Describe "Get-ServiceInfo Test" {
    Context "when a service is running" {
        It "LanmanServer should be running" {
            Get-ServiceInfo -ServiceName 'LanmanServer' | Should -Be 'Running'
        }

        It "LanmanServer should not be stop" {
            Get-ServiceInfo -ServiceName 'LanmanServer' | Should  -Not -Be 'Stopped'
        }
    }
}
Describe "Get-ServiceInfo Negation Test" {
    Context "when a service is running" {
        It "gupdate should not be running" {
            Get-ServiceInfo -ServiceName 'gupdate'| Should -Not -Be 'Running'
        }

        It "gupdate should be stop" {
            Get-ServiceInfo -ServiceName 'gupdate' | Should -Be 'Stopped'
        }
    }
}

Describe "Get-ServiceInfo JarvisServices Test" {
    Context "when a service is running" {
        It "The <Type> <Name> should be <Expected>" -ForEach  @(
            @{ Name = 'UnknownService'; Expected = 'NotInstalled' }
            @{ Name = 'LanmanServer'; Expected = 'Running' }
            @{ Name = 'gupdate'; Expected = 'Stopped' }
        ) {
            Get-ServiceInfo -ServiceName $Name | Should -Be $Expected
        }
    }
}