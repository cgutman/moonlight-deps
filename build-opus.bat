set REPO_PATH=..\..\..\opus

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set CFLAGS=/O2 /DNDEBUG /Zi /Gy
set LDFLAGS=/DEBUG:FULL /OPT:REF /OPT:ICF

mkdir build_x86
cd build_x86
cmake %CMAKE_ARGS% -DOPUS_BUILD_SHARED_LIBRARY=ON -A Win32 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_x64
cd build_x64
cmake %CMAKE_ARGS% -DOPUS_BUILD_SHARED_LIBRARY=ON -A x64 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_arm64
cd build_arm64
cmake %CMAKE_ARGS% -DOPUS_BUILD_SHARED_LIBRARY=ON -A ARM64 %REPO_PATH%
cmake --build . --config Release -v
cd ..