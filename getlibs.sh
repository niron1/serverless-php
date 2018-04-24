#!/usr/bin/env bash
# this script will work only if you have the VM running and SSH setup correctly
pushd .
scp -P 2222 user1@127.0.0.1:/usr/bin/php71 ./php
cd phplibs
scp -P 2222 user1@127.0.0.1:/lib64/libssl.so.10 .
scp -P 2222 user1@127.0.0.1:/lib64/libcrypto.so.10 .
scp -P 2222 user1@127.0.0.1:/opt/remi/php71/root/usr/lib64/php/modules/* .
scp -P 2222 user1@127.0.0.1:/lib64/libedit.so.0 .
# scp -P 2222 user1@127.0.0.1:/lib64/linux-vdso.so.1 .
# scp -P 2222 user1@127.0.0.1:/lib64/libcrypt.so.1 .
# scp -P 2222 user1@127.0.0.1:/lib64/libresolv.so.2 .
# scp -P 2222 user1@127.0.0.1:/lib64/libncurses.so.5 .
# scp -P 2222 user1@127.0.0.1:/lib64/libtinfo.so.5 .
# scp -P 2222 user1@127.0.0.1:/lib64/libstdc++.so.6 .
# scp -P 2222 user1@127.0.0.1:/lib64/libz.so.1 .
# scp -P 2222 user1@127.0.0.1:/lib64/librt.so.1 .
# scp -P 2222 user1@127.0.0.1:/lib64/libm.so.6 .
# scp -P 2222 user1@127.0.0.1:/lib64/libdl.so.2 .
# scp -P 2222 user1@127.0.0.1:/lib64/libnsl.so.1 .
# scp -P 2222 user1@127.0.0.1:/lib64/libxml2.so.2 .
# scp -P 2222 user1@127.0.0.1:/lib64/libgssapi_krb5.so.2 .
# scp -P 2222 user1@127.0.0.1:/lib64/libkrb5.so.3 .
# scp -P 2222 user1@127.0.0.1:/lib64/libk5crypto.so.3 .
# scp -P 2222 user1@127.0.0.1:/lib64/libcom_err.so.2 .
# scp -P 2222 user1@127.0.0.1:/lib64/libc.so.6 .
# scp -P 2222 user1@127.0.0.1:/lib64/ld-linux-x86-64.so.2 .
# scp -P 2222 user1@127.0.0.1:/lib64/libgcc_s.so.1 .
# scp -P 2222 user1@127.0.0.1:/lib64/libpthread.so.0 .
# scp -P 2222 user1@127.0.0.1:/lib64/liblzma.so.5 .
# scp -P 2222 user1@127.0.0.1:/lib64/libkrb5support.so.0 .
# scp -P 2222 user1@127.0.0.1:/lib64/libkeyutils.so.1 .
# scp -P 2222 user1@127.0.0.1:/lib64/libselinux.so.1 .
# scp -P 2222 user1@127.0.0.1:/lib64/libpcre.so.1 .
cd ..
cd phpini
scp -rp -P 2222 user1@127.0.0.1:/etc/opt/remi/php71/php.d ./php.d
popd

