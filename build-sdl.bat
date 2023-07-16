set REPO_PATH=..\..\..\SDL

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set CFLAGS=/O2 /DNDEBUG /Zi /Gy
set LDFLAGS=/DEBUG:FULL /OPT:REF /OPT:ICF

mkdir build_%1
cd build_%1
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DSDL_LIBC=ON -A %2 %REPO_PATH%
cmake --build . --config Release -v
cmake --install . --prefix ..\install_%1 --config Release -v
cd ..