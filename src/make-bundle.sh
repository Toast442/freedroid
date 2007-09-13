#!/bin/sh

cat macfiles/Info.plist | sed -e "s/@VERSION@/${1}/" > ../FreeDroid.app/Contents/Info.plist

cp macfiles/PkgInfo ../FreeDroid.app/Contents
cp macfiles/FreeDroid.icns ../FreeDroid.app/Contents/Resources

cd ../FreeDroid.app/Contents/MacOS

function dylib_fixup {

  DYLIBS=`otool -X -L $1 | grep dylib | grep -v /usr/lib | grep -v Frameworks | awk -F \( '{ print $1 }'`


  for dl in $DYLIBS
  do
  	install_name_tool -change $dl @executable_path/`basename $dl` $1
	if ! test -f `basename $dl`
	then 
  		cp $dl .
		dylib_fixup `basename $dl`
	fi
  done
}

dylib_fixup ./freedroid
