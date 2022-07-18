module Main where

import System.Random
import Data.Time.Clock.POSIX (getPOSIXTime)
-- import Data.Time.Clock.POSIX

randSeed = (round . (* 1000)) <$> getPOSIXTime
randSeedAlt = randomIO :: IO Int

randList :: Int -> [Float]  --changing to [Float]
randList seed = randoms (mkStdGen seed) :: [Float]


main :: IO()

main = do
  putStrLn "\n\nThis will be a random layer of weights, 0-1 flaoting point, for an AI\n"
  -- POSIX time is down to the milliseconds
  mySeed <- randSeed
  let myLayer = randList mySeed
  print . take 256 $  myLayer

