# 微信多开脚本
这是一个更复杂的微信多开脚本，它能通过查找桌面快捷方式或者注册表，自动寻找微信的路径，不需要手动填写，以便于应对更多的情况。  

虽然你可以使用  
```
@echo off
start "" "……\Tencent\WeChat\WeChat.exe"
start "" "……\Tencent\WeChat\WeChat.exe"
……
exit
```
来实现微信多开，但是每换一个环境就要重新手动修改一次安装路径，这很不优雅！  所以我制作了一个可以自己找路径的微信多开脚本。  
你可以直接下载`微信多开.cmd`，或者自己创建一个cmd文件并将下面这些代码复制进去保存：
```
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
```