{- this iterates up from 0 with n instead of down form the top val if I need to manipulate a list -}
timesItself xs = [ x*x | x <- xs ]

absVal n = if n >= 0 then n else -n

printStringNTimes 0 = return ()
printStringNTimes n =
 do
  putStrLn "Iterating example"
  print $ timesItself [(absVal (n-10))]
  printStringNTimes (n-1)

main = printStringNTimes 10
