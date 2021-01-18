@echo off
echo -------------------------------------------
echo VS native addon build environment bootstrap
echo -------------------------------------------
echo Bootstrap based on chocolatey pkg manager.
echo Following packages will be installed:
echo - git
echo - python2
echo - nodejs@12.0.0
echo - visualstudio2017community
echo - visualstudio2017-workload-nativedesktop
echo.
echo [IMPORTANT]
echo Please, be informed, that during installation -
echo some popup windows could appear.
echo DO NOT close any of them, before this script will
echo report about installation complete.
echo.
echo [IMPORTANT]
echo Reboot your system after installation to be sure,
echo that all of components finished the installation.
echo -------------------------------------------
pause

set pws="%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
set refreshEnv=%pws% "%ALLUSERSPROFILE%\chocolatey\bin\RefreshEnv.cmd"

@%pws% -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

@%refreshEnv%

choco install -y --force git
choco install -y --force python2
choco install -y --force nodejs --version=12.0.0

@%refreshEnv%

git config core.longpaths true

choco install -y --force visualstudio2017community --includeOptional --package-parameters " --add Microsoft.VisualStudio.Component.VC.ATL --add Microsoft.VisualStudio.Component.VC.ATLMFC"
choco install -y --force visualstudio2017-workload-nativedesktop

@%refreshEnv%

echo -----------------------------------
echo Disable windows logging services...
echo -----------------------------------
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\System /v PublishUserActivities /t REG_DWORD /d 0 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc /v Start /d 4 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc /v Start /d 4 /f
reg add HKLM\SYSTEM\ControlSet001\Services\CDPUserSvc /v Start /d 4 /f

echo ---------------------------------------------------------------------
echo Jupiter Desktop local environment bootstrap completed. Please reboot.
echo ---------------------------------------------------------------------
