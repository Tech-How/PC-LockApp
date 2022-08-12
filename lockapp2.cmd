@echo off
FOR /F "usebackq delims=" %%i in (`cscript "%localappdata%\PC LockApp\findDesktop.vbs"`) DO SET DESKTOPDIR=%%i >nul
echo.%desktopdir%|findstr /C:"OneDrive" >nul 2>&1 && set "desktopdir=%userprofile%\onedrive\desktop" || set "desktopdir=%userprofile%\desktop"
set pass=0
set count=0
title Lock App
mode con cols=10000 lines=10000
echo true > "%localappdata%\PC LockApp\pclockapp.tmp"
nircmd win max ititle "Lock App"
timeout 1 >nul
nircmd win close ititle LockAppTopMost
nircmd exec hide "%localappdata%\PC LockApp\bin\topmost.cmd"
cls
:A
echo Unlock screen:
echo.
echo Username: USERNAMESTRING
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set pass=%%p
if NOT %pass%== PASSWORDSTRING goto :FAIL
del /q "%localappdata%\PC LockApp\pclockapp.tmp"
exit
:FAIL
cls
set /a count=%count%+1
echo Incorrect Attempts: %count%
echo.
echo.
goto A