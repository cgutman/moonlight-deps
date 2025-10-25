rem Add Strawberry Perl to PATH (Git's Perl won't work)
set PATH=C:\Strawberry\perl\bin;%PATH%

cd ..\openssl

rem CFLAGS/ASFLAGS/LDFLAGS overrides the defaults, so we must include them too
set CFLAGS_OVR=/W3 /wd4090 /nologo
set ASFLAGS_OVR=/nologo /Zi
set LDFLAGS_OVR=/nologo /debug

rem We need to use /FS to avoid PDB writing races with jom
set CFLAGS_OVR=%CFLAGS_OVR% /FS

rem Enable security mitigations
set CFLAGS_OVR=%CFLAGS_OVR% /guard:cf /guard:ehcont
set ASFLAGS_OVR=%ASFLAGS_OVR% /guard:cf /guard:ehcont
set LDFLAGS_OVR=%LDFLAGS_OVR% /guard:cf /guard:ehcont
if /I "%1" NEQ "ARM64" (
    set LDFLAGS_OVR=%LDFLAGS_OVR% /CETCOMPAT
)

rem Build OpenSSL
mkdir ..\build\openssl\build_%1
perl Configure CFLAGS="%CFLAGS_OVR%" ASFLAGS="%ASFLAGS_OVR%" LDFLAGS="%LDFLAGS_OVR%" --prefix=%CD%\..\build\openssl\build_%1 --openssldir=%CD%\..\build\openssl\build_%1 %2 no-tests no-engine no-apps no-legacy no-dso
jom
nmake install_sw

rem Clean up in-tree build
git reset --hard
git clean -f -d -x -e NUL