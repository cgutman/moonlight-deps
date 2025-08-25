set REPO_PATH=..\..\..\discord-rpc

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
cmake %CMAKE_ARGS% -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DBUILD_SHARED_LIBS=ON -A %2 %REPO_PATH%
cmake --build . --config Release -v
cd ..