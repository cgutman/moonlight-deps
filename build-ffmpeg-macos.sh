#!/bin/bash
set -e

pushd ../FFmpeg

# Apply our FFmpeg patches for macOS
git apply ../patches/ffmpeg_metal_vt.patch

# Build FFmpeg
mkdir ../build/FFmpeg/build_$1
PKG_CONFIG_PATH="/usr/local/lib/pkgconfig" ./configure --prefix=$PWD/../build/FFmpeg/build_$1 --extra-cflags="-mmacosx-version-min=$MACOS_MIN -arch $2 --target=$2-apple-macosx" --extra-ldflags="-mmacosx-version-min=$MACOS_MIN -arch $2" --cc=clang --arch=$2 --enable-cross-compile --install-name-dir=@loader_path/../Frameworks --enable-pic --fatal-warnings --enable-shared --disable-static --disable-all --disable-autodetect --enable-avcodec --enable-swscale --enable-decoder=h264 --enable-decoder=hevc --enable-videotoolbox --enable-hwaccel=h264_videotoolbox --enable-hwaccel=hevc_videotoolbox --enable-hwaccel=av1_videotoolbox --enable-libdav1d --enable-decoder=libdav1d
make -j$(sysctl -n hw.ncpu)
make install

# Clean up in-tree build
git reset --hard
git clean -f -d -x
popd