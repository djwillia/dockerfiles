# Build container

FROM ocaml/opam:ubuntu

VOLUME /solo5
VOLUME /src

#RUN opam switch --alias-of 4.03.0 mirage-solo5-dev \

RUN opam repo add mirage-dev git://github.com/mirage/mirage-dev
RUN opam depext -i mirage

WORKDIR /src

#ENTRYPOINT opam --version

#ENTRYPOINT opam pin add -y solo5-kernel-ukvm /solo5 && mirage configure -t ukvm && make

ENTRYPOINT eval `opam config env` && opam pin add -y solo5-kernel-ukvm /solo5 && mirage configure -t ukvm && make

