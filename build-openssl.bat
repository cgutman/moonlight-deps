rem Add Strawberry Perl and NASM to PATH (Git's Perl won't work)
set PATH=C:\Strawberry\perl\bin;%ProgramFiles%\NASM;%PATH%

cd ..\openssl

rem Build OpenSSL
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" %2
mkdir ..\build\openssl\build_%1
perl Configure --prefix=%CD%\..\build\openssl\build_%1 --openssldir=%CD%\..\build\openssl\build_%1 %3 no-tests
nmake
nmake install_sw

rem Clean up in-tree build
git reset --hard
git clean -f -d -x -e NUL