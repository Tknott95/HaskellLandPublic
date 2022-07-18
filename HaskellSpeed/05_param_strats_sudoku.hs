import ThirdPartySudoku

import Control.Parallel.Strategies hiding (parMap)

import Control.Exception
import System.Environment
import Data.Maybe

{- ./sudoku_run.sh 05_param_strats_sudoku  "+RTS -N -s -l" -}

b_bl = "\ESC[1;36m"
b_ylw = "\ESC[1;33m"
clr = "\ESC[0m"


main :: IO ()
main = do

  -- [cliArgs] <- getArgs
  mySolutionData <- readFile "sudoku_data_1k.txt"
  
  putStrLn (b_ylw++"\n\nParallel Sudoku Solver"++clr++"\n")

 {- STRATEGY EXAMPLE 
  THIS      - runEval $ parPair(<func> 13, <func> 22)
  COULD BE  - (<func> 13, <func 22>) `using` parPair
  USING STRATEGIES IN THE SECOND EXAMPLE
 -}

  let 
    puzzles = lines mySolutionData
    solutions = map solve puzzles `using` parList rseq
  
  print (length $ filter isJust solutions)
 
  putStrLn (b_bl++"___________\n"++clr)
