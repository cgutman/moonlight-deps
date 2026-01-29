set REPO_PATH=..\..\..\SDL

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set CFLAGS=/O2 /DNDEBUG /Zi /Gy
set LDFLAGS=/DEBUG:FULL /OPT:REF /OPT:ICF

rem Enable security mitigations
set CFLAGS=%CFLAGS% /guard:cf /guard:ehcont
set CXXFLAGS=%CXXFLAGS% /guard:cf /guard:ehcont
set LDFLAGS=%LDFLAGS% /guard:cf /guard:ehcont
if /I "%1" NEQ "ARM64" (
    set LDFLAGS=%LDFLAGS% /CETCOMPAT
)

mkdir build_%1
cd build_%1
cmake %CMAKE_ARGS% -DSDL_LIBC=ON -DSDL_INSTALL_DOCS=OFF -DSDL_TEST_LIBRARY=OFF -A %2 %REPO_PATH%
cmake --build . --config Release -v -j
cmake --install . --prefix ..\install_%1 --config Release -v
cd ..