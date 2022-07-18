
{- Finding elem in list -}
hasElem :: Eq a => a -> [a] -> Bool
hasElem x []  = False
hasElem x (y:ys) = x == y || hasElem x ys

reverseList :: [a] -> [a]
reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]

{- Filters out that which doesn't match function
  example:  filterList odd [2,2,3,2]
  example:  filterList (\n -> n <= 2) [2,2,3,2]
 -}
filterList :: (a -> Bool) -> [a] -> [a]
filterList ij [] = []
filterList ij (x:xs)
  | ij x       = x:filterList ij xs
  | otherwise  = filterList ij xs
 

