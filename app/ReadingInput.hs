module ReadingInput where

import qualified Graphics.UI.GLFW as G
import Graphics.UI.GLFW (KeyCallback)
import System.IO
import Control.Monad (unless)
import Data.ByteString.Char8 (ByteString, pack)

withWindow::KeyCallback -> IO ()
withWindow callback = do
    i <- G.init
    if not i then hPutStr stderr "Could not initiate GLFW" else do
        G.windowHint $ G.WindowHint'Floating True
        mw <- G.createWindow 200 200 "Remote Listener" Nothing Nothing
        case mw of
            Nothing -> hPutStr stderr "Could not create a window"
            Just w -> do
                G.setKeyCallback w $ Just callback
                wloop w
    where
        wloop w = do
            wshc <- G.windowShouldClose w
            unless wshc $ G.pollEvents >> wloop w

handleKeyCallback::(ByteString->IO())->KeyCallback
handleKeyCallback _ _ _ _ G.KeyState'Repeating _ = return ()
handleKeyCallback hndlr _ key _ kstate _ = hndlr.pack $ show key ++ ":" ++ show kstate
