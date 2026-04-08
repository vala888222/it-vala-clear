Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Get the path of the current folder automatically (Portable)
scriptPath = fso.GetParentFolderName(WScript.ScriptFullName) & "\cleaner.ps1"

' Run PowerShell hidden (0 = hidden window)
' -ExecutionPolicy Bypass ensures it can run locally
shell.Run "powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & scriptPath & """", 0, True