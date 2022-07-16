set REPO_PATH=..\..\..\SDL_ttf

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set LDFLAGS=/DEBUG

rem Checkout vendored dependencies in the external folder
pushd ..\..\SDL_ttf
git submodule update --init
popd

mkdir build_x86
cd build_x86
set CMAKE_PREFIX_PATH=..\..\SDL\install_x86
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DSDL2TTF_SAMPLES=OFF -A Win32 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_x64
cd build_x64
set CMAKE_PREFIX_PATH=..\..\SDL\install_x64
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DSDL2TTF_SAMPLES=OFF -A x64 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_arm64
cd build_arm64
set CMAKE_PREFIX_PATH=..\..\SDL\install_arm64
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DSDL2TTF_SAMPLES=OFF -A ARM64 %REPO_PATH%
cmake --build . --config Release -v
cd ..