#!/bin/bash
set -e

pushd ../FFmpeg

# Apply our FFmpeg patch for macOS
git apply ../patches/ffmpeg_no_ogl_vt.patch

# Build FFmpeg
mkdir ../build/FFmpeg/build_$1
./configure --prefix=$PWD/../build/FFmpeg/build_$1 --extra-cflags="-mmacosx-version-min=10.13 -arch $2 --target=$2-apple-macosx" --extra-ldflags="-mmacosx-version-min=10.13 -arch $2" --cc=clang --arch=$2 --enable-cross-compile --install-name-dir=@loader_path/../Frameworks --enable-pic --enable-shared --disable-static --disable-all --enable-avcodec --enable-decoder=h264 --enable-decoder=hevc --enable-hwaccel=h264_videotoolbox --enable-hwaccel=hevc_videotoolbox
make -j$(sysctl -n hw.ncpu)
make install

# Clean up in-tree build
git reset --hard
git clean -f -d -x
popd