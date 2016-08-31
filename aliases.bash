
alias-help() {
cat<< EOF
solo5-make [clean]
    runs make in the current (solo5) directory
mirage-make TARGET [clean]
    where TARGET is either virtio or ukvm
    runs mirage configure and make in the current (mirage app) directory
    also pins the solo5 kernel in a horrible hardcoded way
ukvm [--net] [--disk=foo] UNIKERNEL -- [unikernel args]
qemu [--net] [--disk=foo] UNIKERNEL -- [unikernel args] 
kvm  [--net] [--disk=foo] UNIKERNEL -- [unikernel args]
    runs a unikernel on ukvm, qemu or kvm
EOF
}

# netcat with some caveats
#    - can't use interactively because stdin to the container is not
#      working right)
#    - can do something like `echo "hi there" | netcat 172.17.0.2 8080`
alias netcat='docker run --rm netcat "`if [[ ! -t 0 ]]; then echo -e "$(cat)"; fi`" -- '

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
alias qemu='docker run --rm --device=/dev/net/tun:/dev/net/tun --cap-add=NET_ADMIN -v $PWD:/src runner qemu'
alias kvm='docker run --rm --device=/dev/kvm:/dev/kvm --device=/dev/net/tun:/dev/net/tun --cap-add=NET_ADMIN -v $PWD:/src runner kvm'



