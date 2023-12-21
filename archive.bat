mkdir output
mkdir output\include
mkdir output\lib

copy opus\include\*.h output\include
copy discord-rpc\include\*.h output\include
copy Detours\include\*.h output\include
copy SDL_ttf\*.h output\include

mkdir output\include\%1
mkdir output\lib\%1

copy build\SDL\install_%1\include\SDL2\* output\include\%1
xcopy /e build\openssl\build_%1\include output\include\%1
xcopy /e build\FFmpeg\build_%1\include output\include\%1
xcopy /e build\libplacebo\build_%1\include output\include\%1

copy build\opus\build_%1\Release\* output\lib\%1
copy build\discord-rpc\build_%1\src\Release\* output\lib\%1
copy build\SDL\build_%1\Release\* output\lib\%1
copy build\SDL_ttf\build_%1\Release\* output\lib\%1
copy build\dav1d\install_%1\bin\* output\lib\%1
copy build\dav1d\install_%1\lib\*.lib output\lib\%1
copy build\FFmpeg\build_%1\bin\* output\lib\%1
copy build\libplacebo\build_%1\bin\*.dll output\lib\%1
copy build\libplacebo\build_%1\bin\*.lib output\lib\%1
copy build\openssl\build_%1\lib\*.lib output\lib\%1
copy build\openssl\build_%1\bin\lib*.dll output\lib\%1
copy build\openssl\build_%1\bin\lib*.pdb output\lib\%1
copy Detours\lib.%1\detours.* output\lib\%1

7z a windows-%1.zip .\output\*