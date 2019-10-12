@echo off
:Restart
ECHO Trying to Disconnect all devices first...
adb disconnect

ECHO Connecting USB Device to 8081 port...
timeout 1 /NOBREAK >NUL
adb tcpip 8081

ECHO Now finding your device's IP Address...
timeout 2 /NOBREAK >NUL
GOTO :OneLine
:Print
ECHO connect to address %TEMPVAR%:8081
adb connect %TEMPVAR%:8081
GOTO :End
:OneLine
SET COMMAND=adb shell "ifconfig wlan0 | grep "inet " | awk -F'[: ]+' '{ print $4 }'"
FOR /F "delims=" %%A IN ('%COMMAND%') DO (
	SET TEMPVAR=%%A
	ECHO Found IP Address %TEMPVAR%
	GOTO :Print 
)
ECHO Problem occured while fetching your device's IP Address.
ECHO Make sure Device is Unlocked and Connected to same Network as this Machine.
set /p id="Press enter to start again"
GOTO :Restart
:End
set /p id="Press enter to Quit"
