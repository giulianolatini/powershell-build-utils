# the script was taken from: [Monitor your Connection to Internet – PowerShell](https://powershellposse.com/2017/12/28/monitor-your-connection-to-internet-powershell/)

function Start-ConnectionMonitoring
{
    param($isp, $gateway, $Logfile, [int]$Delay = 10, [string]$adapter, [switch]$ispPopup, [switch]$gateWayPopup)
    $spacer = '--------------------------'
    while($true)
    {
        if(!(Test-Connection -TargetName $gateway -count 1 -ea Ignore))
        {
            get-date | Add-Content -path $Logfile
            "$gateWay Connection Failure" |add-content -Path $Logfile
            $outagetime = Start-ContinousPing -address $gateway -adapter $adapter -Delay $Delay
            "Total Outage time in Seconds: $outageTime" | Add-Content -path $Logfile
            if($gateWayPopup)
            {
                New-PopupMessage -location $gateway -outagetime $outagetime
            }
            $spacer |add-content -Path $Logfile
        }
        if((!(Test-Connection  -TargetName $isp -count 1 -ea Ignore)) -and (Test-Connection $gateway -count 1 -ea Ignore))
        {
            get-date | Add-Content -path $Logfile
            "$isp Connection Failure" | Add-Content -Path $Logfile
            $outagetime = Start-ContinousPing -address $isp -adapter $adapter -Delay $Delay
            "Total Outage time in Seconds: $outageTime" | Add-Content -path $Logfile
            if($ispPopup)
            {
                New-PopupMessage -location $isp -outagetime $outagetime
            }           
            $spacer|add-content -Path $Logfile

            
        }
        Start-Sleep -Seconds $Delay
    }
}

function Start-ContinousPing
{
    param($address,[ipaddress] $adapter, [int]$Delay = 10)
    $currentTime = get-date
    While(!(Test-Connection $address -count 1 -ea Ignore))
            {
                Sleep -Seconds $Delay
            }
            $outageTime = ((get-date) - $currentTime).TotalSeconds
        $outageTime
}
function New-PopupMessage
{
    param($location, $outagetime)
    $Popup = New-Object -ComObject Wscript.Shell
    $popup.popup("$location Failure - seconds: $outagetime ",0,"$location",0x1)
}

$Logfile = "c:\temp\connection.log"
$isp = 'www.google.com'
if(!(test-path $Logfile))
{
    new-item -Path $Logfile
}
$IP = (Get-NetIPConfiguration -InterfaceAlias 'Ethernet 2').ipv4address.ipaddress
$gateway = (Get-NetIPConfiguration).ipv4defaultGateway.nexthop
Start-ConnectionMonitoring -isp $isp -gateway $gateway -Logfile $Logfile -adapter $IP.ToString() -ispPopup -gateWayPopup