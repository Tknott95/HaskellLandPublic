import System.IO
import Control.Concurrent.STM
import Control.Concurrent

clr00 = '\ESC0;33m;'
clr01 = '\ESC0m;'

data IGroup = MKGroup
data IGate = MKGate

{- finish when bored
 - making a group for - elf - reindeer 
 - when accepted into a group - you get two gates
 - an inGate and an outGate
-}


{- joinGroup takes a group and returns to gates - inGate - outGate - yet here they stay "unnamed" -}


joinGroup :: IGroup -> IO (IGate, IGate)
joinGroup _group =
  do
    putStr "\n\ESC[0;44m  - joinGroup called -\ESC[0m"
    return (MKGate, MKGate)

passGate :: IGate -> IO ()
passGate _gate = putStr ("\n  - passGate called -")


elf_00 :: IGroup -> Int -> IO ()
elf_00 _group _elfID = do
  (inGate, outGate) <- joinGroup _group
  passGate inGate
  meetInStudy _elfID
  passGate outGate


meetInStudy :: Int -> IO ()
meetInStudy _id = putStr ("\n  Elf " ++ show _id ++ " partying in the study bruv!")

main = do
  elf_00 MKGroup 137
--   meetInStudy 137
