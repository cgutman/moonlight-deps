# Our MSYS command drops us in a random folder. Reorient ourselves based on this script directory.
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
OUTDIR="$SCRIPTPATH/build/libplacebo/build_$1"
cd $SCRIPTPATH/libplacebo

if [ "$1" = "x64" ]; then
    MINGW_ENV="mingw-w64-clang-x86_64"
elif [ "$1" = "arm64" ]; then
    MINGW_ENV="mingw-w64-clang-aarch64"
else
    echo Missing architecture parameter
    exit 1
fi

pacman --noconfirm --needed -S $MINGW_ENV-cmake $MINGW_ENV-cc $MINGW_ENV-meson $MINGW_ENV-python-glad $MINGW_ENV-python-jinja $MINGW_ENV-vulkan $MINGW_ENV-fast_float $MINGW_ENV-glslang $MINGW_ENV-tools

LDFLAGS="-static-libstdc++ -Wl,-Bstatic -Wl,--pdb=libplacebo.pdb" CFLAGS="-gcodeview" CC=clang CXX=clang++ meson setup --prefix=$OUTDIR -Ddefault_library=shared -Dbuildtype=debugoptimized -Ddemos=false -Dtests=false -Dopengl=disabled -Dd3d11=disabled -Dvulkan=enabled -Dvk-proc-addr=disabled -Dxxhash=disabled -Dshaderc=disabled --prefer-static build
ninja -C build
ninja -C build install

# Copy the PDB out of the in-tree build location
cp -f build/libplacebo.pdb "$OUTDIR/bin"

# This build was in-tree, so clean it up
git reset --hard
git clean -f -d -x