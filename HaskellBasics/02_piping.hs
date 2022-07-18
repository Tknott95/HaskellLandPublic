import Data.Char
      
main = do  
  contents <- getContents  
  putStr (map toLower contents)
  putStr (map toUpper contents) 
