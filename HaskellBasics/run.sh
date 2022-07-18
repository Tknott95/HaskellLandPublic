#!/bin/sh
# $1

# or just use haskellrun $1
ghc $1.hs -dynamic -o $1 && ./$1 && rm -f $1.hi $1.o $1  
