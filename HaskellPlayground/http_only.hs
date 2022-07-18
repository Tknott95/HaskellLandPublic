module Main where

import Network.HTTPS
import Text.HTML.TagSoup


openURL :: String -> IO String
openURL x = getResponseBody =<< simpleHTTP (getRequest x)

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
