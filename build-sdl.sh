#!/bin/bash
set -e

# Build SDL.framework
OUTPUT_DIR=`pwd`
pushd ../../SDL/Xcode/SDL
pwd
xcodebuild -project SDL.xcodeproj -scheme Framework -configuration Release -sdk macosx CONFIGURATION_BUILD_DIR=$OUTPUT_DIR OTHER_CFLAGS="-DSDL_MAC_NO_SANDBOX=1"
popd