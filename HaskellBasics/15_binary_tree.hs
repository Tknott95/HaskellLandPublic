module Main where

{- UNFINISHED FOR NOW -}

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

flatten :: Tree a -> [a]
flatten (Leaf a) = [a] {- if only 1 val -}
flatten (Node _l _r) = flatten _l ++ flatten _r 

height :: Tree a -> Int
height (Leaf _) = 0
height (Node _l _r) = 1 + (height _l `max` height _r)

main = do
  let u_bl = "\ESC[0;4;36m"
  let b_ylw = "\ESC[1;33m"
  let clr = "\ESC[0m"
  
  putStrLn ("\n\n a "++u_bl++"Binary Tree"++clr++", bro\n")

  let tmplTree = Node(Node (Leaf "leaf_one") (Leaf "leaf_two")) (Leaf "leaf_three")
  print $ tmplTree

  putStrLn ("\n  "++b_ylw++"now flattened"++clr)
  print $ (flatten tmplTree)


  putStrLn ("\n  "++b_ylw++"height of my tmplTree"++clr)
  print $ (height tmplTree)
