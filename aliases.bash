

#alias solo5-make="docker run --rm -v $PWD:/src -u `id -u` solo5-make"
alias solo5-make="docker run --rm -v $PWD:/src -u `id -u` solo5-make"
#alias mirage-make="docker run --rm -v $PWD:/home/opam/src -v /home/djwillia/solo5:/home/opam/solo5 mirage-make"
alias mirage-make="docker run --rm -v $PWD:/home/opam/src -v $PWD/../../solo5:/home/opam/solo5 mirage-make"
