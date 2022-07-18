import Codec.Picture

imgPath = "./assets/pixel-heart.jpg"

transcodeToPng :: FilePath -> FilePath -> IO ()
transcodeToPng pathIn pathOut = do
   eitherImg <- readImage pathIn
   case eitherImg of
      Left _ -> do
        print $ "failed to load img"
        return ()
      Right img -> do
        print $ "yeah"
        savePngImage pathOut img

main :: IO ()
main = do
  putStrLn "\n\n Img Loading into [] \n"

  testImg <- readImage imgPath
  case testImg of
    Left err -> putStrLn ("\n  Could not read img: " ++ err)
    Right (ImageRGB8 img) ->
      print $ img
      -- (saveJpgImage "assets/new-pixel-heart.jpg") img
    Right _ -> putStrLn "\n  Unexpected pixel format\n"
  
  
  transcodeToPng imgPath "./assets/pixel-heart.png"
  putStrLn "\n kladal\n"
  -- print $ testImg

