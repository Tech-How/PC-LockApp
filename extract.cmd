echo off
title PC LockApp
cls
echo Checking install...
FOR /F "usebackq delims=" %%i in (`cscript "%localappdata%\PC LockApp\findDesktop.vbs"`) DO SET DESKTOPDIR=%%i >nul
echo.%desktopdir%|findstr /C:"OneDrive" >nul 2>&1 && set "desktopdir=%userprofile%\onedrive\desktop" || set "desktopdir=%userprofile%\desktop"
timeout 1 >nul
if exist "%localappdata%\PC LockApp" goto alreadyinstalled
cls
echo Extracting...
ren lock.packedicon lock.ico
md "%localappdata%\PC LockApp\bin\exedata"
copy lock.ico "%localappdata%\PC LockApp\bin\exedata" >nul
md "C:\ProgramData\PC LockApp" >nul
copy lock.ico "C:\ProgramData\PC LockApp" >nul
copy installer.cmd "%localappdata%\PC LockApp" >nul
copy findDesktop.vbs "%localappdata%\PC LockApp" >nul
copy fart.exe "%localappdata%\PC LockApp\bin" >nul
copy lockapp2.cmd "%localappdata%\PC LockApp\bin\exedata" >nul
copy mlock.cmd "%localappdata%\PC LockApp\bin" >nul
copy topmost.cmd "%localappdata%\PC LockApp\bin" >nul
copy "PC LockApp.xml" "%localappdata%\PC LockApp\bin" >nul
copy "PC LockApp Non-Admin.xml" "%localappdata%\PC LockApp\bin" >nul
copy version.txt "%localappdata%\PC LockApp\bin" >nul
copy CREDITS.txt "%localappdata%\PC LockApp\bin" >nul
copy nircmd.exe "%localappdata%\PC LockApp\bin\exedata" >nul
FOR /F "usebackq delims=" %%i in (`cscript "%localappdata%\PC LockApp\findDesktop.vbs"`) DO SET DESKTOPDIR=%%i >nul
echo.%desktopdir%|findstr /C:"OneDrive" >nul 2>&1 && set "desktopdir=%userprofile%\onedrive\desktop" || set "desktopdir=%userprofile%\desktop"
copy "PC LockApp.lnk" "%desktopdir%" >nul
xcopy /e /i createexe "%localappdata%\PC LockApp\bin\createexe" >nul
start "" "%localappdata%\PC LockApp\installer.cmd"
exit

:alreadyinstalled
cls
echo Uninstalling...
echo.
echo.
rmdir /s /q "%localappdata%\PC LockApp" >nul 2>&1
rmdir /s /q "C:\ProgramData\PC LockApp" >nul 2>&1
del /q "%desktopdir%\PC LockApp.lnk" >nul 2>&1
schtasks /delete /f /TN "PC LockApp" >nul 2>&1
echo Uninstall complete.
timeout -1 >nul
exit