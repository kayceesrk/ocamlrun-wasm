#!/bin/bash

./ocaml/build/bin/ocamlrun ./ocaml/build/bin/ocamlc -o build/example example.ml 
emcc -s WASM=1 -s TOTAL_MEMORY=1342177280 -O2 build/ocamlrun.o -o build/ocamlrun.js --preload-file build/example
