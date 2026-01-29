#!/bin/bash
set -e

mkdir output
mkdir output/include
mkdir output/lib

cp opus/include/*.h output/include
cp discord-rpc/include/*.h output/include
cp -R build/openssl/build_x64/include/* output/include
cp -R build/FFmpeg/build_x64/include/* output/include
cp -R build/SDL/install/include/* output/include
cp -R build/sdl2-compat/install/include/* output/include
cp -R build/SDL_ttf/install/include/* output/include

cp build/SDL/install/lib/libSDL3.dylib output/lib/libSDL3.dylib
cp build/sdl2-compat/install/lib/libSDL2.dylib output/lib/libSDL2.dylib
cp build/SDL_ttf/install/lib/libSDL2_ttf.dylib output/lib/libSDL2_ttf.dylib

lipo build/opus/build_*/libopus.a -create -o output/lib/libopus.a
lipo build/discord-rpc/build_*/src/libdiscord-rpc.a -create -o output/lib/libdiscord-rpc.a
lipo build/openssl/build_*/lib/libssl.3.dylib -create -o output/lib/libssl.3.dylib
lipo build/openssl/build_*/lib/libcrypto.3.dylib -create -o output/lib/libcrypto.3.dylib
lipo build/FFmpeg/build_*/lib/libavcodec.62.dylib -create -o output/lib/libavcodec.62.dylib
lipo build/FFmpeg/build_*/lib/libavutil.60.dylib -create -o output/lib/libavutil.60.dylib
lipo build/FFmpeg/build_*/lib/libswscale.9.dylib -create -o output/lib/libswscale.9.dylib

lipo -info output/lib/*

7z a macos.zip ./output/*