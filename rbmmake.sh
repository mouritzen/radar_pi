set -xe

export MACOSX_DEPLOYMENT_TARGET=10.10

curl -k -o /tmp/wx315_opencpn50_macos1010.tar.xz  \
    https://download.opencpn.org/s/MCiRiq4fJcKD56r/download

tar -C /tmp -xJf /tmp/wx315_opencpn50_macos1010.tar.xz

rm -rf build && mkdir build && cd build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DwxWidgets_CONFIG_EXECUTABLE=/tmp/wx315_opencpn50_macos1010/bin/wx-config \
  -DwxWidgets_CONFIG_OPTIONS="--prefix=/tmp/wx315_opencpn50_macos1010" \
  -DCMAKE_INSTALL_PREFIX= \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10 \
  ..

make tarball