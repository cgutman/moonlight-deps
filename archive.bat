mkdir output
mkdir output\include
mkdir output\lib

copy opus\include\*.h output\include
copy discord-rpc\include\*.h output\include
xcopy /e /y build\openssl\build_x64\include output\include
xcopy /e /y build\FFmpeg\build_x64\include output\include

for %%i in (x86 x64 arm64) do (
    mkdir output\lib\%%i

    copy build\opus\build_%%i\Release\* output\lib\%%i
    copy build\discord-rpc\build_%%i\src\Release\* output\lib\%%i
    copy build\FFmpeg\build_%%i\bin\* output\lib\%%i
    copy build\openssl\build_%%i\lib\*.lib output\lib\%%i
    copy build\openssl\build_%%i\bin\lib*.dll output\lib\%%i
    copy build\openssl\build_%%i\bin\lib*.pdb output\lib\%%i
)

7z a windows.zip .\output\*