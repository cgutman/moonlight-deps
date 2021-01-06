#!/bin/bash
set -e

# Build SDL.framework
OUTPUT_DIR=`pwd`
pushd ../../SDL/Xcode/SDL
pwd
xcodebuild -project SDL.xcodeproj -scheme Framework -configuration Release -sdk macosx CONFIGURATION_BUILD_DIR=$OUTPUT_DIR
popd