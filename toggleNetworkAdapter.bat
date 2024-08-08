@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

SET ADAPTER_NAME_WIFI=WiFi
SET ADAPTER_NAME_WLAN=Ethernet
SET IS_WLAN_CONNECTED=0

@REM Capture the output of the netsh command
FOR /F "tokens=3" %%i IN ('netsh interface show interface name^="%ADAPTER_NAME_WLAN%" ^| findstr "Connected"') DO (
    if "%%i"=="Connected" SET IS_WLAN_CONNECTED=1
)

@REM log value of IS_WLAN_CONNECTED
echo IS_WLAN_CONNECTED: %IS_WLAN_CONNECTED%

@REM Check if the adapter is connected
IF %IS_WLAN_CONNECTED%==1 (
    echo %ADAPTER_NAME_WLAN% is connected. Disabling it and enabling %ADAPTER_NAME_WIFI%.
    netsh interface set interface "%ADAPTER_NAME_WLAN%" DISABLED
    netsh interface set interface "%ADAPTER_NAME_WIFI%" ENABLED
) ELSE (
    echo %ADAPTER_NAME_WLAN% is not connected. Disabling %ADAPTER_NAME_WIFI% and enabling %ADAPTER_NAME_WLAN%.
    netsh interface set interface "%ADAPTER_NAME_WIFI%" DISABLED
    netsh interface set interface "%ADAPTER_NAME_WLAN%" ENABLED
)

ENDLOCAL