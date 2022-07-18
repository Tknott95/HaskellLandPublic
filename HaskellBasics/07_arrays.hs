import Data.Array


main = do
  let x = [ [ [ (k) | k<-[1..2] ] | j<-[1..2] ] | i<-[1..4] ]
  print $ x
  
  let _a1 = array (0,20) [(i, i*i) | i <- [0..20]]
  print $ _a1

  let _a2 = array (0,2) [(0,1.2),(1,2.2),(2,4.2)]

  print $ _a2
