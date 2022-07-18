import ThirdPartySudoku

import Control.Parallel
import Control.Parallel.Strategies
import Control.DeepSeq
import Control.Exception
import System.Environment
import Data.Maybe

b_bl = "\ESC[1;36m"
b_ylw = "\ESC[1;33m"
clr = "\ESC[0m"
{- Here I will be bringing in a module that already solves sodoku puzzles to then add parallelism in order to wrap my head aorund parallelizing larger computational programs. -}

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
    (as, bs) = splitAt (length puzzles `div` 2) puzzles

    solutions = runEval $ do
      as' <- rpar (force $ map solve as)
      bs' <- rpar (force $ map solve bs)
      rseq as'
      rseq bs'
      return (as' ++ bs')
  
  print (length $ filter isJust solutions)
 
  putStrLn (b_bl++"___________\n"++clr)
