#!/bin/sh

SDL=$HOME/projects/root/Library/Frameworks/SDL_2.0
BUNDLE=../FreeDroid.app

rm -rf ${BUNDLE}

mkdir -p ${BUNDLE}/Contents/MacOS
mkdir -p ${BUNDLE}/Contents/Resources
mkdir -p ${BUNDLE}/Contents/Frameworks

cat macfiles/Info.plist | sed -e "s/@VERSION@/${1}/" > ${BUNDLE}/Contents/Info.plist
cp macfiles/PkgInfo ../FreeDroid.app/Contents
cp macfiles/FreeDroid.icns ${BUNDLE}/Contents/Resources
cp -a ../sound ${BUNDLE}/Contents/Resources
cp -a ../graphics ${BUNDLE}/Contents/Resources
cp -a ../map ${BUNDLE}/Contents/Resources
cp -a $SDL/SDL2.framework ${BUNDLE}/Contents/Frameworks
cp -a $SDL/SDL2_image.framework ${BUNDLE}/Contents/Frameworks
cp -a $SDL/SDL2_mixer.framework ${BUNDLE}/Contents/Frameworks
cp -a freedroid ${BUNDLE}/Contents/MacOS/FreeDroid

rm -vf ${BUNDLE}/Contents/Frameworks/SDL2.framework/Versions/Current/Headers/SDL2


MACOS_APP_BIN=${BUNDLE}/Contents/MacOS/FreeDroid

for old in `otool -L $MACOS_APP_BIN | grep @rpath | cut -f2 | cut -d' ' -f1`; do
    new=`echo $old | sed -e "s/@rpath/@executable_path\/..\/Frameworks/"`
    echo "Replacing '$old' with '$new'"
    install_name_tool -change $old $new $MACOS_APP_BIN
done

pushd ${BUNDLE}/Contents/Frameworks > /dev/null 2>&1
signframework *
popd > /dev/null 2>&1
sign --options=runtime --entitlements=macfiles/freedroid-Entitlements.plist ${BUNDLE}

VERSION=$(/usr/libexec/PlistBuddy  -c "Print CFBundleGetInfoString" ${BUNDLE}/Contents/Info.plist)

ditto -c -k --keepParent ${BUNDLE} Freedroid-$VERSION.zip