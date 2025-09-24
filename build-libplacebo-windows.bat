setlocal

rem Build using the CL frontend for Clang
set CC=clang-cl
set CXX=clang-cl

set OUTDIR=%CD%\..\build\libplacebo\build_%1
mkdir %OUTDIR%

rem Apply the patch required to build
git apply ..\patches\libplacebo_shaderc_win.patch

rem Add the Vulkan SDK to the library and include path
set "LIB=%LIB%;%VULKAN_SDK%\Lib"
set "INCLUDE=%INCLUDE%;%VULKAN_SDK%\Include"

meson setup --prefix=%OUTDIR% -Ddefault_library=shared -Dbuildtype=debugoptimized -Ddemos=false -Dtests=false -Dopengl=disabled -Dd3d11=disabled -Dvulkan=enabled -Dvk-proc-addr=disabled -Dxxhash=disabled -Dshaderc=enabled build
ninja -C build
ninja -C build install

rem This build was in-tree, so clean it up
git reset --hard
git clean -f -d -x
