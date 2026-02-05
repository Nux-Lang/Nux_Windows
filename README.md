# Nux Programming Language - Windows Distribution\r
\r
```\r
████     ██████████████      ███╗    ██╗██╗    ██╗██╗    ██╗\r
████     ██████████████      ████╗   ██║██║    ██║╚██╗  ██╔╝\r
████     ████                ██╔██╗  ██║██║    ██║ ╚██╗██╔╝ \r
████     ████                ██║╚██╗ ██║██║    ██║  ╚███╔╝  \r
██████████████████████       ██║ ╚██╗██║██║    ██║   ███║   \r
██████████████████████       ██║  ╚████║██║    ██║  ██╔██╗  \r
         ████     ████       ██║   ╚███║██║    ██║ ██╔╝╚██╗ \r
         ████     ████       ██║    ╚██║██║    ██║██╔╝  ╚██╗\r
█████████████     ████       ██║     ╚█║╚██████╔╝██║      ██║\r
█████████████     ████       ╚═╝      ╚╝ ╚═════╝ ╚═╝      ╚═╝\r
```\r
\r
**Version:** 1.0.0  \r
**Platform:** Windows 10/11 (x64)\r
\r
## Quick Start\r
\r
Install Nux by running the installer as Administrator:\r
\r
```cmd\r
setup.bat\r
```\r
\r
## System Requirements\r
\r
- **OS:** Windows 10 (build 10586+) or Windows 11\r
- **Architecture:** x64 (64-bit)\r
- **Disk Space:** ~100 MB\r
- **RAM:** 512 MB minimum\r
\r
## Installation\r
\r
### 1. Extract the Package\r
\r
Extract the ZIP file to a folder, e.g., `C:\nux_pack_windows`\r
\r
### 2. Run the Installer as Administrator\r
\r
**Right-click** `setup.bat` and select **"Run as administrator"**\r
\r
The installer will:\r
- ✓ Check administrator privileges\r
- ✓ Create installation directories\r
- ✓ Install Nux runtime and libraries\r
- ✓ Add Nux to system PATH\r
- ✓ Register .nux file extension\r
\r
### 3. Verify Installation\r
\r
Open a **new** Command Prompt or PowerShell and run:\r
\r
```cmd\r
nux --version\r
```\r
\r
You should see: `Nux v1.0.0 (Windows)`\r
\r
## Getting Started\r
\r
### Start the REPL\r
\r
```cmd\r
nux repl\r
```\r
\r
### Run Example Programs\r
\r
```cmd\r
REM Hello World\r
nux examples\hello.nux\r
\r
REM Web Server\r
nux examples\web_server.nux\r
\r
REM AI Demo\r
nux examples\ai_demo.nux\r
```\r
\r
### Create Your First Program\r
\r
```cmd\r
echo import "std.io"; println("Hello, Nux!"); > hello.nux\r
nux hello.nux\r
```\r
\r
## What's Included\r
\r
- **Standard Libraries** (79 files)\r
  - `lib\std\` - Core utilities, I/O, networking, graphics\r
  - `lib\ai\` - Neural networks, transformers, GANs, RL\r
  - `lib\os\` - Kernel, scheduler, memory management\r
  - `lib\embedded\` - Hardware control, GPIO, sensors\r
\r
- **Examples**\r
  - `hello.nux` - Basic syntax and I/O\r
  - `web_server.nux` - HTTP server\r
  - `ai_demo.nux` - Neural network training\r
\r
- **Tools**\r
  - `nux.bat` - Runtime and REPL\r
  - `nuxc.bat` - Compiler\r
  - `nuxr.bat` - Script runner\r
\r
## Windows-Specific Features\r
\r
- **File Association:** Double-click .nux files to run them\r
- **ANSI Colors:** Full color support in Windows Terminal\r
- **PowerShell Integration:** Works in both CMD and PowerShell\r
- **Registry Integration:** Proper file type registration\r
\r
## Troubleshooting\r
\r
### Access Denied\r
\r
Make sure to run `setup.bat` as Administrator:\r
1. Right-click `setup.bat`\r
2. Select "Run as administrator"\r
\r
### Command Not Found\r
\r
Restart your terminal (Command Prompt or PowerShell) after installation.\r
\r
If the issue persists, manually add to PATH:\r
1. Open System Properties → Advanced → Environment Variables\r
2. Add `C:\Program Files\Nux\bin` to PATH\r
\r
### ANSI Colors Not Working\r
\r
Use Windows Terminal (recommended) or update Windows to build 10586+.\r
\r
### Antivirus Blocking Installation\r
\r
Some antivirus software may flag the installer. Add an exception for:\r
- `C:\Program Files\Nux\`\r
- `setup.bat`\r
\r
## Uninstallation\r
\r
Run the installer with the uninstall flag:\r
\r
```cmd\r
setup.bat uninstall\r
```\r
\r
Or manually:\r
1. Delete `C:\Program Files\Nux`\r
2. Remove from PATH in Environment Variables\r
3. Delete registry keys under `HKCU\Software\Classes\.nux`\r
\r
## Documentation\r
\r
- **Language Guide:** https://nux-lang.org/docs\r
- **API Reference:** https://nux-lang.org/api\r
- **Examples:** https://github.com/nux-lang/examples\r
\r
## Support\r
\r
- **Issues:** https://github.com/nux-lang/nux/issues\r
- **Community:** https://discord.gg/nux-lang\r
- **Email:** support@nux-lang.org\r
\r
## License\r
\r
Nux Programming Language is released under the MIT License.  \r
See LICENSE.txt file for details.\r
\r
---\r
\r
**Happy Coding!** 🚀\r
