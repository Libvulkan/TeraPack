#!/bin/bash
if [ $# -lt 1 ]; then
  echo "Specify Architecture for Building RootFS."
  exit 0
fi

if [ "$1" != "aarch64" ] && [ "$1" != "x86_64" ]; then
  echo "Invalid Architecture Specified, Available 'aarch64' and 'x86_64'"
  exit 0
fi

export PREFIX=/data/data/com.winlator/files/imagefs/usr
export INIT_DIR=$PWD
export GIT_SHORT_SHA=$(git rev-parse --short HEAD)

if [ ! -d "$INIT_DIR/built-pkgs" ]; then
  echo "built-pkgs: Don't Exist. Run 'build-all.sh' for generate the needed libs for creating a rootfs for MiceWine."
  exit 0
fi

export ROOTFS_PKGS=$(ls "$INIT_DIR/built-pkgs/"*"$1"*)
export WINE_PKG=$(find "$INIT_DIR/built-pkgs" | grep "wine")
chmod +x download-external-dependencies.sh
chmod +x create-rat-pkg.sh
./download-external-dependencies.sh
./create-rat-pkg.sh "Wine-Utils" "$1" "($GIT_SHORT_SHA)" "wine-utils" "$INIT_DIR/rootfs" "$INIT_DIR"

ROOTFS_PKGS+=" $INIT_DIR/Wine-Utils-($GIT_SHORT_SHA)-$1.rat"

if [ -f "$WINE_PKG" ]; then
  ROOTFS_PKGS+=" $WINE_PKG"
else
  echo "Warning, Wine Not Found."
fi
chmod +x cat-rat-pkgs.sh
./cat-rat-pkgs.sh "Tera-RootFS" "($GIT_SHORT_SHA)" "rootfs" "$1" $ROOTFS_PKGS
