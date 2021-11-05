set REPO_PATH=..\..\..\SDL

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set LDFLAGS=/DEBUG

mkdir build_x86
cd build_x86
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DSDL_LIBC=ON -A Win32 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_x64
cd build_x64
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DSDL_LIBC=ON -A x64 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_arm64
cd build_arm64
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DSDL_LIBC=ON -A ARM64 %REPO_PATH%
cmake --build . --config Release -v
cd ..