set REPO_PATH=..\..\..\opus

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set CFLAGS=/O2 /DNDEBUG /Zi /Gy
set LDFLAGS=/DEBUG:FULL /OPT:REF /OPT:ICF

mkdir build_%1
cd build_%1
cmake %CMAKE_ARGS% -DOPUS_BUILD_SHARED_LIBRARY=ON -A %2 %REPO_PATH%
cmake --build . --config Release -v
cd ..