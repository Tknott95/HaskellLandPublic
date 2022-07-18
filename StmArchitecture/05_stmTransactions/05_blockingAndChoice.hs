import System.IO
import Control.Concurrent.STM
import Control.Concurrent

type Acc = TVar Double

{- prior to using "check"
limitedWithdraw :: Acc -> Double -> STM ()
limitedWithdraw acc amount = do
  bal <- readTVar acc
  if amount > 0 && amount > bal
  then retry
  else writeTVar acc (bal - amount)
 same thing as below
-}

showAcc name acc = do
    bal <- atomically (readTVar acc)
    hPutStr stdout (name ++ ": $")
    hPutStr stdout (show bal ++ "\n")

limitedWithdraw :: Acc -> Double -> STM ()
limitedWithdraw acc amount = do
  bal <- readTVar acc
  check (amount <= 0 || amount <= bal)
  writeTVar acc (bal - amount)

-- double check if this is IO and not STM on run
delayDeposit :: Acc -> Double -> IO ()
delayDeposit acc amount = do
  threadDelay 3000000
  hPutStr stdout "Depositing funds right meow.\n"
  atomically (do bal <- readTVar acc
                 writeTVar acc (bal + amount))
main = do
  acc00 <- atomically (newTVar 1337)
  showAcc "Acc00: $" acc00
  forkIO (delayDeposit acc00 10000)
  showAcc "delayDeposit called - Acc00: $" acc00
  hPutStr stdout "Withdrawing, hopefully my loot went through ^__-\n"
  atomically (limitedWithdraw acc00 2337)
  showAcc "Acc00 - " acc00

