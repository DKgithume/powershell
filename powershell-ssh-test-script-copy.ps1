$checklist = import-csv checklist.csv
$OutArray = @()
Import-Csv checklist.csv |`
ForEach-Object { 
    try {
        $rh = $_.remoteHost
        $p = $_.port
        $socket = new-object System.Net.Sockets.TcpClient($rh, $p)
    } catch [Exception] {
        $myobj = "" | Select "remoteHost", "port", "status"
        $myobj.remoteHost = $rh
        $myobj.port = $p
        $myobj.status = "failed"
        Write-Host $myobj
        $outarray += $myobj
        $myobj = $null
        return
    }
    $myobj = "" | Select "remoteHost", "port", "status"
    $myobj.remoteHost = $rh
    $myobj.port = $p
    $myobj.status = "success"
    Write-Host $myobj
    $outarray += $myobj
    $myobj = $null
    return
}
$outarray | export-csv -path "C:\script\ps\telnet-test\10-78-33-30.csv" -NoTypeInformation