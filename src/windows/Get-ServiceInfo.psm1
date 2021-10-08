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
            [string] $ProcessName
    ) 
    $ErrorActionPreference = 'SilentlyContinue'
    $ProcessState = Get-Process -Name $ProcessName
    If ([string]$ProcessState.Responding) {
        return 'Running'
    } else {
        $ServiceState = Get-Service -Name $ProcessName
        if ($null -ne $ServiceState.Status) {
            return [string]$ServiceState.Status
        } else {
            return 'NotInstalled'
        }
    }
}    

