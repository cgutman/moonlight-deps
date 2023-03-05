#!/bin/bash
set -e

mkdir output
mkdir output/include
mkdir output/lib
mkdir output/Frameworks

cp opus/include/*.h output/include
cp discord-rpc/include/*.h output/include
cp -R build/openssl/build_x64/include/* output/include
cp -R build/FFmpeg/build_x64/include/* output/include

lipo build/opus/build_*/libopus.a -create -o output/lib/libopus.a
lipo build/discord-rpc/build_*/src/libdiscord-rpc.a -create -o output/lib/libdiscord-rpc.a
lipo build/openssl/build_*/lib/libssl.a -create -o output/lib/libssl.a
lipo build/openssl/build_*/lib/libcrypto.a -create -o output/lib/libcrypto.a
lipo build/FFmpeg/build_*/lib/libavcodec.60.dylib -create -o output/lib/libavcodec.60.dylib
lipo build/FFmpeg/build_*/lib/libavutil.58.dylib -create -o output/lib/libavutil.58.dylib

cp -R build/SDL/ output/Frameworks/

lipo -info output/lib/*
lipo -info output/Frameworks/SDL2.framework/SDL2

7z a macos.zip ./output/*