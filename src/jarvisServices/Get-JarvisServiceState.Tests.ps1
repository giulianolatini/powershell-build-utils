BeforeAll {
    $ModuleManifestName = 'Get-JarvisServiceState.psm1'
    Import-Module $PSScriptRoot\$ModuleManifestName
}

Describe "Get-JarvisServiceState Test" {
    Context "when a service is running" {
        It "LanmanServer should be running" {
            Get-JarvisServiceState -ExeName 'LanmanServer' -ProcType 'Service' | Should -Be 'Running'
        }

        It "LanmanServer should not be stop" {
            Get-JarvisServiceState -ExeName 'LanmanServer' -ProcType 'Service' | Should  -Not -Be 'Stopped'
        }
    }
}
Describe "Get-JarvisServiceState Negation Test" {
    Context "when a service is running" {
        It "gupdate should not be running" {
            Get-JarvisServiceState -ExeName 'gupdate' -ProcType 'Service' | Should -Not -Be 'Running'
        }

        It "gupdate should be stop" {
            Get-JarvisServiceState -ExeName 'gupdate' -ProcType 'Service' | Should -Be 'Stopped'
        }
    }
}

Describe "Get-JarvisServiceState JarvisServices Test" {
    Context "when a service is running" {
        It "The <Type> <Name> should be <Expected>" -ForEach  @(
            @{ Name = 'Jarvis.Host.Service.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.Bi.Service.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.DMS.Service.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.Host.Service.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.Offline.Service.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.ProcessManager.Service.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.Projection.Service.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.ProjectionExporter.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.ProjectionRebuilder.exe'; Type = 'Process'; Expected = 'Stopped' }
            @{ Name = 'Jarvis.Service.exe'; Type = 'Process'; Expected = 'Stopped' }
        ) {
            Get-JarvisServiceState -ExeName $Name -ProcType $Type | Should -Be $Expected
        }
    }
}