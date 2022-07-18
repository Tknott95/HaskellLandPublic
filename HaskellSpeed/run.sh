#!/bin/sh
# $1

# second arg is "2 +RTS -N2" or "1 +RTS -N2" 

# or just use haskellrun $1
ghc $1.hs -dynamic -threaded -o $1 && ./$1 $2  && rm -f $1.hi $1.o $1  
