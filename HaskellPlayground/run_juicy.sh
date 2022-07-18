#!/bin/bash

stack ghc juicy_test.hs && rm -f *.o && rm -f *.hi &&./juicy_test "assets/pixel-heart.jpg" "juicy-heart.jpg"

