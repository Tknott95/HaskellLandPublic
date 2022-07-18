import System.IO
import Data.IORef

incRef :: IORef Int -> IO ()
incRef a = do
  b <- readIORef a
  writeIORef a (b+1)

main = do
  i <- newIORef 137
  {- was wrapped in {-hi-} prior, below -}
  incRef i
  j <- readIORef i
  hPutStr stdout (show j)

