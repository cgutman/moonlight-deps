#!/bin/bash
set -e

mkdir output
mkdir output/include
mkdir output/lib

cp opus-$OPUS_VERSION/include/*.h output/include
cp opus-$OPUS_VERSION/.libs/*.a output/lib

cp Ne10/build/modules/*.a output/lib

7z a steamlink.zip ./output/*