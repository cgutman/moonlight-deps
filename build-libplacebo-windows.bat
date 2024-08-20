rem ARM64 is not supported for cross-compilation
if /I "%1"=="arm64" if /I not "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    echo Cross-compiling libplacebo for ARM64 is not supported on x64
    exit /b 0
)

rem Build the DLL
C:\msys64\usr\bin\env.exe MSYSTEM=%2 C:\msys64\usr\bin\bash -l /c/projects/moonlight-deps/build-libplacebo-windows.sh %1

rem Create the def file
C:\msys64\usr\bin\env.exe MSYSTEM=%2 C:\msys64\usr\bin\bash -l /c/projects/moonlight-deps/create-libplacebo-def.sh %1

rem Create the import library
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64
lib.exe /machine:%1 /def:libplacebo\build_%1\bin\libplacebo.def /out:libplacebo\build_%1\bin\libplacebo.lib

rem Strip debug data into a separate PDB
for %%f in (libplacebo\build_%1\bin\*.dll) do ..\tools\cv2pdb.exe %%f