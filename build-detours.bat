set DETOURS_TARGET_PROCESSOR=%1

pushd Detours || exit /b 1

rem Apply the EHCont compatibility patch
git apply ..\patches\detours_ehcont.patch || exit /b 1

pushd src || exit /b 1
nmake || exit /b 1
popd

git reset --hard || exit /b 1
popd