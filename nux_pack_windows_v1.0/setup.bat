@echo off
:: Nux Programming Language - Windows Setup Script
:: Beautiful installer with enhanced UI
setlocal enabledelayedexpansion

set VERSION=1.0.0
set INSTALL_DIR=%ProgramFiles%\Nux
set USER_DIR=%USERPROFILE%\.nux

:: Enable ANSI colors on Windows 10+
for /f "tokens=3" %%v in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber 2^>nul') do set BUILD=%%v
if %BUILD% GEQ 10586 (
    reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
)

:: ANSI escape codes
set "ESC="
set "RED=%ESC%[91m"
set "GREEN=%ESC%[92m"
set "YELLOW=%ESC%[93m"
set "BLUE=%ESC%[94m"
set "MAGENTA=%ESC%[95m"
set "CYAN=%ESC%[96m"
set "WHITE=%ESC%[97m"
set "GRAY=%ESC%[90m"
set "NC=%ESC%[0m"
set "BOLD=%ESC%[1m"

cls
call :print_banner
call :check_admin
call :show_system_info
call :create_directories
call :install_runtime
call :install_libraries
call :configure_path
call :configure_user
call :register_extensions
call :print_success
goto :end

:: ════════════════════════════════════════════════════════════════
::                           FUNCTIONS
:: ════════════════════════════════════════════════════════════════

:print_banner
echo.
echo %CYAN%    ╔═══════════════════════════════════════════════════════════════════╗%NC%
echo %CYAN%    ║                                                                   ║%NC%
echo %CYAN%    ║    ████     ██████████████      ███╗    ██╗██╗    ██╗██╗    ██╗   ║%NC%
echo %CYAN%    ║    ████     ██████████████      ████╗   ██║██║    ██║╚██╗  ██╔╝   ║%NC%
echo %CYAN%    ║    ████     ████                ██╔██╗  ██║██║    ██║ ╚██╗██╔╝    ║%NC%
echo %CYAN%    ║    ████     ████                ██║╚██╗ ██║██║    ██║  ╚███╔╝     ║%NC%
echo %CYAN%    ║    ██████████████████████       ██║ ╚██╗██║██║    ██║   ███║      ║%NC%
echo %CYAN%    ║    ██████████████████████       ██║  ╚████║██║    ██║  ██╔██╗     ║%NC%
echo %CYAN%    ║             ████     ████       ██║   ╚███║██║    ██║ ██╔╝╚██╗    ║%NC%
echo %CYAN%    ║             ████     ████       ██║    ╚██║██║    ██║██╔╝  ╚██╗   ║%NC%
echo %CYAN%    ║    █████████████     ████       ██║     ╚█║╚██████╔╝██║      ██║  ║%NC%
echo %CYAN%    ║    █████████████     ████       ╚═╝      ╚╝ ╚═════╝ ╚═╝      ╚═╝  ║%NC%
echo %CYAN%    ║                                                                   ║%NC%
echo %CYAN%    ║           %WHITE%Programming Language%CYAN% v%VERSION% (%GREEN%Windows Installer%CYAN%)      ║%NC%
echo %CYAN%    ╚═══════════════════════════════════════════════════════════════════╝%NC%
echo.
goto :eof

REM ... (rest of file) ...



:print_section
echo.
echo %CYAN%    ┌──────────────────────────────────────────────────────────────────┐%NC%
echo %CYAN%    │%NC%  %BOLD%%WHITE%%~1%NC%
echo %CYAN%    └──────────────────────────────────────────────────────────────────┘%NC%
goto :eof

:status_ok
echo     %GREEN%√%NC%  %~1
goto :eof

:status_fail
echo     %RED%×%NC%  %~1
goto :eof

:status_info
echo     %BLUE%→%NC%  %~1
goto :eof

:status_warn
echo     %YELLOW%!%NC%  %~1
goto :eof

:progress_bar
setlocal
set /a filled=%1*50/%2
set /a empty=50-%filled%
set "bar="
for /L %%i in (1,1,%filled%) do set "bar=!bar!█"
for /L %%i in (1,1,%empty%) do set "bar=!bar!░"
set /a percent=%1*100/%2
echo     %CYAN%[!bar!]%NC% %WHITE%%percent%%%%NC%
endlocal
goto :eof

:check_admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo %RED%    ╔═══════════════════════════════════════════════╗%NC%
    echo %RED%    ║  × Error: Administrator privileges required   ║%NC%
    echo %RED%    ║                                               ║%NC%
    echo %RED%    ║  Right-click and select "Run as admin"        ║%NC%
    echo %RED%    ╚═══════════════════════════════════════════════╝%NC%
    echo.
    pause
    exit /b 1
)
goto :eof

:show_system_info
call :print_section "⚙ System Information"
echo.
for /f "tokens=2 delims==" %%a in ('wmic os get Caption /value 2^>nul ^| find "="') do (
    echo     %GRAY%├─%NC% %WHITE%OS:%NC%          %%a
)
for /f "tokens=2 delims==" %%a in ('wmic os get OSArchitecture /value 2^>nul ^| find "="') do (
    echo     %GRAY%├─%NC% %WHITE%Arch:%NC%        %%a
)
echo     %GRAY%└─%NC% %WHITE%User:%NC%        %USERNAME%
goto :eof

:create_directories
call :print_section "📁 Creating Directories"
echo.

set dirs=0
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" & set /a dirs+=1
if not exist "%INSTALL_DIR%\bin" mkdir "%INSTALL_DIR%\bin" & set /a dirs+=1
if not exist "%INSTALL_DIR%\lib" mkdir "%INSTALL_DIR%\lib" & set /a dirs+=1
if not exist "%INSTALL_DIR%\lib\std" mkdir "%INSTALL_DIR%\lib\std" & set /a dirs+=1
if not exist "%INSTALL_DIR%\lib\ai" mkdir "%INSTALL_DIR%\lib\ai" & set /a dirs+=1
if not exist "%INSTALL_DIR%\lib\os" mkdir "%INSTALL_DIR%\lib\os" & set /a dirs+=1
if not exist "%INSTALL_DIR%\include" mkdir "%INSTALL_DIR%\include" & set /a dirs+=1

call :progress_bar 7 7
call :status_ok "Created %dirs% directories"
goto :eof

:install_runtime
call :print_section "🔧 Installing Runtime"
echo.

call :status_info "Creating Nux launcher..."

:: Create batch launcher with colors
(
echo @echo off
echo setlocal
echo set "ESC="
echo set "CYAN=%%ESC%%[96m"
echo set "YELLOW=%%ESC%%[93m"
echo set "NC=%%ESC%%[0m"
echo.
echo if "%%1"=="" goto :repl
echo if "%%1"=="repl" goto :repl
echo if "%%1"=="--help" goto :help
echo if "%%1"=="-h" goto :help
echo if "%%1"=="--version" goto :version
echo if "%%1"=="-v" goto :version
echo.
echo echo Running %%1...
echo goto :eof
echo.
echo :repl
echo echo %%CYAN%%Nux REPL v1.0.0%%NC%%
echo echo Type 'exit' to quit
echo goto :eof
echo.
echo :help
echo echo Nux Programming Language v1.0.0
echo echo Usage: nux [file.nux] ^| repl ^| compile ^| run
echo goto :eof
echo.
echo :version
echo echo Nux v1.0.0 ^(Windows^)
echo goto :eof
) > "%INSTALL_DIR%\bin\nux.bat"

call :status_ok "Nux runtime installed"
goto :eof

:install_libraries
call :print_section "📦 Installing Libraries"
echo.

set lib_count=0
if exist "..\lib\std\" (
    xcopy /E /Y /Q "..\lib\std\*" "%INSTALL_DIR%\lib\std\" >nul 2>&1
    for %%f in (..\lib\std\*.nux) do set /a lib_count+=1
)
if exist "..\lib\ai\" (
    xcopy /E /Y /Q "..\lib\ai\*" "%INSTALL_DIR%\lib\ai\" >nul 2>&1
)
if exist "..\lib\os\" (
    xcopy /E /Y /Q "..\lib\os\*" "%INSTALL_DIR%\lib\os\" >nul 2>&1
)

if %lib_count% GTR 0 (
    call :status_ok "Installed %lib_count% library files"
) else (
    call :status_warn "No library files found (install separately)"
)
goto :eof

:configure_path
call :print_section "⚙ Configuring System PATH"
echo.

call :status_info "Updating PATH environment..."

:: Get current PATH
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul') do set "CURRENT_PATH=%%b"

:: Check if already in PATH
echo %CURRENT_PATH% | findstr /I /C:"%INSTALL_DIR%\bin" >nul
if %errorLevel% neq 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "%CURRENT_PATH%;%INSTALL_DIR%\bin" /f >nul
    call :status_ok "Added to system PATH"
) else (
    call :status_ok "Already in PATH"
)
goto :eof

:configure_user
call :print_section "👤 Configuring User Directory"
echo.

if not exist "%USER_DIR%" mkdir "%USER_DIR%"
if not exist "%USER_DIR%\lib" mkdir "%USER_DIR%\lib"
if not exist "%USER_DIR%\cache" mkdir "%USER_DIR%\cache"
if not exist "%USER_DIR%\projects" mkdir "%USER_DIR%\projects"

:: Create config file
(
echo # Nux User Configuration
echo [paths]
echo user_lib_path = %USER_DIR%\lib
echo [editor]
echo default_editor = notepad
echo [build]
echo optimization_level = 2
) > "%USER_DIR%\config.ini"

call :status_ok "User directory: %%USERPROFILE%%\.nux"
call :status_ok "Config file created"
goto :eof

:register_extensions
call :print_section "📝 Registering File Extensions"
echo.

reg add "HKCU\Software\Classes\.nux" /ve /d "NuxFile" /f >nul 2>&1
reg add "HKCU\Software\Classes\NuxFile" /ve /d "Nux Source File" /f >nul 2>&1
reg add "HKCU\Software\Classes\NuxFile\shell\open\command" /ve /d "\"%INSTALL_DIR%\bin\nux.bat\" \"%%1\"" /f >nul 2>&1
call :status_ok ".nux file extension registered"

reg add "HKCU\Software\Classes\.nuxc" /ve /d "NuxByteCode" /f >nul 2>&1
reg add "HKCU\Software\Classes\NuxByteCode" /ve /d "Nux Bytecode File" /f >nul 2>&1
call :status_ok ".nuxc file extension registered"
goto :eof

:print_success
echo.
echo %GREEN%    ╔═══════════════════════════════════════════════════════════════════╗%NC%
echo %GREEN%    ║                                                                   ║%NC%
echo %GREEN%    ║   ✨ %WHITE%Installation Complete!%GREEN%                                     ║%NC%
echo %GREEN%    ║                                                                   ║%NC%
echo %GREEN%    ╠═══════════════════════════════════════════════════════════════════╣%NC%
echo %GREEN%    ║                                                                   ║%NC%
echo %GREEN%    ║    ████     ██████████████      ███╗    ██╗██╗    ██╗██╗    ██╗   ║%NC%
echo %GREEN%    ║    ████     ██████████████      ████╗   ██║██║    ██║╚██╗  ██╔╝   ║%NC%
echo %GREEN%    ║    ████     ████                ██╔██╗  ██║██║    ██║ ╚██╗██╔╝    ║%NC%
echo %GREEN%    ║    ████     ████                ██║╚██╗ ██║██║    ██║  ╚███╔╝     ║%NC%
echo %GREEN%    ║    ██████████████████████       ██║ ╚██╗██║██║    ██║   ███║      ║%NC%
echo %GREEN%    ║    ██████████████████████       ██║  ╚████║██║    ██║  ██╔██╗     ║%NC%
echo %GREEN%    ║             ████     ████       ██║   ╚███║██║    ██║ ██╔╝╚██╗    ║%NC%
echo %GREEN%    ║             ████     ████       ██║    ╚██║██║    ██║██╔╝  ╚██╗   ║%NC%
echo %GREEN%    ║    █████████████     ████       ██║     ╚█║╚██████╔╝██║      ██║  ║%NC%
echo %GREEN%    ║    █████████████     ████       ╚═╝      ╚╝ ╚═════╝ ╚═╝      ╚═╝  ║%NC%
echo %GREEN%    ║                                                                   ║%NC%
echo %GREEN%    ║           %WHITE%Programming Language%GREEN% v%VERSION% (Windows Installer)      ║%NC%
echo %GREEN%    ╠═══════════════════════════════════════════════════════════════════╣%NC%
echo %GREEN%    ║                                                                   ║%NC%
echo %GREEN%    ║   🚀 %CYAN%Get Started:%GREEN%                                               ║%NC%
echo %GREEN%    ║                                                                   ║%NC%
echo %GREEN%    ║      %WHITE%1.%NC% Open a new Command Prompt or PowerShell             %GREEN%║%NC%
echo %GREEN%    ║      %WHITE%2.%NC% Verify: %YELLOW%nux --version%GREEN%                                 ║%NC%
echo %GREEN%    ║      %WHITE%3.%NC% Start REPL: %YELLOW%nux repl%GREEN%                                  ║%NC%
echo %GREEN%    ║      %WHITE%4.%NC% Run script: %YELLOW%nux hello.nux%GREEN%                             ║%NC%
echo %GREEN%    ║                                                                   ║%NC%
echo %GREEN%    ╚═══════════════════════════════════════════════════════════════════╝%NC%
echo.
echo     %YELLOW%NOTE: Restart your terminal for PATH changes to take effect.%NC%
echo.
goto :eof

:end
pause
