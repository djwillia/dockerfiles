# Build container

FROM ocaml/opam:ubuntu

RUN opam repo add mirage-dev git://github.com/mirage/mirage-dev

# What we install here is somewhat handpicked to try to minimize what
# we need to build/rebuild every time we run the container.

RUN opam depext -i mirage mirage-logs mirage-console mirage-clock-xen duration ocaml-src ocaml-freestanding mirage-solo5 mirage-console-solo5 mirage-bootvar-solo5

VOLUME /home/opam/src
WORKDIR /home/opam/src

COPY script.bash /home/opam
ENTRYPOINT [ "/home/opam/script.bash" ]

