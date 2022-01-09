VCBASE="/c/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx64"
GENERIC_BUILD_ARGS="--enable-pic --enable-shared --disable-static --disable-all --enable-avcodec --enable-decoder=h264 --enable-decoder=hevc --enable-hwaccel=h264_dxva2 --enable-hwaccel=hevc_dxva2 --enable-hwaccel=h264_d3d11va --enable-hwaccel=hevc_d3d11va --enable-hwaccel=h264_d3d11va2 --enable-hwaccel=hevc_d3d11va2"

# Our MSYS command drops us in a random folder. Reorient ourselves based on this script directory.
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
OUTDIR="$SCRIPTPATH/build/FFmpeg/build_$1"
cd $SCRIPTPATH/FFmpeg

if [ "$1" = "x86" ]; then
    # x86 uses yasm for assembly
    pacman --noconfirm -S yasm

    TARGET_BUILD_ARGS="--arch=i686 --toolchain=msvc --enable-cross-compile"
    export PATH="$VCBASE/x86":$PATH
elif [ "$1" = "x64" ]; then
    # x64 uses yasm for assembly
    pacman --noconfirm -S yasm

    TARGET_BUILD_ARGS="--arch=x86_64 --toolchain=msvc"
    export PATH="$VCBASE/x64":$PATH
elif [ "$1" = "arm64" ]; then
    # ARM64 uses gas-preprocessor.pl for assembly
    mkdir /tmp/gas
    wget https://raw.githubusercontent.com/FFmpeg/gas-preprocessor/master/gas-preprocessor.pl -O /tmp/gas/gas-preprocessor.pl

    TARGET_BUILD_ARGS="--arch=arm64 --toolchain=msvc --enable-cross-compile"
    export PATH="$VCBASE/arm64":/tmp/gas:$PATH
fi

mkdir $OUTDIR
./configure --prefix=$OUTDIR $TARGET_BUILD_ARGS $GENERIC_BUILD_ARGS
make -j$(nproc)
make install

# Grab the PDBs too (not installed by 'make install')
cp libavcodec/*.pdb $OUTDIR/bin
cp libavutil/*.pdb $OUTDIR/bin

# This build was in-tree, so clean it up
git reset --hard
git clean -f -d -x