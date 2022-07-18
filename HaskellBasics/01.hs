myBMI :: (RealFloat a) => a -> String  
  
myBMI v
  | v <= 18.5 = "Small, bro!"  
  | v <= 25.0 = "Avg Jo"  
  | v <= 30.0 = "Thicc"  
  | otherwise   = "Buoyant" 

main = do
  let tBmi = myBMI 27.3
  putStrLn tBmi
