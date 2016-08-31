# Build container

FROM ocaml/opam:ubuntu

RUN sudo apt-get update && sudo apt-get install -y netcat

COPY script.bash /home/opam
ENTRYPOINT [ "/home/opam/script.bash" ]
