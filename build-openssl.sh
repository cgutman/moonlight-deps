#!/bin/bash
set -e
pushd ../openssl

# Build OpenSSL
mkdir ../build/openssl/build_$1
./Configure --prefix=$PWD/../build/openssl/build_$1 --openssldir=$PWD/../build/openssl/build_x64 $2 -mmacosx-version-min=10.13
make -j$(sysctl -n hw.ncpu)
make install

# Clean up in-tree build
git reset --hard
git clean -f -d -x
popd