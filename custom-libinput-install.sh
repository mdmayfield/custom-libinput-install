#!/bin/bash
set -o errexit
set -o pipefail

sudo apt install -y build-essential git

# Pasted from apt build-dep libinput in 18.04. May change in future

sudo apt install -y autoconf automake autopoint autotools-dev debhelper dh-autoreconf \
  dh-strip-nondeterminism gettext intltool-debian libarchive-zip-perl libevdev-dev \
  libfile-stripnondeterminism-perl libglib2.0-dev libglib2.0-dev-bin libmtdev-dev \
  libpcre16-3 libpcre3-dev libpcre32-3 libpcrecpp0v5 libsigsegv2 libtool libudev-dev \
  libwacom-dev m4 meson ninja-build pkg-config po-debconf python3-distutils \
  python3-lib2to3 zlib1g-dev

# Extras needed to build not included in build-dep for some reason
sudo apt install -y doxygen graphviz libgtk-3-dev check valgrind libunwind-dev

cd ~

git clone https://gitlab.freedesktop.org/mdmayfield/libinput.git/

cd libinput

meson . builddir

ninja -C builddir

sudo ninja install -C builddir

echo '/usr/local/lib/x86_64-linux-gnu' | sudo tee -a /etc/ld.so.conf.d/usr-local-lib.conf

sudo ldconfig

echo "Custom libinput driver installed in /usr/local/lib/x86_64-linux-gnu/."
echo "Please logout/login, or restart, to activate."

