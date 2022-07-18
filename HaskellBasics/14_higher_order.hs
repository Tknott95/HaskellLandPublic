import Data.List


{-  (.) will go from left<-right (right to left)  -} 
higherOrder_00 :: [Int]
higherOrder_00 =  (filter even . take 3 . map (\x -> x-1)) [1..]


higherOrder_01 :: [Int]
higherOrder_01 =  filter odd $ take 33 $ map (\x -> x-1) [1..]

higherOrder_02 :: [Int]
higherOrder_02 = take 33 $ (+100) <$> [0..]

main = do
  putStrLn "\n Higher Order Functions\n"
  putStrLn "\n  higherOrder_00"
  print $ higherOrder_00

  putStrLn "\n  higherOrder_01"
  print $ higherOrder_01


  putStrLn "\n  higherOrder_02"
  print $ higherOrder_02

  putStrLn "\n  ((+137) . (*2)) 137 "
  print $  ((+137) . (*2)) 137

  putStrLn "\n  flip example"
  print $ (take 10 $ flip map [1..] (\x -> x*x))  

  putStrLn "\n  filter even $ ( -> (x-1)*x) <$> [1..33]"
  print $ (filter even $ (\x -> (x-1)*x) <$> [1..33])
  
  
