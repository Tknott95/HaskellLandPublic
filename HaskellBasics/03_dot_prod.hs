-- Dot Prod of **n arrays --
dotProd :: Num a => [a] -> [a] -> a
dotProd xs ys = sum[x*y | (x,y) <- zip xs ys]

main = do
  let myDot = dotProd [2,3,4] [5,6,7]

  print $ myDot
