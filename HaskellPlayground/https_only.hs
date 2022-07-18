module Main where

import Network.HTTP.Conduit
import qualified Data.ByteString.Lazy as LB
import Text.HTML.TagSoup
import Text.Regex.Posix

-- (=~) :: string -> pattern -> result

openURL :: String -> IO LB.ByteString
openURL x = simpleHttp x

{-
listOfArtworks :: [Char] -> IO ()
listOfArtworks _artistName = do
  tags <- parseTags <$> openURL "https://www.wikiart.org/en/salvador-dali/all-works/text-list"
  let a
-}


main :: IO ()
main = do
    src <- openURL "https://www.wikiart.org/en/salvador-dali/all-works/text-list"
    print $ src
