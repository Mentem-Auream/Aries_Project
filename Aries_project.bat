@echo off
:: KLUCZOWA LINIJKA: Włącza obsługę wykrzykników w zmiennych
setlocal EnableDelayedExpansion
:: Ustawienie kodowania na UTF-8 dla polskich znaków i symboli
chcp 65001 >nul
title ARIES_OS_TERMINAL v.2.0.5 [Aries Mod Hub]
:: Kolor 0A to jasna zieleń (Emerald), idealnie pasująca do strony
color 0B

:: Konfiguracja ścieżek i URLi
set "CURRENT_VERSION=1.0"
set "URL_VERSION=https://amongus.igornowakowski.pl/files/version.txt"
set "URL_UPDATE=https://amongus.igornowakowski.pl/files/ArisModHub.bat"
set "BEP_URL=https://amongus.igornowakowski.pl/files/bepInEx_AmongUs.zip"
set "DEST_DIR=%USERPROFILE%\AppData\LocalLow\Innersloth\Among Us"
set "FILE_NAME=regionInfo.json"
set "URL_SERVERS=https://amongus.igornowakowski.pl/files/regionInfo.json"

set "URL_TOHE=https://amongus.igornowakowski.pl/files/mods/TOHE.dll"
set "URL_AUNLOCKER=https://amongus.igornowakowski.pl/files/mods/AUnlocker.dll"

set "MIRA_REGION=https://amongus.igornowakowski.pl/files/mods/mira/Mini.RegionInstall.dll"
set "MIRA_API=https://amongus.igornowakowski.pl/files/mods/mira/MiraAPI.dll"
set "MIRA_REACTOR=https://amongus.igornowakowski.pl/files/mods/mira/Reactor.dll"
set "MIRA_DLL=https://amongus.igornowakowski.pl/files/mods/mira/TownOfUsMira.dll"
set "MIRA_BUNDLE=https://amongus.igornowakowski.pl/files/mods/mira/touhats.bundle"
set "MIRA_CATALOG=https://amongus.igornowakowski.pl/files/mods/mira/touhats.catalog"

set "LI_DLL=https://amongus.igornowakowski.pl/files/mods/levelimpostor/LevelImpostor.dll"
set "LI_REACTOR=https://amongus.igornowakowski.pl/files/mods/levelimpostor/Reactor.dll"

:: Sprawdzanie aktualizacji w tle
curl -s -L "!URL_VERSION!" -o "%TEMP%\latest_ver.txt"
if exist "%TEMP%\latest_ver.txt" (
    set /p LATEST_VERSION=<"%TEMP%\latest_ver.txt"
    del /f /q "%TEMP%\latest_ver.txt"
)

:: ==============================================================================
::                                 MENU GŁÓWNE
:: ==============================================================================

:menu
cls
echo.
echo  ┌──────────────────────────────────────────────────────────────────────────┐
echo  │  ARIES_OS // TERMINAL v.2.0.5                                            │
echo  └──────────────────────────────────────────────────────────────────────────┘
echo.
echo           █████╗ ██████╗ ██╗███████╗███████╗
echo          ██╔══██╗██╔══██╗██║██╔════╝██╔════╝
echo          ███████║██████╔╝██║█████╗  ███████╗
echo          ██╔══██║██╔══██╗██║██╔══╝  ╚════██║
echo          ██║  ██║██║  ██║██║███████╗███████║
echo          ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
echo.
echo  ------------------- Build Version: %CURRENT_VERSION% -------------------
echo.

if defined LATEST_VERSION (
    if "%CURRENT_VERSION%" LSS "!LATEST_VERSION!" (
        echo  [!] UPDATE AVAILABLE: !LATEST_VERSION! (Option [5])
        echo.
    )
)

echo  ^> WYBIERZ_PAKIET_DANYCH:
echo  [1] 📥 LOCAL NODE       (Serwery, Kosmetyki)
echo  [2] 🛠️ MOD PROTOCOLS    (Town of Us, Level Impostor)
echo  [3] 📂 MANAGE ASSETS    (Usuwanie wybranych modów)
echo  [4] 🧹 VANILLA RESTORE  (Przywracanie czystej wersji)
echo  [5] 🔄 UPDATE KERNEL    (Aktualizuj skrypt)
echo  [0] ❌ DISCONNECT       (Wyjście)
echo.
set /p choice="[USER@ARIES_HUB]:~# "

if "%choice%"=="1" goto local_menu
if "%choice%"=="2" goto mod_menu
if "%choice%"=="3" goto manage_mods
if "%choice%"=="4" goto clean
if "%choice%"=="5" goto update_script
if "%choice%"=="0" exit
goto menu

:: ================================= SEKCJA LOCAL =================================

:local_menu
cls
echo.
echo  ┌─ [ LOCAL NODE ] ─────────────────────────────────────────────────────────┐
echo.
echo   [1] 🌐 REGION_INSTALL (Serwery)
echo   [2] 🎭 COSMETIC_UNLOCK (AUnlocker)
echo   [3] 👑 TOHE_PROTOCOL (Town Of Host Enhanced)
echo   [4] ⬅️ BACK_TO_ROOT
echo.
set /p loc_choice="[LOCAL@ARIES_HUB]:~# "

if "%loc_choice%"=="1" goto install_servers
if "%loc_choice%"=="2" goto install_cosmetics
if "%loc_choice%"=="3" goto install_tohe
if "%loc_choice%"=="4" goto menu
goto local_menu

:: ================================= SEKCJA MODS ==================================

:mod_menu
cls
echo.
echo  ┌─ [ MOD PROTOCOLS ] ──────────────────────────────────────────────────────┐
echo.
echo   [1] 🍄 TOWN_OF_US_MIRA (Full Bundle)
echo   [2] 🎭 LEVEL_IMPOSTOR  (Reactor + DLL)
echo   [3] ⬅️ BACK_TO_ROOT
echo.
set /p mod_choice="[MODS@ARIES_HUB]:~# "

if "%mod_choice%"=="1" goto install_mira
if "%mod_choice%"=="2" goto install_level_impostor
if "%mod_choice%"=="3" goto menu
goto mod_menu

:: ================================= SEKCJA ZARZĄDZANIA =================================

:manage_mods
cls
echo.
echo  ┌─ [ MANAGE ASSETS ] ──────────────────────────────────────────────────────┐
echo.
set /p USER_PATH="^> WKLEJ SCIEZKE DO FOLDERU AMONG US: "
set "USER_PATH=%USER_PATH:"=%"

set "PLUGIN_DIR=!USER_PATH!\BepInEx\plugins"

if not exist "!PLUGIN_DIR!" (
    echo.
    echo [ERROR] DIRECTORY_NOT_FOUND: plugins folder not found.
    pause
    goto menu
)

:manage_list
cls
echo.
echo  ┌─ [ ASSET LIST ] ────────────────────────────────────────────────────────┐
echo.
set /a count=0
for %%f in ("!PLUGIN_DIR!\*.dll" "!PLUGIN_DIR!\*.bundle" "!PLUGIN_DIR!\*.catalog") do (
    set /a count+=1
    set "file!count!=%%~nxf"
    echo   [!count!] %%~nxf
)

if %count%==0 (
    echo   Brak plików do wyświetlenia.
    echo.
    pause
    goto menu
)

echo.
echo   [0] Powrót do menu
echo  ──────────────────────────────────────────────────────────────────────────
echo.
set /p del_choice="^> WYBIERZ NUMER DO USUNIECIA: "

if "%del_choice%"=="0" goto menu

if !del_choice! GTR %count% (
    echo [BŁĄD] Nieprawidłowy numer!
    timeout /t 2 >nul
    goto manage_list
)
if !del_choice! LSS 0 (
    echo [BŁĄD] Nieprawidłowy numer!
    timeout /t 2 >nul
    goto manage_list
)

set "to_delete=!file%del_choice%!"

echo.
echo CZY NA PEWNO CHCESZ USUNĄĆ: !to_delete!?
set /p confirm="WPISZ [T] ABY POTWIERDZIĆ: "

if /i "%confirm%"=="T" (
    del /f /q "!PLUGIN_DIR!\!to_delete!"
    echo [SUCCESS] Asset removed.
    timeout /t 2 >nul
    goto manage_list
) else (
    echo [INFO] Anulowano.
    timeout /t 2 >nul
    goto manage_list
)

:: ========================== FUNKCJE INSTALACJI ==========================

:install_servers
cls
echo ^> INITIALIZING REGION_INSTALL...
if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"
curl -L -o "%DEST_DIR%\%FILE_NAME%" "%URL_SERVERS%"
if %ERRORLEVEL% EQU 0 (
    echo ^> DATA_STREAM: %FILE_NAME% -- [SUCCESS]
) else (
    echo [ERROR] DOWNLOAD_FAILED
)
pause
goto local_menu

:install_cosmetics
set "TARGET_MOD=AUnlocker.dll"
set "TARGET_URL=%URL_AUNLOCKER%"
set "MOD_NAME=AUnlocker (Cosmetics)"
goto universal_installer

:install_tohe
set "TARGET_MOD=TOHE.dll"
set "TARGET_URL=%URL_TOHE%"
set "MOD_NAME=Town Of Host Enhanced"
goto universal_installer

:universal_installer
cls
echo ^> INITIATING %MOD_NAME% INSTALLATION...
set /p USER_PATH="^> PODAJ_SCIEZKE_GRY: "
set "USER_PATH=%USER_PATH:"=%"

if not exist "!USER_PATH!\Among Us.exe" (
    echo [ERROR] TARGET_NOT_FOUND: Among Us.exe
    pause
    goto local_menu
)

call :check_bepinex "!USER_PATH!"
set "PLUGIN_DIR=!USER_PATH!\BepInEx\plugins"
if not exist "!PLUGIN_DIR!" mkdir "!PLUGIN_DIR!"

echo ^> DOWNLOADING %TARGET_MOD%...
curl -L "%TARGET_URL%" -o "%PLUGIN_DIR%\%TARGET_MOD%"

if %ERRORLEVEL% EQU 0 (
    echo ^> PROTOCOL_COMPLETE: %MOD_NAME% ACTIVE
) else (
    echo [ERROR] DLL_TRANSFER_FAILED
)
pause
goto local_menu

:install_mira
cls
echo ^> INITIATING TOWN_OF_US_MIRA INSTALLATION...
set /p USER_PATH="^> PODAJ_SCIEZKE_GRY: "
set "USER_PATH=%USER_PATH:"=%"

if not exist "!USER_PATH!\Among Us.exe" (
    echo [ERROR] TARGET_NOT_FOUND: Among Us.exe
    pause
    goto mod_menu
)

call :check_bepinex "!USER_PATH!"
set "PLUGIN_DIR=!USER_PATH!\BepInEx\plugins"
if not exist "!PLUGIN_DIR!" mkdir "!PLUGIN_DIR!"

echo ^> DOWNLOADING ASSETS...
curl -L "https://amongus.igornowakowski.pl/files/mods/mira/Mini.RegionInstall.dll" -o "!PLUGIN_DIR!\Mini.RegionInstall.dll"
curl -L "https://amongus.igornowakowski.pl/files/mods/mira/MiraAPI.dll" -o "!PLUGIN_DIR!\MiraAPI.dll"
curl -L "https://amongus.igornowakowski.pl/files/mods/mira/Reactor.dll" -o "!PLUGIN_DIR!\Reactor.dll"
curl -L "https://amongus.igornowakowski.pl/files/mods/mira/TownOfUsMira.dll" -o "!PLUGIN_DIR!\TownOfUsMira.dll"
curl -L "https://amongus.igornowakowski.pl/files/mods/mira/touhats.bundle" -o "!PLUGIN_DIR!\touhats.bundle"
curl -L "https://amongus.igornowakowski.pl/files/mods/mira/touhats.catalog" -o "!PLUGIN_DIR!\touhats.catalog"

echo.
echo ^> PROTOCOL_COMPLETE: MIRA_MODS_ACTIVE
pause
goto mod_menu

:install_level_impostor
cls
echo ^> INITIATING LEVEL_IMPOSTOR INSTALLATION...
set /p USER_PATH="^> PODAJ_SCIEZKE_GRY: "
set "USER_PATH=%USER_PATH:"=%"

if not exist "!USER_PATH!\Among Us.exe" (
    echo [ERROR] TARGET_NOT_FOUND: Among Us.exe
    pause
    goto mod_menu
)

call :check_bepinex "!USER_PATH!"
set "PLUGIN_DIR=!USER_PATH!\BepInEx\plugins"
if not exist "!PLUGIN_DIR!" mkdir "!PLUGIN_DIR!"

echo ^> DOWNLOADING CORE DLL...
curl -L "https://amongus.igornowakowski.pl/files/mods/levelimpostor/LevelImpostor.dll" -o "!PLUGIN_DIR!\LevelImpostor.dll"
curl -L "https://amongus.igornowakowski.pl/files/mods/levelimpostor/Reactor.dll" -o "!PLUGIN_DIR!\Reactor.dll"

echo.
echo ^> PROTOCOL_COMPLETE: LEVEL_IMPOSTOR ACTIVE
pause
goto mod_menu

:: ================================= FUNKCJE POMOCNICZE =================================

:check_bepinex
set "TARGET_GAME_DIR=%~1"
if exist "%TARGET_GAME_DIR%\winhttp.dll" (
    echo [ INFO ] BEPINEX_KERNEL: DETECTED
    exit /b
)
echo ^> DOWNLOADING BEPINEX_ENGINE...
curl -L "%BEP_URL%" -o "%TARGET_GAME_DIR%\bepinex_temp.zip"
tar -xf "%TARGET_GAME_DIR%\bepinex_temp.zip" -C "%TARGET_GAME_DIR%"
del /f /q "%TARGET_GAME_DIR%\bepinex_temp.zip"
exit /b

:: ================================= Sekcja VANILLA =================================

:clean
cls
echo ^> INITIATING VANILLA_RESTORE...
set /p USER_PATH="^> PODAJ_SCIEZKE_GRY: "
set "USER_PATH=%USER_PATH:"=%"

if not exist "%USER_PATH%\Among Us.exe" (
    echo [ERROR] Błędna ścieżka!
    pause
    goto menu
)

echo ^> PURGING MOD_FILES...
if exist "%USER_PATH%\BepInEx" rd /s /q "%USER_PATH%\BepInEx"
if exist "%USER_PATH%\dotnet" rd /s /q "%USER_PATH%\dotnet"
if exist "%USER_PATH%\mono" rd /s /q "%USER_PATH%\mono"
if exist "%USER_PATH%\TOHE-DATA" rd /s /q "%USER_PATH%\TOHE-DATA"
if exist "%USER_PATH%\doorstop_config.ini" del /f /q "%USER_PATH%\doorstop_config.ini"
if exist "%USER_PATH%\winhttp.dll" del /f /q "%USER_PATH%\winhttp.dll"
if exist "%USER_PATH%\.doorstop_version" del /f /q "%USER_PATH%\.doorstop_version"

if exist "%DEST_DIR%\%FILE_NAME%" del /f /q "%DEST_DIR%\%FILE_NAME%"

echo.
echo ^> SYSTEM_CLEAN: REVERSION COMPLETE
pause
goto menu

:: ==============================================================================
::                          SYSTEM AUTO-AKTUALIZACJI
:: ==============================================================================
:update_script
cls
echo ^> INITIATING KERNEL_UPDATE...
echo [1/3] Downloading latest .bat...

if "!URL_UPDATE!"=="" (
    echo [ERROR] UPDATE_LINK_MISSING
    pause
    goto menu
)

curl -L -f -s "!URL_UPDATE!" -o "%~dp0update_new.tmp"

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] TRANSFER_FAILED
    pause
    goto menu
)

echo [2/3] Creating patcher...

(
    echo @echo off
    echo echo Czekam na zamkniecie glownego okna...
    echo timeout /t 2 /nobreak ^>nul
    echo del /f /q "%~f0"
    echo ren "%~dp0update_new.tmp" "%~nx0"
    echo echo [SUCCESS] Update complete!
    echo start "" "%~f0"
    echo del "%%~f0"
) > "%temp%\aries_patcher.bat"

echo [3/3] Restarting session...
start "" "%temp%\aries_patcher.bat"
exit
