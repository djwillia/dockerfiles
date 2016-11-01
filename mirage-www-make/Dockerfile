# Build container

FROM ocaml/opam:ubuntu

RUN sudo apt-get update \
    && sudo apt-get install -qq -yy autoconf libgmp-dev libxen-dev uuid-dev

RUN opam repo add mirage-dev git://github.com/mirage/mirage-dev

# What we install here is somewhat handpicked to try to minimize what
# we need to build/rebuild every time we run the container.

RUN opam depext -i mirage xapi-rrd uri js_of_ocaml io-page cstruct re lwt c3 logs

RUN opam depext -i cowabloga mirage-http mirage-conduit cohttp conduit tcpip cow mirage-console mirage-unix nocrypto mirage-logs mirage-net-unix mirage-clock-unix mirage-fs-unix

VOLUME /home/opam/src
WORKDIR /home/opam/src

COPY script.bash /home/opam
ENTRYPOINT [ "/home/opam/script.bash" ]

