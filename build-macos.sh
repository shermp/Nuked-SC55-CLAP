#!/bin/sh

# Build macOS Universal Binary CLAP plugin bundle.
# Expects VCPKG_ROOT to be set and vcpkg in the path (see README).

rm -rf out
mkdir out

# Build arm64
rm -rf build
cmake --preset=default -DCMAKE_OSX_ARCHITECTURES=arm64
cmake --build build
mv build/NukedSC55.clap out

# Build x86_64
rm -rf build
cmake --preset=default -DCMAKE_OSX_ARCHITECTURES=x86_64
cmake --build build
cp build/NukedSC55.clap/Contents/MacOS/NukedSC55 out/NukedSC55-x86_64

# Create universal binary
lipo out/NukedSC55-x86_64 out/NukedSC55.clap/Contents/MacOS/NukedSC55 -create -output out/NukedSC55
rm out/NukedSC55.clap/Contents/MacOS/NukedSC55
mv out/NukedSC55 out/NukedSC55.clap/Contents/MacOS/
