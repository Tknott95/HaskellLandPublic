module Main where

import System.Random
import Data.Time.Clock.POSIX (getPOSIXTime)
-- import Data.Time.Clock.POSIX

-- python example - np.random.randn(4, 8)    - (numOfInputs, numOfNeurons)
-- [[-0.67876771,  0.1211329 ,  1.35455162,  0.44799711, -0.4457754 ,
--          0.13669434,  0.32073965,  0.98320713],
--        [ 1.10370193,  0.02849202, -0.99961128, -0.26964529, -0.75553059,
--         -0.50717925,  0.59203409, -0.12477267],
--        [ 0.50379314,  0.64768863,  0.18534165,  1.4254625 , -0.89855048,
--         -0.1846783 , -0.10298856, -2.0453411 ],
--        [ 0.90059041, -0.91968484,  0.9924015 ,  0.15651993,  0.86114697,
--          0.32050474,  2.18065177, -2.090749  ]

randSeed = (round . (* 1000)) <$> getPOSIXTime
randSeedAlt = randomIO :: IO Int

randList :: Int -> [Float]  --changing to [Float]
randList seed = randoms (mkStdGen seed) :: [Float]
randLayer m n seed = [  take m $ randList (seed+j) | j <- [1..n] ]  

main :: IO()
main = do
  mySeed <- randSeed
  
  print $  randLayer 8 4 mySeed
  print $  randLayer 88 2 (mySeed+3)

  putStrLn "\n\nThis will be a random layer of weights, 0-1 flaoting point, for an AI\n"
  -- POSIX time is down to the milliseconds
  let myLayer = randList mySeed

  print . take 256 $  myLayer

