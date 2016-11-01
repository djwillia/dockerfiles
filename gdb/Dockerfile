# Build container

FROM ocaml/opam:ubuntu

RUN sudo apt-get update && sudo apt-get install -y gdb

VOLUME /src
WORKDIR /src

ENTRYPOINT ["/usr/bin/gdb"]
