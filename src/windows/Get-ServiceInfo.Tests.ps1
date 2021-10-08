BeforeAll {
    $ModuleManifestName = 'Get-ServiceInfo.psm1'
    Import-Module $PSScriptRoot\$ModuleManifestName
}

Describe "Get-ServiceInfo Test" {
    Context "when a service is running" {
        It "pwsh should be running" {
            Get-ServiceInfo -ProcessName 'pwsh' | Should -Be 'Running'
        }

        It "pwsh should not be stop" {
            Get-ServiceInfo -ProcessName 'pwsh' | Should  -Not -Be 'Stopped'
        }
    }
}
Describe "Get-ServiceInfo Negation Test" {
    Context "when a service is running" {
        It "gupdate should not be running" {
            Get-ServiceInfo -ProcessName 'gupdate'| Should -Not -Be 'Running'
        }

        It "gupdate should be stop" {
            Get-ServiceInfo -ProcessName 'gupdate' | Should -Be 'Stopped'
        }
    }
}

Describe "Get-ServiceInfo JarvisServices Test" {
    Context "when a service is running" {
        It "The <Type> <Name> should be <Expected>" -ForEach  @(
            @{ Name = 'UnknownService'; Expected = 'NotInstalled' }
            @{ Name = 'pwsh'; Expected = 'Running' }
            @{ Name = 'gupdate'; Expected = 'Stopped' }
            @{ Name = 'dcpm-notify'; Expected = 'Stopped' }
            @{ Name = 'DellOptimizer'; Expected = 'Running' }
        ) {
            Get-ServiceInfo -ProcessName $Name | Should -Be $Expected
        }
    }
}