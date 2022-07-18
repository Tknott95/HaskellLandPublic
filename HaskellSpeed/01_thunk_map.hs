
map2 ::  (a -> b) -> [a] -> [b]
map2 f [] = []
-- How map is normally  map f (x:xs) = f x : map f xs
map2 f (x:xs) = 
  let
    x'   = f x
    xs'  = map2 f xs
  in
    x' : xs'

{- in ghci  let ij = map (*2) [0..10]   :sprint ij -}


