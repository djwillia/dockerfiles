This is an attempt to make it easy for me to build and test Solo5 or
Solo5/Mirage unikernels using Docker and Docker-for-Mac.  The script
`build.bash` builds a bunch of Docker containers, which are used in
turn to build and test unikernels.  The `aliases.bash` script contains
aliases to run the containers with less verbose commands.

To use this stuff, first `source` the aliases in your (bash) shell:

    source aliases.bash

To run the unikernels, these containers are using a modified version
of
[docker-unikernel-runner](https://github.com/djwillia/docker-unikernel-runner/tree/combo)
which can use either `ukvm`, `kvm`, or `qemu` as a hypervisor, all
with a uniform command format (see below).  On MacOSX, `qemu` is the
only hypervisor that will work (the others need `/dev/kvm`).

### Summary of aliases/containers
```
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
netcat
    a very limited netcat for testing on Docker-for-Mac
```

### Building/testing Solo5 on its own

1. Clone the Solo5 code and move into that directory
   ```
   git clone https://github.com/solo5/solo5.git
   cd solo5
   ```

2. Build the kernel (including its tests)
   ```
   solo5-make
   ```

3. Run a test unikernel
   ```
   cd tests/test_hello
   qemu test_hello.virtio -- hello
   ```

### Building/testing a Solo5/Mirage unikernel

1. Clone the Solo5 code and the Mirage skeleton tests
   ```
   git clone https://github.com/solo5/solo5.git
   git clone -b mirage-dev https://github.com/mirage/mirage-skeleton
   cd mirage-skeleton/stackv4
   ```

2. Build the unikernel.  Note that the containers but default will
   expect your Solo5 source directory in a specific place
   (`../../solo5`) and pin it during the Mirage/Solo5 build.  This
   should be fixed so that pinning is optional and the location can be
   specified.
   ```
   mirage-make virtio
   ```

3. Run the unikernel.  Because we let `docker-unikernel-runner`, don't
   specify unikernel options for the network.  Disk support is not yet
   there.
   ```
   qemu --net mir-stackv4.virtio
   ```

4. On Docker-for-Mac, we need another container to contact the
   unikernel over the network.  The `netcat` container helps with
   this:
   ```
   echo "hello there" | netcat 172.17.0.2 8080
   ```

### Building/testing a Solo5/Mirage unikernel on `uhvf`

`uhvf` is an in-progress port of `ukvm` to MacOSX's
Hypervisor.Framework, so these instructions will probably be out of
date very soon.  See https://github.com/djwillia/solo5/tree/uhvf-ukvm.

1. Clone the uhvf branch of the Solo5 code and the Mirage skeleton tests
   ```
   git clone -b uhvf-ukvm https://github.com/djwillia/solo5.git
   git clone -b mirage-dev https://github.com/mirage/mirage-skeleton
   cd mirage-skeleton/console
   ```

2. Build the unikernel.  Note that the containers but default will
   expect your Solo5 source directory in a specific place
   (`../../solo5`) and pin it during the Mirage/Solo5 build.  This
   should be fixed so that pinning is optional and the location can be
   specified.
   ```
   mirage-make ukvm
   ```

2. Build `uhvf`.  Note that this build is native (not from a container)
   ```
   cd ../../solo5/uhvf
   make
   ```

3. Run the unikernel.  
   ```
   uhvf ../../mirage-skeleton/console/mir-console.ukvm
   ```

