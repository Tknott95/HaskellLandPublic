import System.IO
import Control.Concurrent.STM

type Acc = TVar Double

withdraw :: Acc -> Double -> STM ()
withdraw acc amount = do
  bal <- readTVar acc
  writeTVar acc (bal - amount)

emulateWithdraw:: Acc -> IO ()
emulateWithdraw acc = do
  hPutStr stdout "\n  emulateWithdraw called"
  atomically (withdraw acc 137.5)

showAcc :: Acc -> IO Double
showAcc acc = atomically (readTVar acc)

main = do
  acc <- atomically (newTVar 5280.0)

  shAcc00 <- showAcc acc
  hPutStr stdout ("\n Account total: " ++ show shAcc00)
  
  emulateWithdraw acc
  shAcc01 <- showAcc acc
  hPutStr stdout ("\n Withdrew funds - Total now " ++ show shAcc01)

