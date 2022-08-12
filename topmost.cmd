title LockAppTopMost
"%localappdata%\PC LockApp\bin\exedata\nircmd.exe" win settopmost ititle "Lock App" 1
"%localappdata%\PC LockApp\bin\exedata\nircmd.exe" exec hide "%localappdata%\PC LockApp\bin\mlock.cmd"
:l
"%localappdata%\PC LockApp\bin\exedata\nircmd.exe" win max ititle "Lock App"
tasklist /nh /fi "imagename eq lockapp2.exe" | findstr /i "lockapp2.exe" >nul && (goto l)|| (goto res)
goto l

:res
if exist "%localappdata%\PC LockApp\pclockapp.tmp" goto res2
"%localappdata%\PC LockApp\bin\exedata\nircmd.exe" win close ititle mLock64
exit

:res2
start "" "%localappdata%\PC LockApp\lockapp2.exe"
timeout 3
"%localappdata%\PC LockApp\bin\exedata\nirnmd.exe" win settopmost ititle "Lock App" 1
goto l