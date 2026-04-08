# ============================================================
# IT vALA - POWER CLEANER PRO
# ============================================================
# This script performs a visual cleanup of temp folders.
# Language: PowerShell
# ============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

$folders = @(
    "C:\Windows\Temp",
    [Environment]::GetEnvironmentVariable("TEMP", "User"),
    "C:\Windows\Prefetch",
    "$env:APPDATA\Microsoft\Windows\Recent"
)

Write-Host "`n[+] INITIALIZING IT vALA POWER CLEANER..." -ForegroundColor Green
Write-Host "[+] Mode: Visual Execution`n" -ForegroundColor Cyan

foreach ($path in $folders) {
    if (Test-Path $path) {
        $folderName = Split-Path $path -Leaf
        Write-Host "[*] Cleaning: $path" -ForegroundColor Yellow
        
        # A. Open Folder
        Invoke-Item $path
        Start-Sleep -Milliseconds 1500

        # B. Robust Activation & Selection
        # We loop to find the exact Explorer window for this path
        $shell = New-Object -ComObject Shell.Application
        $window = $shell.Windows() | Where-Object { $_.LocationURL -like "*$($path.Replace('\','/'))*" } | Select-Object -First 1
        
        if ($window) {
            # Bring to front using AppActivate
            [Microsoft.VisualBasic.Interaction]::AppActivate($window.LocationName)
            Start-Sleep -Milliseconds 500

            # Force Focus Trick (Ctrl+Shift+6) for Details View
            [System.Windows.Forms.SendKeys]::SendWait("^+6")
            Start-Sleep -Milliseconds 600

            # Select All
            [System.Windows.Forms.SendKeys]::SendWait("^a")
            Start-Sleep -Milliseconds 400

            # Shift + Delete
            [System.Windows.Forms.SendKeys]::SendWait("+{DEL}")
            Start-Sleep -Milliseconds 600

            # Handle Initial Confirmation (Permanent Delete)
            [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
            Start-Sleep -Milliseconds 600

            # Handle Skip Loop (File in Use)
            # Checks for dialogs every 500ms for 30 seconds
            $skipLoop = 0
            while ($skipLoop -lt 60) {
                # Attempt to catch "File in Use" or "Access Denied" dialogs
                # PowerShell doesn't have a direct 'AppActivate' by title check as easy as VBS, 
                # but we can spam the Skip keys if a dialog is likely present.
                
                # Check "Do this for all" (Alt+A) and "Skip" (Alt+S)
                [System.Windows.Forms.SendKeys]::SendWait("%a")
                Start-Sleep -Milliseconds 100
                [System.Windows.Forms.SendKeys]::SendWait("%i")
                Start-Sleep -Milliseconds 100
                [System.Windows.Forms.SendKeys]::SendWait(" ")
                Start-Sleep -Milliseconds 200
                [System.Windows.Forms.SendKeys]::SendWait("%s")
                
                Start-Sleep -Milliseconds 500
                $skipLoop++
                
                # If the main window is gone or empty, we can stop early
                # (Complex to detect perfectly, so we just loop a reasonable amount)
                if ($skipLoop -eq 4) { break } 
            }

            # Close Window
            [Microsoft.VisualBasic.Interaction]::AppActivate($window.LocationName)
            [System.Windows.Forms.SendKeys]::SendWait("%{F4}")
            Write-Host "[+] Finished: $folderName" -ForegroundColor Green
        } else {
            Write-Host "[!] Could not find Explorer window for $folderName" -ForegroundColor Red
        }
        
        Start-Sleep -Milliseconds 500
    }
}

Write-Host "`n[+++] CLEANUP COMPLETE [+++]" -ForegroundColor Green
Write-Host "Press any key to exit..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
