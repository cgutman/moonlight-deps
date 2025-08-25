set REPO_PATH=..\..\..\dav1d

set COMMON_OPTIONS=-Ddefault_library=shared -Dbuildtype=debugoptimized -Denable_tools=false -Denable_tests=false

rem x86 and x64 use NASM for assembly
set PATH=%ProgramFiles%\NASM;%PATH%

rem ARM64 uses gas-preprocessor.pl for assembly
mkdir %TEMP%\gas
curl https://raw.githubusercontent.com/FFmpeg/gas-preprocessor/master/gas-preprocessor.pl -o %TEMP%\gas\gas-preprocessor.pl
set PATH=%TEMP%\gas;%PATH%

rem Enable security mitigations
set CFLAGS=%CFLAGS% /guard:cf /guard:ehcont
set CXXFLAGS=%CXXFLAGS% /guard:cf /guard:ehcont
set LDFLAGS=%LDFLAGS% /guard:cf /guard:ehcont
if /I "%1" NEQ "ARM64" (
    set LDFLAGS=%LDFLAGS% /CETCOMPAT
)

mkdir build_%1
cd build_%1
meson setup %REPO_PATH% --prefix=%CD%\..\install_%1 %COMMON_OPTIONS%
meson compile
meson install
cd ..