import System.IO
import Control.Concurrent

main :: IO ()
main = do
  threadID <- forkIO (hPutStr stdout "Lorem")
  hPutStr stdout "Ipsum\n"

