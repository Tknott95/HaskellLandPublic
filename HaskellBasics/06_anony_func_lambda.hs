module Main where

main :: IO ()
main = do
  putStrLn("\n-- Anony func aka lambda which uses a backslash --")
  print $ map (\(a, b) -> a + b) [(0, 0), (3,3), (6,3)]
