#!/bin/bash

# Blender version to build
PKG_VER="3.6.0" # Specify your Blender version
SRC_URL="https://github.com/blender/blender/archive/refs/tags/v$PKG_VER.tar.gz"
SRC_DIR="blender-$PKG_VER"
BUILD_DIR="$SRC_DIR/build"

# CMake configuration arguments
CMAKE_ARGS="-DCMAKE_SYSTEM_NAME=Linux -DWITH_X11=ON -DWITH_GLEW=ON -DWITH_VULKAN_BACKEND=ON -DWITH_WAYLAND=OFF"

# Update package list and install necessary dependencies
sudo apt update
sudo apt install -y cmake ninja-build clang python3 libx11-dev libxi-dev libxrandr-dev libxcursor-dev libxinerama-dev mesa-common-dev libglew-dev libvulkan-dev

# Download and extract Blender source code
if [ ! -f "v$PKG_VER.tar.gz" ]; then
    echo "Downloading Blender source code..."
    wget $SRC_URL -O "v$PKG_VER.tar.gz"
fi

echo "Extracting Blender source code..."
tar -xf "v$PKG_VER.tar.gz"

# Create build directory
mkdir -p $BUILD_DIR
cd $BUILD_DIR

# Configure build with CMake
echo "Configuring Blender build with CMake..."
cmake .. $CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=$PREFIX

# Compile Blender
echo "Building Blender..."
make -j$(nproc)

# Install Blender
echo "Installing Blender..."
sudo make install

# Clean up
cd ../..
echo "Cleaning up..."
rm -rf "$SRC_DIR"
rm "v$PKG_VER.tar.gz"

echo "Blender $PKG_VER has been installed."
