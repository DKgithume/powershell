$Iplist = Get-Content ips.txt
$group = @()
foreach ($ip in $Iplist) {
  $status = @{ "ServerIP Name" = $ip; "TimeStamp" = (Get-Date -f s) }
  $pings = Test-Connection $ip -Count 4 -ea 0
  if ($pings) {
    $status["AverageResponseTime"] =
        ($pings | Measure-Object -Property ResponseTime -Average).Average
    $status["Results"] = "Up"
  }
  else {
    $status["Results"] = "Down"
  }

  New-Object -TypeName PSObject -Property $status -OutVariable serverStatus
  $group += $serverStatus
}

$group | Export-Csv c:\ping\results.csv -NoTypeInformation