set REPO_PATH=..\..\..\dav1d

rem Find Visual Studio and run vcvarsall.bat
for /f "usebackq delims=" %%i in (`..\..\tools\vswhere.exe -latest -property installationPath`) do (
    set VSPATH=%%i
)

set COMMON_OPTIONS=-Ddefault_library=shared -Dbuildtype=debugoptimized -Denable_tools=false -Denable_tests=false

rem x86 and x64 use NASM for assembly
set PATH=%ProgramFiles%\NASM;%PATH%

mkdir build_x86
cd build_x86
setlocal
call "%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat" amd64_x86
meson setup %REPO_PATH% --prefix=%CD%\..\install_x86 --cross-file=%REPO_PATH%\..\meson-crossfiles\msvc-amd64-x86.txt %COMMON_OPTIONS%
meson compile
meson install
endlocal
cd ..

mkdir build_x64
cd build_x64
setlocal
call "%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat" amd64
meson setup %REPO_PATH% --prefix=%CD%\..\install_x64 %COMMON_OPTIONS%
meson compile
meson install
endlocal
cd ..

rem ARM64 uses gas-preprocessor.pl for assembly
mkdir %TEMP%\gas
curl https://raw.githubusercontent.com/FFmpeg/gas-preprocessor/master/gas-preprocessor.pl -o %TEMP%\gas\gas-preprocessor.pl
set PATH=%TEMP%\gas;%PATH%

mkdir build_arm64
cd build_arm64
setlocal
call "%VSPATH%\VC\Auxiliary\Build\vcvarsall.bat" amd64_arm64
meson setup %REPO_PATH% --prefix=%CD%\..\install_arm64 --cross-file=%REPO_PATH%\..\meson-crossfiles\msvc-amd64-arm64.txt %COMMON_OPTIONS%
meson compile
meson install
endlocal
cd ..