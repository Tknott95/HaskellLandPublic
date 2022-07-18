import System.IO
import Control.Concurrent.STM

type Acc = TVar Double

withdraw :: Acc -> Double -> STM ()
withdraw acc amount = do
  bal <- readTVar acc
  writeTVar acc (bal - amount)

deposit :: Acc -> Double -> STM ()
deposit acc amount = withdraw acc (- amount)

transfer :: Acc -> Acc -> Double -> IO ()
transfer from to amount =
  atomically (do 
    deposit to amount
    withdraw from amount)

showAcc :: Acc -> IO Double
showAcc acc = atomically (readTVar acc)

main = do
   acc00 <- atomically (newTVar 5280.0) 
   acc01 <- atomically (newTVar 1000.0)
 
   shAcc00 <- showAcc acc00
   hPutStr stdout ("\n Account00 total: " ++ show shAcc00) 
   shAcc01 <- showAcc acc01
   hPutStr stdout ("\n Account01 total: " ++ show shAcc01)


   let transferAmt = 280.25 :: Double
   hPutStr stdout ("\n\n Acc00 -> Acc01 - Transferring: " ++ show transferAmt)
   
   transfer acc00 acc01 transferAmt

   shAcc00 <- showAcc acc00
   hPutStr stdout ("\n\n Account00 total: " ++ show shAcc00) 
   shAcc01 <- showAcc acc01
   hPutStr stdout ("\n Account01 total: " ++ show shAcc01)

