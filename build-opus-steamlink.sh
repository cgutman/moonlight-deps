source $STEAMLINK_SDK_PATH/setenv.sh

# Build Ne10 static library first
pushd Ne10
NE10_DIR=$(pwd)
mkdir build && pushd build
export NE10_LINUX_TARGET_ARCH=armv7
cmake -DGNULINUX_PLATFORM=ON -DCMAKE_C_FLAGS="-fPIC" ..
make -j$(nproc)
popd
popd

# Build Opus and link against Ne10
OPUS_INSTALL_DIR=$(pwd)/build
wget https://github.com/xiph/opus/releases/download/v$OPUS_VERSION/opus-$OPUS_VERSION.tar.gz
tar xvf opus-$OPUS_VERSION.tar.gz
pushd opus-$OPUS_VERSION
./configure --prefix=$OPUS_INSTALL_DIR --enable-fixed-point --disable-doc --disable-extra-programs --with-NE10-libraries=$NE10_DIR/build/modules --with-NE10-includes=$NE10_DIR/inc --host=armv7l-unknown-linux-gnueabihf
make -j$(nproc)
popd