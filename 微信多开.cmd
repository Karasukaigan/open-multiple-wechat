chcp 65001 > nul
@echo off
setlocal enabledelayedexpansion

:: 设置多开数量，默认为2
set "openCount=2"

set "shortcutName=微信.lnk"
set "userDesktopPath=%USERPROFILE%\Desktop"
set "publicDesktopPath=C:\Users\Public\Desktop"
set "regKey=HKEY_CURRENT_USER\SOFTWARE\Tencent\WeChat"
if exist "!userDesktopPath!\!shortcutName!" (
    set "targetPath=!userDesktopPath!\!shortcutName!"
) else if exist "!publicDesktopPath!\!shortcutName!" (
    set "targetPath=!publicDesktopPath!\!shortcutName!"
) else (
    for /f "tokens=2*" %%A in ('reg query "!regKey!" /v "InstallPath"') do set "targetPath=%%B\WeChat.exe"
    if not defined targetPath (
        pause
        exit /b 1
    )
)
for /l %%i in (1,1,%openCount%) do start "" "!targetPath!"
exit /b 0


