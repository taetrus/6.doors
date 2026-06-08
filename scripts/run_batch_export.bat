@echo off
setlocal
chcp 1254 >nul

REM ---- EDIT THESE -----------------------------------------------------------
set "DOORS_BIN=C:\Program Files (x86)\IBM\Rational\DOORS\9.7\bin"
set "DOORS_DATA=36677@YOUR_SERVER"
set "DOORS_USER=kerem"
set "DOORS_PASS=YOUR_PASSWORD"
set "DXL_SCRIPT=C:\dxl\batch_export.dxl"
set "DOORS_MODULE=/MyProject/Requirements/Functional Requirements"
set "DOORS_OUT_CSV=C:\temp\doors_export.csv"
set "DOORS_LOG=C:\temp\doors_batch.log"
REM ---------------------------------------------------------------------------

if not exist "C:\temp" mkdir "C:\temp"

"%DOORS_BIN%\doors.exe" -data "%DOORS_DATA%" -u "%DOORS_USER%" -P "%DOORS_PASS%" ^
  -b "%DXL_SCRIPT%" -W

echo.
echo ===== Run log =====
if exist "%DOORS_LOG%" ( type "%DOORS_LOG%" ) else ( echo No log produced. )
endlocal
