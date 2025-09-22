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
lipo build/openssl/build_*/lib/libssl.3.dylib -create -o output/lib/libssl.3.dylib
lipo build/openssl/build_*/lib/libcrypto.3.dylib -create -o output/lib/libcrypto.3.dylib
lipo build/FFmpeg/build_*/lib/libavcodec.62.dylib -create -o output/lib/libavcodec.62.dylib
lipo build/FFmpeg/build_*/lib/libavutil.60.dylib -create -o output/lib/libavutil.60.dylib
lipo build/FFmpeg/build_*/lib/libswscale.9.dylib -create -o output/lib/libswscale.9.dylib

cp -R build/SDL/ output/Frameworks/

lipo -info output/lib/*
lipo -info output/Frameworks/SDL2.framework/SDL2

7z a macos.zip ./output/*