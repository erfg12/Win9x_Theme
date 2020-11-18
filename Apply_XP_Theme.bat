@echo off

echo - Be sure to install Open-Shell-Menu before running this file. https://github.com/Open-Shell/Open-Shell-Menu/releases
echo - This batch file will copy this folder to %userprofile%\documents\Themes\WinXP\

for /F "tokens=3" %%A in ('reg query "HKCU\Control Panel\Desktop\PerMonitorSettings" /s') DO if %%A GEQ 0x3 goto :SCALE_ERROR

setlocal
:PROMPT
SET /P AREYOUSURE=Ready to start? Y/[N]:

IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

:: Copy files to directory Themes folder
xcopy /s "%CD%\WIN XP THEME" %userprofile%\documents\Themes\WinXP\
copy "%CD%\Apply_Theme.bat" "%userprofile%\documents\Themes\Apply_WindowsXP_Theme.bat"
copy "%CD%\Remove_Theme.bat" "%userprofile%\documents\Themes\Remove_Theme.bat"

:: Small taskbar buttons with text
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V TaskbarSmallIcons /T REG_DWORD /D 1 /F
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V TaskbarGlomLevel /T REG_DWORD /D 2 /F

:: Show desktop icons
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {645FF040-5081-101B-9F08-00AA002F954E} /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {F02C1A0D-BE21-4350-88B0-7367FC96EF3C} /t REG_DWORD /d 0 /f

:: Change desktop icons
set DOC_PATH="%userprofile%\documents\Themes\WinXP\System Icons"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\DefaultIcon" /VE /D %DOC_PATH%\16.ico /F
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{59031A47-3F72-44A7-89C5-5595FE6B30EE}\DefaultIcon" /VE /D %DOC_PATH%\235.ico /F
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" /VE /t REG_EXPAND_SZ /D %DOC_PATH%\33.ico /F
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" /V full /t REG_EXPAND_SZ /D %DOC_PATH%\33.ico /F
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" /V empty /t REG_EXPAND_SZ /D %DOC_PATH%\32.ico /F
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\DefaultIcon" /VE /D %DOC_PATH%\18.ico /F

:: Apply open-shell-menu theme
for /F "tokens=3" %%A in ('reg query "HKCU\Control Panel\Desktop\PerMonitorSettings" /s') DO if %%A == 0x0 ( "C:\Program Files\Open-Shell\StartMenu" -xml "%userprofile%\documents\Themes\WinXP\Menu Settings.xml" ) else if %%A == 0x1 ( "C:\Program Files\Open-Shell\StartMenu" -xml "%userprofile%\documents\Themes\WinXP\Menu Settings (x1.25).xml" )

:: Change wallpaper
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /f /t REG_SZ /d  "%userprofile%\documents\Themes\WinXP\Wallpapers\windows_xp_bliss-wide.bmp"
"%userprofile%\documents\Themes\WinXP\winxp.deskthemepack"

echo You can now delete this folder.

:: Reload explorer to show applied changes
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
taskkill /f /im explorer.exe
start explorer.exe

:SCALE_ERROR
@echo: 
echo ERROR: Your monitor resolution scale is set too high! Lower it to 100 percent or 125 percent in settings.
@echo: 
pause

:END
endlocal