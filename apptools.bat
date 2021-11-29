@echo off
setlocal enabledelayedexpansion

set commands[0]=%DART_HOME%\pub run build_runner build
set commands[1]=%FLUTTER_HOME%\flutter packages pub run build_runner build --delete-conflicting-outputs
set commands[2]=%FLUTTER_HOME%\flutter packages pub run build_runner watch
set commands[3]=%FLUTTER_HOME%\flutter pub run flutter_launcher_icons:main
set commands[4]=%FLUTTER_HOME%\flutter pub run flutter_native_splash:create
set commands[5]=%FLUTTER_HOME%\flutter pub run flutter_native_splash:remove
set commands[6]=%FLUTTER_HOME%\flutter build web --web-renderer html
set commands[7]=%FLUTTER_HOME%\flutter run --release --dart-define=APP_ENV=Release

set "count=0"
:SymLoop
if defined commands[%count%] (
   set /a "count+=1"
   GOTO :SymLoop
)
set /a "count-=1"

echo Your DART_HOME: %DART_HOME%
echo Your FLUTTER_HOME: %FLUTTER_HOME%
echo.
echo.
echo Please select a command.
echo ==============================
for /l %%n in (0,1,%count%) do (
   echo %%n^) !commands[%%n]!
)
echo ==============================
echo.
echo.
echo Default selection command
echo !commands[1]!
echo.
echo.
set /p command_id=Enter command id:

if "%command_id%"=="" (
   call !commands[1]!
)
call !commands[%command_id%]!