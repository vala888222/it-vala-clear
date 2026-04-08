# IT-vALA System Cleaner 🚀

A high-performance, visual system cleanup tool designed for the **IT vALA** project. This tool automatically cleans temporary files, prefetch data, and recent items using a robust PowerShell-based automation engine.

## 🌟 Features

-   **Visual Cleanup**: Watch the folders open, select, and delete in real-time.
-   **UAC Bypass**: No more "Yes/No" prompts after the initial setup.
-   **Silent & Background Ready**: Can be scheduled to run at login via Task Scheduler.
-   **Locked File Handling**: Automatically skips files that are currently in use by the system.

## 📂 Folders Cleaned

1.  **System Temp** (`C:\Windows\Temp`)
2.  **User Temp** (`%TEMP%`)
3.  **Prefetch** (`C:\Windows\Prefetch`)
4.  **Recent Items** (`AppData\..\Recent`)

## 🛠️ Installation

1.  Clone this repository or download the folder.
2.  Right-click `setup_uac_fix.bat` and select **"Run as Administrator"**.
3.  That's it! The tool will now run automatically every time you log in.

## 📝 Technologies Used

-   **PowerShell**: Core automation engine.
-   **Batch**: Portable installer.
-   **Windows Task Scheduler**: UAC bypass implementation.

---
**Developed by vala88822 (IT vALA Project)**
