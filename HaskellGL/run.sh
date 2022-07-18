stack install OpenGL
stack install GLFW-b

rm -f main

stack ghc main.hs

rm -f main.o main.hi

./main 
