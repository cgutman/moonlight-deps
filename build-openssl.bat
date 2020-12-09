rem Install NASM and add Strawberry Perl to PATH (Git's Perl won't work)
choco install nasm -y
set PATH=C:\Strawberry\perl\bin;%ProgramFiles%\NASM;%PATH%

cd ..\openssl

rem Build OpenSSL
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" %2
perl Configure %3
nmake

rem Copy DLLs, LIBs, and PDBs
mkdir ..\build\openssl\build_%1
copy libcrypto.lib ..\build\openssl\build_%1
copy libssl.lib ..\build\openssl\build_%1
copy lib*.dll ..\build\openssl\build_%1
copy lib*.pdb ..\build\openssl\build_%1

rem Clean up in-tree build
git reset --hard
git clean -f -d -x -e NUL