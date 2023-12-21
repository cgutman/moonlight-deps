# Our MSYS command drops us in a random folder. Reorient ourselves based on this script directory.
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
OUTDIR="$SCRIPTPATH/build/libplacebo/build_$1"
cd $SCRIPTPATH/libplacebo

# Generate the def file and copy it next to the DLL
gendef $OUTDIR/bin/*.dll
mv libplacebo*.def $OUTDIR/bin/libplacebo.def