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

function Get-JarvisServiceState {
    [CmdletBinding()]
    param (
        [Parameter()]
            [string] $ExeName,
            [string] $ProcType
    ) 

    switch ( $ProcType ) {
        'Process' { 
            $ProcessState = Get-Process -Name $ExeName -ErrorAction SilentlyContinue
            If ($null -ne $ProcessState.Id) {
                return 'Running'
            } 
            else {
                return 'Stopped'
            }
        }
        'Service' { 
            $ServiceState = Get-Service -Name $ExeName -ErrorAction SilentlyContinue
            return [string]$ServiceState.Status
        }
        Default {
            Write-Error -Message "Execution Type $ProcType unmanaged" -Category OpenError
        }
    }
    
    
    
    $ProcessState = Get-Process -Name $ServiceName
    If ($null -ne $ProcessState.Id) {
        return 'Running'
    } 
    else {
        return 'Stopped'
    }
}