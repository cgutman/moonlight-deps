set REPO_PATH=..\..\..\dav1d

rem Find Visual Studio and run vcvarsall.bat
for /f "usebackq delims=" %%i in (`..\..\tools\vswhere.exe -latest -property installationPath`) do (
    set VSPATH=%%i
)

set COMMON_OPTIONS=-Ddefault_library=shared -Dbuildtype=debugoptimized -Denable_tools=false -Denable_tests=false

rem x86 and x64 use NASM for assembly
set PATH=%ProgramFiles%\NASM;%PATH%

rem ARM64 uses gas-preprocessor.pl for assembly
mkdir %TEMP%\gas
curl https://raw.githubusercontent.com/FFmpeg/gas-preprocessor/master/gas-preprocessor.pl -o %TEMP%\gas\gas-preprocessor.pl
set PATH=%TEMP%\gas;%PATH%

rem Non-x64 builds are cross builds that require a cross file
if /I "%1" NEQ "x64" (
    set COMMON_OPTIONS=%COMMON_OPTIONS% --cross-file=%REPO_PATH%\..\meson-crossfiles\msvc-%2.txt
)

mkdir build_%1
cd build_%1
call "%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat" %2
meson setup %REPO_PATH% --prefix=%CD%\..\install_%1 %COMMON_OPTIONS%
meson compile
meson install
endlocal
cd ..