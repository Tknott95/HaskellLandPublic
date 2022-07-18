import System.IO

{- this will call the hEchoLine function and setup data for it -}
hEchoLine :: Handle -> IO String
hEchoLine h =  do
  s <- hGetLine h
  hPutStr h ("hGetLine grabbed dis bittie - " ++ s)
  return s

main = do
  h <- openFile "hEchoLineTxt.txt" ReadWriteMode
  str <- {-hi-}hEchoLine h{-/hi-}
  hClose h
  str01 <- readFile "hEchoLineTxt.txt"
  hPutStr stdout str01

