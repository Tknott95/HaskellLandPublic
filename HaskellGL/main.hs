import Graphics.Rendering.OpenGL as GL
import Graphics.UI.GLFW as GLFW
import Control.Monad
import System.Exit ( exitWith, ExitCode(..) )


-- @TODO --
-- set wHeight && wWidth to resize vals --
winSize = [848, 484]
-- WINDOW SIZE --
resizeWindow :: GLFW.WindowSizeCallback
resizeWindow win winWidth winHeight = do
  GL.viewport $= (GL.Position 0 0, GL.Size (fromIntegral winWidth) (fromIntegral winHeight))
  GL.matrixMode $= GL.Projection
  GL.loadIdentity
  GL.ortho2D 0 (realToFrac winWidth) (realToFrac winHeight) 0

-- KEYS --
-- @NOTE Calling outside of Display loop so press won't loop
-- .. could use guards for these basic "global key" configs.
keyPressed :: GLFW.KeyCallback
keyPressed win GLFW.Key'Escape _ GLFW.KeyState'Pressed _ = shutdown win
keyPressed win GLFW.Key'Space _ GLFW.KeyState'Pressed _ = print $ ["space pressed"]
keyPressed _   _               _ _                     _ = return ()

shutdown :: GLFW.WindowCloseCallback
shutdown win = do
  GLFW.destroyWindow win
  GLFW.terminate
  _ <- exitWith ExitSuccess
  return ()

-- MAIN --
main :: IO ()
main = do
  GLFW.init
  GLFW.defaultWindowHints
  Just win <- GLFW.createWindow (head winSize) (winSize !! 1) "HaskellGL 0001" Nothing Nothing
  GLFW.makeContextCurrent (Just win)
  GLFW.setWindowSizeCallback win (Just resizeWindow)
  GLFW.setKeyCallback win (Just keyPressed)
  GLFW.setWindowCloseCallback win (Just shutdown)
  
  GL.viewport $= (GL.Position 0 0, GL.Size (fromIntegral (head winSize)) (fromIntegral (winSize !! 1)))
  GL.matrixMode $= GL.Projection
  GL.loadIdentity
  GL.ortho2D 0 (realToFrac (head winSize)) (realToFrac (winSize !! 1)) 0
  onDisplay win
  GLFW.destroyWindow win
  GLFW.terminate

-- MAIN LOOP FOR RENDERING --
onDisplay :: Window -> IO ()
onDisplay win = do
  print $ ["Looping"]
  GL.clearColor $= Color4 0 0.23 0.24 1
  GL.clear [ColorBuffer]

  renderPrimitive Triangles $ do
    corner 1 0 0 5 5
    corner 0 1 0 555 5
    corner 0 0 1 5 555

  GLFW.swapBuffers win
  -- flush
 
  forever $ do  
    GLFW.pollEvents
    onDisplay win

corner r g b x y = do 
  color (Color3  r g b  :: Color3 GLfloat)
  vertex (Vertex2 x y  :: Vertex2 GLfloat)
