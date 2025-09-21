rem ARM64 is not supported for cross-compilation
if /I "%1"=="arm64" if /I not "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    echo Cross-compiling libplacebo for ARM64 is not supported on x64
    exit /b 0
)

rem Use the MSYS environment with the correct compiler toolchain
set MSYSTEM=%2

rem Build the DLL
cmd /c msys2 -c "../build-libplacebo-windows.sh %1"

rem Create the def file
cmd /c msys2 -c "../create-libplacebo-def.sh %1"

rem Create the import library
lib.exe /machine:%1 /def:libplacebo\build_%1\bin\libplacebo.def /out:libplacebo\build_%1\bin\libplacebo.lib
