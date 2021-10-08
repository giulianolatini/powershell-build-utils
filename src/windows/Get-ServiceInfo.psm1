<#
.SYNOPSIS
Get state of a Windows Service

.DESCRIPTION
It requires modules VSSetup installed in the system, you can install
with standard instruction

Install-Module VSSetup -Scope CurrentUser -Force

.EXAMPLE

function ChangeJarvisServiceState {
    param (
        $ServiceName
    )

    $JarvisServiceState = Get-JarvisServiceState($ServiceName)
    If $JarvisServiceState Then {
        Stop-JarvisService
    } else {
        Start-JarvisService
    }
}

Set-Alias -Name changeJSS -Value ChangeJarvisServiceState

ChangeJarvisServiceState(JarvisProjection.service.exe)
    or
chanhejss(JarvisProjection.service.exe)
#>

function Get-ServiceInfo {
    [CmdletBinding()]
    param (
        [Parameter()]
            [string] $ServiceName
    ) 
    $ErrorActionPreference = 'SilentlyContinue'
    $ServiceState = Get-Service -Name $ServiceName
    switch ([string]$ServiceState.Status) {
        'Running' {
            return 'Running'
        }
        'Stopped' {
            return 'Stopped'
        }
        Default {
            return 'NotInstalled'
        }

    }
    # return 'NotInstalled'
}    

