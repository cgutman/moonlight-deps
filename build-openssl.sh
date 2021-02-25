#!/bin/bash
set -e
pushd ../openssl

# Build OpenSSL
mkdir ../build/openssl/build_$1
./Configure --prefix=$PWD/../build/openssl/build_$1 --openssldir=$PWD/../build/openssl/build_$1 $2 -mmacosx-version-min=10.13 no-tests
make -j$(sysctl -n hw.ncpu)
make install_sw

# Clean up in-tree build
git reset --hard
git clean -f -d -x
popd