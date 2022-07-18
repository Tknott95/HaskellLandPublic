#!/bin/sh
# $1

# second arg is "2 +RTS -N2" or "1 +RTS -N2" -l for logging 
# or just use haskellrun $1
ghc $1.hs -dynamic -threaded -rtsopts -eventlog -o $1 && ./$1 $2  && rm -f *.hi *.o $1

