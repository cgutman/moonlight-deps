#!/bin/bash
set -e
pushd ../openssl

# Build OpenSSL
mkdir ../build/openssl/build_$1
INSTALLPREFIX=$PWD/../build/openssl/build_$1
./Configure --prefix=$INSTALLPREFIX --openssldir=$INSTALLPREFIX $2 -mmacosx-version-min=$MACOS_MIN no-tests no-engine no-apps no-legacy no-dso
make -j$(sysctl -n hw.ncpu)
make install_sw

# Patch the library paths
install_name_tool -id @loader_path/../Frameworks/libcrypto.3.dylib $INSTALLPREFIX/lib/libcrypto.3.dylib
install_name_tool -id @loader_path/../Frameworks/libssl.3.dylib $INSTALLPREFIX/lib/libssl.3.dylib
install_name_tool -change $INSTALLPREFIX/lib/libcrypto.3.dylib @loader_path/../Frameworks/libcrypto.3.dylib $INSTALLPREFIX/lib/libssl.3.dylib

# Clean up in-tree build
git reset --hard
git clean -f -d -x
popd