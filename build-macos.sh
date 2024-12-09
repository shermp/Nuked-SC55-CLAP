#!/bin/sh

# Build macOS Universal Binary CLAP plugin bundle.
# Expects VCPKG_ROOT to be set and vcpkg in the path (see README).

rm -rf out
mkdir out

# Build arm64
rm -rf build
cmake --preset=default -DCMAKE_OSX_ARCHITECTURES=arm64
cmake --build build
mv build/Nuked-SC55.clap out

# Build x86_64
rm -rf build
cmake --preset=default -DCMAKE_OSX_ARCHITECTURES=x86_64
cmake --build build
cp build/Nuked-SC55.clap/Contents/MacOS/Nuked-SC55 out/Nuked-SC55-x86_64

# Create universal binary
lipo out/Nuked-SC55-x86_64 \
	 out/Nuked-SC55.clap/Contents/MacOS/Nuked-SC55 \
	 -create -output out/Nuked-SC55

rm out/Nuked-SC55-x86_64
rm out/Nuked-SC55.clap/Contents/MacOS/Nuked-SC55

mv out/Nuked-SC55 out/Nuked-SC55.clap/Contents/MacOS/
