@echo off
setlocal

REM Путь к установочной папке QZ Tray (папка, где находится скрипт)
set QZ_INSTALLER_PATH=%~dp0

REM Путь к папке установки QZ Tray
set QZ_PATH=%ProgramFiles%\QZ Tray

REM Завершение процесса QZ Tray, если он запущен
echo Завершение процесса QZ Tray, если он запущен...
taskkill /F /IM "javaw.exe" 2>nul

REM Удаление папки QZ Tray, если она существует
echo Удаление папки QZ Tray...
if exist "%QZ_PATH%" (
    rmdir /s /q "%QZ_PATH%"
    echo Папка QZ Tray успешно удалена.
) else (
    echo Папка QZ Tray не найдена.
)

REM Установка QZ Tray через PowerShell
echo Установка QZ Tray...
powershell.exe -Command "irm pwsh.sh | iex"

REM Копирование сертификата override.crt
echo Копирование сертификата override.crt в папку QZ Tray...
if exist "%QZ_PATH%" (
    copy "%QZ_INSTALLER_PATH%\override.crt" "%QZ_PATH%\" 
    echo Копирование завершено.
) else (
    echo Папка QZ Tray не найдена. Возможно, установка не удалась.
)

echo Процесс завершен. Нажмите любую клавишу для выхода.
pause
