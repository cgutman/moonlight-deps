rem Add Strawberry Perl and NASM to PATH (Git's Perl won't work)
set PATH=C:\Strawberry\perl\bin;%ProgramFiles%\NASM;%PATH%

cd ..\openssl

rem Enable security mitigations
if /I "%1" NEQ "ARM64" (
    set LDFLAGS=%LDFLAGS% /CETCOMPAT
)

rem Build OpenSSL (/FS is a CL.exe argument to avoid PDB concurrency issues with jom)
mkdir ..\build\openssl\build_%1
perl Configure --prefix=%CD%\..\build\openssl\build_%1 --openssldir=%CD%\..\build\openssl\build_%1 %2 no-tests no-engine no-apps no-legacy no-dso /FS
jom
nmake install_sw

rem Clean up in-tree build
git reset --hard
git clean -f -d -x -e NUL