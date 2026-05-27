set REPO_PATH=..\..\..\SDL_ttf

rem Set linker flags to produce PDB with Release build type
rem This is preferable to RelWithDebInfo. See https://gitlab.kitware.com/cmake/cmake/-/issues/20812
set CFLAGS=/O2 /DNDEBUG /Zi /Gy /GL
set CXXFLAGS=/O2 /DNDEBUG /Zi /Gy /GL
set LDFLAGS=/DEBUG:FULL /OPT:REF /OPT:ICF /LTCG

rem Enable security mitigations
set CFLAGS=%CFLAGS% /guard:cf /guard:ehcont
set CXXFLAGS=%CXXFLAGS% /guard:cf /guard:ehcont
set LDFLAGS=%LDFLAGS% /guard:cf /guard:ehcont
if /I "%1" NEQ "ARM64" (
    set LDFLAGS=%LDFLAGS% /CETCOMPAT
)

rem Checkout vendored dependencies in the external folder
pushd ..\..\SDL_ttf || exit /b 1
git submodule update --init || exit /b 1
popd

mkdir build_%1
cd build_%1 || exit /b 1
set CMAKE_PREFIX_PATH=..\..\sdl2-compat\install_%1
cmake %CMAKE_ARGS% -DSDL2TTF_SAMPLES=OFF -DSDL2TTF_VENDORED=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -A %2 %REPO_PATH% || exit /b 1
cmake --build . --config Release -v || exit /b 1
cmake --install . --prefix ..\install_%1 --config Release -v || exit /b 1
cd ..