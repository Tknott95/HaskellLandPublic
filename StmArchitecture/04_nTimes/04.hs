import System.IO

nTimes :: Int -> IO ()
  -> IO ()
nTimes 0 fb = return ()
nTimes a fb = do
  fb
  nTimes (a-1) fb

main = nTimes 137 (hPutStr stdout "l33t aF, bro\n")
