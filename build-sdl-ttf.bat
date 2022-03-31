set REPO_PATH=..\..\..\SDL_ttf

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set LDFLAGS=/DEBUG
set OLD_LIB=%LIB%
set FREETYPE_DIR=%CD%\..\..\freetype

mkdir build_x86
cd build_x86
set CMAKE_PREFIX_PATH=..\..\SDL\install_x86
set LIB=%CD%\..\..\..\freetype\objs\Win32\Release;%OLD_LIB%
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -A Win32 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_x64
cd build_x64
set CMAKE_PREFIX_PATH=..\..\SDL\install_x64
set LIB=%CD%\..\..\..\freetype\objs\x64\Release;%OLD_LIB%
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -A x64 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_arm64
cd build_arm64
set CMAKE_PREFIX_PATH=..\..\SDL\install_arm64
set LIB=%CD%\..\..\..\freetype\objs\arm64\Release;%OLD_LIB%
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -A ARM64 %REPO_PATH%
cmake --build . --config Release -v
cd ..