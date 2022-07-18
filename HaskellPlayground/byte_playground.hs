import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC

bString00 = BC.pack "This is a bytestring, not a [Char]"

bytes = B.unpack bString00
chars = BC.unpack bString00

main :: IO ()
main = do
  putStrLn "\n  Byte Playground\n"

  BC.putStrLn bString00
  print $ bytes
  print $ chars

