#!/bin/bash

set -ex

SRC=$(cd "$(dirname "$0")" && pwd)
DST=$(cd "$SRC"/../plugins/2020.3627 && pwd)

: "${ANDROID_NDK:?Android NDK directory is not set}"
(
    cd "$SRC/android"
    rm -rf corona-libs libs obj
    ./build.sh
    rsync -a --exclude '.*' --exclude '_CodeSignature' libs/  "$DST"/android/jniLibs --delete
    cp libs/armeabi-v7a/libplugin.zip.so "$DST"/android/libplugin.zip.so
)


(
    cd "$SRC/ios"
    rm -rf libplugin.zip.a build
    ./build.sh
    cp build/Release-iphoneos/libplugin.zip.a "$DST"/iphone/libplugin.zip.a
    cp build/Release-iphonesimulator/libplugin.zip.a "$DST"/iphone-sim/libplugin.zip.a
)

(
    cd "$SRC/tvos"
    rm -rf  build
    ./build.sh
    rsync -a --exclude '.*' --exclude '_CodeSignature' build/Release-appletvos/Corona_plugin_zip.framework/ "$DST"/appletvos/Corona_plugin_zip.framework --delete
    rsync -a --exclude '.*' --exclude '_CodeSignature' build/Release-appletvsimulator/Corona_plugin_zip.framework/ "$DST"/appletvsimulator/Corona_plugin_zip.framework --delete
)

(
    cd "$SRC/mac"
    rm -rf build plugin_zip.dylib
    ./build.sh
    cp plugin_zip.dylib "$DST"/mac-sim/plugin_zip.dylib
)

echo 'Done!'
