@echo off
title PC LockApp Installer - https://github.com/Tech-How
FOR /F "usebackq delims=" %%i in (`cscript "%localappdata%\PC LockApp\findDesktop.vbs"`) DO SET DESKTOPDIR=%%i >nul
echo.%desktopdir%|findstr /C:"OneDrive" >nul 2>&1 && set "desktopdir=%userprofile%\onedrive\desktop" || set "desktopdir=%userprofile%\desktop"
echo Welcome to the PC LockApp installer.
echo.
echo This program will help guard your PC while you're away, without the limitations of the standard Windows lock screen.
echo.
echo.
echo.
echo Next, you'll enter a username and password that will appear on the lock screen.
echo These do not have to be your actual Windows credentials.
echo.
timeout -1
:setinfo
cls
echo Please enter a username to display on the lock screen:
set/p "USERNAMESTRING=Enter Username: "
echo.
echo.
echo Please enter a password to use to unlock the computer. NOTE: Using spaces will crash the installer.
set "psCommand=powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set PASSWORD1=%%p
set "psCommand=powershell -Command "$pword = read-host 'Confirm Password' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set PASSWORD2=%%p
if %PASSWORD1% equ %PASSWORD2% goto passcheck1
cls
echo Error: The passwords do not match.
timeout 3 /nobreak >nul
goto setinfo
:passcheck1
set PASSWORDSTRING=%PASSWORD2%
cls
echo Installing...
"%localappdata%\PC LockApp\bin\fart.exe" "%localappdata%\PC LockApp\bin\PC LockApp.xml" "XMLUSRSTRING" "%username%" >nul
"%localappdata%\PC LockApp\bin\fart.exe" "%localappdata%\PC LockApp\bin\PC LockApp.xml" "XMLPROGSTRING" "%localappdata%\PC LockApp\lockapp2.exe" >nul
timeout 3 /nobreak >nul
"%localappdata%\PC LockApp\bin\fart.exe" "%localappdata%\PC LockApp\bin\exedata\lockapp2.cmd" "USERNAMESTRING" "%USERNAMESTRING%" >nul
"%localappdata%\PC LockApp\bin\fart.exe" "%localappdata%\PC LockApp\bin\exedata\lockapp2.cmd" "PASSWORDSTRING" "%PASSWORDSTRING%" >nul
set errorlevel=0
schtasks /create /tn "PC LockApp" /XML "%localappdata%\PC LockApp\bin\PC LockApp.xml" >nul 2>&1
if errorlevel 1 goto schtaskserror
:resumeschtasks
"%localappdata%\PC LockApp\bin\exedata\nircmd.exe" exec hide "%localappdata%\PC LockApp\bin\createexe\bat2exe.cmd"
timeout 3 /nobreak >nul
cls
echo Install complete.
echo.
echo You can run the program from the desktop shortcut.
echo To uninstall, download and run the setup again.
timeout -1
exit

:schtaskserror
"%localappdata%\PC LockApp\bin\fart.exe" "%localappdata%\PC LockApp\bin\PC LockApp Non-Admin.xml" "XMLUSRSTRING" "%username%" >nul
"%localappdata%\PC LockApp\bin\fart.exe" "%localappdata%\PC LockApp\bin\PC LockApp Non-Admin.xml" "XMLPROGSTRING" "%localappdata%\PC LockApp\lockapp2.exe" >nul
set errorlevel=0
schtasks /create /tn "PC LockApp" /XML "%localappdata%\PC LockApp\bin\PC LockApp Non-Admin.xml" >nul 2>&1
if errorlevel 1 goto schtaskserror2
goto resumeschtasks

:schtaskserror2
cls
echo ERROR:
echo.
echo Unable to create scheduled task.
timeout -1 >nul
exit