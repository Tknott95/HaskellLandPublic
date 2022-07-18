import Codec.Picture
import qualified Codec.Picture.Types as M
import System.Environment (getArgs)

main :: IO ()
main = do
  [path, path'] <- getArgs
  eimg <- readImage path
  case eimg of
    Left err -> putStrLn ("Could not read image: " ++ err)
    Right (ImageRGB8 img) -> do
      let (PixelRGB8 r g b) = pixelAt img 3 4
      print $ r
      print $ g
      print $ b
      (savePngImage path' . ImageRGB8) img
    Right _ -> putStrLn "Unexpected pixel format"

