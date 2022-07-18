module Main where
import System.Environment

np1Chain :: (Integral a) => a -> [a]
np1Chain 1 = [1]
np1Chain n
  | even n = n:np1Chain (div n 2)
  | odd n = n:np1Chain ((3*n) + 1)

main :: IO ()
main = do
  putStrLn("\n-- (3n+1 | n/2) chain cryptography for 30 --")
  print $ np1Chain 30
