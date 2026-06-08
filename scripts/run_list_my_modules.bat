@echo off
setlocal

REM Match console to the DB legacy ANSI codepage so Turkish chars render right.
REM 1254 = Windows Turkish (ANSI). Use 65001 instead if the DB is Unicode/UTF-8.
chcp 1254 >nul

REM ---- EDIT THESE -----------------------------------------------------------
set "DOORS_BIN=C:\Program Files (x86)\IBM\Rational\DOORS\9.7\bin"
set "DOORS_DATA=36677@YOUR_SERVER"
set "DOORS_USER=kerem"
set "DOORS_PASS=YOUR_PASSWORD"
set "DXL_SCRIPT=C:\dxl\list_my_modules.dxl"
set "DOORS_MODULE_LIST=C:\temp\my_modules.txt"
REM ---------------------------------------------------------------------------

if not exist "C:\temp" mkdir "C:\temp"

"%DOORS_BIN%\doors.exe" -data "%DOORS_DATA%" -u "%DOORS_USER%" -P "%DOORS_PASS%" ^
  -b "%DXL_SCRIPT%" -W

echo.
echo ===== Accessible modules =====
if exist "%DOORS_MODULE_LIST%" (
    type "%DOORS_MODULE_LIST%"
) else (
    echo No output file produced - check credentials, -data value, and DXL path.
)
endlocal
