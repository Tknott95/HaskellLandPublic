import Control.Parallel
import Control.Parallel.Strategies
import Control.Exception
import Data.Time.Clock
import Text.Printf
import System.Environment

iGen :: Int -> Int
iGen 0 = 1
iGen 1 = 1
iGen a = iGen(a-1) + iGen(a-2)

{- UNDER THE HOOD
  data Eval a
  instance Monad Eval
  runEval :: Eval a -> a
  rpar :: a -> Eval a
  rseq :: a -> Eval a
-}

main = do
  {- hacking args to switch between diff of rseq and rpar examples -}
  [argsHack] <- getArgs
  let ijk = [ex_00, ex_01, ex_02] !! (read argsHack-1)
  time_00 <- getCurrentTime
  runningEval <- evaluate (runEval ex_02)
  printTimeSince time_00
  print $ runningEval
  printTimeSince time_00

ex_00 = do 
  a <- rpar (iGen 31)
  b <- rpar (iGen 17)
  return (a,b)

ex_01 = do 
  a <- rpar (iGen 31)
  b <- rpar (iGen 17)
  rseq a
  rseq b
  return (a,b)

ex_02 = do 
  a <- rpar (iGen 31)
  b <- rseq (iGen 17)
  return (a,b)

printTimeSince t0 = do
  t1 <- getCurrentTime
  printf "time: %.2fs\n" (realToFrac (diffUTCTime t1 t0) :: Double)

{- ./02_rpar_rseq 2 +RTS -N2 -}
