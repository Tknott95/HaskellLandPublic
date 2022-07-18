import System.IO
import Control.Concurrent.STM
import Control.Concurrent

type Acc = TVar Double

limitedWithdraw :: Acc -> Double -> STM ()
limitedWithdraw _acc _amount = do
  accBal <- readTVar _acc
  check (_amount <= 0 || _amount <= accBal)
  writeTVar _acc (accBal - _amount)

showAcc :: String -> Acc -> IO ()
showAcc _name _acc = do
  accBal <- atomically (readTVar _acc)
  hPutStr stdout (_name ++ ": $")
  hPutStr stdout (show accBal ++ "\n")

limitedWithdraw' :: Acc -> Acc -> Double -> STM ()
{- withdraws from acc00 if it has enough funds else it will withdraw from acc01 -}
limitedWithdraw' _acc00 _acc01 _amt = 
  orElse (limitedWithdraw _acc00 _amt) (limitedWithdraw _acc01 _amt)

delayDeposit :: String -> Acc -> Double -> IO ()
delayDeposit _accName _acc _amt = do
  threadDelay 3000000
  hPutStr stdout ("\n  Depositing $"++ show _amt ++ " into " ++ _accName ++ "\n")
  atomically ( do 
    accBal <- readTVar _acc
    writeTVar _acc (accBal + _amt))

main = do
  acc00 <- atomically (newTVar 34000)
  acc01 <- atomically (newTVar 34000)
  showAcc "\n  Acc00 " acc00
  showAcc "  Acc01 " acc01

  forkIO (delayDeposit "Acc01" acc01 70000)
  hPutStr stdout "\n  Withdrawing 100k from either acc once funds are available... \n"
  atomically (limitedWithdraw' acc00 acc01 100000)

  showAcc "\n  Acc00 " acc00
  showAcc "  Acc01 " acc01

