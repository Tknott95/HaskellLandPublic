module Main where

type Table k v = [(k, v)]

empty :: Table k v
empty = []

{- 
  example: x = insert 1 "relu" empty
  example: x = insert 1 "relu" (insert 2 "softmax" empty)
-}
insert :: k -> v -> Table k v -> Table k v
insert k v table = (k, v) : table

{- example (FIRST): x = insert 1 "relu" (insert 2 "softmax" empty) 
   example (THEN):  delete 2 x 
-}
delete :: Eq k => k -> Table k v -> Table k v
delete k table = filter (\(k', _) -> not (k == k')) table

{- This only returns the value, from the key, in a "Just" format -}
-- lookup :: Eq k => k -> Table k v -> Maybe v

main :: IO ()
main = do
  putStrLn "\n  k v tables"
  let x = insert 1 "RELU" (insert 2 "Softmax" (insert 3 "leakyRELU" empty))
  print $ x
  print $ (delete 3 x)
  print $ (insert 42 "leakyRELU" (delete 3 x))

