mkdir output
mkdir output\include
mkdir output\lib

copy opus\include\*.h output\include
copy discord-rpc\include\*.h output\include
copy Detours\include\*.h output\include
copy SDL_ttf\*.h output\include

for %%i in (x86 x64 arm64) do (
    mkdir output\include\%%i
    mkdir output\lib\%%i

    copy SDL\include\*.h output\include\%%i
    copy /y build\SDL\build_%%i\include\* output\include\%%i
    xcopy /e build\openssl\build_%%i\include output\include\%%i
    xcopy /e build\FFmpeg\build_%%i\include output\include\%%i

    copy build\opus\build_%%i\Release\* output\lib\%%i
    copy build\discord-rpc\build_%%i\src\Release\* output\lib\%%i
    copy build\SDL\build_%%i\Release\* output\lib\%%i
    copy build\SDL_ttf\build_%%i\Release\* output\lib\%%i
    copy build\FFmpeg\build_%%i\bin\* output\lib\%%i
    copy build\openssl\build_%%i\lib\*.lib output\lib\%%i
    copy build\openssl\build_%%i\bin\lib*.dll output\lib\%%i
    copy build\openssl\build_%%i\bin\lib*.pdb output\lib\%%i
    copy Detours\lib.%%i\detours.* output\lib\%%i

    if /I "%%i" EQU "x86" (
        copy freetype\objs\Win32\Release\freetype.dll output\lib\%%i
    ) else (
        copy freetype\objs\%%i\Release\freetype.dll output\lib\%%i
    )
)

7z a windows.zip .\output\*