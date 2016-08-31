#!/bin/bash

# There's a permission issue with mapping a volume.  The volume
# insists on being under the same owner as the host, which causes
# issues if the uid:gid doesn't match.  The problem is that the
# container needs to do opam stuff under the 'opam' user, so we can't
# just run the entrypoint under the same uid as the volume.  Instead
# we do this horrible chown, rechown.

T=$1
shift

if [ "x$T" != "xukvm" ] && [ "x$T" != "xvirtio" ] && [ "x$T" != "xclean" ]; then
    echo "Usage: mirage-make TARGET"
    echo "           where TARGET is either 'virtio' or 'ukvm'"
    echo "       mirage-make clean"
    exit 1;
fi

OLD_UG=`stat -c %u:%g /home/opam/src`;
sudo chown -R opam:opam /home/opam/src;
eval `opam config env`;
if [[ $T == "clean" ]]; then
    (cd /home/opam/src && make clean && mirage clean);
else
    opam pin add -y solo5-kernel-$T /home/opam/solo5;
    (cd /home/opam/src && mirage configure -t $T && make);
fi
sudo chown -R $OLD_UG /home/opam/src;
