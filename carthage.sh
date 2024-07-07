#!/usr/bin/env sh
# Copyright (c) Alexandre Gomes Gaigalas <alganet@gmail.com>
# SPDX-License-Identifier: ISC

set -xeu

if ! test -f cosmocc.zip
then wget https://cosmo.zip/pub/cosmocc/cosmocc.zip
fi

if ! test -f php-8.3.9.tar.gz
then wget https://www.php.net/distributions/php-8.3.9.tar.gz
fi

if ! test -f ph7.zip
then wget -O ph7.zip https://github.com/alganet/PH7/archive/refs/heads/master.zip
fi

if ! test -d cosmocc
then
    mkdir cosmocc
    cd cosmocc
    unzip ../cosmocc.zip
    cd ..
fi

if ! test -d php
then
    mkdir php
    cd php
    tar --extract --strip-components=1 --file ../php-8.3.9.tar.gz
    cd ..
fi

if ! test -d ph7
then
    mkdir ph7
    cd ph7
    unzip ../ph7.zip
    mv PH7-master/* .
    rm -rf PH7-master
    cd ..
fi

set -x

mkdir -p target/bin
export PATH="$PWD/cosmocc/bin:$PATH"
export CC="cosmocc -I$PWD/cosmocc/include -L$PWD/cosmocc/lib"
export CXX="cosmoc++ -I$PWD/cosmocc/include -L$PWD/cosmocc/lib"
export PKG_CONFIG="pkg-config --with-path=$PWD/cosmocc/lib/pkgconfig"
export INSTALL="cosmoinstall"
export AR="cosmoar"

if ! test -f target/bin/ph7
then
    cd ph7
    $CC -o ph7 ph7.c examples/ph7_interp.c -W -Wunused -Wall -I.
    $INSTALL -c -m 755 ph7 ../target/bin/ph7-2.1.4
    ../target/bin/ph7-2.1.4 ../litmus.php
cd ..
fi

if ! test -f target/bin/php
then
    cd php
    ./buildconf --force
    ./configure --prefix=$PWD/../target --disable-all --disable-shared --disable-fiber-asm
    make -j $(nproc)
    make install-cli install-phpdbg
    mv ../target/bin/php ../target/bin/php-8.3.9
    mv ../target/bin/phpdbg ../target/bin/phpdbg-8.3.9
    ../target/bin/php-8.3.9 ../litmus.php
    cd ..
fi
