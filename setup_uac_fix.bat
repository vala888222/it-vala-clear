@echo off
setlocal
set "psPath=%~dp0cleaner.ps1"
set "taskName=IT_vALA_Cleanup"

echo ======================================================
echo           IT vALA - UAC BYPASS INSTALLER
echo ======================================================
echo.

:: Check for Admin for the setup process
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Please Right-click this file and select 'Run as Administrator'.
    echo This is required ONLY ONCE to setup the bypass.
    pause
    exit /b
)

echo [1] Removing old Startup shortcuts...
del /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Auto_System_Clean.vbs" >nul 2>&1

echo [2] Creating Bypass Task...
:: This task will run 'cleaner.ps1' with 'Highest Privileges' at Logon
schtasks /create /tn "%taskName%" /tr "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \""%psPath%\""" /sc onlogon /rl highest /f

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] UAC Bypass setup complete!
    echo Cleanup will now run automatically on login without any 'Yes' buttons.
) else (
    echo [ERROR] Could not create the task.
)

echo.
echo Press any key to finish...
pause >nul
