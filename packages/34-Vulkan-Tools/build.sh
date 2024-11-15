PKG_VER=1.3.296
SRC_URL=https://github.com/KhronosGroup/Vulkan-Tools/archive/refs/tags/v$PKG_VER.tar.gz
CMAKE_ARGS="-DCMAKE_SYSTEM_NAME=Linux -DBUILD_CUBE=ON -DBUILD_ICD=OFF -DBUILD_WSI_WAYLAND_SUPPORT=OFF -DBUILD_WSI_XCB_SUPPORT=ON -DBUILD_WSI_XLIB_SUPPORT=ON -DVULKAN_HEADERS_INSTALL_DIR=$PREFIX"
