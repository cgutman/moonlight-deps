set DETOURS_TARGET_PROCESSOR=%1

pushd Detours\src || exit /b 1
nmake || exit /b 1
popd