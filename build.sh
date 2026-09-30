#!/bin/sh
# Build Eduka-Orca: download Orca 50.3 from GNOME, apply the Eduka patches,
# and (optionally) build the Debian package.
#
#   ./build.sh            -> prepare source in build/eduka-orca-<version>/
#   ./build.sh deb        -> also build build/eduka-orca_<version>_all.deb
#                            (run on Debian 13 "trixie" / Edukasaun OS)
set -eu

ORCA_TAG="50.3"
ORCA_REPO="https://github.com/GNOME/orca.git"
VERSION="50.3+eduka1"

HERE=$(cd "$(dirname "$0")" && pwd)
BUILD="$HERE/build"
SRC="$BUILD/eduka-orca-$VERSION"

echo ">> Mengambil Orca $ORCA_TAG / Downloading Orca $ORCA_TAG"
rm -rf "$SRC"
mkdir -p "$BUILD"
git -c advice.detachedHead=false clone --quiet --depth 1 --branch "$ORCA_TAG" "$ORCA_REPO" "$SRC"

echo ">> Menerapkan patch Eduka / Applying Eduka patches"
for patch in "$HERE"/patches/*.patch; do
    echo "   $(basename "$patch")"
    git -C "$SRC" -c user.name="Edukasaun OS" -c user.email="eduka@localhost" \
        am --quiet "$patch"
done

echo ">> Sumber siap / Source ready: $SRC"

if [ "${1:-}" = "deb" ]; then
    echo ">> Membangun paket .deb / Building .deb"
    cd "$SRC"
    if command -v mk-build-deps >/dev/null 2>&1 && [ "$(id -u)" = 0 ]; then
        mk-build-deps --install --remove \
            --tool "apt-get -y --no-install-recommends" debian/control
    fi
    dpkg-buildpackage -b -us -uc
    echo ">> Selesai / Done:"
    ls -1 "$BUILD"/*.deb
fi
