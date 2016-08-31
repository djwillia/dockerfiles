
# solo5-make [clean]
#     runs make in the solo5 directory

alias solo5-make='docker run --rm -v $PWD:/src -u `id -u` solo5-make'

# mirage-make TARGET [clean]
#     where TARGET is either 'virtio' or 'ukvm'

alias mirage-make='docker run --rm -v $PWD:/home/opam/src -v $PWD/../../solo5:/home/opam/solo5 mirage-make'

# ukvm [--net] [--disk=foo] UNIKERNEL -- [unikernel args]
# qemu [--net] [--disk=foo] UNIKERNEL -- [unikernel args]
# kvm  [--net] [--disk=foo] UNIKERNEL -- [unikernel args]

alias ukvm='docker run --rm --device=/dev/kvm:/dev/kvm --device=/dev/net/tun:/dev/net/tun --cap-add=NET_ADMIN -v $PWD:/src runner /src/ukvm-bin'
alias qemu='docker run --rm --device=/dev/kvm:/dev/kvm --device=/dev/net/tun:/dev/net/tun --cap-add=NET_ADMIN -v $PWD:/src runner qemu'
alias kvm='docker run --rm --device=/dev/kvm:/dev/kvm --device=/dev/net/tun:/dev/net/tun --cap-add=NET_ADMIN -v $PWD:/src runner kvm'



