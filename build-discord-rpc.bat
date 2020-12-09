set REPO_PATH=..\..\..\discord-rpc

mkdir build_x86
cd build_x86
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -A Win32 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_x64
cd build_x64
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -A x64 %REPO_PATH%
cmake --build . --config Release -v
cd ..

mkdir build_arm64
cd build_arm64
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -A ARM64 %REPO_PATH%
cmake --build . --config Release -v
cd ..