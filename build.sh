#!/bin/sh

mkdir -p build

# We configure ocaml for emscripten.
cd ocaml
emconfigure ./configure -cc emcc -no-pthread -no-debugger -no-curses -no-ocamldoc -no-graph
make clean

# TODO: Fix these aliasing hacks.
# Alias ar to use the llvm version since emscripten requires it but the OCaml
# make files doesn't pick up its override of the standard archive tool.
alias ar='llvm-ar'

## Next we will build the byte code interpreter using emscripten.
cd byterun
emmake make
# internal ranlib command failed try again.
emmake make

# Give the output a file extension so that emscripten can infer it.
mv ocamlrun ../../build/ocamlrun.o
cd ../..

# Next we configure and build the native ocaml compiler so that we can use it
# to compile our ml script at the same version.
unalias ar
cd ocaml
make clean
./configure -prefix `pwd`/build -no-debugger -no-curses -no-ocamldoc -no-graph
make -j8 world
cd ..

# Build the OCaml example file to byte code.
./compile.sh
