mkdir output || exit /b 1
mkdir output\include || exit /b 1
mkdir output\lib || exit /b 1

copy opus\include\*.h output\include || exit /b 1
copy discord-rpc\include\*.h output\include || exit /b 1
copy Detours\include\*.h output\include || exit /b 1

xcopy /e /q Vulkan-Headers\include output\include || exit /b 1

mkdir output\include\%1 || exit /b 1
mkdir output\lib\%1 || exit /b 1

xcopy /e /q build\SDL\install_%1\include output\include\%1 || exit /b 1
xcopy /e /q build\sdl2-compat\install_%1\include output\include\%1 || exit /b 1
xcopy /e /q build\SDL_ttf\install_%1\include output\include\%1 || exit /b 1
xcopy /e /q build\openssl\build_%1\include output\include\%1 || exit /b 1
xcopy /e /q build\FFmpeg\build_%1\include output\include\%1 || exit /b 1
xcopy /e /q build\libplacebo\build_%1\include output\include\%1 || exit /b 1

copy build\opus\build_%1\Release\* output\lib\%1 || exit /b 1
copy build\discord-rpc\build_%1\src\Release\* output\lib\%1 || exit /b 1
copy build\SDL\build_%1\Release\* output\lib\%1 || exit /b 1
copy build\sdl2-compat\build_%1\Release\* output\lib\%1 || exit /b 1
copy build\SDL_ttf\build_%1\Release\* output\lib\%1 || exit /b 1
copy build\dav1d\install_%1\bin\* output\lib\%1 || exit /b 1
copy build\dav1d\install_%1\lib\*.lib output\lib\%1 || exit /b 1
copy build\FFmpeg\build_%1\bin\* output\lib\%1 || exit /b 1
copy build\libplacebo\build_%1\bin\*.dll output\lib\%1 || exit /b 1
copy build\libplacebo\build_%1\bin\*.pdb output\lib\%1 || exit /b 1
copy build\libplacebo\build_%1\lib\*.lib output\lib\%1 || exit /b 1
copy build\openssl\build_%1\lib\*.lib output\lib\%1 || exit /b 1
copy build\openssl\build_%1\bin\lib*.dll output\lib\%1 || exit /b 1
copy build\openssl\build_%1\bin\lib*.pdb output\lib\%1 || exit /b 1
copy Detours\lib.%1\detours.* output\lib\%1 || exit /b 1
