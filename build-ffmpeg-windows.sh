mkdir build_x86
./configure --target-os=win32 --toolchain=msvc --enable-cross-compile --enable-pic --enable-shared --disable-static --disable-all --enable-avcodec --enable-decoder=h264 --enable-decoder=hevc --enable-hwaccel=h264_dxva2 --enable-hwaccel=hevc_dxva2 --enable-hwaccel=h264_d3d11va --enable-hwaccel=hevc_d3d11va --enable-hwaccel=h264_d3d11va2 --enable-hwaccel=hevc_d3d11va2
make clean
make -j4
cd ..

mkdir build_x64
./configure --target-os=win64 --arch=x86_64 --toolchain=msvc --enable-pic --enable-shared --disable-static --disable-all --enable-avcodec --enable-decoder=h264 --enable-decoder=hevc --enable-hwaccel=h264_dxva2 --enable-hwaccel=hevc_dxva2 --enable-hwaccel=h264_d3d11va --enable-hwaccel=hevc_d3d11va --enable-hwaccel=h264_d3d11va2 --enable-hwaccel=hevc_d3d11va2
make clean
make -j4
cd ..

mkdir build_x64
./configure --target-os=win64 --arch=arm64 --toolchain=msvc --enable-pic --enable-shared --disable-static --disable-all --enable-avcodec --enable-decoder=h264 --enable-decoder=hevc --enable-hwaccel=h264_dxva2 --enable-hwaccel=hevc_dxva2 --enable-hwaccel=h264_d3d11va --enable-hwaccel=hevc_d3d11va --enable-hwaccel=h264_d3d11va2 --enable-hwaccel=hevc_d3d11va2
make clean
make -j4
cd ..