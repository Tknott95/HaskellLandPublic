import ThirdPartySudoku

import Control.Parallel.Strategies hiding (parMap)

import Control.Exception
import System.Environment
import Data.Maybe

{- ./sudoku_run.sh 04_dynamic_par_sudoku  "+RTS -N2 -s" -}

b_bl = "\ESC[1;36m"
b_ylw = "\ESC[1;33m"
clr = "\ESC[0m"
{- Here I will be bringing in a module that already solves sodoku puzzles to then add parallelism in order to wrap my head aorund parallelizing larger computational programs. -}

parMap :: (a -> b) -> [a] -> Eval [b]
parMap f [] = return []
parMap f (a:as) = do
  b <- rpar(f a)
  bs <- parMap f as
  return (b:bs)

main :: IO ()
main = do

  -- [cliArgs] <- getArgs
  mySolutionData <- readFile "sudoku_data_1k.txt"
  
  putStrLn (b_ylw++"\n\nParallel Sudoku Solver"++clr++"\n")

 {-let  BEFORE PARALLELISM 
    puzzles    = lines mySolutionData
    solutions  = map solve puzzles

  print (length $ filter isJust solutions)
 -}

  let 
    puzzles = lines mySolutionData
    solutions = runEval $ parMap solve puzzles
  
  print (length $ filter isJust solutions)
 
  putStrLn (b_bl++"___________\n"++clr)
